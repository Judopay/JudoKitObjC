//
//  JudoKit.h
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
#import <PassKit/PassKit.h>

#import "IDEALService.h"
#import "JPCardDetails.h"
#import "JPSession.h"
#import "JPTransactionData.h"
#import "JudoPaymentMethodsViewController.h"
#import "PaymentMethods.h"

static NSString *__nonnull const JudoKitVersion = @"8.2.1";

@class JudoPayViewController;
@class ApplePayConfiguration;

@class JPPayment, JPPreAuth, JPRegisterCard, JPCheckCard, JPSaveCard, JPTransaction;
@class JPCollection, JPVoid, JPRefund, JPAmount, JPReference, JPPagination, JPResponse;
@class JPCardDetails, JPReceipt, JPPrimaryAccountDetails, JPPaymentToken, JPTheme;

/**
 *  Entry point for interacting with judoKit
 */
@interface JudoKit : NSObject

/**
 *  JudoKit api session
 */
@property (nonatomic, strong, readonly) JPSession *_Nonnull apiSession;

/**
 *  The theme of any judoSession
 */
@property (nonatomic, strong) JPTheme *_Nonnull theme;

/**
 *  An optional property for additional payment metadata a merchant can provide
 */
@property (nonatomic, strong) NSDictionary *_Nullable paymentMetadata;

/**
 * Optional primary account details, such as the name, account number, date of birth and post code
 */
@property (nonatomic, strong) JPPrimaryAccountDetails *_Nullable primaryAccountDetails;

/**
 *  The currently active and visible viewController instance
 */
@property (nonatomic, weak) UIViewController *_Nullable activeViewController;

/**
 *  Designated initializer of JudoKit
 *
 *  @param transaction  A class that conforms to JPTransaction
 *  @param completion   A completion block that is called when the request finishes
 *
 */
- (void)sendWithCompletion:(nonnull JPTransaction *)transaction
                completion:(nonnull JudoCompletionBlock)completion;

/**
 *  Designated initializer of JudoKit
 *
 *  @param token                    A string object representing the token
 *  @param secret                   A string object representing the secret
 *  @param jailbrokenDevicesAllowed A boolean indicating whether the sdk should allow access from jailbroken devices
 *
 *  @return a new instance of JudoKit
 */
- (nonnull instancetype)initWithToken:(nonnull NSString *)token
                               secret:(nonnull NSString *)secret
               allowJailbrokenDevices:(BOOL)jailbrokenDevicesAllowed;

/**
 *  Conveniece initializer. This allows Jailbroken devices to make payments by default
 *
 *  @param token  A string object representing the token
 *  @param secret A string object representing the secret
 *
 *  @return a new instance of JudoKit
 */
- (nonnull instancetype)initWithToken:(nonnull NSString *)token
                               secret:(nonnull NSString *)secret;

/**
 *  This method only creates a JPPayment object for usages in a custom UI. This means the developer needs to set the remaining mandatory fields like a payment method (card, token or PKPayment object for ApplePay) to then make the transaction
 *
 *  @param judoId    The judoID of the merchant to receive the transaction
 *  @param amount    The amount and currency of the payment (default is GBP)
 *  @param reference Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *
 *  @return a JPPayment object
 */
- (nonnull JPPayment *)paymentWithJudoId:(nonnull NSString *)judoId
                                  amount:(nonnull JPAmount *)amount
                               reference:(nonnull JPReference *)reference;

/**
 *  This method only creates a JPPreAuth object for usages in a custom UI. This means the developer needs to set the remaining mandatory fields like a payment method (card, token or PKPayment object for ApplePay) to then make the transaction
 *
 *  @param judoId    The judoID of the merchant to receive the transaction
 *  @param amount    The amount and currency of the pre-auth (default is GBP)
 *  @param reference Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *
 *  @return a JPPreAuth object
 */
- (nonnull JPPreAuth *)preAuthWithJudoId:(nonnull NSString *)judoId
                                  amount:(nonnull JPAmount *)amount
                               reference:(nonnull JPReference *)reference;

/**
 *  This method only creates a JPRegisterCard object for usages in a custom UI. The developer needs to set the remaining mandatory fields to then make the transaction
 *
 *  @param judoId    The judoID of the merchant to receive the transaction
 *  @param reference Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *
 *  @return a JPRegisterCard object
 */
- (nonnull JPRegisterCard *)registerCardWithJudoId:(nonnull NSString *)judoId
                                         reference:(nonnull JPReference *)reference;

/**
 *  This method only creates a JPCheckCard object for usages in a custom UI. The developer needs to set the remaining mandatory fields to then make the transaction
 *
 *  @param judoId    The judoID of the merchant to receive the transaction
 *  @param currency Used to specify an optional currency code. If none is provided, defaults to GBP
 *  @param reference Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *
 *  @return a JPCheckCard object
 */
- (nonnull JPCheckCard *)checkCardWithJudoId:(nonnull NSString *)judoId
                                    currency:(nullable NSString *)currency
                                   reference:(nonnull JPReference *)reference;

/**
 *  This method only creates a JPSaveCard object for usages in a custom UI. The developer needs to set the remaining mandatory fields to then make the transaction
 *
 *  @param judoId    The judoID of the merchant to receive the transaction
 *  @param reference Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *
 *  @return a JPSaveCard object
 */
- (nonnull JPSaveCard *)saveCardWithJudoId:(nonnull NSString *)judoId
                                 reference:(nonnull JPReference *)reference;

/**
 *  This method creates a JPCollection object that can be used to collect a previously pre-authorized transaction.
 *
 *  @param receiptId The receipt ID
 *  @param amount    The amount and currency of the collection (default is GBP)
 *
 *  @return a JPCollection object
 */
- (nonnull JPCollection *)collectionWithReceiptId:(nonnull NSString *)receiptId
                                           amount:(nonnull JPAmount *)amount;

/**
 *  This method creates a JPVoid object that can be used to void a previously pre-authorized transaction to free the reserved funds on the user's card
 *
 *  @param receiptId The receipt ID
 *  @param amount    The amount and currency of the void (default is GBP)
 *
 *  @return a JPVoid object
 */
- (nonnull JPVoid *)voidWithReceiptId:(nonnull NSString *)receiptId
                               amount:(nonnull JPAmount *)amount;

/**
 *  This method creates a JPRefund object that can be used to refund a previous payment transaction and refunds the given amount back to the user's card
 *
 *  @param receiptId The receipt ID
 *  @param amount    The amount and currency of the refund (default is GBP)
 *
 *  @return a JPRefund object
 */
- (nonnull JPRefund *)refundWithReceiptId:(nonnull NSString *)receiptId
                                   amount:(nonnull JPAmount *)amount;

/**
 *  Create a JPReceipt object to query for a given receipt ID or all receipts.
 *
 *  @param receiptId the receipt ID to query for - nil for a list of all receipts
 *
 *  @return a JPReceipt object
 */
- (nonnull JPReceipt *)receipt:(nullable NSString *)receiptId;

/**
 *  A helper method that lists all the transaction for a given class that conforms to JPTransaction (JPPayment, JPPreAuth, JPRegisterCard, JPSaveCard)
 *
 *  @param type       The class that conforms to JPTransaction to be queried for its list
 *  @param pagination An optional pagination object for multi-paged requests
 *  @param completion The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)list:(nonnull Class)type
     paginated:(nullable JPPagination *)pagination
    completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  Helper method that creates a Transaction based on the Class that is passed (JPPayment, JPPreAuth, JPRegisterCard or JPSaveCard)
 *
 *  @param type      The class that conforms to JPTransaction to be created with this method
 *  @param judoId    The judoID of the merchant
 *  @param amount    The amount and currency of the transaction (default is GBP)
 *  @param reference Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *
 *  @return a JPTransaction object
 */
- (nonnull JPTransaction *)transactionForTypeClass:(nonnull Class)type
                                            judoId:(nonnull NSString *)judoId
                                            amount:(nullable JPAmount *)amount
                                         reference:(nonnull JPReference *)reference;

/**
 *  Helper method that creates a Transaction based on the TransactionType that is passed (Payment, PreAuth, RegisterCard or SaveCard)
 *
 *  @param type      The TransactionType to be created with this method
 *  @param judoId    The judoID of the merchant
 *  @param amount    The amount and currency of the transaction (default is GBP)
 *  @param reference Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *
 *  @return a JPTransaction object
 */
- (nullable JPTransaction *)transactionForType:(TransactionType)type
                                        judoId:(nonnull NSString *)judoId
                                        amount:(nullable JPAmount *)amount
                                     reference:(nonnull JPReference *)reference;

@end

@interface JudoKit (Invokers)

/**
 *  This method will invoke the Payment Method screen which allows you to select your preferred payment method to complete a Payment transaction.
 *
 *  @param judoId               The judoID of the merchant to receive the payment
 *  @param amount               The amount and currency of the payment (default is GBP)
 *  @param reference         The reference for this transaction
 *  @param methods              The payment methods to be shown
 *  @param networks   The supported card networks
 *  @param completion           The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokePaymentMethodSelection:(nonnull NSString *)judoId
                              amount:(nonnull JPAmount *)amount
                           reference:(nonnull JPReference *)reference
                      paymentMethods:(PaymentMethods)methods
               supportedCardNetworks:(CardNetwork)networks
                          completion:(nonnull JudoCompletionBlock)completion;

/**
 *  This method will invoke the Payment Method screen which allows you to select your preferred payment method to complete a PreAuth transaction.
 *
 *  @param judoId               The judoID of the merchant to receive the payment
 *  @param amount               The amount and currency of the payment (default is GBP)
 *  @param reference            The reference for this transaction
 *  @param methods              The payment methods to be shown
 *  @param networks   The supported card networks
 *  @param completion           The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokePreAuthMethodSelection:(nonnull NSString *)judoId
                              amount:(nonnull JPAmount *)amount
                           reference:(nonnull JPReference *)reference
                      paymentMethods:(PaymentMethods)methods
               supportedCardNetworks:(CardNetwork)networks
                          completion:(nonnull JudoCompletionBlock)completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. When the form has been successfully filled, the button will invoke a payment with the judo API and respond in a completion block
 *
 *  @param judoId               The judoID of the merchant to receive the payment
 *  @param amount               The amount and currency of the payment (default is GBP)
 *  @param reference            The consumer reference for this transaction
 *  @param cardDetails          The card details to present in the input fields
 *  @param completion           The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokePayment:(nonnull NSString *)judoId
               amount:(nonnull JPAmount *)amount
    consumerReference:(nonnull NSString *)reference
          cardDetails:(nullable JPCardDetails *)cardDetails
           completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. When the form has been successfully filled, the button will invoke a payment with the judo API and respond in a completion block
 *
 *  @param judoId      The judoID of the merchant to receive the payment
 *  @param amount      The amount and currency of the payment (default is GBP)
 *  @param reference   Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *  @param cardDetails The card details to present in the input fields
 *  @param completion  The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokePayment:(nonnull NSString *)judoId
               amount:(nonnull JPAmount *)amount
            reference:(nonnull JPReference *)reference
          cardDetails:(nullable JPCardDetails *)cardDetails
           completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. When the form has been successfully filled, the button will invoke a pre-auth with the judo API and respond in a completion block
 *
 *  @param judoId               The judoID of the merchant to receive the pre-auth
 *  @param amount               The amount and currency of the pre-auth (default is GBP)
 *  @param reference            The consumer reference for this transaction
 *  @param cardDetails          The card details to present in the input fields
 *  @param completion           The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokePreAuth:(nonnull NSString *)judoId
               amount:(nonnull JPAmount *)amount
    consumerReference:(nonnull NSString *)reference
          cardDetails:(nullable JPCardDetails *)cardDetails
           completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. When the form has been successfully filled, the button will invoke a pre-auth with the judo API and respond in a completion block
 *
 *  @param judoId      The judoID of the merchant to receive the pre-auth
 *  @param amount      The amount and currency of the pre-auth (default is GBP)
 *  @param reference   Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *  @param cardDetails The card details to present in the input fields
 *  @param completion  The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokePreAuth:(nonnull NSString *)judoId
               amount:(nonnull JPAmount *)amount
            reference:(nonnull JPReference *)reference
          cardDetails:(nullable JPCardDetails *)cardDetails
           completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. When the form has been successfully filled, the button will invoke a card registration with the judo API and respond in a completion block
 *
 *  @param judoId               The judoID of the merchant
 *  @param reference            The consumer reference for this transaction
 *  @param completion           The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeRegisterCard:(nonnull NSString *)judoId
         consumerReference:(nonnull NSString *)reference
                completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. When the form has been successfully filled, the button will invoke a card registration with the judo API and respond in a completion block
 *
 *  @param judoId      The judoID of the merchant
 *  @param reference   Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *  @param completion  The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeRegisterCard:(nonnull NSString *)judoId
                 reference:(nonnull JPReference *)reference
                completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. When the form has been successfully filled, the button will invoke a card registration with the judo API and respond in a completion block
 *
 *  @param judoId      The judoID of the merchant
 *  @param reference   Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *  @param cardDetails The card details to present in the input fields
 *  @param completion  The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeCheckCard:(nonnull NSString *)judoId
               currency:(nullable NSString *)amount
              reference:(nonnull JPReference *)reference
            cardDetails:(nullable JPCardDetails *)cardDetails
             completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will save a card with the judo API and respond in a completion block
 *
 *  @param judoId               The judoID of the merchant
 *  @param reference            The consumer reference
 *  @param cardDetails          The card details to be saved
 *  @param completion           The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeSaveCard:(nonnull NSString *)judoId
     consumerReference:(nonnull NSString *)reference
            completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will save a card with the judo API and respond in a completion block
 *
 *  @param judoId      The judoID of the merchant
 *  @param reference   Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *  @param completion  The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeSaveCard:(nonnull NSString *)judoId
             reference:(nonnull JPReference *)reference
            completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. This method needs the cardDetails object in order to show the known details to the user when entering the CV2. When the form has been successfully filled, the button will invoke a token payment with the judo API and respond in a completion block
 *
 *  @param judoId               The judoID of the merchant to receive the token payment
 *  @param amount               The amount and currency of the payment (default is GBP)
 *  @param reference            The consumer reference for this transaction
 *  @param cardDetails          The card details to present in the input fields
 *  @param paymentToken         The consumer and card token to make a token payment with
 *  @param completion           The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeTokenPayment:(nonnull NSString *)judoId
                    amount:(nonnull JPAmount *)amount
         consumerReference:(nonnull NSString *)reference
               cardDetails:(nonnull JPCardDetails *)cardDetails
              paymentToken:(nonnull JPPaymentToken *)paymentToken
                completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. This method needs the cardDetails object in order to show the known details to the user when entering the CV2. When the form has been successfully filled, the button will invoke a token payment with the judo API and respond in a completion block
 *
 *  @param judoId       The judoID of the merchant to receive the token payment
 *  @param amount       The amount and currency of the payment (default is GBP)
 *  @param reference    Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *  @param cardDetails  The card details to present in the input fields
 *  @param paymentToken The consumer and card token to make a token payment with
 *  @param completion   The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeTokenPayment:(nonnull NSString *)judoId
                    amount:(nonnull JPAmount *)amount
                 reference:(nonnull JPReference *)reference
               cardDetails:(nonnull JPCardDetails *)cardDetails
              paymentToken:(nonnull JPPaymentToken *)paymentToken
                completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. This method needs the cardDetails object in order to show the known details to the user when entering the CV2. When the form has been successfully filled, the button will invoke a token pre-auth with the judo API and respond in a completion block
 *
 *  @param judoId               The judoID of the merchant to receive the token pre-auth
 *  @param amount               The amount and currency of the pre-auth (default is GBP)
 *  @param reference            The consumer reference for this transaction
 *  @param cardDetails          The card details to present in the input fields
 *  @param paymentToken         The consumer and card token to make a token payment with
 *  @param completion           The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeTokenPreAuth:(nonnull NSString *)judoId
                    amount:(nonnull JPAmount *)amount
         consumerReference:(nonnull NSString *)reference
               cardDetails:(nonnull JPCardDetails *)cardDetails
              paymentToken:(nonnull JPPaymentToken *)paymentToken
                completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the Judo UI on the top UIViewController instance of the Application window. This method needs the cardDetails object in order to show the known details to the user when entering the CV2. When the form has been successfully filled, the button will invoke a token pre-auth with the judo API and respond in a completion block
 *
 *  @param judoId       The judoID of the merchant to receive the token pre-auth
 *  @param amount       The amount and currency of the pre-auth (default is GBP)
 *  @param reference    Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *  @param cardDetails  The card details to present in the input fields
 *  @param paymentToken The consumer and card token to make a token payment with
 *  @param completion   The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeTokenPreAuth:(nonnull NSString *)judoId
                    amount:(nonnull JPAmount *)amount
                 reference:(nonnull JPReference *)reference
               cardDetails:(nonnull JPCardDetails *)cardDetails
              paymentToken:(nonnull JPPaymentToken *)paymentToken
                completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

/**
 *  This method will invoke the iDEAL transaction form on the top UIViewController instance of the Applications window. The iDEAL transaction form allows the
 *  merchant to set a name and select from one of the available iDEAL banks to complete the transaction.
 *
 *  @param judoId           The judoID of the merchant to receive the token pre-auth
 *  @param amount           The amount expressed as a double (currency is limited to EUR)
 *  @param reference     Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 *  @param redirectCompletion        A completion block that can be optionally set to return back the redirect response for iDEAL transactions
 *  @param completion   The completion handler which will respond with a JPResponse object or an NSError
 */
- (void)invokeIDEALPaymentWithJudoId:(nonnull NSString *)judoId
                              amount:(double)amount
                           reference:(nonnull JPReference *)reference
                  redirectCompletion:(nullable IDEALRedirectCompletion)redirectCompletion
                          completion:(nonnull JudoCompletionBlock)completion;

@end

@interface JudoKit (ApplePay) <PKPaymentAuthorizationViewControllerDelegate>

/**
 *  This method will request and process Apple Pay payments. It works by presenting the
 *  PKAuthorizationViewController object and using its delegate methods to send a JPTransaction object
 *  and return the payment completion block. Besides the usual response, JPResponse also stores the
 *  optional billing and shipping contact information.
 *
 *  @param configuration    An ApplePayConfiguration object that sets Apple Pay payment properties.
 *  @param completion       The completion handler which will respond with a JPResponse object or an NSError.
 */
- (void)invokeApplePayWithConfiguration:(nonnull ApplePayConfiguration *)configuration
                             completion:(nonnull JudoCompletionBlock)completion;

@end
