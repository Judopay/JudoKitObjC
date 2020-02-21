//
//  JPOrderDetails.h
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

/**
 *  An object containing the order details returned from an iDEAL transaction
 */
@interface JPOrderDetails : NSObject

/**
 *  The order identifier for the transaction
 */
@property (nonatomic, strong) NSString *_Nullable orderId;

/**
 *  The status of the transaction
 */
@property (nonatomic, strong, readonly) NSString *_Nullable orderStatus;

/**
 *  The optional failure reason if the transaction failed
 */
@property (nonatomic, strong, readonly) NSString *_Nullable orderFailureReason;

/**
 *  The timestamp of the response
 */
@property (nonatomic, strong, readonly) NSString *_Nullable timestamp;

/**
 *  Designated initializer
 *
 *  @param dictionary The JSON dictionary returned from the server
 *
 *  @return an instance of a JPOrderDetails object
 */
- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
