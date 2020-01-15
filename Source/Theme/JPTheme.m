//
//  JPTheme.m
//  JudoKitObjC
//
//  Copyright (c) 2016 Alternative Payments Ltd
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

#import "JPTheme.h"
#import "JPCardDetails.h"
#import "NSString+Localize.h"
#import "UIColor+Judo.h"

@implementation JPTheme

- (instancetype)init {
    if (self = [super init]) {
        // defaults
        _buttonCornerRadius = 4;
    }

    return self;
}

#pragma mark - Configuration

- (NSArray *)acceptedCardNetworks {
    if (!_acceptedCardNetworks) {
        _acceptedCardNetworks = @[ @(CardNetworkVisa), @(CardNetworkMasterCard), @(CardNetworkAMEX), @(CardNetworkMaestro) ];
    }
    return _acceptedCardNetworks;
}

#pragma mark - Strings

- (NSString *)paymentButtonTitle {
    if (!_paymentButtonTitle) {
        _paymentButtonTitle = @"pay".localized;
    }
    return _paymentButtonTitle;
}

- (NSString *)registerCardButtonTitle {
    if (!_registerCardButtonTitle) {
        _registerCardButtonTitle = @"add_card".localized;
    }
    return _registerCardButtonTitle;
}

- (NSString *)registerCardNavBarButtonTitle {
    if (!_registerCardNavBarButtonTitle) {
        _registerCardNavBarButtonTitle = @"add".localized;
    }
    return _registerCardNavBarButtonTitle;
}

- (NSString *)backButtonTitle {
    if (!_backButtonTitle) {
        _backButtonTitle = @"back".localized;
    }
    return _backButtonTitle;
}

- (NSString *)paymentTitle {
    if (!_paymentTitle) {
        _paymentTitle = @"pay".localized;
    }
    return _paymentTitle;
}

- (NSString *)registerCardTitle {
    if (!_registerCardTitle) {
        _registerCardTitle = @"add_card".localized;
    }
    return _registerCardTitle;
}

- (NSString *)refundTitle {
    if (!_refundTitle) {
        _refundTitle = @"refund".localized;
    }
    return _refundTitle;
}

- (NSString *)iDEALTitle {
    if (!_iDEALTitle) {
        _iDEALTitle = @"ideal_transaction".localized;
    }
    return _iDEALTitle;
}

- (NSString *)checkCardTitle {
    if (!_checkCardTitle) {
        _checkCardTitle = @"check_card".localized;
    }
    return _checkCardTitle;
}

- (NSString *)authenticationTitle {
    if (!_authenticationTitle) {
        _authenticationTitle = @"authentication".localized;
    }
    return _authenticationTitle;
}

- (NSString *)loadingIndicatorRegisterCardTitle {
    if (!_loadingIndicatorRegisterCardTitle) {
        _loadingIndicatorRegisterCardTitle = @"adding_card".localized;
    }
    return _loadingIndicatorRegisterCardTitle;
}

- (NSString *)loadingIndicatorProcessingTitle {
    if (!_loadingIndicatorProcessingTitle) {
        _loadingIndicatorProcessingTitle = @"processing_payment".localized;
    }
    return _loadingIndicatorProcessingTitle;
}

- (NSString *)redirecting3DSTitle {
    if (!_redirecting3DSTitle) {
        _redirecting3DSTitle = @"redirecting".localized;
    }
    return _redirecting3DSTitle;
}

- (NSString *)verifying3DSPaymentTitle {
    if (!_verifying3DSPaymentTitle) {
        _verifying3DSPaymentTitle = @"verifying_payment".localized;
    }
    return _verifying3DSPaymentTitle;
}

- (NSString *)verifying3DSRegisterCardTitle {
    if (!_verifying3DSRegisterCardTitle) {
        _verifying3DSRegisterCardTitle = @"verifying_card".localized;
    }
    return _verifying3DSRegisterCardTitle;
}

- (NSString *)securityMessageString {
    if (!_securityMessageString) {
        _securityMessageString = @"secure_server_transmission".localized;
    }
    return _securityMessageString;
}

#pragma mark - Sizes

- (CGFloat)inputFieldHeight {
    if (_inputFieldHeight == 0) {
        _inputFieldHeight = 68;
    }
    return _inputFieldHeight;
}

- (CGFloat)securityMessageTextSize {
    if (_securityMessageTextSize == 0) {
        _securityMessageTextSize = 12;
    }
    return _securityMessageTextSize;
}

#pragma mark - Colors
- (UIColor *)tintColor {
    if (_tintColor) {
        return _tintColor;
    }
    return [UIColor defaultTintColor];
}

- (UIColor *)judoTextColor {
    if (_judoTextColor) {
        return _judoTextColor;
    }
    UIColor *textColor = [UIColor thunder];
    if ([self.tintColor isDarkColor]) {
        return textColor;
    }
    return [textColor inverseColor];
}

- (UIColor *)judoInputFieldTextColor {
    if (_judoInputFieldTextColor) {
        return _judoInputFieldTextColor;
    }
    UIColor *textColor = [UIColor darkGrayColor];
    if ([self.tintColor isDarkColor]) {
        return textColor;
    }
    return [textColor inverseColor];
}

- (UIColor *)judoInputFieldBorderColor {
    return _judoInputFieldBorderColor ? _judoInputFieldBorderColor : [UIColor magnesium];
}

- (UIColor *)judoContentViewBackgroundColor {
    if (_judoContentViewBackgroundColor) {
        return _judoContentViewBackgroundColor;
    }
    
    UIColor *backgroundColor = [UIColor zircon];
    if ([self.tintColor isDarkColor]) {
        return backgroundColor;
    }
    return [backgroundColor inverseColor];
}

- (UIColor *)judoButtonColor {
    return _judoButtonColor ? _judoButtonColor : self.tintColor;
}

- (UIColor *)judoLoadingBackgroundColor {
    if (_judoLoadingBackgroundColor) {
        return _judoLoadingBackgroundColor;
    }
    UIColor *loadingBackgroundColor = [UIColor lightGray];
    if ([self.tintColor isDarkColor]) {
        return loadingBackgroundColor;
    }
    return [loadingBackgroundColor inverseColor];
}

- (UIColor *)judoErrorColor {
    return _judoErrorColor ? _judoErrorColor : [UIColor cgRed];
}

- (UIColor *)judoLoadingBlockViewColor {
    if (_judoLoadingBlockViewColor) {
        return _judoLoadingBlockViewColor;
    }
    if ([self.tintColor isDarkColor]) {
        return [UIColor whiteColor];
    }
    return [UIColor blackColor];
}

- (UIColor *)judoInputFieldBackgroundColor {
    return _judoInputFieldBackgroundColor ? _judoInputFieldBackgroundColor : _judoContentViewBackgroundColor;
}

#pragma mark - Payment Methods

- (CGFloat)buttonHeight {
    if (_buttonHeight <= 0) {
        _buttonHeight = 50;
    }
    return _buttonHeight;
}

- (CGFloat)buttonsSpacing {
    if (_buttonsSpacing <= 0) {
        _buttonsSpacing = 24;
    }
    return _buttonsSpacing;
}

- (UIFont *)buttonFont {
    if (!_buttonFont) {
        _buttonFont = [UIFont boldSystemFontOfSize:22.0];
    }
    return _buttonFont;
}

- (CGFloat)judoInputFieldBorderWidth {
    if (!_judoInputFieldBorderWidth) {
        _judoInputFieldBorderWidth = 0.0;
    }
    return _judoInputFieldBorderWidth;
}

#pragma mark - New styles (use for iDEAL page styling)

- (UIColor *)judoNavigationButtonColor {
    if (!_judoNavigationButtonColor) {
        return [self.tintColor isDarkColor] ? UIColor.thunder : UIColor.thunder.inverseColor;
    }
    return _judoNavigationButtonColor;
}

- (UIFont *)judoNavigationButtonFont {
    if (!_judoNavigationButtonFont) {
        _judoNavigationButtonFont = [UIFont systemFontOfSize:16.0];
    }
    return _judoNavigationButtonFont;
}

- (UIColor *)judoNavigationBarTitleColor {
    if (!_judoNavigationBarTitleColor) {
        return [self.tintColor isDarkColor] ? UIColor.thunder : UIColor.thunder.inverseColor;
    }
    return _judoNavigationBarTitleColor;
}

- (UIFont *)judoNavigationBarTitleFont {
    if (!_judoNavigationBarTitleFont) {
        _judoNavigationBarTitleFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
    }
    return _judoNavigationBarTitleFont;
}

- (UIColor *)judoNavigationBarColor {
    if (!_judoNavigationBarColor) {
        _judoNavigationBarColor = UINavigationBar.appearance.barTintColor;
    }
    return _judoNavigationBarColor;
}

- (UIColor *)judoBackgroundColor {
    if (!_judoBackgroundColor) {
        _judoBackgroundColor = [self.tintColor isDarkColor] ? UIColor.zircon : UIColor.zircon.inverseColor;
    }
    return _judoBackgroundColor;
}

- (UIColor *)judoPlaceholderColor {
    if (!_judoPlaceholderColor) {
        return [self.tintColor isDarkColor] ? UIColor.magnesium : UIColor.magnesium.inverseColor;
    }
    return _judoPlaceholderColor;
}

- (UIFont *)judoPlaceholderFont {
    if (!_judoPlaceholderFont) {
        return [UIFont systemFontOfSize:16.0];
    }
    return _judoPlaceholderFont;
}

- (UIColor *)judoFloatingLabelColor {
    if (!_judoFloatingLabelColor) {
        return [self.tintColor isDarkColor] ? UIColor.thunder : UIColor.thunder.inverseColor;
    }
    return _judoFloatingLabelColor;
}

- (UIFont *)judoFloatingLabelFont {
    if (_judoFloatingLabelFont) {
        return [UIFont systemFontOfSize:10.0 weight:UIFontWeightSemibold];
    }
    return _judoFloatingLabelFont;
}

- (UIColor *)judoTextFieldColor {
    if (!_judoTextFieldColor) {
        return [self.tintColor isDarkColor] ? UIColor.thunder : UIColor.thunder.inverseColor;
    }
    return _judoTextFieldColor;
}

- (UIFont *)judoTextFieldFont {
    if (!_judoTextFieldFont) {
        return [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
    }
    return _judoTextFieldFont;
}

- (UIColor *)judoButtonBackgroundColor {
    if (!_judoButtonBackgroundColor) {
        _judoButtonBackgroundColor = self.tintColor;
    }
    return _judoButtonBackgroundColor;
}

- (UIColor *)judoButtonTitleColor {
    if (!_judoButtonTitleColor) {
        return [self.tintColor isDarkColor] ? [UIColor whiteColor] : [UIColor blackColor];
    }
    return _judoButtonTitleColor;
}

- (UIFont *)judoButtonTitleFont {
    if (!_judoButtonTitleFont) {
        return [UIFont systemFontOfSize:20.0 weight:UIFontWeightSemibold];
    }
    return _judoButtonTitleFont;
}

- (UIColor *)judoLabelColor {
    if (!_judoLabelColor) {
        return [self.tintColor isDarkColor] ? UIColor.thunder : UIColor.thunder.inverseColor;
    }
    return _judoLabelColor;
}

- (UIFont *)judoLabelFont {
    if (!_judoLabelFont) {
        return [UIFont systemFontOfSize:16];
    }
    return _judoLabelFont;
}

- (UIActivityIndicatorViewStyle)judoActivityIndicatorType {
    if (!_judoActivityIndicatorType) {
        _judoActivityIndicatorType = UIActivityIndicatorViewStyleGray;
    }
    return _judoActivityIndicatorType;
}

- (UIColor *)judoActivityIndicatorColor {
    if (_judoActivityIndicatorColor) {
        _judoActivityIndicatorColor = [self.tintColor isDarkColor] ? self.tintColor : self.tintColor.inverseColor;
    }
    return _judoActivityIndicatorColor;
}

@end
