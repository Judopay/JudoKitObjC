//
//  JPReference.h
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

#import <UIKit/UIKit.h>

/**
 *  the Reference object is supposed to simplify storing reference data like consumer, payment references and metadata dictionary that can hold an arbitrary set of key value based information
 */
@interface JPReference : NSObject

/**
 *  Your reference for this consumer
 */
@property (nonatomic, strong, readonly) NSString *_Nonnull consumerReference;

/**
 *  Your reference for this payment
 */
@property (nonatomic, strong, readonly) NSString *_Nonnull paymentReference;

/**
 *  An object containing any additional data you wish to tag this payment with. The property name and value are both limited to 50 characters, and the whole object cannot be more than 1024 characters
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSObject *> *_Nullable metaData;

/**
 *  initializer that will generate a unique payment reference
 *
 *  @param ref The consumer reference for a JPReference
 *
 *  @return a JPReference object
 */
- (nonnull instancetype)initWithConsumerReference:(nonnull NSString *)ref;

/**
 *  initializer that will generate a unique payment reference
 *
 *
 *  @param ref The payment reference for a JPReference - This must be a unquie reference for this transaction. Every request to the api must contain a different payment reference.
 *
 *  @return a JPReference object
 */
- (nonnull instancetype)initWithConsumerReference:(nonnull NSString *)ref paymentReference:(nonnull NSString *)paymentReference;

/**
 *  Convenient initializer that will generate a unique payment reference
 *
 *  @param ref The consumer reference for a JPReference
 *
 *  @return a JPReference object
 */
+ (nonnull instancetype)consumerReference:(nonnull NSString *)ref;

/**
 *  Helper method that creates a randomly generated Payment reference string
 *
 *  @return a random string that can act as a payment reference for any kind of transaction with the judo API
 */
+ (nullable NSString *)generatePaymentReference;

@end
