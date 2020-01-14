//
//  SecurityCodeInputField.m
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

#import "SecurityCodeInputField.h"
#import "CardLogoView.h"
#import "FloatingTextField.h"
#import "JPTheme.h"
#import "NSString+Additions.h"
#import "NSString+Validation.h"

@interface JPInputField ()

- (void)setupView;

@end

@implementation SecurityCodeInputField

- (void)setupView {
    self.textField.secureTextEntry = YES;
    [super setupView];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (self.textField != textField) {
        return YES;
    }

    if (string.length > 0 && self.textField.secureTextEntry) {
        self.textField.secureTextEntry = NO;
    }

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if (newString.length == 0) {
        return YES;
    }

    return newString.isNumeric && newString.length <= [self securityCodeLengthForCardNetwork:self.cardNetwork];
}

#pragma mark - Helpers

- (BOOL)isValid {
    return self.textField.text.length == [self securityCodeLengthForCardNetwork:self.cardNetwork];
}

- (void)textFieldDidChangeValue:(UITextField *)textField {
    [super textFieldDidChangeValue:textField];

    [self didChangeInputText];

    [self.delegate judoPayInput:self didValidate:self.textField.text.length == [self securityCodeLengthForCardNetwork:self.cardNetwork]];
}

- (NSAttributedString *)placeholder {
    return [[NSAttributedString alloc] initWithString:self.title attributes:@{NSForegroundColorAttributeName : self.theme.judoPlaceholderTextColor}];
}

- (BOOL)containsLogo {
    return YES;
}

- (CardLogoView *)logoView {
    CardLogoType type = self.cardNetwork == CardNetworkAMEX ? CardLogoTypeCID : CardLogoTypeCVC;
    return [[CardLogoView alloc] initWithType:type];
}

- (NSString *)title {
    switch (self.cardNetwork) {
        case CardNetworkVisa:
            return @"CVV2";
        case CardNetworkMasterCard:
            return @"CVC2";
        case CardNetworkAMEX:
            return @"CID";
        case CardNetworkChinaUnionPay:
            return @"CVN2";
        case CardNetworkDiscover:
            return @"CID";
        case CardNetworkJCB:
            return @"CAV2";
        default:
            return @"CVV";
    }
}

- (NSString *)hintLabelText {
    if (self.isTokenPayment) {
        return @"please_reenter_the_card_security_code".localized;
    }
    return @"security_code".localized;
}

- (NSInteger)securityCodeLengthForCardNetwork:(CardNetwork)network {
    if (network == CardNetworkAMEX) {
        return 4;
    }
    return 3;
}

@end
