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

@interface JPPaymentMethodsHeaderView()

@property (nonatomic, strong) UILabel *emptyTitleLabel;
@property (nonatomic, strong) UILabel *emptyTextLabel;

@property (nonatomic, strong) UILabel *amountPrefixLabel;
@property (nonatomic, strong) UILabel *amountValueLabel;

@property (nonatomic, strong) JPAddCardButton *payButton;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation JPPaymentMethodsHeaderView

- (instancetype)initWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    if (self = [super init]) {
        [self setupViews];
        
        self.amountValueLabel.text = [NSString stringWithFormat:@"%@ %@",
                                      viewModel.amount.currency,
                                      viewModel.amount.amount];
        
        [self.payButton configureWithViewModel:viewModel.payButtonModel];
        
    }
    return self;
}

- (void)changePreviewWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel
                     animationType:(CardPreviewAnimationType)animationType {
    
}

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    
    
}

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

@end
