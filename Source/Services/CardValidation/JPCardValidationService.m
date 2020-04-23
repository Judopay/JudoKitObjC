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
#import "JPBillingCountry.h"
#import "JPCardNetwork.h"
#import "JPConstants.h"
#import "JPValidationResult.h"
#import "NSError+Additions.h"
#import "NSString+Additions.h"

@interface JPCardValidationService ()

@property (nonatomic, strong) JPValidationResult *lastCardNumberValidationResult;
@property (nonatomic, strong) JPValidationResult *lastExpiryDateValidationResult;
@property (nonatomic, strong) NSString *selectedJPBillingCountry;
@end

@implementation JPCardValidationService

#pragma mark - Constants

static int const kCardHolderNameLength = 3;

#pragma mark - Public Methods

- (void)resetCardValidationResults {
    self.lastCardNumberValidationResult = nil;
    self.lastExpiryDateValidationResult = nil;
}

- (BOOL)isInputSupported:(NSString *)input
    forSupportedNetworks:(CardNetwork)supportedCardNetworks {

    if (input.cardNetwork == CardNetworkUnknown && input.length == kMaxDefaultCardLength) {
        return NO;
    }

    if (supportedCardNetworks == CardNetworksAll || input.cardNetwork == CardNetworkUnknown) {
        return YES;
    }

    return input.cardNetwork & supportedCardNetworks;
}

- (JPValidationResult *)validateCardNumberInput:(NSString *)input
                           forSupportedNetworks:(CardNetwork)networks {
    NSError *error;
    NSString *cardNumber = [input stringByRemovingWhitespaces];
    NSString *cardNetworkPatern = [JPCardNetwork cardPatternForType:cardNumber.cardNetwork];
    NSUInteger maxCardLength = [self maxCardLength:cardNumber.cardNetwork];

    if (cardNumber.length > maxCardLength) {
        cardNumber = [cardNumber substringToIndex:maxCardLength];
    }

    if ((cardNumber.length == maxCardLength) && (![cardNumber isCardNumberValid])) {
        error = NSError.judoInvalidCardNumberError;
    }

    if (![self isInputSupported:cardNumber forSupportedNetworks:networks]) {
        error = [NSError judoUnsupportedCardNetwork:input.cardNetwork];
    }

    cardNumber = [cardNumber formatWithPattern:cardNetworkPatern];

    self.lastCardNumberValidationResult = [JPValidationResult validationWithResult:(error == 0 && [cardNumber stringByRemovingWhitespaces].length == maxCardLength)
                                                                      inputAllowed:([input stringByRemovingWhitespaces].length <= maxCardLength)
                                                                      errorMessage:error ? error.localizedDescription : nil
                                                                    formattedInput:cardNumber];

    self.lastCardNumberValidationResult.cardNetwork = cardNumber.cardNetwork;
    return self.lastCardNumberValidationResult;
}

- (JPValidationResult *)validateCarholderNameInput:(NSString *)input {
    return [JPValidationResult validationWithResult:input.length > kCardHolderNameLength
                                       inputAllowed:YES
                                       errorMessage:nil
                                     formattedInput:input];
}

- (JPValidationResult *)validateExpiryDateInput:(NSString *)input {

    if (input.length == 0) {
        return [self validateNoExpiryDigitInput:input];
    }

    if (input.length == 1) {
        return [self validateFirstExpiryDigitInput:input];
    }

    if (input.length == 2) {
        return [self validateSecondExpiryDigitInput:input];
    }

    if (input.length == 3) {
        return [self validateThirdExpiryDigitInput:input];
    }

    if (input.length == 4) {
        return [self validateFourthExpiryDigitInput:input];
    }

    if (input.length == 5) {
        return [self validateFifthExpiryDigitInput:input];
    }

    return [JPValidationResult validationWithResult:YES
                                       inputAllowed:NO
                                       errorMessage:nil
                                     formattedInput:input];
}

- (JPValidationResult *)validateSecureCodeInput:(NSString *)input {
    NSUInteger securityCodeLength = [JPCardNetwork secureCodeLengthForNetworkType:self.lastCardNumberValidationResult.cardNetwork];
    NSString *formatedInput = [input substringToIndex:MIN(input.length, securityCodeLength)];

    return [JPValidationResult validationWithResult:formatedInput.length == securityCodeLength
                                       inputAllowed:formatedInput.length <= securityCodeLength
                                       errorMessage:nil
                                     formattedInput:formatedInput];
}

- (JPValidationResult *)validateCountryInput:(NSString *)input {
    self.selectedJPBillingCountry = input;
    return [JPValidationResult validationWithResult:YES
                                       inputAllowed:YES
                                       errorMessage:nil
                                     formattedInput:input];
}

- (JPValidationResult *)validatePostalCodeInput:(NSString *)input {

    if ([self.selectedJPBillingCountry isEqualToString:@"country_usa".localized]) {
        return [self validatePostalCodeInput:input country:JPBillingCountryUSA];
    }

    if ([self.selectedJPBillingCountry isEqualToString:@"country_uk".localized]) {
        return [self validatePostalCodeInput:input country:JPBillingCountryUK];
    }

    if ([self.selectedJPBillingCountry isEqualToString:@"country_canada".localized]) {
        return [self validatePostalCodeInput:input country:JPBillingCountryCanada];
    }

    if ([self.selectedJPBillingCountry isEqualToString:@"country_other".localized]) {
        return [self validateOtherPostalCodeInput:input];
    }

    return [JPValidationResult validationWithResult:NO
                                       inputAllowed:NO
                                       errorMessage:nil
                                     formattedInput:input];
}

#pragma mark - Getters

- (NSArray *)acceptedCardNetworks {
    return @[
        @(CardNetworkVisa),
        @(CardNetworkAMEX),
        @(CardNetworkMasterCard),
        @(CardNetworkMaestro),
        @(CardNetworkDiscover),
        @(CardNetworkJCB),
        @(CardNetworkDinersClub),
        @(CardNetworkChinaUnionPay),
    ];
}

#pragma mark - Expiry Date Validation Methods

- (JPValidationResult *)validateNoExpiryDigitInput:(NSString *)input {
    self.lastExpiryDateValidationResult = [JPValidationResult validationWithResult:NO
                                                                      inputAllowed:YES
                                                                      errorMessage:nil
                                                                    formattedInput:input];
    return self.lastExpiryDateValidationResult;
}

- (JPValidationResult *)validateFirstExpiryDigitInput:(NSString *)input {

    BOOL isValidInput = ([input isEqualToString:@"0"] || [input isEqualToString:@"1"]);
    NSString *errorMessage = isValidInput ? nil : @"invalid_expiry_date_value".localized;

    self.lastExpiryDateValidationResult = [JPValidationResult validationWithResult:NO
                                                                      inputAllowed:YES
                                                                      errorMessage:errorMessage
                                                                    formattedInput:input];
    return self.lastExpiryDateValidationResult;
}

- (BOOL)shouldRejectInput:(NSString *)input {
    BOOL isErrorPresent = self.lastExpiryDateValidationResult.errorMessage != nil;
    BOOL isAddingCharacter = input.length > self.lastExpiryDateValidationResult.formattedInput.length;
    return isErrorPresent && isAddingCharacter;
}

- (JPValidationResult *)validateSecondExpiryDigitInput:(NSString *)input {

    if ([self shouldRejectInput:input]) {
        return self.lastExpiryDateValidationResult;
    }

    if (input.length < self.lastExpiryDateValidationResult.formattedInput.length) {
        NSString *formattedInput = [input substringToIndex:input.length - 1];
        self.lastExpiryDateValidationResult = [JPValidationResult validationWithResult:NO
                                                                          inputAllowed:YES
                                                                          errorMessage:nil
                                                                        formattedInput:formattedInput];
        return self.lastExpiryDateValidationResult;
    }

    BOOL isValidInput = (input.intValue > 0 && input.intValue <= 12);

    NSString *formattedInput = [NSString stringWithFormat:@"%@/", input];
    NSString *errorMessage = isValidInput ? nil : @"invalid_expiry_date_value".localized;
    self.lastExpiryDateValidationResult = [JPValidationResult validationWithResult:NO
                                                                      inputAllowed:YES
                                                                      errorMessage:errorMessage
                                                                    formattedInput:isValidInput ? formattedInput : input];
    return self.lastExpiryDateValidationResult;
}

- (JPValidationResult *)validateThirdExpiryDigitInput:(NSString *)input {

    if ([self shouldRejectInput:input]) {
        return self.lastExpiryDateValidationResult;
    }

    self.lastExpiryDateValidationResult = [JPValidationResult validationWithResult:NO
                                                                      inputAllowed:YES
                                                                      errorMessage:nil
                                                                    formattedInput:input];
    return self.lastExpiryDateValidationResult;
}

- (JPValidationResult *)validateFourthExpiryDigitInput:(NSString *)input {

    if ([self shouldRejectInput:input]) {
        return self.lastExpiryDateValidationResult;
    }

    NSString *lastDigitString = [input substringFromIndex:input.length - 1];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    int yearFirstDigit = [yearString substringToIndex:1].intValue;

    BOOL isValid = lastDigitString.intValue >= yearFirstDigit && lastDigitString.intValue < yearFirstDigit + 2;
    NSString *errorMessage = isValid ? nil : @"invalid_expiry_date_value".localized;

    self.lastExpiryDateValidationResult = [JPValidationResult validationWithResult:NO
                                                                      inputAllowed:YES
                                                                      errorMessage:errorMessage
                                                                    formattedInput:input];
    return self.lastExpiryDateValidationResult;
}

- (JPValidationResult *)validateFifthExpiryDigitInput:(NSString *)input {

    if ([self shouldRejectInput:input]) {
        return self.lastExpiryDateValidationResult;
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kMonthYearDateFormat];
    NSString *currentDate = [formatter stringFromDate:NSDate.date];

    NSArray<NSString *> *currentDateComponents = [currentDate componentsSeparatedByString:@"/"];
    NSArray<NSString *> *inputDateComponents = [input componentsSeparatedByString:@"/"];

    int currentMonth = currentDateComponents[0].intValue;
    int currentYear = currentDateComponents[1].intValue;

    int inputMonth = inputDateComponents[0].intValue;
    int inputYear = inputDateComponents[1].intValue;

    if (inputYear < currentYear) {
        self.lastExpiryDateValidationResult = [JPValidationResult validationWithResult:NO
                                                                          inputAllowed:YES
                                                                          errorMessage:@"check_expiry_date".localized
                                                                        formattedInput:input];
        return self.lastExpiryDateValidationResult;
    }

    if (inputYear == currentYear && inputMonth < currentMonth) {
        self.lastExpiryDateValidationResult = [JPValidationResult validationWithResult:NO
                                                                          inputAllowed:YES
                                                                          errorMessage:@"check_expiry_date".localized
                                                                        formattedInput:input];
        return self.lastExpiryDateValidationResult;
    }

    self.lastExpiryDateValidationResult = [JPValidationResult validationWithResult:YES
                                                                      inputAllowed:YES
                                                                      errorMessage:nil
                                                                    formattedInput:input];
    return self.lastExpiryDateValidationResult;
}

- (BOOL)doesPostalCode:(NSString *)postalCode matchRegex:(NSString *)regex {
    NSRegularExpression *ukRegex = [NSRegularExpression regularExpressionWithPattern:regex
                                                                             options:NSRegularExpressionAnchorsMatchLines
                                                                               error:nil];
    return [ukRegex numberOfMatchesInString:postalCode
                                    options:NSMatchingWithoutAnchoringBounds
                                      range:NSMakeRange(0, postalCode.length)] > 0;
}

- (void)maskAndCheckInputUK:(NSString *__autoreleasing *)input isValid:(BOOL *)isValid {
    NSString *inputClear = [[*input stringByRemovingWhitespaces] uppercaseString];
    NSRange range = NSMakeRange(0, inputClear.length);
    NSRegularExpression *ukRegex = [NSRegularExpression regularExpressionWithPattern:kUKRegex
                                                                             options:NSRegularExpressionAnchorsMatchLines
                                                                               error:nil];
    [ukRegex enumerateMatchesInString:inputClear
                              options:0
                                range:range
                           usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags __unused, BOOL *stop __unused) {
                               if (result != nil && result.numberOfRanges >= 3) {
                                   NSString *firstPart = [inputClear substringWithRange:[result rangeAtIndex:1]];
                                   NSString *secondPart = [inputClear substringWithRange:[result rangeAtIndex:2]];
                                   *input = [NSString stringWithFormat:@"%@ %@", firstPart, secondPart];
                                   *isValid = true;
                               }
                           }];
}

- (void)maskAndCheckInputUSA:(NSString *__autoreleasing *)input isValid:(BOOL *)isValid {
    NSString *inputClear = [[*input stringByRemovingWhitespaces] uppercaseString];
    NSString *inputClearWithoutSpecialCharacters = [inputClear stringByReplacingOccurrencesOfString:@"-" withString:@""];

    if (inputClear.length > kUSAPostalCodeMinLength) {
        NSString *firstPart = [inputClearWithoutSpecialCharacters substringToIndex:kUSAPostalCodeMinLength];
        NSString *secondPart = [inputClearWithoutSpecialCharacters substringWithRange:NSMakeRange(kUSAPostalCodeMinLength, inputClearWithoutSpecialCharacters.length - kUSAPostalCodeMinLength)];

        *input = [NSString stringWithFormat:@"%@-%@", firstPart, secondPart];
    }
    *isValid = [self doesPostalCode:*input matchRegex:kUSARegex];
}

- (void)maskAndCheckInput:(NSString *__autoreleasing *)input country:(JPBillingCountry)country isValid:(BOOL *)isValid {
    switch (country) {
        case JPBillingCountryCanada:
            *input = [[*input stringByRemovingWhitespaces] formatWithPattern:kMaskForCanadaPostCode];
            *isValid = [self doesPostalCode:*input matchRegex:kCanadaRegex];
            break;
        case JPBillingCountryUK:
            [self maskAndCheckInputUK:input isValid:isValid];
            break;
        case JPBillingCountryUSA:
            [self maskAndCheckInputUSA:input isValid:isValid];
            break;
        default:
            break;
    }
}

- (JPValidationResult *)validatePostalCodeInput:(NSString *)input country:(JPBillingCountry)country {
    BOOL isValid = false;
    NSUInteger maxLength = [self postCodeMaxLengthForCountry:country];
    NSUInteger minLength = [self postCodeMinLengthForCountry:country];
    NSString *errorString = [self postCodeErrorForCountry:country];

    if (input.length > maxLength) {
        input = [input substringToIndex:maxLength];
    }

    [self maskAndCheckInput:&input
                    country:country
                    isValid:&isValid];
    NSString *errorMessage = (input.length >= minLength && !isValid) ? errorString : nil;

    JPValidationResult *lastPostalCodeValidationResult = [JPValidationResult validationWithResult:isValid
                                                                                     inputAllowed:input.length <= maxLength
                                                                                     errorMessage:errorMessage
                                                                                   formattedInput:input.uppercaseString];
    return lastPostalCodeValidationResult;
}

- (JPValidationResult *)validateOtherPostalCodeInput:(NSString *)input {
    JPValidationResult *lastPostalCodeValidationResult = [JPValidationResult validationWithResult:YES
                                                                                     inputAllowed:input.length <= kOtherPostalCodeLength
                                                                                     errorMessage:nil
                                                                                   formattedInput:input.uppercaseString];
    return lastPostalCodeValidationResult;
}

- (NSString *)selectedJPBillingCountry {
    if (!_selectedJPBillingCountry) {
        _selectedJPBillingCountry = @"country_uk".localized;
    }
    return _selectedJPBillingCountry;
}

- (NSString *)postCodeErrorForCountry:(JPBillingCountry)country {
    if (country == JPBillingCountryUSA) {
        return @"invalid_zip_code".localized;
    }
    return @"invalid_postcode".localized;
}

- (NSUInteger)postCodeMaxLengthForCountry:(JPBillingCountry)country {
    switch (country) {
        case JPBillingCountryCanada:
            return kCanadaPostalCodeLength;
        case JPBillingCountryUK:
            return kUKPostalCodeMaxLength;
        case JPBillingCountryUSA:
            return kUSAPostalCodeMaxLength;
        case JPBillingCountryOther:
            return kOtherPostalCodeLength;
        default:
            break;
    }
}

- (NSUInteger)postCodeMinLengthForCountry:(JPBillingCountry)country {
    switch (country) {
        case JPBillingCountryCanada:
            return kCanadaPostalCodeLength;
        case JPBillingCountryUK:
            return kUKPostalCodeMinLength;
        case JPBillingCountryUSA:
            return kUSAPostalCodeMinLength;
        case JPBillingCountryOther:
            return kOtherPostalCodeLength;
        default:
            break;
    }
}

- (NSUInteger)maxCardLength:(CardNetwork)cardNetwork {
    switch (cardNetwork) {
        case CardNetworkAMEX:
            return kMaxAMEXCardLength;
        case CardNetworkDinersClub:
            return kMaxDinersClubCardLength;
        default:
            return kMaxDefaultCardLength;
    }
}

@end
