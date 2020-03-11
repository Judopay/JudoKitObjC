//
//  JPPaymentMethodsIDEALBankCell.m
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

#import "JPPaymentMethodsIDEALBankCell.h"
#import "JPPaymentMethodsViewModel.h"
#import "UIImage+Additions.h"
#import "UIStackView+Additions.h"

@interface JPPaymentMethodsIDEALBankCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *checkmarkImageView;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation JPPaymentMethodsIDEALBankCell

#pragma mark - Constants

const float kiDEALBankVerticalPadding = 18.0f;
const float kiDEALBankStackViewHorizontalPadding = 27.0f;
const float kiDEALBankStackViewHeight = 24.0f;
const float kiDEALBankIconWidth = 60.0f;
const float kiDEALBankCheckmarkWidth = 34.0f;
const float kiDEALBankSeparatorHeight = 1.0f;
const float kiDEALBankStackViewSpacing = 10.0f;

#pragma mark - Initializers

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupLayout];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.titleLabel.font = theme.bodyBold;
    self.titleLabel.textColor = theme.jpBlackColor;
    self.separatorView.backgroundColor = theme.jpLightGrayColor;
}

#pragma mark - Layout setup

- (void)setupLayout {
    self.backgroundColor = UIColor.whiteColor;
    [self.stackView addArrangedSubview:self.iconImageView];
    [self.stackView addArrangedSubview:self.titleLabel];
    [self.stackView addArrangedSubview:self.checkmarkImageView];

    [self addSubview:self.stackView];
    [self addSubview:self.separatorView];
}

- (void)setupConstraints {

    NSArray *stackViewConstraints = @[
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor
                                                 constant:kiDEALBankVerticalPadding],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                     constant:kiDEALBankStackViewHorizontalPadding],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                      constant:-kiDEALBankStackViewHorizontalPadding],
        [self.stackView.heightAnchor constraintEqualToConstant:kiDEALBankStackViewHeight],
    ];

    NSArray *constraints = @[
        [self.iconImageView.widthAnchor constraintEqualToConstant:kiDEALBankIconWidth],
        [self.checkmarkImageView.widthAnchor constraintEqualToConstant:kiDEALBankCheckmarkWidth],
    ];

    NSArray *separatorConstraints = @[
        [self.separatorView.heightAnchor constraintEqualToConstant:kiDEALBankSeparatorHeight],
        [self.separatorView.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.separatorView.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor
                                                     constant:kiDEALBankVerticalPadding],
        [self.separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
    ];

    [NSLayoutConstraint activateConstraints:stackViewConstraints];
    [NSLayoutConstraint activateConstraints:constraints];
    [NSLayoutConstraint activateConstraints:separatorConstraints];
}

#pragma mark - View Model configuration

- (void)configureWithViewModel:(JPPaymentMethodsModel *)viewModel {
    if ([viewModel isKindOfClass:JPPaymentMethodsIDEALBankModel.class]) {
        JPPaymentMethodsIDEALBankModel *bankModel;
        bankModel = (JPPaymentMethodsIDEALBankModel *)viewModel;
        self.iconImageView.image = [UIImage imageWithIconName:bankModel.bankIconName];
        self.titleLabel.text = bankModel.bankTitle;

        NSString *checkmarkIconName = bankModel.isSelected ? @"radio-on" : @"radio-off";
        self.checkmarkImageView.image = [UIImage imageWithIconName:checkmarkIconName];
    }
}

#pragma mark - Lazy properties

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UIImageView *)checkmarkImageView {
    if (!_checkmarkImageView) {
        _checkmarkImageView = [UIImageView new];
        _checkmarkImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _checkmarkImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _checkmarkImageView;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [UIView new];
        _separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _separatorView;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView horizontalStackViewWithSpacing:kiDEALBankStackViewSpacing];
    }
    return _stackView;
}

@end
