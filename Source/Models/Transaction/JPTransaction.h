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

typedef NS_ENUM(NSUInteger, TransactionMode) {
    TransactionModePayment,
    TransactionModePreAuth,
    TransactionModeServerToServer,
};

typedef NS_ENUM(NSUInteger, TransactionType) {
    TransactionTypePayment,
    TransactionTypePreAuth,
    TransactionTypeRefund,
    TransactionTypeRegisterCard,
    TransactionTypeCheckCard,
    TransactionTypeSaveCard,
    TransactionTypeCollection,
    TransactionTypeVoid,
};

typedef NS_ENUM(NSUInteger, TransactionResult) {
    TransactionResultSuccess,
    TransactionResultDeclined,
    TransactionResultError
};

@interface JPTransaction : NSObject

/**
 * The endpoint of the transaction
 */
@property (nonatomic, strong, readonly) NSString *_Nullable transactionPath;

/**
 * The Judo ID required for most transactions
 */
@property (nonatomic, strong) NSString *_Nonnull judoId;

/**
 * The Site ID used for iDEAL transactions
 */
@property (nonatomic, strong) NSString *_Nullable siteId;

/**
 * An object containing the consumer's and the payment reference
 */
@property (nonatomic, strong) JPReference *_Nullable reference;

/**
 * An object containing the amount and the currency of the transaction
 */
@property (nonatomic, strong) JPAmount *_Nullable amount;

/**
 * An object that stores the card details
 */
@property (nonatomic, strong) JPCard *_Nullable card;

/**
 * An object that stores the payment token for the transaction
 */
@property (nonatomic, strong) JPPaymentToken *_Nullable paymentToken;

/**
 * An object that stores additional account details passed to the transaction
 */
@property (nonatomic, strong) JPPrimaryAccountDetails *_Nullable primaryAccountDetails;

/**
 * An object that stores ApplePay-related payment information
 */
@property (nonatomic, strong, readonly) PKPayment *_Nullable pkPayment;

/**
 * An object that stores the Visa Checkout result details
 */
@property (nonatomic, strong, readonly) JPVCOResult *_Nullable vcoResult;

/**
 * A structure that stores the coordinates of the device
 */
@property (nonatomic, assign) CLLocationCoordinate2D location;

/**
 * A dictionary object with device-related details
 */
@property (nonatomic, strong) NSDictionary *_Nullable deviceSignal;

/**
 * The user's mobile number
 */
@property (nonatomic, strong) NSString *_Nullable mobileNumber;

/**
 * The user's email address
 */
@property (nonatomic, strong) NSString *_Nullable emailAddress;

/**
 * A reference to the API session used to make REST API requests
 */
@property (nonatomic, strong) JPSession *_Nullable apiSession;

/**
 * A reference to the transaction enricher object
 */
@property (nonatomic, strong) JPTransactionEnricher *_Nullable enricher;

/**
 * An object that offers additional SDK-related details
 */
@property (nonatomic, strong) JPEnhancedPaymentDetail *_Nullable paymentDetail;

/**
 * Initializer that creates a JPTransaction instance based on a provided transaction type
 *
 * @param type - the type of the transaction
 *
 * @returns a configured instance of JPTransaction
 */
+ (nonnull instancetype)transactionWithType:(TransactionType)type;

/**
 * Initializer that creates a refund-related JPTransaction instance based on a provided transaction type
 *
 * @param type - the type of the transaction
 * @param receiptId - the receipt identifier
 * @param amount - the amount of the transaction
 *
 * @returns a configured instance of JPTransaction
 */
+ (nonnull instancetype)transactionWithType:(TransactionType)type
                                  receiptId:(nonnull NSString *)receiptId
                                     amount:(nonnull JPAmount *)amount;

/**
 * Initializer that creates a JPTransaction instance based on a provided transaction type
 *
 * @param type - the type of the transaction
 *
 * @returns a configured instance of JPTransaction
 */
- (nonnull instancetype)initWithType:(TransactionType)type;

/**
 * Initializer that creates a refund-related JPTransaction instance based on a provided transaction type
 *
 * @param type - the type of the transaction
 * @param receiptId - the receipt identifier
 * @param amount - the amount of the transaction
 *
 * @returns a configured instance of JPTransaction
 */
- (nonnull instancetype)initWithType:(TransactionType)type
                           receiptId:(nonnull NSString *)receiptId
                              amount:(nonnull JPAmount *)amount;

/**
 * A method which sets the PKPayment object returned from ApplePay in order to complete the payment flow
 *
 * @param pkPayment - the PKPayment object returned from ApplePay
 * @param error - a pointer to an NSError object which will store the possible error
 *
 * @returns 0 if the PKPayment has been succesfully set, 1 otherwise
 */
- (int)setPkPayment:(nonnull PKPayment *)pkPayment
              error:(NSError *__autoreleasing _Nullable *_Nullable)error;

/**
 * A method which sets the Visa Checkout result
 *
 * @param vcoResult - the Visa Checkout result object
 */
- (void)setVCOResult:(nonnull JPVCOResult *)vcoResult;

/**
 * A method which performs the transaction and returns the response/error as a completion block
 *
 * @param completion - the completion block that stores an optional JPResponse object or an NSError
 */
- (void)sendWithCompletion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 * A method that performs a 3D Secure transaction
 *
 * @param parameters - the parameters passed to the transaction
 * @param receiptId - the receipt ID of the transaction
 * @param completion - the completion block that stores an optional JPResponse object or an NSError
 */
- (void)threeDSecureWithParameters:(nonnull NSDictionary *)parameters
                         receiptId:(nonnull NSString *)receiptId
                        completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 * A method which returns a list of all transactions in a completion block
 *
 * @param completion - the completion block that stores an optional JPResponse object or an NSError
 */
- (void)listWithCompletion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 * A method which returns a list of all transactions in a completion block with specified pagination
 *
 * @param pagination - an object that describes the pagination logic (offset & page size) of the transaction list
 * @param completion - the completion block that stores an optional JPResponse object or an NSError
 */
- (void)listWithPagination:(nullable JPPagination *)pagination
                completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

@end
