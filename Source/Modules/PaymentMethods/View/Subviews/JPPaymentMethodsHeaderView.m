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
#import "Functions.h"
#import "JPAmount.h"
#import "JPPaymentMethodsViewModel.h"
#import "JPTransactionButton.h"
#import "NSLayoutConstraint+Additions.h"
#import "NSString+Additions.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"
#import "UIImage+Additions.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

#import "JPPaymentMethodsCardHeaderView.h"
#import "JPPaymentMethodsEmptyHeaderView.h"

@interface JPPaymentMethodsHeaderView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) JPPaymentMethodsEmptyHeaderView *emptyHeaderView;
@property (nonatomic, strong) JPPaymentMethodsCardHeaderView *cardHeaderView;

@property (nonatomic, strong) UILabel *amountPrefixLabel;
@property (nonatomic, strong) UILabel *amountValueLabel;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIStackView *amountStackView;
@property (nonatomic, strong) UIStackView *paymentStackView;

@end

@implementation JPPaymentMethodsHeaderView

static const CGFloat bottomHeight = 86.0f;

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
    [self configureTopHeaderWithViewModel:viewModel];
    [self configureBottomHeaderWithViewModel:viewModel];
}

- (void)configureTopHeaderWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    [self removePreviousTopHeader];

    if (viewModel.cardModel == nil && viewModel.paymentMethodType == JPPaymentMethodTypeCard) {
        self.backgroundImageView.image = [UIImage imageWithResourceName:@"no-cards"];
        [self displayEmptyHeaderView];
        return;
    }

    self.backgroundImageView.image = [UIImage imageWithResourceName:@"gradient-background"];
    [self displayCardHeaderViewWithViewModel:viewModel];
}

- (void)configureBottomHeaderWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {

    for (UIView *view in self.paymentStackView.subviews) {
        [view removeFromSuperview];
    }

    [self.paymentStackView addArrangedSubview:self.amountStackView];
    [self configureAmountWithViewModel:viewModel];

    if (viewModel.paymentMethodType == JPPaymentMethodTypeApplePay) {

        PKPaymentButtonType type;
        type = viewModel.isApplePaySetUp ? PKPaymentButtonTypeBuy : PKPaymentButtonTypeSetUp;

        self.applePayButton = [self applePayButtonWithType:type];

        [self.paymentStackView addArrangedSubview:self.applePayButton];
        [self.applePayButton.widthAnchor constraintEqualToConstant:200.0].active = YES;
        return;
    }

    [self.paymentStackView addArrangedSubview:self.payButton];
    [self.payButton.widthAnchor constraintEqualToConstant:200.0].active = YES;
    [self.payButton configureWithViewModel:viewModel.payButtonModel];
}

- (void)configureAmountWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    self.amountValueLabel.text = [NSString stringWithFormat:@"%@%@",
                                                            viewModel.amount.currency.toCurrencySymbol,
                                                            viewModel.amount.amount];
}

#pragma mark - Helper methods

- (void)removePreviousTopHeader {
    self.emptyHeaderView.transform = CGAffineTransformMakeTranslation(0, 100);
    self.emptyHeaderView.alpha = 0.0;
    self.backgroundImageView.alpha = 0.0;

    [self.emptyHeaderView removeFromSuperview];
    [self.cardHeaderView removeFromSuperview];
}

- (void)displayEmptyHeaderView {
    [self.topView addSubview:self.emptyHeaderView];
    [self.emptyHeaderView pinToView:self.topView withPadding:0.0];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.emptyHeaderView.transform = CGAffineTransformIdentity;
                         self.emptyHeaderView.alpha = 1.0;
                         self.backgroundImageView.alpha = 1.0;
                     }];
}

- (void)displayCardHeaderViewWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    [self.topView addSubview:self.cardHeaderView];
    [self.cardHeaderView pinToView:self.topView withPadding:0.0];
    [self.cardHeaderView configureWithViewModel:viewModel];

    [self insertSubview:self.bottomView aboveSubview:self.topView];
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    [self setupBackgroundImageView];
    [self setupBottomView];
    [self setupTopView];
    [self setupAmountStackView];
    [self setupPaymentStackView];
}

- (void)setupBottomView {
    [self addSubview:self.bottomView];

    [NSLayoutConstraint activateConstraints:@[
        [self.bottomView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.bottomView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.bottomView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.bottomView.heightAnchor constraintEqualToConstant:bottomHeight]
    ]];
}

- (void)setupTopView {
    [self addSubview:self.topView];
    [NSLayoutConstraint activateConstraints:@[
        [self.topView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.topView.bottomAnchor constraintEqualToAnchor:self.bottomView.topAnchor],
        [self.topView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.topView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    ]];
}

- (void)setupBackgroundImageView {
    [self addSubview:self.backgroundImageView];
    [self.backgroundImageView pinToView:self withPadding:0.0];
}

- (void)setupAmountStackView {
    [self.amountStackView addArrangedSubview:self.amountPrefixLabel];
    [self.amountStackView addArrangedSubview:self.amountValueLabel];
    self.amountStackView.alignment = UIStackViewAlignmentLeading;
}

- (void)setupPaymentStackView {
    self.paymentStackView.distribution = UIStackViewDistributionFill;
    [self.bottomView addSubview:self.paymentStackView];

    [NSLayoutConstraint activateConstraints:@[
        [self.paymentStackView.leadingAnchor constraintEqualToAnchor:self.bottomView.leadingAnchor
                                                            constant:24.0],
        [self.paymentStackView.trailingAnchor constraintEqualToAnchor:self.bottomView.trailingAnchor
                                                             constant:-24.0],
        [self.paymentStackView.topAnchor constraintEqualToAnchor:self.bottomView.topAnchor
                                                        constant:20.0],
        [self.paymentStackView.bottomAnchor constraintEqualToAnchor:self.bottomView.bottomAnchor
                                                           constant:-20.0],
    ]];
}

#pragma mark - Lazy Properties

- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, bottomHeight);

        UIColor *clearWhite = [UIColor.whiteColor colorWithAlphaComponent:0.0];
        gradient.colors = @[ (id)clearWhite.CGColor, (id)UIColor.whiteColor.CGColor ];
        gradient.locations = @[ @0.0, @0.3 ];

        [_bottomView.layer insertSublayer:gradient atIndex:0];
    }
    return _bottomView;
}

- (UIStackView *)amountStackView {
    if (!_amountStackView) {
        _amountStackView = [UIStackView verticalStackViewWithSpacing:0.0];
        _amountStackView.alignment = NSLayoutAttributeLeading;
    }
    return _amountStackView;
}

- (UIStackView *)paymentStackView {
    if (!_paymentStackView) {
        _paymentStackView = [UIStackView horizontalStackViewWithSpacing:0.0];
    }
    return _paymentStackView;
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

- (JPTransactionButton *)payButton {
    if (!_payButton) {
        _payButton = [JPTransactionButton new];
        _payButton.translatesAutoresizingMaskIntoConstraints = NO;
        _payButton.layer.cornerRadius = 4.0f;
        _payButton.titleLabel.font = UIFont.headline;
        [_payButton setBackgroundImage:UIColor.blackColor.asImage forState:UIControlStateNormal];
        [_payButton setClipsToBounds:YES];
    }
    return _payButton;
}

- (PKPaymentButton *)applePayButton {
    if (!_applePayButton) {
        _applePayButton = [self applePayButtonWithType:PKPaymentButtonTypeSetUp];
    }
    return _applePayButton;
}

- (PKPaymentButton *)applePayButtonWithType:(PKPaymentButtonType)type {
    return [PKPaymentButton buttonWithType:type
                                     style:PKPaymentButtonStyleBlack];
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

@end
