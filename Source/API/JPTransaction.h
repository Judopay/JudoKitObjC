//
//  JPTransaction.h
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

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

@class JPResponse, JPPagination, JPSession, JPPaymentToken, JPCard, JPAmount, JPReference, JPVCOResult, JPEnhancedPaymentDetail,
    JPTransactionEnricher, JPPrimaryAccountDetails;

/**
 *  Superclass Helper for Payment, Pre-auth, RegisterCard and SaveCard
 */
@interface JPTransaction : NSObject

/**
 *  path variable made for subclassing to identify the api path
 */
@property (nonatomic, strong, readonly) NSString *_Nullable transactionPath;

/**
 *  The judo ID for the transaction
 */
@property (nonatomic, strong) NSString *_Nonnull judoId;

/**
 *  The reference of the transaction
 */
@property (nonatomic, strong) JPReference *_Nullable reference;

/**
 *  The amount and currency of the transaction
 */
@property (nonatomic, strong) JPAmount *_Nullable amount;

/**
 *  The card info of the transaction
 */
@property (nonatomic, strong) JPCard *_Nullable card;

/**
 *  The payment token of the transaction
 */
@property (nonatomic, strong) JPPaymentToken *_Nullable paymentToken;

/**
 *  Object that contains information about the account details provided by the merchant
 */
@property (nonatomic, strong) JPPrimaryAccountDetails *_Nullable primaryAccountDetails;

/**
 *  the PKPayment object for ApplePay
 */
@property (nonatomic, strong, readonly) PKPayment *_Nullable pkPayment;

/**
 *  The VCOPaymentDetails object for Visa Checkout payment
 */
@property (nonatomic, strong, readonly) JPVCOResult *_Nullable vcoResult;

/**
 *  Location coordinate for fraud prevention in this transaction
 */
@property (nonatomic, assign) CLLocationCoordinate2D location;

/**
 *  Device identification for this transaction
 */
@property (nonatomic, strong) NSDictionary *_Nullable deviceSignal;

/**
 *  Mobile number of the entity initiating the transaction
 */
@property (nonatomic, strong) NSString *_Nullable mobileNumber;

/**
 *  Email address of the entity initiating the transaction
 */
@property (nonatomic, strong) NSString *_Nullable emailAddress;

/**
 *  The current Session to access the Judo API
 */
@property (nonatomic, strong) JPSession *_Nullable apiSession;

@property (nonatomic, strong) JPTransactionEnricher *_Nullable enricher;

@property (nonatomic, strong) JPEnhancedPaymentDetail *_Nullable paymentDetail;

/**
 *  set the PKPayment object
 *
 *  @param pkPayment the PKPayment object that was returned from PassKit
 *  @param error     an error if the PKPayment object was faulty
 */
- (int)setPkPayment:(nonnull PKPayment *)pkPayment error:(NSError *__autoreleasing _Nullable *_Nullable)error;

/**
 *  set the VCOResult object
 *
 *  @param vcoResult the VCOResult object that was returned from the Visa Checkout SDK
 */
- (void)setVCOResult:(nonnull JPVCOResult *)vcoResult;

/**
 *  Helper method that checks if the transaction is valid
 *
 *  @return error if transaction is not valid
 */
- (nullable NSError *)validateTransaction;

/**
 *  Completion caller - this method will automatically trigger a Session Call to the judo REST API and execute the request based on the information that were set in the previous methods
 *
 *  @param completion a completion block that is called when the request finishes
 */
- (void)sendWithCompletion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  threeDSecure call - this method will automatically trigger a Session Call to the judo REST API and execute the finalizing 3DS call on top of the information that had been sent in the previous methods
 *
 *  @param parameters the dictionary that contains all the information from the 3DS WKWebView Request
 *  @param receiptId  the receipt for the given Transaction
 *  @param completion a completion block that is called when the request finishes
 */
- (void)threeDSecureWithParameters:(nonnull NSDictionary *)parameters
                         receiptId:(nonnull NSString *)receiptId
                        completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will return a list of transactions, filtered to just show the payment or preAuth transactions. The method will show the first 10 items in a Time Descending order. See [List all transactions](<https://www.judopay.com/docs/v4_1/restful-api/api-reference/#transactions>) for more information.
 *
 *  @param completion a completion block that is called when the request finishes
 */
- (void)listWithCompletion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will return a list of transactions, filtered to just show the payment or pre-auth transactions. See [List all transactions](<https://www.judopay.com/docs/v4_1/restful-api/api-reference/#transactions>) for more information.
 *
 *  @param pagination The offset, number of items and order in which to return the items
 *  @param completion a completion block that is called when the request finishes
 */
- (void)listWithPagination:(nullable JPPagination *)pagination
                completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

@end
