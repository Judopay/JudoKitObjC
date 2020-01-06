//
//  JPPaymentMethodsCardCell.m
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

#import "JPPaymentMethodsCardCell.h"
#import "JPCardNetwork.h"
#import "JPPaymentMethodsViewModel.h"
#import "NSString+Additions.h"
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"
#import "UIImage+Icons.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

@interface JPPaymentMethodsCardCell ()

@property (nonatomic, strong) UIView *iconContainerView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation JPPaymentMethodsCardCell

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

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPPaymentMethodsModel *)viewModel {

    if (![viewModel isKindOfClass:JPPaymentMethodsCardModel.class]) {
        return;
    }

    JPPaymentMethodsCardModel *cardModel = (JPPaymentMethodsCardModel *)viewModel;
    self.titleLabel.text = cardModel.cardTitle;

    self.subtitleLabel.text = [NSString stringWithFormat:@"card_subtitle".localized,
                                                         [JPCardNetwork nameOfCardNetwork:cardModel.cardNetwork],
                                                         cardModel.cardNumberLastFour];

    self.iconImageView.image = [UIImage imageForCardNetwork:cardModel.cardNetwork];

    NSString *iconName = cardModel.isSelected ? @"radio-on" : @"radio-off";

    UIImage *accesoryImage = [UIImage imageWithIconName:iconName];
    UIImageView *accessoryImageView = [[UIImageView alloc] initWithImage:accesoryImage];
    accessoryImageView.contentMode = UIViewContentModeScaleAspectFit;
    accessoryImageView.frame = CGRectMake(0, 0, 24, 24);
    self.accessoryView = accessoryImageView;
}

#pragma mark - Layout Setup

- (void)setupViews {
    UIStackView *horizontalStackView = [UIStackView horizontalStackViewWithSpacing:8.0];
    UIStackView *verticalStackView = [UIStackView verticalStackViewWithSpacing:3.0];

    [verticalStackView addArrangedSubview:self.titleLabel];
    [verticalStackView addArrangedSubview:self.subtitleLabel];

    [self.iconContainerView addSubview:self.iconImageView];
    [self.iconImageView pinToView:self.iconContainerView withPadding:8.0f];

    [horizontalStackView addArrangedSubview:self.iconContainerView];
    [horizontalStackView addArrangedSubview:verticalStackView];

    [self addSubview:horizontalStackView];
    [horizontalStackView pinToAnchors:AnchorTypeTop | AnchorTypeBottom forView:self withPadding:13.0f];
    [horizontalStackView pinToAnchors:AnchorTypeLeading | AnchorTypeTrailing forView:self withPadding:24.0f];
}

#pragma mark - Lazy instantiated properties

- (UIView *)iconContainerView {
    if (!_iconContainerView) {
        _iconContainerView = [UIView new];
        _iconContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        _iconContainerView.layer.borderColor = [UIColor colorFromHex:0xF5F5F6].CGColor;
        _iconContainerView.layer.borderWidth = 1.0f;
        _iconContainerView.layer.cornerRadius = 2.4f;
        [_iconContainerView.heightAnchor constraintEqualToConstant:36.0f].active = YES;
        [_iconContainerView.widthAnchor constraintEqualToConstant:52.0f].active = YES;
    }
    return _iconContainerView;
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
        _titleLabel.textColor = UIColor.jpTextColor;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel new];
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleLabel.font = UIFont.caption;
        _subtitleLabel.textColor = UIColor.jpSubtitleColor;
    }
    return _subtitleLabel;
}

@end
