//
//  CardInputField.m
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

#import "CardInputField.h"
#import "NSString+Card.h"
#import "NSError+Judo.h"
#import "FloatingTextField.h"
#import "JPCard.h"
#import "JPTheme.h"
#import "CardLogoView.h"
#import "NSString+Validation.h"
#import "NSString+Manipulation.h"

@interface JPInputField ()

- (void)setupView;

@end

@interface CardInputField ()

@property (nonatomic, strong) UITextRange *currentTextRange;

@end

@implementation CardInputField

- (void)setupView {
    self.textField.secureTextEntry = YES;
    [super setupView];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    self.currentTextRange = textField.selectedTextRange;
    
    if (string.length > 0 && self.textField.secureTextEntry) {
        self.textField.secureTextEntry = NO;
    }
    
    NSString *oldString = textField.text;
    NSString *newString = [oldString stringByReplacingCharactersInRange:range withString:string];
    
    if (!newString.length || !string.length) {
        return YES;
    }
    
    newString = [newString stringByRemovingWhitespaces];
    
    if (!newString.isNumeric) {
        return NO;
    }
    
    NSError *error = nil;
    
    NSString *cardPresentationString = [newString cardPresentationStringWithAcceptedNetworks:self.theme.acceptedCardNetworks error:&error];
    
    if (error) {
        [self.delegate cardInput:self didFailWithError:error];
        return NO;
    }
    
    if (cardPresentationString) {
        [self dismissError];
    }
    
    return YES;
}

- (BOOL)isValid {
    return self.isTokenPayment || self.textField.text.isCardNumberValid;
}

- (void)textFieldDidChangeValue:(UITextField *)textField {
    [super textFieldDidChangeValue:textField];
    
    [self didChangeInputText];
    
    NSError *error = nil;
    
    self.textField.text = [self.textField.text cardPresentationStringWithAcceptedNetworks:self.theme.acceptedCardNetworks error:&error];
    
    if (error) {
        [self.delegate cardInput:self didFailWithError:error];
    } else {
        CardNetwork network = self.textField.text.cardNetwork;
        [self.delegate cardInput:self didDetectNetwork:network];
        
        NSUInteger cardNumberLength = 16;
        
        if (network == CardNetworkAMEX || network == CardNetworkUATP) {
            cardNumberLength = 15;
        }
        
        if ([self.textField.text stringByRemovingWhitespaces].length == cardNumberLength) {
            if (self.textField.text.isCardNumberValid) {
                [self.delegate cardInput:self didFindValidNumber:self.textField.text];
            } else {
                [self.delegate cardInput:self didFailWithError:[NSError judoInvalidCardNumberError]];
            }
        }
        
    }
}

- (NSAttributedString *)placeholder {
    return [[NSAttributedString alloc] initWithString:self.title attributes:@{NSForegroundColorAttributeName:self.theme.judoPlaceholderTextColor}];
}

- (BOOL)containsLogo {
    return YES;
}

- (CardLogoView *)logoView {
    return [[CardLogoView alloc] initWithType:[CardInputField cardLogoTypeForNetworkType:self.cardNetwork]];
}

- (NSString *)title {
    return @"Card number";
}

- (NSString *)hintLabelText {
    return @"Long card number";
}

+ (CardLogoType)cardLogoTypeForNetworkType:(CardNetwork)network {
    switch (network) {
        case CardNetworkVisa:
        case CardNetworkVisaDebit:
        case CardNetworkVisaElectron:
        case CardNetworkVisaPurchasing:
            return CardLogoTypeVisa;
        case CardNetworkMasterCard:
        case CardNetworkMasterCardDebit:
            return CardLogoTypeMasterCard;
        case CardNetworkAMEX:
            return CardLogoTypeAMEX;
        case CardNetworkMaestro:
            return CardLogoTypeMaestro;
        default:
            return CardLogoTypeUnknown;
    }
}

@end
