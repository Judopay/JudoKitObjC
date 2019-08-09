//
//  JPVCOResult.h
//  JudoKitObjC
//
//  Copyright (c) 2017 Alternative Payments Ltd
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
 *  A JPVCOResult object used in Visa Checkout transactions
 */
@interface JPVCOResult : NSObject

/**
 *  The callId returned by the Visa Checkout SDK
 */
@property (nonatomic, strong, readonly) NSString *_Nullable callId;

/**
 *  The encrypted key returned by the Visa Checkout SDK
 */
@property (nonatomic, strong, readonly) NSString *_Nullable encryptedKey;

/**
 *  The encrypted payment data returned by the Visa Checkout SDK
 */
@property (nonatomic, strong, readonly) NSString *_Nullable encryptedPaymentData;

/**
 *  Designated initializer
 *
 *  @param callId               callId string
 *  @param encryptedKey         encryptedKey string
 *  @param encryptedPaymentData encryptedPaymentData string
 *
 *  @return a JPVCOResult object
 */
- (nonnull instancetype)initWithCallId:(nonnull NSString *)callId encryptedKey:(nonnull NSString *)encryptedKey encryptedPaymentData:(nonnull NSString *)encryptedPaymentData;

@end
