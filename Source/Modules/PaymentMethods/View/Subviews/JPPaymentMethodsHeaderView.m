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
#import "JPPaymentMethodsViewModel.h"
#import "JPAddCardButton.h"
#import "JPAmount.h"
#import "NSString+Localize.h"
#import "UIFont+Additions.h"
#import "UIColor+Judo.h"
#import "UIStackView+Additions.h"
#import "UIImage+Icons.h"
#import "UIView+Additions.h"

@interface JPPaymentMethodsHeaderView()

@property (nonatomic, strong) UILabel *emptyTitleLabel;
@property (nonatomic, strong) UILabel *emptyTextLabel;

@property (nonatomic, strong) UILabel *amountPrefixLabel;
@property (nonatomic, strong) UILabel *amountValueLabel;

@property (nonatomic, strong) JPAddCardButton *payButton;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIStackView *emptyTextStackView;
@property (nonatomic, strong) UIStackView *paymentStackView;
@property (nonatomic, strong) UIStackView *amountStackView;
@property (nonatomic, strong) UIStackView *mainStackView;

@end

@implementation JPPaymentMethodsHeaderView

//----------------------------------------------------------------------
#pragma mark - Initializers
//----------------------------------------------------------------------

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

//----------------------------------------------------------------------
#pragma mark - View Model Configuration
//----------------------------------------------------------------------

- (void)configureWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    self.amountValueLabel.text = [NSString stringWithFormat:@"%@ %@",
                                  viewModel.amount.currency,
                                  viewModel.amount.amount];
    
    [self.payButton configureWithViewModel:viewModel.payButtonModel];
}

//----------------------------------------------------------------------
#pragma mark - Layout Setup
//----------------------------------------------------------------------

- (void)setupViews {
    
    self.backgroundColor = UIColor.redColor;
    
    [self addSubview:self.backgroundImageView];
    [self setupBackgroundImageViewConstraints];
    
    [self setupStackViews];
    [self setupStackViewConstraints];
}

- (void)setupStackViews {
    [self.emptyTextStackView addArrangedSubview:self.emptyTitleLabel];
    [self.emptyTextStackView addArrangedSubview:self.emptyTextLabel];
    
    [self.amountStackView addArrangedSubview:self.amountPrefixLabel];
    [self.amountStackView addArrangedSubview:self.amountValueLabel];
    
    [self.paymentStackView addArrangedSubview:self.amountStackView];
    [self.paymentStackView addArrangedSubview:self.payButton];
    
    [self.mainStackView addArrangedSubview:self.emptyTextStackView];
    [self.mainStackView addArrangedSubview:self.paymentStackView];
    
    [self addSubview:self.mainStackView];
}

//----------------------------------------------------------------------
#pragma mark - Constraints Setup
//----------------------------------------------------------------------

- (void)setupBackgroundImageViewConstraints {
    [self.backgroundImageView pinToView:self withPadding:0.0];
}

- (void)setupStackViewConstraints {
    
    [self.amountStackView.topAnchor constraintEqualToAnchor:self.paymentStackView.topAnchor].active = YES;
    [self.amountStackView.bottomAnchor constraintEqualToAnchor:self.paymentStackView.bottomAnchor].active = YES;
    
    [self.payButton.heightAnchor constraintEqualToConstant:45].active = YES;
    [self.payButton.trailingAnchor constraintEqualToAnchor:self.mainStackView.trailingAnchor].active = YES;
    [self.payButton.leadingAnchor constraintEqualToAnchor:self.amountStackView.trailingAnchor].active = YES;

    [self.mainStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:24].active = true;
    [self.mainStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-24].active = true;
    [self.mainStackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:35].active = true;
    [self.mainStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-15].active = true;
}

//----------------------------------------------------------------------
#pragma mark - Lazy Properties
//----------------------------------------------------------------------

- (UILabel *)emptyTitleLabel {
    if (!_emptyTitleLabel) {
        _emptyTitleLabel = [UILabel new];
        _emptyTitleLabel.numberOfLines = 0;
        _emptyTitleLabel.text = @"choose_payment_method".localized;
        _emptyTitleLabel.font = [UIFont boldSystemFontOfSize:18]; //TODO: Replace with predefined fonts
        _emptyTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _emptyTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _emptyTitleLabel;
}

- (UILabel *)emptyTextLabel {
    if (!_emptyTextLabel) {
        _emptyTextLabel = [UILabel new];
        _emptyTextLabel.numberOfLines = 0;
        _emptyTextLabel.text = @"no_cards_added".localized;
        _emptyTextLabel.font = [UIFont systemFontOfSize:14]; //TODO: Replace with predefined fonts
        _emptyTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _emptyTextLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _emptyTextLabel;
}

- (UILabel *)amountValueLabel {
    if (!_amountValueLabel) {
        _amountValueLabel = [UILabel new];
        _amountValueLabel.numberOfLines = 0;
        _amountValueLabel.font = [UIFont boldSystemFontOfSize:24]; //TODO: Replace with predefined fonts
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
        _amountPrefixLabel.font = [UIFont boldSystemFontOfSize:14]; //TODO: Replace with predefined fonts
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
        _payButton.titleLabel.font = UIFont.largeTitleFont;
        _payButton.backgroundColor = UIColor.jpTextColor;
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

-(UIStackView *)emptyTextStackView {
    if(!_emptyTextStackView) {
        _emptyTextStackView = [UIStackView verticalStackViewWithSpacing:4.0];
        _emptyTextStackView.distribution = UIStackViewDistributionEqualSpacing;
        _emptyTextStackView.alignment = UIStackViewAlignmentLeading;
    }
    return  _emptyTextStackView;
}

-(UIStackView *)paymentStackView {
    if(!_paymentStackView) {
        _paymentStackView = [UIStackView horizontalStackViewWithSpacing:0.0];
        _paymentStackView.distribution = UIStackViewDistributionFillEqually;
        _paymentStackView.alignment = UIStackViewAlignmentTop;
    }
    return  _paymentStackView;
}

-(UIStackView *)amountStackView {
    if(!_amountStackView) {
        _amountStackView = [UIStackView verticalStackViewWithSpacing:0.0];
        _amountStackView.distribution = UIStackViewDistributionEqualSpacing;
        _amountStackView.alignment = UIStackViewAlignmentTop;
    }
    return  _amountStackView;
}

-(UIStackView *)mainStackView {
    if(!_mainStackView) {
        _mainStackView = [UIStackView verticalStackViewWithSpacing:50.0];
        _mainStackView.distribution = UIStackViewDistributionEqualSpacing;
        _mainStackView.alignment = UIStackViewAlignmentLeading;
    }
    return  _mainStackView;
}

@end
