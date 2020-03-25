//
//  JPTransactionView.m
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

#import "JPTransactionView.h"
#import "JPCardInputField.h"
#import "JPCardNumberField.h"
#import "JPLoadingButton.h"
#import "JPRoundedCornerView.h"
#import "JPTransactionButton.h"
#import "JPTransactionViewModel.h"
#import "NSString+Additions.h"
#import "UIColor+Additions.h"
#import "UIImage+Additions.h"
#import "UIStackView+Additions.h"
#import "UITextField+Additions.h"
#import "UIView+Additions.h"

@interface JPTransactionView ()

@property (nonatomic, strong) JPRoundedCornerView *bottomSlider;
@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIImageView *lockImageView;
@property (nonatomic, strong) UILabel *securityMessageLabel;
@property (nonatomic, strong) NSLayoutConstraint *sliderHeightConstraint;
@property (nonatomic, copy) void (^onScanCardButtonTapHandler)(void);

@end

@implementation JPTransactionView

#pragma mark - Constants

static const float kStandardSliderHeight = 365.0f;
static const float kAVSSliderHeight = 410.0f;
static const float kScanButtonCornerRadius = 4.0f;
static const float kScanButtonBorderWidth = 1.0f;
static const float kContentHorizontalPadding = 24.0f;
static const float kContentVerticalPadding = 20.0f;
static const float kScanCardHeight = 36.0f;
static const float kInputFieldHeight = 44.0f;
static const float kAddCardButtonHeight = 46.0f;
static const float kLockImageWidth = 17.0f;
static const float kSliderCornerRadius = 10.0f;
static const float kTightContentSpacing = 8.0f;
static const float kLooseContentSpacing = 16.0;

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.cancelButton.titleLabel.font = theme.bodyBold;
    [self.cancelButton setTitleColor:theme.jpBlackColor
                            forState:UIControlStateNormal];

    self.scanCardButton.titleLabel.font = theme.bodyBold;
    [self.scanCardButton setTitleColor:theme.jpBlackColor
                              forState:UIControlStateNormal];
    [self.scanCardButton setBorderWithColor:theme.jpBlackColor
                                      width:kScanButtonBorderWidth
                            andCornerRadius:kScanButtonCornerRadius];

    self.addCardButton.titleLabel.font = theme.headline;
    self.addCardButton.layer.cornerRadius = theme.buttonCornerRadius;
    [self.addCardButton setBackgroundImage:theme.buttonColor.asImage
                                  forState:UIControlStateNormal];
    [self.addCardButton setTitleColor:theme.buttonTitleColor
                             forState:UIControlStateNormal];

    self.securityMessageLabel.font = theme.caption;
    self.securityMessageLabel.textColor = theme.jpDarkGrayColor;

    [self.cardNumberTextField applyTheme:theme];
    [self.cardHolderTextField applyTheme:theme];
    [self.cardExpiryTextField applyTheme:theme];
    [self.secureCodeTextField applyTheme:theme];
    [self.countryTextField applyTheme:theme];
    [self.postcodeTextField applyTheme:theme];
}

#pragma mark - View model configuration

- (void)configureWithViewModel:(JPTransactionViewModel *)viewModel {
    self.sliderHeightConstraint.constant = kStandardSliderHeight;
    [self.cardNumberTextField configureWithViewModel:viewModel.cardNumberViewModel];
    [self.cardHolderTextField configureWithViewModel:viewModel.cardholderNameViewModel];
    [self.cardExpiryTextField configureWithViewModel:viewModel.expiryDateViewModel];
    [self.secureCodeTextField configureWithViewModel:viewModel.secureCodeViewModel];
    [self.addCardButton configureWithViewModel:viewModel.addCardButtonViewModel];

    self.countryTextField.hidden = !viewModel.shouldDisplayAVSFields;
    self.postcodeTextField.hidden = !viewModel.shouldDisplayAVSFields;

    if (viewModel.shouldDisplayAVSFields) {
        self.sliderHeightConstraint.constant = kAVSSliderHeight;
        [self.countryTextField configureWithViewModel:viewModel.countryPickerViewModel];
        [self.postcodeTextField configureWithViewModel:viewModel.postalCodeInputViewModel];
    }
}

#pragma mark - Helper methods

- (void)enableUserInterface:(BOOL)shouldEnable {
    self.cancelButton.enabled = shouldEnable;
    self.scanCardButton.enabled = shouldEnable;
    self.cardNumberTextField.enabled = shouldEnable;
    self.cardHolderTextField.enabled = shouldEnable;
    self.cardExpiryTextField.enabled = shouldEnable;
    self.secureCodeTextField.enabled = shouldEnable;
    self.countryTextField.enabled = shouldEnable;
    self.postcodeTextField.enabled = shouldEnable;
    self.addCardButton.enabled = shouldEnable;
}

#pragma mark - Layout setup

- (void)setupSubviews {
    [self addSubview:self.backgroundView];
    [self addSubview:self.bottomSlider];
    [self.bottomSlider addSubview:self.mainStackView];
}

- (void)setupConstraints {
    [self.backgroundView pinToView:self withPadding:0.0];
    [self setupBottomSliderConstraints];
    [self setupMainStackViewConstraints];
    [self setupContentsConstraints];
}

- (void)setupBottomSliderConstraints {
    [self.bottomSlider pinToAnchors:AnchorTypeLeading | AnchorTypeTrailing forView:self];

    self.bottomSliderConstraint = [self.bottomSlider.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    self.sliderHeightConstraint = [self.bottomSlider.heightAnchor constraintEqualToConstant:kStandardSliderHeight];

    self.bottomSliderConstraint.active = YES;
    self.sliderHeightConstraint.active = YES;
}

- (void)setupMainStackViewConstraints {

    [self.mainStackView pinToAnchors:AnchorTypeTop | AnchorTypeBottom
                             forView:self.bottomSlider
                         withPadding:kContentVerticalPadding];

    [self.mainStackView pinToAnchors:AnchorTypeLeading | AnchorTypeTrailing
                             forView:self.bottomSlider
                         withPadding:kContentHorizontalPadding];
}

- (void)setupContentsConstraints {
    NSArray *constraints = @[
        [self.scanCardButton.heightAnchor constraintEqualToConstant:kScanCardHeight],
        [self.cardNumberTextField.heightAnchor constraintEqualToConstant:kInputFieldHeight],
        [self.cardHolderTextField.heightAnchor constraintEqualToConstant:kInputFieldHeight],
        [self.cardExpiryTextField.heightAnchor constraintEqualToConstant:kInputFieldHeight],
        [self.secureCodeTextField.heightAnchor constraintEqualToConstant:kInputFieldHeight],
        [self.countryTextField.heightAnchor constraintEqualToConstant:kInputFieldHeight],
        [self.postcodeTextField.heightAnchor constraintEqualToConstant:kInputFieldHeight],
        [self.addCardButton.heightAnchor constraintEqualToConstant:kAddCardButtonHeight],
        [self.lockImageView.widthAnchor constraintEqualToConstant:kLockImageWidth],
    ];

    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - Lazily instantiated properties

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = UIColor.clearColor;
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _backgroundView;
}

- (UIView *)bottomSlider {
    if (!_bottomSlider) {
        UIRectCorner corners = UIRectCornerTopRight | UIRectCornerTopLeft;
        _bottomSlider = [[JPRoundedCornerView alloc] initWithRadius:kSliderCornerRadius
                                                         forCorners:corners];
        _bottomSlider.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomSlider.backgroundColor = UIColor.whiteColor;
    }
    return _bottomSlider;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_cancelButton setTitle:@"cancel".localized forState:UIControlStateNormal];
    }
    return _cancelButton;
}

- (UIButton *)scanCardButton {
    if (!_scanCardButton) {
        _scanCardButton = [UIButton new];
        _scanCardButton.translatesAutoresizingMaskIntoConstraints = NO;

        [_scanCardButton setTitle:@"scan_card".localized forState:UIControlStateNormal];
        [_scanCardButton setImage:[UIImage imageWithIconName:@"scan-card"]
                         forState:UIControlStateNormal];
        _scanCardButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _scanCardButton.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 0);
        _scanCardButton.contentEdgeInsets = UIEdgeInsetsMake(5, -20, 5, 5);
    }
    return _scanCardButton;
}

- (JPCardNumberField *)cardNumberTextField {
    if (!_cardNumberTextField) {
        _cardNumberTextField = [JPCardNumberField new];
        _cardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _cardNumberTextField;
}

- (JPCardInputField *)cardHolderTextField {
    if (!_cardHolderTextField) {
        _cardHolderTextField = [JPCardInputField new];
    }
    return _cardHolderTextField;
}

- (JPCardInputField *)cardExpiryTextField {
    if (!_cardExpiryTextField) {
        _cardExpiryTextField = [JPCardInputField new];
        _cardExpiryTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _cardExpiryTextField;
}

- (JPCardInputField *)secureCodeTextField {
    if (!_secureCodeTextField) {
        _secureCodeTextField = [JPCardInputField new];
        _secureCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _secureCodeTextField;
}

- (JPCardInputField *)countryTextField {
    if (!_countryTextField) {
        _countryTextField = [JPCardInputField new];
        _countryTextField.inputView = self.countryPickerView;
    }
    return _countryTextField;
}

- (UIPickerView *)countryPickerView {
    if (!_countryPickerView) {
        _countryPickerView = [UIPickerView new];
    }
    return _countryPickerView;
}

- (JPCardInputField *)postcodeTextField {
    if (!_postcodeTextField) {
        _postcodeTextField = [JPCardInputField new];
    }
    return _postcodeTextField;
}

- (JPTransactionButton *)addCardButton {
    if (!_addCardButton) {
        _addCardButton = [JPTransactionButton new];
        _addCardButton.translatesAutoresizingMaskIntoConstraints = NO;
        _addCardButton.clipsToBounds = YES;
    }
    return _addCardButton;
}

- (UIImageView *)lockImageView {
    if (!_lockImageView) {
        _lockImageView = [UIImageView new];
        _lockImageView.contentMode = UIViewContentModeScaleAspectFit;
        _lockImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _lockImageView.image = [UIImage imageWithIconName:@"lock-icon"];
    }
    return _lockImageView;
}

- (UILabel *)securityMessageLabel {
    if (!_securityMessageLabel) {
        _securityMessageLabel = [UILabel new];
        _securityMessageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _securityMessageLabel.text = @"secure_server_transmission".localized;
        _securityMessageLabel.numberOfLines = 0;
    }
    return _securityMessageLabel;
}

#pragma mark - Stack Views

- (UIStackView *)mainStackView {
    if (!_mainStackView) {
        _mainStackView = [UIStackView verticalStackViewWithSpacing:kLooseContentSpacing];

        [_mainStackView addArrangedSubview:self.topButtonStackView];
        [_mainStackView addArrangedSubview:self.inputFieldsStackView];
        [_mainStackView addArrangedSubview:self.buttonStackView];
    }
    return _mainStackView;
}

- (UIStackView *)topButtonStackView {
    UIStackView *stackView = [UIStackView new];

    [stackView addArrangedSubview:self.cancelButton];
    [stackView addArrangedSubview:[UIView new]];
    [stackView addArrangedSubview:self.scanCardButton];

    return stackView;
}

- (UIStackView *)additionalInputFieldsStackView {
    UIStackView *stackView = [UIStackView horizontalStackViewWithSpacing:kTightContentSpacing];
    stackView.distribution = UIStackViewDistributionFillEqually;

    [stackView addArrangedSubview:self.cardExpiryTextField];
    [stackView addArrangedSubview:self.secureCodeTextField];

    return stackView;
}

- (UIStackView *)inputFieldsStackView {
    UIStackView *stackView = [UIStackView verticalStackViewWithSpacing:kTightContentSpacing];

    [stackView addArrangedSubview:self.cardNumberTextField];
    [stackView addArrangedSubview:self.cardHolderTextField];
    [stackView addArrangedSubview:self.additionalInputFieldsStackView];
    [stackView addArrangedSubview:self.avsStackView];

    return stackView;
}

- (UIStackView *)avsStackView {
    UIStackView *stackView = [UIStackView horizontalStackViewWithSpacing:kTightContentSpacing];
    stackView.distribution = UIStackViewDistributionFillEqually;
    [stackView addArrangedSubview:self.countryTextField];
    [stackView addArrangedSubview:self.postcodeTextField];

    return stackView;
}

- (UIStackView *)securityMessageStackView {
    UIStackView *stackView = [UIStackView horizontalStackViewWithSpacing:kTightContentSpacing];
    [stackView addArrangedSubview:self.lockImageView];
    [stackView addArrangedSubview:self.securityMessageLabel];
    return stackView;
}

- (UIStackView *)buttonStackView {
    UIStackView *stackView = [UIStackView verticalStackViewWithSpacing:kLooseContentSpacing];
    [stackView addArrangedSubview:self.addCardButton];
    [stackView addArrangedSubview:self.securityMessageStackView];
    return stackView;
}

@end
