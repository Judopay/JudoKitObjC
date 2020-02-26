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
#import "NSLayoutConstraint+Additions.h"
#import "NSString+Additions.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"
#import "UIImage+Additions.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

@interface JPPaymentMethodsCardCell ()

@property (nonatomic, strong) UIView *iconContainerView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation JPPaymentMethodsCardCell

#pragma mark - Constants

const float kCardHorizontalPadding = 24.0f;
const float kCardVerticalPadding = 13.0f;
const float kCardIconHeight = 36.0f;
const float kCardIconWidth = 52.0f;
const float kCardDefaultPadding = 8.0f;
const float kCardSmallPadding = 3.0f;

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

    NSString *subtitleText = [NSString stringWithFormat:@"card_subtitle".localized,
                                                        [JPCardNetwork nameOfCardNetwork:cardModel.cardNetwork],
                                                        cardModel.cardNumberLastFour];

    NSMutableAttributedString *subtitleLabelText = [[NSMutableAttributedString alloc] initWithString:subtitleText];

    if (subtitleText.length >= 4) {
        NSRange range = NSMakeRange(subtitleText.length - 4, 4);
        [subtitleLabelText addAttributes:@{NSFontAttributeName : UIFont.captionBold} range:range];
    }

    self.subtitleLabel.attributedText = subtitleLabelText;

    self.iconImageView.image = [UIImage imageForCardNetwork:cardModel.cardNetwork];

    NSString *iconName = cardModel.isSelected ? @"radio-on" : @"radio-off";

    UIImage *accesoryImage = [UIImage imageWithIconName:iconName];
    UIImageView *accessoryImageView = [[UIImageView alloc] initWithImage:accesoryImage];
    accessoryImageView.contentMode = UIViewContentModeScaleAspectFit;
    accessoryImageView.frame = CGRectMake(0, 0, kCardHorizontalPadding, kCardHorizontalPadding);
    self.accessoryView = accessoryImageView;

    [self setSubtitleExpirationStatus:cardModel.cardExpirationStatus];
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.clearColor;
    [self setupIconView];
    [self setupStackView];
    [self setupDisclosureIndicator];
}

- (void)setupIconView {
    [self.iconContainerView addSubview:self.iconImageView];
    [self.iconImageView pinToView:self.iconContainerView withPadding:kCardDefaultPadding];

    [NSLayoutConstraint activateConstraints:@[
        [self.iconContainerView.heightAnchor constraintEqualToConstant:kCardIconHeight],
        [self.iconContainerView.widthAnchor constraintEqualToConstant:kCardIconWidth],
    ]];
}

- (void)setupStackView {
    UIStackView *horizontalStackView = [UIStackView horizontalStackViewWithSpacing:kCardDefaultPadding];
    UIStackView *verticalStackView = [UIStackView verticalStackViewWithSpacing:kCardSmallPadding];

    [verticalStackView addArrangedSubview:self.titleLabel];
    [verticalStackView addArrangedSubview:self.subtitleLabel];

    [horizontalStackView addArrangedSubview:self.iconContainerView];
    [horizontalStackView addArrangedSubview:verticalStackView];

    [self.contentView addSubview:horizontalStackView];

    NSArray *constraints = @[
        [horizontalStackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor
                                                      constant:kCardVerticalPadding],
        [horizontalStackView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor
                                                         constant:-kCardVerticalPadding],
        [horizontalStackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor
                                                          constant:kCardHorizontalPadding],
        [horizontalStackView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor
                                                           constant:-kCardHorizontalPadding]
    ];

    [NSLayoutConstraint activateConstraints:constraints withPriority:999];
}

- (void)setupDisclosureIndicator {
    UIImage *disclosureIcon = [UIImage imageWithIconName:@"disclosure-icon"];
    UIImageView *disclosureImageView = [[UIImageView alloc] initWithImage:disclosureIcon];
    disclosureImageView.contentMode = UIViewContentModeScaleAspectFit;
    disclosureImageView.frame = CGRectMake(0, 0, kCardHorizontalPadding, kCardHorizontalPadding);
    self.editingAccessoryView = disclosureImageView;
}

- (void)setSubtitleExpirationStatus:(CardExpirationStatus)status {
    NSString *expirationStatus = @"";
    NSString *boldWord = @"";

    switch (status) {
        case CardNotExpired:
            break;
        case CardExpired:
            expirationStatus = @"is_expired".localized;
            boldWord = @"expired".localized;
            self.subtitleLabel.textColor = UIColor.jpRedColor;
            break;
        case CardExpiresSoon:
            expirationStatus = @"will_expire_soon".localized;
            boldWord = @"expire_soon".localized;
            self.subtitleLabel.textColor = UIColor.jpDarkGrayColor;
            break;
    }

    NSString *isExpiredString = [NSString stringWithFormat:@"%@%@", @" ", expirationStatus];
    NSMutableAttributedString *isExpiredText = [isExpiredString attributedStringWithBoldSubstring:boldWord];
    NSMutableAttributedString *subtitleText = [[NSMutableAttributedString alloc] initWithAttributedString:self.subtitleLabel.attributedText];
    [subtitleText appendAttributedString:isExpiredText];
    self.subtitleLabel.attributedText = subtitleText;
}

#pragma mark - Lazy instantiated properties

- (UIView *)iconContainerView {
    if (!_iconContainerView) {
        _iconContainerView = [UIView new];
        _iconContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        _iconContainerView.layer.borderColor = [UIColor colorFromHex:0xF5F5F6].CGColor;
        _iconContainerView.layer.borderWidth = 1.0f;
        _iconContainerView.layer.cornerRadius = 2.4f;
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
        _titleLabel.textColor = UIColor.jpBlackColor;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel new];
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleLabel.font = UIFont.caption;
        _subtitleLabel.textColor = UIColor.jpDarkGrayColor;
    }
    return _subtitleLabel;
}

@end
