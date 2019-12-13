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
#import "JPValidationResult.h"
#import "JPCardNetwork.h"
#import "NSString+Card.h"
#import "NSString+Localize.h"
#import "NSError+Judo.h"

@interface JPCardValidationService()

@property (nonatomic, strong) JPValidationResult *lastCardNumberValidationResult;
@property (nonatomic, strong) JPValidationResult *lastCardholderValidationResult;

@end

@implementation JPCardValidationService

//------------------------------------------------------------------------------------
# pragma mark - Public Methods
//------------------------------------------------------------------------------------

- (JPValidationResult *)validateCardNumberInput:(NSString *)input {
    
    NSError *error;
    NSString *presentationString = [input cardPresentationStringWithAcceptedNetworks:self.acceptedCardNetworks
                                                                               error:&error];
    
    NSString *trimmedString = [input stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (input.cardNetwork == CardNetworkAMEX || input.cardNetwork == CardNetworkUATP) {
        if (trimmedString.length > 15) {
            return self.lastCardNumberValidationResult;
        }
    }
    
    if (trimmedString.length > 16) {
        return self.lastCardNumberValidationResult;
    }

    if ([input isCardNumberValid]) {
        self.lastCardNumberValidationResult = [JPValidationResult validationWithResult:YES
                                                                inputAllowed:YES
                                                                errorMessage:nil
                                                              formattedInput:presentationString];
        
        self.lastCardNumberValidationResult.cardNetwork = input.cardNetwork;
        return self.lastCardNumberValidationResult;
    }

    if (input.cardNetwork == CardNetworkAMEX || input.cardNetwork == CardNetworkUATP) {
        if (trimmedString.length == 15) {
            error = NSError.judoInvalidCardNumberError;
        }
    }
    
    if (trimmedString.length == 16) {
        error = NSError.judoInvalidCardNumberError;
    }
    
    self.lastCardNumberValidationResult = [JPValidationResult validationWithResult:NO
                                                            inputAllowed:(presentationString != nil)
                                                            errorMessage:error.localizedDescription
                                                          formattedInput:presentationString];
    
    self.lastCardNumberValidationResult.cardNetwork = input.cardNetwork;
    return self.lastCardNumberValidationResult;
}

- (JPValidationResult *)validateCarholderNameInput:(NSString *)input {
    return [JPValidationResult validationWithResult:input.length > 3
                                       inputAllowed:YES
                                       errorMessage:nil
                                     formattedInput:input];
}

- (JPValidationResult *)validateExpiryDateInput:(NSString *)input {
    
    NSString *invalidInputError = @"Invalid value entered";
    NSString *invalidDateError = @"Please check your expiry date";
    
    //-----------------------------------------------------------------------------
    # pragma mark - VALIDATE FOR 1 DIGIT
    //-----------------------------------------------------------------------------
    
    if (input.length == 1) {
        BOOL isValidInput = ([input isEqualToString:@"0"] || [input isEqualToString:@"1"]);
        self.lastCardholderValidationResult = [JPValidationResult validationWithResult:NO
                                                                          inputAllowed:isValidInput
                                                                          errorMessage:isValidInput ? nil : invalidInputError
                                                                        formattedInput:input];
        return self.lastCardholderValidationResult;
    }
    
    //-----------------------------------------------------------------------------
    # pragma mark - VALIDATE FOR 2 DIGITS
    //-----------------------------------------------------------------------------
    
    if (input.length == 2) {
        
        // Handle backspace -> delete / character
        
        BOOL isValidInput = (input.intValue > 0 && input.intValue <= 12);
        
        NSString *formattedInput = [NSString stringWithFormat:@"%@/", input];
        self.lastCardholderValidationResult = [JPValidationResult validationWithResult:NO
                                                                          inputAllowed:isValidInput
                                                                          errorMessage:isValidInput ? nil : invalidInputError
                                                                        formattedInput:isValidInput ? formattedInput : input];
        return self.lastCardholderValidationResult;
    }
    
    //-----------------------------------------------------------------------------
    # pragma mark - VALIDATE FOR 4 DIGITS
    //----------------------------------------------------------a-------------------
    
    if (input.length == 4) {
        
        NSString *lastDigitString = [input substringFromIndex:input.length - 1];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yy"];
        NSString *yearString = [formatter stringFromDate:[NSDate date]];
        int yearFirstDigit = [yearString substringToIndex:1].intValue;
        
        BOOL isValid = lastDigitString.intValue >= yearFirstDigit && lastDigitString.intValue < yearFirstDigit + 2;
        
        self.lastCardholderValidationResult = [JPValidationResult validationWithResult:NO
                                                                          inputAllowed:isValid
                                                                          errorMessage:isValid ? nil : invalidInputError
                                                                        formattedInput:input];
        return self.lastCardholderValidationResult;
        
    }
    
    if (input.length == 5) {
                
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:NSLocale.currentLocale];
        [formatter setDateFormat:@"MM/yy"];
        NSDate *inputDate = [formatter dateFromString:input];
        
        BOOL isValid = [NSDate.date compare:inputDate] != NSOrderedDescending;
        
        self.lastCardholderValidationResult = [JPValidationResult validationWithResult:NO
                                                                          inputAllowed:isValid
                                                                          errorMessage:isValid ? nil : invalidDateError
                                                                        formattedInput:input];
        return self.lastCardholderValidationResult;
        
    }
    
    
    
    return [JPValidationResult validationWithResult:input.length > 3
                                       inputAllowed:YES
                                       errorMessage:nil
                                     formattedInput:input];
}

- (JPValidationResult *)validateSecureCodeInput:(NSString *)input {
    return [JPValidationResult validationWithResult:input.length > 3
                                       inputAllowed:YES
                                       errorMessage:nil
                                     formattedInput:input];
}

- (JPValidationResult *)validateCountryInput:(NSString *)input {
    return [JPValidationResult validationWithResult:input.length > 3
                                       inputAllowed:YES
                                       errorMessage:nil
                                     formattedInput:input];
}

- (JPValidationResult *)validatePostalCodeInput:(NSString *)input {
    return [JPValidationResult validationWithResult:input.length > 3
                                       inputAllowed:YES
                                       errorMessage:nil
                                     formattedInput:input];
}

//------------------------------------------------------------------------------------
# pragma mark - Helper getters
//------------------------------------------------------------------------------------

- (NSArray *)acceptedCardNetworks {
    return @[
        @(CardNetworkVisa), @(CardNetworkAMEX), @(CardNetworkMasterCard), @(CardNetworkMaestro),
        @(CardNetworkDiscover), @(CardNetworkJCB), @(CardNetworkDinersClub), @(CardNetworkChinaUnionPay),
    ];
}

@end
