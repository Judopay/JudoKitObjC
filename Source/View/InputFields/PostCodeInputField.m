//
//  PostCodeInputField.m
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

#import "PostCodeInputField.h"

#import "FloatingTextField.h"

#import "NSError+Judo.h"
#import "NSString+Localize.h"
#import "NSString+Validation.h"

static NSString *const kUKRegexString = @"(GIR 0AA)|((([A-Z-[QVX]][0-9][0-9]?)|(([A-Z-[QVX]][A-Z-[IJZ]][0-9][0-9]?)|(([A-Z-[QVX‌​]][0-9][A-HJKSTUW])|([A-Z-[QVX]][A-Z-[IJZ]][0-9][ABEHMNPRVWXY]))))\\s?[0-9][A-Z-[C‌​IKMOV]]{2})";
static NSString *const kCanadaRegexString = @"[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]";
static NSString *const kUSARegexString = @"(^\\d{5}$)|(^\\d{5}-\\d{4}$)";

@interface JPInputField ()

- (void)setupView;

@end

@implementation PostCodeInputField

- (void)setupView {
    [super setupView];
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)setBillingCountry:(BillingCountry)billingCountry {
    if (_billingCountry == billingCountry) {
        return;
    }

    _billingCountry = billingCountry;

    if (_billingCountry == BillingCountryUK || _billingCountry == BillingCountryCanada) {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    } else {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }

    NSString *placeholder = [self descriptionForBillingCountry:_billingCountry];
    [self.textField setPlaceholder:placeholder floatingTitle:placeholder];
}

- (NSString *)descriptionForBillingCountry:(BillingCountry)country {

    if (country == BillingCountryUSA) {
        return @"billing_zip_code".localized;
    }

    if (country == BillingCountryCanada) {
        return @"billing_postcode".localized;
    }

    return @"billing_postcode".localized;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField != self.textField) {
        return YES;
    }

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if (newString.length == 0) {
        return YES;
    }

    switch (self.billingCountry) {
        case BillingCountryUK:
            return newString.isAlphaNumeric && newString.length <= 8;
        case BillingCountryCanada:
            return newString.isAlphaNumeric && newString.length <= 6;
        case BillingCountryUSA:
            return newString.isNumeric && newString.length <= 5;
        default:
            return newString.isNumeric && newString.length <= 8;
    }
}

- (BOOL)isValid {
    if (self.billingCountry == BillingCountryOther) {
        return YES;
    }

    NSString *newString = [self.textField.text uppercaseString];

    NSRegularExpression *ukRegex = [NSRegularExpression regularExpressionWithPattern:kUKRegexString options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRegularExpression *canadaRegex = [NSRegularExpression regularExpressionWithPattern:kCanadaRegexString options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRegularExpression *usaRegex = [NSRegularExpression regularExpressionWithPattern:kUSARegexString options:NSRegularExpressionAnchorsMatchLines error:nil];

    switch (self.billingCountry) {
        case BillingCountryUK:
            return [ukRegex numberOfMatchesInString:newString options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, newString.length)] > 0;
        case BillingCountryCanada:
            return [canadaRegex numberOfMatchesInString:newString options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, newString.length)] > 0 && newString.length == 6;
        case BillingCountryUSA:
            return [usaRegex numberOfMatchesInString:newString options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, newString.length)] > 0;
        default:
            return newString.isNumeric && newString.length <= 8;
    }

    return NO;
}

- (void)textFieldDidChangeValue:(UITextField *)textField {
    [super textFieldDidChangeValue:textField];

    [self didChangeInputText];

    [self.delegate judoPayInput:self didValidate:self.isValid];

    NSUInteger characterCount = textField.text.length;

    BOOL valid = YES;

    if (self.billingCountry == BillingCountryUK && characterCount >= 8) {
        valid = NO;
    }

    if (self.billingCountry == BillingCountryCanada && characterCount >= 6) {
        valid = NO;
    }

    if (!valid) {
        [self errorAnimation:YES];
        [self.delegate postCodeInputField:self didFailWithError:[NSError judoInputMismatchErrorWithMessage:[NSString stringWithFormat:@"Check %@", [self descriptionForBillingCountry:self.billingCountry]]]];
        return;
    }
}

- (NSString *)title {
    return [self descriptionForBillingCountry:self.billingCountry];
}

- (CGFloat)titleWidth {
    return 120.0f;
}

@end
