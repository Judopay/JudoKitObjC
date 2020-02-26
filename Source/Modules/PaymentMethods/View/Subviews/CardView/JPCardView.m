//
//  JPCardView.m
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

#import "JPCardView.h"
#import "Functions.h"
#import "JPCardCustomizationViewModel.h"
#import "JPCardNetwork.h"
#import "JPCardPaymentMethodView.h"
#import "JPOtherPaymentMethodView.h"
#import "JPPaymentMethodsViewModel.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"
#import "UIImage+Additions.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

@interface JPCardView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) JPCardPaymentMethodView *cardPaymentView;
@property (nonatomic, strong) JPOtherPaymentMethodView *otherPaymentView;

@end

@implementation JPCardView

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
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

- (void)configureWithPaymentMethodModel:(JPPaymentMethodsHeaderModel *)viewModel {
    [self.contentView removeAllSubviews];

    switch (viewModel.paymentMethodType) {
        case JPPaymentMethodTypeCard:
            [self.contentView addSubview:self.cardPaymentView];
            [self.cardPaymentView pinToView:self.contentView withPadding:0.0];
            [self.cardPaymentView configureWithTitle:viewModel.cardModel.cardTitle
                                          expiryDate:viewModel.cardModel.cardExpiryDate
                                             network:viewModel.cardModel.cardNetwork
                                        cardLastFour:viewModel.cardModel.cardNumberLastFour
                                         patternType:viewModel.cardModel.cardPatternType];

            [self.cardPaymentView configureExpirationStatus:viewModel.cardModel.cardExpirationStatus];
            break;

        default:
            [self.contentView addSubview:self.otherPaymentView];
            [self.otherPaymentView pinToView:self.contentView withPadding:0.0];
            [self.otherPaymentView configureWithViewModel:viewModel];
            break;
    }
}

- (void)configureWithCustomizationModel:(JPCardCustomizationHeaderModel *)viewModel {
    [self.contentView addSubview:self.cardPaymentView];
    [self.cardPaymentView pinToView:self.contentView withPadding:0.0];
    [self.cardPaymentView configureWithTitle:viewModel.cardTitle
                                  expiryDate:viewModel.cardExpiryDate
                                     network:viewModel.cardNetwork
                                cardLastFour:viewModel.cardLastFour
                                 patternType:viewModel.cardPatternType];
}

#pragma mark - Layout Setup

- (void)setupViews {
    [self addSubview:self.contentView];
    [self.contentView pinToView:self withPadding:0.0];
}

#pragma mark - Lazy Properties

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.clipsToBounds = YES;
        _contentView.layer.cornerRadius = 10.0;
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}

- (JPCardPaymentMethodView *)cardPaymentView {
    if (!_cardPaymentView) {
        _cardPaymentView = [JPCardPaymentMethodView new];
        _cardPaymentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _cardPaymentView;
}

- (JPOtherPaymentMethodView *)otherPaymentView {
    if (!_otherPaymentView) {
        _otherPaymentView = [JPOtherPaymentMethodView new];
        _otherPaymentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _otherPaymentView;
}

@end
