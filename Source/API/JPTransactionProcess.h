//
//  JPTransactionProcess.h
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

@import CoreLocation;

@class JPAmount;
@class JPResponse;
@class JPSession;

/**
 *  Superclass Helper for Collection, Void and Refund
 */
@interface JPTransactionProcess : NSObject

/**
 *  The receipt ID for a collection, void or refund
 */
@property (nonatomic, strong, readonly) NSString *_Nonnull receiptId;

/**
 *  The amount of the collection, void or refund
 */
@property (nonatomic, strong, readonly) JPAmount *_Nonnull amount;

/**
 *  The payment reference String for a collection, void or refund
 */
@property (nonatomic, strong, readonly) NSString *_Nonnull paymentReference;

/**
 *  Location coordinate for fraud prevention in this transaction
 */
@property (nonatomic, assign) CLLocationCoordinate2D location;

/**
 *  Device identification for this transaction
 */
@property (nonatomic, strong) NSDictionary *_Nullable deviceSignal;

/**
 *  Helper method for subclasses to be able to access the dynamic path value
 */
@property (nonatomic, strong, readonly) NSString *_Nullable transactionProcessingPath;

/**
 *  the current api session variable
 */
@property (nonatomic, strong) JPSession *_Nullable apiSession;

/**
 *  Starting point and a reactive method to create a collection, void or refund
 *
 *  @param receiptId the receiptID identifying the transaction you wish to collect, void or refund - has to be luhn-valid
 *  @param amount    The amount to process
 *
 *  @return a JPTransactionProcess instance
 */
- (nonnull instancetype)initWithReceiptId:(nonnull NSString *)receiptId amount:(nonnull JPAmount *)amount;

/**
 *  Completion caller - this method will automatically trigger a Session Call to the judo REST API and execute the request based on the information that were set in the previous methods
 *
 *  @param completion a completion block that is called when the request finishes
 */
- (void)sendWithCompletion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

@end
