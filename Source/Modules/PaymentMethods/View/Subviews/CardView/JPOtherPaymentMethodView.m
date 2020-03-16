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

#import "Functions.h"
#import "JPOtherPaymentMethodView.h"
#import "JPPaymentMethodsViewModel.h"
#import "NSString+Additions.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"
#import "UIImage+Additions.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

@interface JPOtherPaymentMethodView ()

@property (nonatomic, strong) UIImageView *leadingImageView;
@property (nonatomic, strong) UIImageView *trailingImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;

@end

@implementation JPOtherPaymentMethodView

#pragma mark - Constants

static const float kLeadingImageViewWidth = 109.0f;
static const float kLeadingImageViewHeight = 31.0f;
static const float kTrailingImageViewWidth = 30.0f;
static const float kContentPadding = 28.0f;


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

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.titleLabel.font = theme.title;
    self.titleLabel.textColor = theme.jpBlackColor;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {

    switch (viewModel.paymentMethodType) {
        case JPPaymentMethodTypeApplePay:
            self.leadingImageView.image = [UIImage imageWithIconName:@"apple-pay-icon"];
            self.titleLabel.text = @"apple-pay".localized;
            break;

        case JPPaymentMethodTypeIDeal:
            self.titleLabel.text = viewModel.bankModel.bankTitle;
            self.leadingImageView.image = [UIImage imageWithIconName:viewModel.bankModel.bankIconName];
            self.trailingImageView.image = [UIImage imageWithIconName:@"ideal-pay-icon"];
            break;

        default:
            break;
    }

    CGSize imageSize = self.leadingImageView.image.size;
    self.widthConstraint.constant = imageSize.width * (kLeadingImageViewHeight / imageSize.height);
}

#pragma mark - Layout Setup

- (void)setupViews {

    self.widthConstraint = [self.leadingImageView.widthAnchor constraintLessThanOrEqualToConstant:kLeadingImageViewWidth];

    [NSLayoutConstraint activateConstraints:@[
        [self.leadingImageView.heightAnchor constraintEqualToConstant:kLeadingImageViewHeight],
        self.widthConstraint,
        [self.trailingImageView.widthAnchor constraintEqualToConstant:kTrailingImageViewWidth],
    ]];

    UIStackView *bottomStackView = [UIStackView horizontalStackViewWithSpacing:0.0];
    [bottomStackView addArrangedSubview:self.leadingImageView];
    [bottomStackView addArrangedSubview:[UIView new]];
    [bottomStackView addArrangedSubview:self.trailingImageView];

    UIStackView *mainStackView = [UIStackView verticalStackViewWithSpacing:0.0];
    [mainStackView addArrangedSubview:self.titleLabel];
    [mainStackView addArrangedSubview:[UIView new]];
    [mainStackView addArrangedSubview:bottomStackView];

    [self addSubview:mainStackView];
    [mainStackView pinToView:self withPadding:kContentPadding * getWidthAspectRatio()];
}

#pragma mark - Lazy Properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UIImageView *)leadingImageView {
    if (!_leadingImageView) {
        _leadingImageView = [UIImageView new];
        _leadingImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leadingImageView;
}

- (UIImageView *)trailingImageView {
    if (!_trailingImageView) {
        _trailingImageView = [UIImageView new];
        _trailingImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _trailingImageView;
}

@end
