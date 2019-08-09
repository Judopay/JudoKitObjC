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
 *  <#Description#>
 */
@property (nonatomic, strong) NSString *_Nullable cardNumber;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSString *_Nullable expiryDate;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSString *_Nullable secureCode;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSString *_Nullable startDate;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSString *_Nullable issueNumber;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) JPAddress *_Nullable cardAddress;

/**
 *  <#Description#>
 *
 *  @param cardNumber <#cardNumber description#>
 *  @param expiryDate <#expiryDate description#>
 *  @param secureCode <#secureCode description#>
 *
 *  @return <#return value description#>
 */
- (nonnull instancetype)initWithCardNumber:(nonnull NSString *)cardNumber expiryDate:(nonnull NSString *)expiryDate secureCode:(nonnull NSString *)secureCode;

@end
