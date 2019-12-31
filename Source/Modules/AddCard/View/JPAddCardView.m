//
//  JPAddCardView.m
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

#import "JPAddCardView.h"
#import "JPAddCardButton.h"
#import "JPAddCardViewModel.h"
#import "JPCardInputField.h"
#import "JPCardNumberField.h"
#import "LoadingButton.h"
#import "NSString+Localize.h"
#import "RoundedCornerView.h"
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"
#import "UIImage+Icons.h"
#import "UIStackView+Additions.h"
#import "UITextField+Additions.h"
#import "UIView+Additions.h"

@interface JPAddCardView ()

@property (nonatomic, strong) RoundedCornerView *bottomSlider;
@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIImageView *lockImageView;
@property (nonatomic, strong) UILabel *securityMessageLabel;
@property (nonatomic, strong) NSLayoutConstraint *sliderHeightConstraint;

@end

@implementation JPAddCardView

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

#pragma mark - View model configuration

- (void)configureWithViewModel:(JPAddCardViewModel *)viewModel {
    self.sliderHeightConstraint.constant = 365.0f;
    [self.cardNumberTextField configureWithViewModel:viewModel.cardNumberViewModel];
    [self.cardHolderTextField configureWithViewModel:viewModel.cardholderNameViewModel];
    [self.cardExpiryTextField configureWithViewModel:viewModel.expiryDateViewModel];
    [self.secureCodeTextField configureWithViewModel:viewModel.secureCodeViewModel];
    [self.addCardButton configureWithViewModel:viewModel.addCardButtonViewModel];

    self.countryTextField.hidden = !viewModel.shouldDisplayAVSFields;
    self.postcodeTextField.hidden = !viewModel.shouldDisplayAVSFields;

    if (viewModel.shouldDisplayAVSFields) {
        self.sliderHeightConstraint.constant = 410.0f;
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
    self.sliderHeightConstraint = [self.bottomSlider.heightAnchor constraintEqualToConstant:365.0];

    self.bottomSliderConstraint.active = YES;
    self.sliderHeightConstraint.active = YES;
}

- (void)setupMainStackViewConstraints {

    [self.mainStackView pinToAnchors:AnchorTypeTop
                             forView:self.bottomSlider
                         withPadding:20.0];

    [self.mainStackView pinToAnchors:AnchorTypeLeading | AnchorTypeTrailing
                             forView:self.bottomSlider
                         withPadding:24.0];

    [self.mainStackView pinToAnchors:AnchorTypeBottom
                             forView:self.bottomSlider
                         withPadding:32.0];
}

- (void)setupContentsConstraints {
    NSArray *constraints = @[
        [self.scanCardButton.heightAnchor constraintEqualToConstant:36.0],
        [self.cardNumberTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.cardHolderTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.cardExpiryTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.secureCodeTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.countryTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.postcodeTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.addCardButton.heightAnchor constraintEqualToConstant:46.0],
        [self.lockImageView.widthAnchor constraintEqualToConstant:17.0],
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
        _bottomSlider = [[RoundedCornerView alloc] initWithRadius:10.0 forCorners:corners];
        _bottomSlider.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomSlider.backgroundColor = UIColor.whiteColor;
    }
    return _bottomSlider;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        _cancelButton.titleLabel.font = UIFont.smallTitleFont;
        [_cancelButton setTitle:@"cancel".localized forState:UIControlStateNormal];
        [_cancelButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    return _cancelButton;
}

- (UIButton *)scanCardButton {
    if (!_scanCardButton) {
        _scanCardButton = [UIButton new];
        _scanCardButton.translatesAutoresizingMaskIntoConstraints = NO;

        [_scanCardButton setTitle:@"scan_card".localized forState:UIControlStateNormal];
        [_scanCardButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _scanCardButton.titleLabel.font = UIFont.smallTitleFont;

        [_scanCardButton setImage:[UIImage imageWithIconName:@"scan-card"]
                         forState:UIControlStateNormal];
        _scanCardButton.imageView.contentMode = UIViewContentModeScaleAspectFit;

        [_scanCardButton setBorderWithColor:UIColor.blackColor width:1.0f andCornerRadius:4.0f];

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

- (JPAddCardButton *)addCardButton {
    if (!_addCardButton) {
        _addCardButton = [JPAddCardButton new];
        _addCardButton.translatesAutoresizingMaskIntoConstraints = NO;
        _addCardButton.titleLabel.font = UIFont.largeTitleFont;
        _addCardButton.layer.cornerRadius = 4.0f;
        _addCardButton.backgroundColor = UIColor.jpTextColor;
    }
    return _addCardButton;
}

- (UIImageView *)lockImageView {
    if (!_lockImageView) {
        _lockImageView = [UIImageView new];
        _lockImageView.contentMode = UIViewContentModeScaleAspectFit;
        _lockImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _lockImageView.image = [UIImage imageWithIconName:@"lock-icon"];
        ;
    }
    return _lockImageView;
}

- (UILabel *)securityMessageLabel {
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"secure_server_transmission".localized;
    label.numberOfLines = 0;
    label.font = UIFont.subtitleFont;
    label.textColor = UIColor.jpSubtitleColor;
    return label;
}

#pragma mark - Stack Views

- (UIStackView *)mainStackView {
    if (!_mainStackView) {
        _mainStackView = [UIStackView verticalStackViewWithSpacing:16.0];

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
    UIStackView *stackView = [UIStackView horizontalStackViewWithSpacing:8.0];
    stackView.distribution = UIStackViewDistributionFillEqually;

    [stackView addArrangedSubview:self.cardExpiryTextField];
    [stackView addArrangedSubview:self.secureCodeTextField];

    return stackView;
}

- (UIStackView *)inputFieldsStackView {
    UIStackView *stackView = [UIStackView verticalStackViewWithSpacing:8.0];

    [stackView addArrangedSubview:self.cardNumberTextField];
    [stackView addArrangedSubview:self.cardHolderTextField];
    [stackView addArrangedSubview:self.additionalInputFieldsStackView];
    [stackView addArrangedSubview:self.avsStackView];

    return stackView;
}

- (UIStackView *)avsStackView {
    UIStackView *stackView = [UIStackView horizontalStackViewWithSpacing:8.0];
    stackView.distribution = UIStackViewDistributionFillEqually;

    [stackView addArrangedSubview:self.countryTextField];
    [stackView addArrangedSubview:self.postcodeTextField];

    return stackView;
}

- (UIStackView *)securityMessageStackView {
    UIStackView *stackView = [UIStackView horizontalStackViewWithSpacing:8.0];
    [stackView addArrangedSubview:self.lockImageView];
    [stackView addArrangedSubview:self.securityMessageLabel];
    return stackView;
}

- (UIStackView *)buttonStackView {
    UIStackView *stackView = [UIStackView verticalStackViewWithSpacing:16.0];
    [stackView addArrangedSubview:self.addCardButton];
    [stackView addArrangedSubview:self.securityMessageStackView];
    return stackView;
}

@end
