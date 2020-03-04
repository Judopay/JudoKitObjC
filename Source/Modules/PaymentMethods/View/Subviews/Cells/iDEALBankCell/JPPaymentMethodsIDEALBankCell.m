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
#import "UIFont+Additions.h"
#import "UIColor+Additions.h"
#import "UIStackView+Additions.h"
#import "UIImage+Additions.h"

@interface JPPaymentMethodsIDEALBankCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *checkmarkImageView;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIStackView *horizontalStackView;
@property (nonatomic, strong) UIStackView *verticalStackView;
@end

@implementation JPPaymentMethodsIDEALBankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupLayout];
        [self setupConstraints];
    }
    return self;
}

- (void)setupLayout {
    
    [self.horizontalStackView addArrangedSubview:self.iconImageView];
    [self.horizontalStackView addArrangedSubview:self.titleLabel];
    [self.horizontalStackView addArrangedSubview:self.checkmarkImageView];
    
    [self.verticalStackView addArrangedSubview:self.horizontalStackView];
    [self.verticalStackView addArrangedSubview:self.separatorView];
    
    [self addSubview:self.verticalStackView];
}

- (void)setupConstraints {
    
    NSArray *stackViewConstraints = @[
        [self.verticalStackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:17.0],
        [self.verticalStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.verticalStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:27.0],
        [self.verticalStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-27.0],
        [self.verticalStackView.heightAnchor constraintEqualToConstant:57.0f],
    ];
    
    NSArray *constraints = @[
        [self.iconImageView.widthAnchor constraintEqualToConstant:60.0],
        [self.checkmarkImageView.widthAnchor constraintEqualToConstant:34.0],
        [self.separatorView.heightAnchor constraintEqualToConstant:1.0],
//        [self.separatorView.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor]
    ];
    
    [NSLayoutConstraint activateConstraints:stackViewConstraints];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)configureWithViewModel:(JPPaymentMethodsModel *)viewModel {
    if ([viewModel isKindOfClass:JPPaymentMethodsIDEALBankModel.class]) {
        JPPaymentMethodsIDEALBankModel *bankModel;
        bankModel = (JPPaymentMethodsIDEALBankModel *)viewModel;
        self.iconImageView.image = [UIImage imageWithIconName:bankModel.bankIconName];
        self.titleLabel.text = bankModel.bankTitle;
    }
}

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
        _titleLabel.font = UIFont.bodyBold;
        _titleLabel.textColor = UIColor.jpBlackColor;
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
        _separatorView.backgroundColor = UIColor.jpLightGrayColor;
    }
    return _separatorView;
}

- (UIStackView *)horizontalStackView {
    if (!_horizontalStackView) {
        _horizontalStackView = [UIStackView horizontalStackViewWithSpacing:10.0];
    }
    return _horizontalStackView;
}

- (UIStackView *)verticalStackView {
    if (!_verticalStackView) {
        _verticalStackView = [UIStackView verticalStackViewWithSpacing:18.0];
    }
    return _verticalStackView;
}

@end
