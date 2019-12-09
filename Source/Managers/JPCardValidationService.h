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

#import <Foundation/Foundation.h>

@class JPCard;

@interface JPCardValidationService : NSObject

/**
 * A method that validates a JPCard object
 *
 * @param card - an instance of JPCard that contains the card details
 * @param isAVSEnabled - a boolean value that, if set, takes AVS fields into consideration
 */
- (BOOL)isCardValid:(JPCard *)card withAVSEnabled:(BOOL)isAVSEnabled;

/**
 * A method that validates the card number string
 *
 * @param cardNumber - the card number string to be validated
 */
- (BOOL)isCardNumberValid:(NSString *)cardNumber;

/**
 * A method that validates the cardholder name
 *
 * @param cardholderName - the cardholder name string to be validated
 */
- (BOOL)isCardholderNameValid:(NSString *)cardholderName;

/**
 * A method that validates the card expiry date
 *
 * @param expiryDate - the expiry date string to be validated
 */
- (BOOL)isExpiryDateValid:(NSString *)expiryDate;

/**
 * A method that validates the secure code
 *
 * @param secureCode - the secure code string to be validated
 */
- (BOOL)isSecureCodeValid:(NSString *)secureCode;

/**
 * A method that validates the expiry date month
 *
 * @param month - the month string value to be validated
 */
- (BOOL)isValidMonth:(NSString *)month;

/**
 * A method that validates the expiry date year
 *
 * @param year - the year string value to be validated
 */
- (BOOL)isValidYear:(NSString *)year;

/**
 * A method that validates the country
 *
 * @param country - the country string value to be validated
 */
- (BOOL)isCountryValid:(NSString *)country;

/**
 * A method that validates the postal code
 *
 * @param postalCode - the postal code string value to be validated
 */
- (BOOL)isPostalCodeValid:(NSString *)postalCode;

@end
