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
        _paymentTitle = @"payment".localized;
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
    if (!_tintColor) {
        _tintColor = [UIColor colorWithRed:30 / 255.0f green:120 / 255.0f blue:160 / 255.0f alpha:1.0f];
    }
    return _tintColor;
}

- (UIColor *)judoTextColor {
    if (_judoTextColor) {
        return _judoTextColor;
    }
    UIColor *dgc = [UIColor colorWithRed:75 / 255.0f green:75 / 255.0f blue:75 / 255.0f alpha:1.0f];
    if ([self.tintColor colorMode]) {
        return dgc;
    }
    return [dgc inverseColor];
}

- (UIColor *)judoNavigationBarTitleColor {
    if (_judoNavigationBarTitleColor) {
        return _judoNavigationBarTitleColor;
    }
    UIColor *dgc = [UIColor colorWithRed:75 / 255.0f green:75 / 255.0f blue:75 / 255.0f alpha:1.0f];
    if ([self.tintColor colorMode]) {
        return dgc;
    }
    return [dgc inverseColor];
}

- (UIColor *)judoInputFieldTextColor {
    return _judoInputFieldTextColor ? _judoInputFieldTextColor : [UIColor colorWithRed:75 / 255.0f green:75 / 255.0f blue:75 / 255.0f alpha:1.0f];
}

- (UIColor *)judoPlaceholderTextColor {
    if (_judoPlaceholderTextColor) {
        return _judoPlaceholderTextColor;
    }
    UIColor *lgc = [UIColor colorWithRed:180 / 255.0f green:180 / 255.0f blue:180 / 255.0f alpha:1.0];
    if ([self.tintColor colorMode]) {
        return lgc;
    }
    return [lgc inverseColor];
}

- (UIColor *)judoInputFieldBorderColor {
    return _judoInputFieldBorderColor ? _judoInputFieldBorderColor : [UIColor colorWithRed:180 / 255.0f green:180 / 255.0f blue:180 / 255.0f alpha:1.0f];
}

- (UIColor *)judoContentViewBackgroundColor {
    if (_judoContentViewBackgroundColor) {
        return _judoContentViewBackgroundColor;
    }
    UIColor *bgc = [UIColor colorWithRed:245 / 255.0f green:245 / 255.0f blue:245 / 255.0f alpha:1.0f];
    if ([self.tintColor colorMode]) {
        return bgc;
    }
    return [bgc inverseColor];
}

- (UIColor *)judoButtonColor {
    return _judoButtonColor ? _judoButtonColor : self.tintColor;
}

- (UIColor *)judoButtonTitleColor {
    if (_judoButtonTitleColor) {
        return _judoButtonTitleColor;
    }
    return [self.tintColor colorMode] ? [UIColor whiteColor] : [UIColor blackColor];
}

- (UIColor *)judoLoadingBackgroundColor {
    if (_judoLoadingBackgroundColor) {
        return _judoLoadingBackgroundColor;
    }
    UIColor *lbc = [UIColor colorWithRed:210 / 255.0f green:210 / 255.0f blue:210 / 255.0f alpha:0.8f];
    if ([self.tintColor colorMode]) {
        return lbc;
    }
    return [lbc inverseColor];
}

- (UIColor *)judoErrorColor {
    return _judoErrorColor ? _judoErrorColor : [UIColor colorWithRed:235 / 255.0f green:55 / 255.0f blue:45 / 255.0f alpha:1.0];
}

- (UIColor *)judoLoadingBlockViewColor {
    if (_judoLoadingBlockViewColor) {
        return _judoLoadingBlockViewColor;
    }
    if ([self.tintColor colorMode]) {
        return [UIColor whiteColor];
    }
    return [UIColor blackColor];
}

- (UIColor *)judoInputFieldBackgroundColor {
    return _judoInputFieldBackgroundColor ? _judoInputFieldBackgroundColor : _judoContentViewBackgroundColor;
}

#pragma marks - Payment Methods

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

@end
