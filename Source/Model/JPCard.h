//
//  JPCard.h
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

#import <Foundation/Foundation.h>

@class JPAddress;

/**
 *  Card objects store all the necessary card information for making transactions
 */
@interface JPCard : NSObject

/**
 *  A string describing the card number
 */
@property (nonatomic, strong) NSString *_Nullable cardNumber;

/**
 *  A string describing the cardholder name
 */
@property (nonatomic, strong) NSString *_Nullable cardholderName;

/**
 *  A string describing the card expiration date
 */
@property (nonatomic, strong) NSString *_Nullable expiryDate;

/**
 *  A string describing the card's secure code
 */
@property (nonatomic, strong) NSString *_Nullable secureCode;

/**
 *  A string describing the card's start date (Maestro-specific)
 */
@property (nonatomic, strong) NSString *_Nullable startDate;

/**
 *  A string describing the card's issue number (Maestro-specific)
 */
@property (nonatomic, strong) NSString *_Nullable issueNumber;

/**
 *  A JPAddress instance describing the billing address
 */
@property (nonatomic, strong) JPAddress *_Nullable cardAddress;

/**
 *  Initializes a card with the minimum required card details
 *
 *  @param cardNumber - a string describing the card number
 *  @param cardholderName - a string describing the cardholder name
 *  @param expiryDate - a string describing the expiration date
 *  @param secureCode - a string describing the secure code
 *
 *  @return a configured JPCard instance
 */
- (nonnull instancetype)initWithCardNumber:(nonnull NSString *)cardNumber
                            cardholderName:(nullable NSString *)cardholderName
                                expiryDate:(nonnull NSString *)expiryDate
                                secureCode:(nonnull NSString *)secureCode;

@end
