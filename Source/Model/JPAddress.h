//
//  JPAddress.h
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

/**
 *  The Address object stores information around the address that is related to a card
 */
@interface JPAddress : NSObject

/**
 *  Line one of the address
 */
@property (nonatomic, strong) NSString *_Nullable line1;

/**
 *  Line two of the address
 */
@property (nonatomic, strong) NSString *__nullable line2;

/**
 *  Line three of the address
 */
@property (nonatomic, strong) NSString *__nullable line3;

/**
 *  Post code of the address
 */
@property (nonatomic, strong) NSString *__nullable postCode;

/**
 *  Town of the address
 */
@property (nonatomic, strong) NSString *__nullable town;

/**
 *  Billing country of the address
 */
@property (nonatomic, strong) NSString *__nullable billingCountry;

/**
 *  dictionary representation of the receiver
 */
@property (nonatomic, strong, readonly) NSDictionary *__nullable dictionaryRepresentation;

/**
 *  Designated Initializer
 *
 *  @param line1    line one
 *  @param line2    line two
 *  @param line3    line three
 *  @param postCode post code
 *  @param town     town
 *
 *  @return a JPAddress object
 */
- (nonnull instancetype)initWithLine1:(nullable NSString *)line1
                                line2:(nullable NSString *)line2
                                line3:(nullable NSString *)line3
                             postCode:(nullable NSString *)postCode
                                 town:(nullable NSString *)town;

/**
 *  Initializer
 *
 *  @param dictionary a dictionary containing all the values
 *
 *  @return a JPAddress object
 */
- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
