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
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"
#import "UIImage+Icons.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

@interface JPPaymentMethodsEmptyCardListCell ()
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *addCardButton;
@property (nonatomic, copy) void (^onAddCardButtonTapHandler)(void);
@end

@implementation JPPaymentMethodsEmptyCardListCell

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

    self.addCardButton.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 0);
    self.addCardButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);

    self.onAddCardButtonTapHandler = emptyViewModel.onAddCardButtonTapHandler;
}

#pragma mark - User actions

- (void)onAddCardButtonTap {
    self.onAddCardButtonTapHandler();
}

#pragma mark - Layout setup

- (void)setupViews {
    self.stackView = [UIStackView verticalStackViewWithSpacing:16.0f];
    self.stackView.alignment = UIStackViewAlignmentCenter;
    [self.stackView addArrangedSubview:self.titleLabel];
    [self.stackView addArrangedSubview:self.addCardButton];
    [self addSubview:self.stackView];
}

- (void)setupConstraints {
    [self.addCardButton.widthAnchor constraintEqualToConstant:106.0f].active = YES;
    [self.addCardButton.heightAnchor constraintEqualToConstant:36.0f].active = YES;
    [self.stackView pinToView:self withPadding:25.0f];
}

#pragma mark - Lazy properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = UIFont.largeTitleFont;
        _titleLabel.textColor = UIColor.jpTextColor;
    }
    return _titleLabel;
}

- (UIButton *)addCardButton {
    if (!_addCardButton) {
        _addCardButton = [UIButton new];
        _addCardButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_addCardButton setBorderWithColor:UIColor.jpTextColor width:1.0f andCornerRadius:4.0f];
        [_addCardButton setTitleColor:UIColor.jpTextColor forState:UIControlStateNormal];
        _addCardButton.titleLabel.font = UIFont.smallTitleFont;

        [self.addCardButton addTarget:self
                               action:@selector(onAddCardButtonTap)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCardButton;
}

@end
