//
//  JPPaymentMethodsCardListHeaderCell.m
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

#import "JPPaymentMethodsCardListHeaderCell.h"
#import "JPPaymentMethodsViewModel.h"
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"
#import "UIView+Additions.h"

@implementation JPPaymentMethodsCardListHeaderCell

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

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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

- (void)configureWithViewModel:(JPPaymentMethodsModel *)viewModel {

    if (![viewModel isKindOfClass:JPPaymentMethodsCardHeaderModel.class]) {
        return;
    }

    JPPaymentMethodsCardHeaderModel *headerModel;
    headerModel = (JPPaymentMethodsCardHeaderModel *)viewModel;

    self.titleLabel.text = headerModel.title;
    [self.actionButton setTitle:headerModel.editButtonTitle forState:UIControlStateNormal];
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.titleLabel];
    [self addSubview:self.actionButton];

    [self.titleLabel pinToAnchors:AnchorTypeLeading forView:self withPadding:24.0];
    [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;

    [self.actionButton pinToAnchors:AnchorTypeTrailing forView:self withPadding:24.0];
    [self.actionButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
}

#pragma mark - Lazy instantiated properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textColor = UIColor.jpTextColor;
        _titleLabel.font = UIFont.headline;
    }
    return _titleLabel;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton new];
        _actionButton.translatesAutoresizingMaskIntoConstraints = NO;
        _actionButton.titleLabel.font = UIFont.bodyBold;
        [_actionButton setTitleColor:UIColor.jpTextColor forState:UIControlStateNormal];
    }
    return _actionButton;
}

@end
