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

#import "JPCardPaymentMethodView.h"
#import "Functions.h"
#import "JPPaymentMethodsViewModel.h"
#import "NSString+Additions.h"
#import "UIImage+Additions.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

@interface JPCardPaymentMethodView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *expiryDateLabel;
@property (nonatomic, strong) UILabel *cardNumberLabel;
@property (nonatomic, strong) JPTheme *theme;

@end

@implementation JPCardPaymentMethodView

#pragma mark - Constants

const float kCardLogoShadowOpacity = 0.2f;
const float kCardLogoShadowOffset = 0.0f;
const int kExpiryDateNumberOfLines = 2;
const float kCardLogoSize = 50.0f;
const float kCardMainStackViewPadding = 28.0f;
const float kCardTitleStackViewSpacing = 24.0f;
const float kCardDefaultStackViewsSpacing = 0.0f;
const int kSubstringPatternOffset = 4;

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
    self.theme = theme;
    self.titleLabel.textColor = theme.jpWhiteColor;
    self.titleLabel.font = theme.title;
    self.cardNumberLabel.font = theme.bodyBold;
    self.cardNumberLabel.textColor = theme.jpLightGrayColor;
    self.expiryDateLabel.font = theme.bodyBold;
    self.expiryDateLabel.textColor = theme.jpLightGrayColor;
}

#pragma mark - View Model Configuration

- (void)configureWithTitle:(NSString *)title
                expiryDate:(NSString *)expiryDate
                   network:(CardNetwork)cardNetwork
              cardLastFour:(NSString *)cardLastFour
               patternType:(JPCardPatternType)patternType {

    self.titleLabel.text = title;
    self.expiryDateLabel.text = expiryDate;

    JPCardNetwork *network = [JPCardNetwork cardNetworkWithType:cardNetwork];
    NSString *substringPattern = [network.numberPattern substringToIndex:network.numberPattern.length - kSubstringPatternOffset];
    NSString *stylizedPattern = [substringPattern stringByReplacingOccurrencesOfString:@"X" withString:@"•"];

    self.cardNumberLabel.text = [NSString stringWithFormat:@"%@ %@",
                                                           stylizedPattern,
                                                           cardLastFour];

    self.logoImageView.image = [UIImage headerImageForCardNetwork:cardNetwork];

    JPCardPattern *pattern = [JPCardPattern patternWithType:patternType];
    self.backgroundColor = pattern.color;
    self.backgroundImageView.image = pattern.image;
}

- (void)configureExpirationStatus:(CardExpirationStatus)expirationStatus {
    if (expirationStatus == CardExpired) {
        [self setCardAsExpired];
    }
}

#pragma mark - Layout Setup

- (void)setupViews {

    [self addSubview:self.backgroundImageView];
    [self.backgroundImageView pinToView:self withPadding:kCardDefaultStackViewsSpacing];

    UIStackView *bottomStackView = [UIStackView horizontalStackViewWithSpacing:kCardDefaultStackViewsSpacing];
    [bottomStackView addArrangedSubview:self.cardNumberLabel];
    [bottomStackView addArrangedSubview:self.expiryDateLabel];

    UIStackView *cardTitleStackView = [UIStackView verticalStackViewWithSpacing:kCardTitleStackViewSpacing * getWidthAspectRatio()];
    [cardTitleStackView addArrangedSubview:self.titleLabel];
    [cardTitleStackView addArrangedSubview:bottomStackView];

    UIStackView *logoStackView = [UIStackView horizontalStackViewWithSpacing:kCardDefaultStackViewsSpacing];
    [logoStackView addArrangedSubview:self.logoImageView];
    [logoStackView addArrangedSubview:[UIView new]];

    UIStackView *mainStackView = [UIStackView verticalStackViewWithSpacing:kCardDefaultStackViewsSpacing];
    [mainStackView addArrangedSubview:logoStackView];
    [mainStackView addArrangedSubview:[UIView new]];
    [mainStackView addArrangedSubview:cardTitleStackView];

    [self.logoImageView.widthAnchor constraintEqualToConstant:kCardLogoSize * getWidthAspectRatio()].active = YES;
    [self.logoImageView.heightAnchor constraintEqualToConstant:kCardLogoSize * getWidthAspectRatio()].active = YES;

    [self addSubview:mainStackView];
    [mainStackView pinToView:self withPadding:kCardMainStackViewPadding * getWidthAspectRatio()];
}

- (void)setCardAsExpired {
    self.backgroundColor = self.theme.jpDarkGrayColor;
    self.expiryDateLabel.textColor = self.theme.jpRedColor;
    self.expiryDateLabel.numberOfLines = kExpiryDateNumberOfLines;
    NSDictionary *attrDict = @{NSFontAttributeName : self.theme.caption};
    NSString *expiredString = [NSString stringWithFormat:@"%@ %@", @"expired".localized, @"\r"];
    NSMutableAttributedString *expiredText = [[NSMutableAttributedString alloc] initWithString:expiredString attributes:attrDict];
    NSAttributedString *expiryDate = [[NSAttributedString alloc] initWithString:self.expiryDateLabel.text];
    [expiredText appendAttributedString:expiryDate];
    self.expiryDateLabel.attributedText = expiredText;
}
#pragma mark - Lazy Properties

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backgroundImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UILabel *)cardNumberLabel {
    if (!_cardNumberLabel) {
        _cardNumberLabel = [UILabel new];
        _cardNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _cardNumberLabel;
}

- (UILabel *)expiryDateLabel {
    if (!_expiryDateLabel) {
        _expiryDateLabel = [UILabel new];
        _expiryDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _expiryDateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _expiryDateLabel;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        _logoImageView.layer.shadowColor = UIColor.blackColor.CGColor;
        _logoImageView.layer.shadowOpacity = kCardLogoShadowOpacity;
        _logoImageView.layer.shadowOffset = CGSizeMake(kCardLogoShadowOffset, kCardLogoShadowOffset);
        _logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoImageView;
}

@end
