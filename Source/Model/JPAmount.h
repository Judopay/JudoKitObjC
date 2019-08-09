//
//  JPAmount.h
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
 *  Amount objects store information about an amount and the corresponding currency for a transaction
 */
@interface JPAmount : NSObject

/**
 *  The amount to process, to two decimal places
 */
@property (nonatomic, strong, readonly) NSString *_Nonnull amount;

/**
 *  The currency ISO Code - GBP is default
 */
@property (nonatomic, strong, readonly) NSString *_Nonnull currency;

/**
 *  Convenient initializer for amount
 *
 *  @param amount   a string with the value of an amount to transact
 *  @param currency the currency of the amount to transact
 *
 *  @return a JPAmount object
 */
+ (nonnull instancetype)amount:(nonnull NSString *)amount currency:(nonnull NSString *)currency;

/**
 *  Initializer for amount
 *
 *  @param amount   a string with the value of an amount to transact
 *  @param currency the currency of the amount to transact
 *
 *  @return a JPAmount object
 */
- (nonnull instancetype)initWithAmount:(nonnull NSString *)amount currency:(nonnull NSString *)currency;

@end
