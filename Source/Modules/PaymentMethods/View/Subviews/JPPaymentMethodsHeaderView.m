//
//  JPPaymentMethodsHeaderView.m
//  JudoKitObjC
//
//  Copyright (c) 2019 Alternative Payments Ltd
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JPPaymentMethodsHeaderView.h"
#import "JPAddCardButton.h"
#import "JPAmount.h"
#import "JPPaymentMethodsViewModel.h"
#import "NSString+Additions.h"
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"
#import "UIImage+Icons.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

#import "JPPaymentMethodsCardHeaderView.h"
#import "JPPaymentMethodsEmptyHeaderView.h"

@interface JPPaymentMethodsHeaderView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) JPPaymentMethodsEmptyHeaderView *emptyHeaderView;
@property (nonatomic, strong) JPPaymentMethodsCardHeaderView *cardHeaderView;

@property (nonatomic, strong) UILabel *amountPrefixLabel;
@property (nonatomic, strong) UILabel *amountValueLabel;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIStackView *amountStackView;
@property (nonatomic, strong) UIStackView *mainStackView;

@end

@implementation JPPaymentMethodsHeaderView

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    self.amountValueLabel.text = [NSString stringWithFormat:@"%@%@",
                                                            viewModel.amount.currency.toCurrencySymbol,
                                                            viewModel.amount.amount];

    [self.payButton configureWithViewModel:viewModel.payButtonModel];

    [self.emptyHeaderView removeFromSuperview];
    [self.cardHeaderView removeFromSuperview];

    if (viewModel.cardModel == nil) {
        self.backgroundImageView.image = [UIImage imageWithResourceName:@"no-cards"];
        [self displayEmptyHeaderView];
    } else {
        self.backgroundImageView.image = [UIImage imageWithResourceName:@"gradient-background"];
        [self displayCardHeaderViewWithViewModel:viewModel];
    }
}

- (void)displayEmptyHeaderView {
    [self.topView addSubview:self.emptyHeaderView];
    [self.emptyHeaderView pinToView:self.topView withPadding:0.0];
}

- (void)displayCardHeaderViewWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    [self.topView addSubview:self.cardHeaderView];
    [self.cardHeaderView pinToView:self.topView withPadding:0.0];
    [self.cardHeaderView configureWithViewModel:viewModel];

    [self insertSubview:self.mainStackView aboveSubview:self.topView];
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;

    [self insertSubview:self.backgroundImageView belowSubview:self.mainStackView];
    [self setupBackgroundImageViewConstraints];

    [self setupPaymentStackViews];
    [self setupStackViewConstraints];

    [self addSubview:self.topView];
    [self setupGeneralConstraints];
    [self setupPaymentStackViewBackground];
}

- (void)setupPaymentStackViews {
    [self.amountStackView addArrangedSubview:self.amountPrefixLabel];
    [self.amountStackView addArrangedSubview:self.amountValueLabel];

    [self.mainStackView addArrangedSubview:self.amountStackView];
    [self.mainStackView addArrangedSubview:self.payButton];

    [self insertSubview:self.mainStackView aboveSubview:self.topView];
}

- (void)setupPaymentStackViewBackground {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = bgView.bounds;
    gradient.colors = @[ (id)[UIColor colorWithWhite:1 alpha:0].CGColor, (id)[UIColor colorWithWhite:1 alpha:1].CGColor ];
    gradient.locations = @[ @0.0, @0.2 ];
    [bgView.layer insertSublayer:gradient atIndex:1];
    [self.mainStackView insertSubview:bgView atIndex:0];
}

#pragma mark - Constraints Setup

- (void)setupBackgroundImageViewConstraints {
    [self.backgroundImageView pinToView:self withPadding:0.0];
}

- (void)setupGeneralConstraints {
    [self.payButton.widthAnchor constraintEqualToConstant:200.0].active = YES;
    [self.topView pinToAnchors:AnchorTypeTop | AnchorTypeLeading | AnchorTypeTrailing forView:self];
    [self.topView.bottomAnchor constraintEqualToAnchor:self.mainStackView.topAnchor].active = YES;
}

- (void)setupStackViewConstraints {
    [self.mainStackView.heightAnchor constraintEqualToConstant:46.0].active = YES;
    [self.mainStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.mainStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:24.0].active = YES;
    [self.mainStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-24.0].active = YES;
}

#pragma mark - Lazy Properties

- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

- (JPPaymentMethodsEmptyHeaderView *)emptyHeaderView {
    if (!_emptyHeaderView) {
        _emptyHeaderView = [JPPaymentMethodsEmptyHeaderView new];
        _emptyHeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _emptyHeaderView;
}

- (JPPaymentMethodsCardHeaderView *)cardHeaderView {
    if (!_cardHeaderView) {
        _cardHeaderView = [JPPaymentMethodsCardHeaderView new];
        _cardHeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _cardHeaderView;
}

- (UILabel *)amountValueLabel {
    if (!_amountValueLabel) {
        _amountValueLabel = [UILabel new];
        _amountValueLabel.numberOfLines = 0;
        _amountValueLabel.font = UIFont.largeTitle;
        _amountValueLabel.textColor = UIColor.jpBlackColor;
        _amountValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _amountValueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _amountValueLabel;
}

- (UILabel *)amountPrefixLabel {
    if (!_amountPrefixLabel) {
        _amountPrefixLabel = [UILabel new];
        _amountPrefixLabel.numberOfLines = 0;
        _amountPrefixLabel.text = @"you_will_pay".localized;
        _amountPrefixLabel.font = UIFont.body;
        _amountPrefixLabel.textColor = UIColor.jpBlackColor;
        _amountPrefixLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _amountPrefixLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _amountPrefixLabel;
}

- (JPAddCardButton *)payButton {
    if (!_payButton) {
        _payButton = [JPAddCardButton new];
        _payButton.translatesAutoresizingMaskIntoConstraints = NO;
        _payButton.layer.cornerRadius = 4.0f;
        _payButton.titleLabel.font = UIFont.headline;
        [_payButton setBackgroundImage:UIColor.jpBlackColor.asImage forState:UIControlStateNormal];
        [_payButton setClipsToBounds:YES];
    }
    return _payButton;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        UIImage *image = [UIImage imageWithResourceName:@"no-cards"];
        _backgroundImageView = [[UIImageView alloc] initWithImage:image];
        _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

- (UIStackView *)amountStackView {
    if (!_amountStackView) {
        _amountStackView = [UIStackView verticalStackViewWithSpacing:0.0];
        _amountStackView.alignment = NSLayoutAttributeLeading;
    }
    return _amountStackView;
}

- (UIStackView *)mainStackView {
    if (!_mainStackView) {
        _mainStackView = [UIStackView horizontalStackViewWithSpacing:0.0];
    }
    return _mainStackView;
}

@end
