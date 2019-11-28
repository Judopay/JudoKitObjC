//
//  JPAddCardViewController.m
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

#import "JPAddCardViewController.h"
#import "RoundedCornerView.h"
#import "UIFont+Custom.h"
#import "NSBundle+Additions.h"
#import "UIColor+Hex.h"
#import "NSString+Localize.h"

@interface JPAddCardViewController()

@property (nonatomic, strong) RoundedCornerView *bottomSlider;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *scanCardButton;
@property (nonatomic, strong) UITextField *cardInputTextField;
@property (nonatomic, strong) UITextField *cardholderNameTextField;
@property (nonatomic, strong) UITextField *expirationDateTextField;
@property (nonatomic, strong) UITextField *lastDigitsTextField;
@property (nonatomic, strong) UIButton *addCardButton;
@property (nonatomic, strong) UIImageView *lockImageView;
@property (nonatomic, strong) UILabel *securityMessageLabel;
@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIView *spacingView;
@end

@implementation JPAddCardViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [self setupViews];
    [self setupConstraints];
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.view addSubview:self.bottomSlider];
    [self setupSliderContents];
}

- (void)setupSliderContents {
    self.mainStackView = [UIStackView new];
    self.mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mainStackView.axis = UILayoutConstraintAxisVertical;
    self.mainStackView.spacing = 8.0;
    
    UIStackView *topButtonsStackView = [UIStackView new];
    [topButtonsStackView addArrangedSubview:self.cancelButton];
    [topButtonsStackView addArrangedSubview:self.spacingView];
    [topButtonsStackView addArrangedSubview:self.scanCardButton];
    
    [self.mainStackView addArrangedSubview:topButtonsStackView];
    [self.mainStackView addArrangedSubview:self.cardInputTextField];
    [self.mainStackView addArrangedSubview:self.cardholderNameTextField];
    
    UIStackView *inputFieldsStackview = [UIStackView new];
    inputFieldsStackview.alignment = UILayoutConstraintAxisHorizontal;
    inputFieldsStackview.distribution = UIStackViewDistributionFillEqually;
    inputFieldsStackview.spacing = 10.0f;
    [inputFieldsStackview addArrangedSubview:self.expirationDateTextField];
    [inputFieldsStackview addArrangedSubview:self.lastDigitsTextField];
    
    [self.mainStackView addArrangedSubview:inputFieldsStackview];
    [self.mainStackView addArrangedSubview:self.addCardButton];
    
    UIStackView *securityMessageStackView = [UIStackView new];
    securityMessageStackView.spacing = 8.0f;
    [securityMessageStackView addArrangedSubview:self.lockImageView];
    [securityMessageStackView addArrangedSubview:self.securityMessageLabel];
    
    [self.mainStackView addArrangedSubview:securityMessageStackView];
    
    [self.bottomSlider addSubview:self.mainStackView];
}

#pragma mark - Constraint Setup

- (void)setupConstraints {
    [self setupBottomSliderConstraints];
    [self setupMainStackViewConstraints];
    [self setupContentsConstraints];
}

- (void)setupBottomSliderConstraints {
    NSArray *constraints = @[
        [_bottomSlider.heightAnchor constraintEqualToConstant:375.0f],
        [_bottomSlider.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_bottomSlider.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_bottomSlider.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupMainStackViewConstraints {
    NSArray *constraints = @[
        [_mainStackView.topAnchor constraintEqualToAnchor:_bottomSlider.topAnchor
                                                 constant:20.0],
        
        [_mainStackView.leadingAnchor constraintEqualToAnchor:_bottomSlider.leadingAnchor
                                                     constant:24.0],
        
        [_mainStackView.trailingAnchor constraintEqualToAnchor:_bottomSlider.trailingAnchor
                                                      constant:-24.0],
        
        [_mainStackView.bottomAnchor constraintEqualToAnchor:_bottomSlider.bottomAnchor
                                                    constant:-32.0],
    ];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupContentsConstraints {
    NSArray *constraints = @[
        [self.cardInputTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.cardholderNameTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.expirationDateTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.lastDigitsTextField.heightAnchor constraintEqualToConstant:44.0],
        [self.addCardButton.heightAnchor constraintEqualToConstant:46.0],
        [self.lockImageView.widthAnchor constraintEqualToConstant:17.0],
    ];
    
    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - Lazily instantiated properties

- (UIView *)bottomSlider {
    if (!_bottomSlider) {
        UIRectCorner corners = UIRectCornerTopRight | UIRectCornerTopLeft;
        _bottomSlider = [[RoundedCornerView alloc] initWithRadius:10 forCorners:corners];
        _bottomSlider.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomSlider.backgroundColor = UIColor.whiteColor;
    }
    return _bottomSlider;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        _cancelButton.titleLabel.font = [UIFont SFProDisplaySemiboldWithSize:14.0];
        [_cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    return _cancelButton;
}

- (UIButton *)scanCardButton {
    if (!_scanCardButton) {
        _scanCardButton = [UIButton new];
        _scanCardButton.translatesAutoresizingMaskIntoConstraints = NO;
        _scanCardButton.layer.borderWidth = 1.0f;
        _scanCardButton.layer.borderColor = UIColor.blackColor.CGColor;
        _scanCardButton.layer.cornerRadius = 4.0f;
        _scanCardButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        _scanCardButton.titleLabel.font = [UIFont SFProDisplaySemiboldWithSize:14.0];
        [_scanCardButton setTitle:@"SCAN CARD" forState:UIControlStateNormal];
        [_scanCardButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    return _scanCardButton;
}

- (UITextField *)cardInputTextField {
    if (!_cardInputTextField) {
        _cardInputTextField = [UITextField new];
        _cardInputTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _cardInputTextField.layer.cornerRadius = 6.0f;
        _cardInputTextField.backgroundColor = [UIColor colorFromHex:0xE5E5E5];
        _cardInputTextField.placeholder = @"Card Number";
    }
    return _cardInputTextField;
}

- (UITextField *)cardholderNameTextField {
    if (!_cardholderNameTextField) {
        _cardholderNameTextField = [UITextField new];
        _cardholderNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _cardholderNameTextField.layer.cornerRadius = 6.0f;
        _cardholderNameTextField.backgroundColor = [UIColor colorFromHex:0xE5E5E5];
        _cardholderNameTextField.placeholder = @"Cardholder Name";
    }
    return _cardholderNameTextField;
}

- (UITextField *)expirationDateTextField {
    if (!_expirationDateTextField) {
        _expirationDateTextField = [UITextField new];
        _expirationDateTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _expirationDateTextField.layer.cornerRadius = 6.0f;
        _expirationDateTextField.backgroundColor = [UIColor colorFromHex:0xE5E5E5];
        _expirationDateTextField.placeholder = @"MM/YY";
    }
    return _expirationDateTextField;
}

- (UITextField *)lastDigitsTextField {
    if (!_lastDigitsTextField) {
        _lastDigitsTextField = [UITextField new];
        _lastDigitsTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _lastDigitsTextField.layer.cornerRadius = 6.0f;
        _lastDigitsTextField.backgroundColor = [UIColor colorFromHex:0xE5E5E5];
        _lastDigitsTextField.placeholder = @"CVV";
    }
    return _lastDigitsTextField;
}

- (UIButton *)addCardButton {
    if (!_addCardButton) {
        _addCardButton = [UIButton new];
        _addCardButton.translatesAutoresizingMaskIntoConstraints = NO;
        _addCardButton.titleLabel.font = [UIFont SFProDisplaySemiboldWithSize:16.0f];
        _addCardButton.layer.cornerRadius = 4.0f;
        [_addCardButton setTitle:@"ADD CARD" forState:UIControlStateNormal];
        _addCardButton.backgroundColor = [UIColor colorFromHex:0x999999];
    }
    return _addCardButton;
}

- (UIImageView *)lockImageView {
    if (!_lockImageView) {
        _lockImageView = [UIImageView new];
        _lockImageView.contentMode = UIViewContentModeScaleAspectFit;
        _lockImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _lockImageView.image = [UIImage imageNamed:@"lock-icon"
                                          inBundle:NSBundle.iconsBundle
                     compatibleWithTraitCollection:nil];
    }
    return _lockImageView;
}

- (UILabel *)securityMessageLabel {
    if (!_securityMessageLabel) {
        _securityMessageLabel = [UILabel new];
        _securityMessageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _securityMessageLabel.text = @"secure_server_transmission".localized;
        _securityMessageLabel.numberOfLines = 0;
        _securityMessageLabel.font = [UIFont SFProTextRegularWithSize:10.0];
        _securityMessageLabel.textColor = [UIColor colorFromHex:0x999999];
    }
    return _securityMessageLabel;
}

- (UIView *)spacingView {
    if (!_spacingView) {
        _spacingView = [UIView new];
        _spacingView.translatesAutoresizingMaskIntoConstraints = NO;
        [_spacingView setContentHuggingPriority:UILayoutPriorityDefaultLow
                                        forAxis:UILayoutConstraintAxisHorizontal];
        [_spacingView setContentHuggingPriority:UILayoutPriorityDefaultLow
                                        forAxis:UILayoutConstraintAxisVertical];
    }
    return _spacingView;
}

@end
