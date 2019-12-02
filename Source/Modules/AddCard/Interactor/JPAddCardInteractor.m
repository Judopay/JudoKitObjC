//
//  JPAddCardInteractor.m
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

#import "JPAddCardInteractor.h"

@interface JPAddCardInteractorImpl ()
@property (nonatomic, assign) BOOL avsEnabled;
@end

@implementation JPAddCardInteractorImpl

- (instancetype)initWithAVSEnabled:(BOOL)isAVSEnabled {
    if (self = [super init]) {
        self.avsEnabled = isAVSEnabled;
    }
    return self;
}

- (BOOL)isAVSEnabled {
    return self.avsEnabled;
}

- (BOOL)isCardValidForViewModel:(JPAddCardViewModel *)viewModel {
    BOOL isCardNumberValid = [self isCardNumberValid:viewModel.cardNumberViewModel.text];
    BOOL isCardholderNameValid = [self isCardholderNameValid:viewModel.cardholderNameViewModel.text];
    BOOL isExpiryDateValid = [self isExpiryDateValid:viewModel.expiryDateViewModel.text];
    BOOL isLastDigitsValid = [self isLastDigitsValid:viewModel.lastFourViewModel.text];
    
    BOOL isCardValid = isCardNumberValid && isCardholderNameValid && isExpiryDateValid && isLastDigitsValid;
    
    if (self.avsEnabled) {
        BOOL isCountryValid = [self isCountryValid:viewModel.countryInputViewModel.text];
        BOOL isPostalCodeValid = [self isPostalCodeValid:viewModel.postalCodeInputViewModel.text];
        return isCardValid && isCountryValid && isPostalCodeValid;
    }
    
    return isCardValid;
}

- (BOOL)isCardNumberValid:(NSString *)cardNumber {
    //TODO: Handle card number validation
    return cardNumber.length == 16;
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
