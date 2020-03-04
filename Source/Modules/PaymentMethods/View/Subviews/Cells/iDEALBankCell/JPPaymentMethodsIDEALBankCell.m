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
@property (nonatomic, strong) UIStackView *stackView;
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
    
    [self.stackView addArrangedSubview:self.iconImageView];
    [self.stackView addArrangedSubview:self.titleLabel];
    [self.stackView addArrangedSubview:self.checkmarkImageView];
    
    [self addSubview:self.stackView];
    [self addSubview:self.separatorView];
}

- (void)setupConstraints {
        
    NSArray *stackViewConstraints = @[
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:18.0],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:27.0],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-27.0],
        [self.stackView.heightAnchor constraintEqualToConstant:24.0f],
    ];
    
    NSArray *constraints = @[
        [self.iconImageView.widthAnchor constraintEqualToConstant:60.0],
        [self.checkmarkImageView.widthAnchor constraintEqualToConstant:34.0],
    ];
    
    NSArray *separatorConstraints = @[
        [self.separatorView.heightAnchor constraintEqualToConstant:1.0],
        [self.separatorView.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.separatorView.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor constant:18.0],
        [self.separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
    ];
    
    [NSLayoutConstraint activateConstraints:stackViewConstraints];
    [NSLayoutConstraint activateConstraints:constraints];
    [NSLayoutConstraint activateConstraints:separatorConstraints];
}

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

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView horizontalStackViewWithSpacing:10.0];
    }
    return _stackView;
}

@end
