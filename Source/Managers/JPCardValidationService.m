//
//  JPCardValidationService.m
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

#import "JPCardValidationService.h"
#import "JPCard.h"
#import "JPAddress.h"

@implementation JPCardValidationService

- (BOOL)isCardValid:(JPCard *)card withAVSEnabled:(BOOL)isAVSEnabled {
        
    BOOL isCardNumberValid = [self isCardNumberValid:card.cardNumber];
    BOOL isCardholderNameValid = [self isCardholderNameValid:card.cardholderName];
    BOOL isExpiryDateValid = [self isExpiryDateValid:card.expiryDate];
    BOOL isLastDigitsValid = [self isLastDigitsValid:card.secureCode];
    
    BOOL isCardValid = isCardNumberValid && isCardholderNameValid && isExpiryDateValid && isLastDigitsValid;
    
    if (isAVSEnabled) {
        BOOL isCountryValid = [self isCountryValid:card.cardAddress.billingCountry];
        BOOL isPostalCodeValid = [self isPostalCodeValid:card.cardAddress.postCode];
        return isCardValid && isCountryValid && isPostalCodeValid;
    }
    
    return isCardValid;
}

- (BOOL)isCardNumberValid:(NSString *)cardNumber {
    //TODO: Handle card number validation
    return [cardNumber stringByReplacingOccurrencesOfString:@" " withString:@""].length == 16;
}

- (BOOL)isCardholderNameValid:(NSString *)cardholderName {
    //TODO: Handle cardholder name validation
    return cardholderName.length > 3;
}

- (BOOL)isExpiryDateValid:(NSString *)expiryDate {
    if ([expiryDate rangeOfString:@"/"].location == NSNotFound) {
        return false;
    }
    NSArray *dateComponents = [expiryDate componentsSeparatedByString:@"/"];
    NSString *month = [dateComponents objectAtIndex:0];
    NSString *year = [dateComponents objectAtIndex:1];
    return [self isValidMonth:month] && [self isValidYear:year];
}

- (BOOL)isLastDigitsValid:(NSString *)lastDigits {
    //TODO: Handle last digit validation
    return [lastDigits isEqualToString:@"341"];
}

- (BOOL)isValidMonth:(NSString *)month {
    //TODO: Handle the month logic
    return month.intValue > 0 && month.intValue < 13;
}

- (BOOL)isValidYear:(NSString *)year {
    //TODO: Handle the year logic
    return year.intValue > 18;
}

- (BOOL)isCountryValid:(NSString *)country {
    //TODO: Handle country validation
    return country.length > 0;
}

- (BOOL)isPostalCodeValid:(NSString *)postalCode {
    //TODO: Handlee postal code validation
    return postalCode.length > 0;
}

@end
