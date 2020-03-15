//
//  JPCardValidationService.h
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

#import "JPCardDetails.h"
#import <Foundation/Foundation.h>

@class JPCard, JPValidationResult;

/**
 * A class that handles credit card validation
 */
@interface JPCardValidationService : NSObject

/**
 * A method for resetting the card validation results
 */
- (void)resetCardValidationResults;

/**
 *  A method for validating the card number
 *
 *  @param input - an input string
 *  @param networks - the supported card networks
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateCardNumberInput:(NSString *)input
                           forSupportedNetworks:(CardNetwork)networks;

/**
 *  A method for validating the cardholder name
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateCarholderNameInput:(NSString *)input;

/**
 *  A method for validating the expiry date
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateExpiryDateInput:(NSString *)input;

/**
 *  A method for validating the secure code
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateSecureCodeInput:(NSString *)input;

/**
 *  A method for validating the country
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateCountryInput:(NSString *)input;

/**
 *  A method for validating the postal code
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validatePostalCodeInput:(NSString *)input;

@end
