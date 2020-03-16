//
//  JPPaymentMethodsEmptyCardListCell.m
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

#import "JPPaymentMethodsEmptyCardListCell.h"
#import "JPPaymentMethodsViewModel.h"
#import "NSLayoutConstraint+Additions.h"
#import "UIImage+Additions.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

@interface JPPaymentMethodsEmptyCardListCell ()
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *addCardButton;
@property (nonatomic, copy) void (^onTransactionButtonTapHandler)(void);
@end

@implementation JPPaymentMethodsEmptyCardListCell

#pragma mark - Constants

static const float kHorizontalImageEdgeInsets = 12.0f;
static const float kLeadingTitleEdgeInset = -10.0f;
static const float kStackViewSpacing = 16.0f;
static const float kStackViewTopPadding = 60.0f;
static const float kAddCardButtonHeight = 36.0f;
static const float kAddCardBorderWidth = 1.0f;
static const float kAddCardCornerRadius = 4.0f;
static const int kConstraintPriority = 999;

#pragma mark - View model configuration

- (void)configureWithViewModel:(JPPaymentMethodsModel *)viewModel {

    [self setupViews];
    [self setupConstraints];

    JPPaymentMethodsEmptyListModel *emptyViewModel = (JPPaymentMethodsEmptyListModel *)viewModel;

    if (!emptyViewModel)
        return;

    self.titleLabel.text = emptyViewModel.title;

    [self.addCardButton setTitle:emptyViewModel.addCardButtonTitle
                        forState:UIControlStateNormal];

    UIImage *buttonImage = [UIImage imageWithIconName:emptyViewModel.addCardButtonIconName];
    [self.addCardButton setImage:buttonImage forState:UIControlStateNormal];
    self.addCardButton.imageView.contentMode = UIViewContentModeScaleAspectFit;

    CGFloat leadingInsets = kHorizontalImageEdgeInsets;
    self.addCardButton.imageEdgeInsets = UIEdgeInsetsMake(leadingInsets, 0, leadingInsets, 0);
    self.addCardButton.titleEdgeInsets = UIEdgeInsetsMake(0, kLeadingTitleEdgeInset, 0, 0);

    self.onTransactionButtonTapHandler = emptyViewModel.onTransactionButtonTapHandler;
}

#pragma mark - User actions

- (void)onTransactionButtonTap {
    self.onTransactionButtonTapHandler();
}

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.titleLabel.font = theme.headline;
    self.titleLabel.textColor = theme.jpBlackColor;
    self.addCardButton.titleLabel.font = theme.bodyBold;
    [self.addCardButton setBorderWithColor:theme.jpBlackColor
                                     width:kAddCardBorderWidth
                           andCornerRadius:kAddCardCornerRadius];
    [self.addCardButton setTitleColor:theme.jpBlackColor
                             forState:UIControlStateNormal];
}

#pragma mark - Layout setup

- (void)setupViews {
    self.backgroundColor = UIColor.clearColor;
    self.stackView = [UIStackView verticalStackViewWithSpacing:kStackViewSpacing];
    self.stackView.alignment = UIStackViewAlignmentCenter;
    [self.stackView addArrangedSubview:self.titleLabel];
    [self.stackView addArrangedSubview:self.addCardButton];
    [self addSubview:self.stackView];
}

- (void)setupConstraints {
    NSArray *constraints = @[
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor
                                                 constant:kStackViewTopPadding],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.addCardButton.heightAnchor constraintEqualToConstant:kAddCardButtonHeight],
    ];

    [NSLayoutConstraint activateConstraints:constraints withPriority:kConstraintPriority];
}

#pragma mark - Lazy properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)addCardButton {
    if (!_addCardButton) {
        _addCardButton = [UIButton new];
        [_addCardButton addTarget:self
                           action:@selector(onTransactionButtonTap)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCardButton;
}

@end
