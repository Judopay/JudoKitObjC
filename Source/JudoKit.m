//
//  JudoKit.m
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

#import "JudoKit.h"

#import <DeviceDNA/DeviceDNA.h>

#import "ApplePayConfiguration.h"
#import "ApplePayManager.h"
#import "CardInputField.h"
#import "DateInputField.h"
#import "FloatingTextField.h"
#import "IDEALFormViewController.h"
#import "JPCheckCard.h"
#import "JPCollection.h"
#import "JPInputField.h"
#import "JPPayment.h"
#import "JPPreAuth.h"
#import "JPPrimaryAccountDetails.h"
#import "JPReceipt.h"
#import "JPReference.h"
#import "JPRefund.h"
#import "JPRegisterCard.h"
#import "JPResponse.h"
#import "JPSaveCard.h"
#import "JPSession.h"
#import "JPTheme.h"
#import "JPTransactionData.h"
#import "JPTransactionEnricher.h"
#import "JPVoid.h"
#import "JudoPayViewController.h"
#import "JudoPaymentMethodsViewModel.h"
#import "NSError+Judo.h"

#import "JPAddCardBuilder.h"
#import "JPAddCardViewController.h"
#import "SliderTransitioningDelegate.h"

@interface JPSession ()
@property (nonatomic, strong, readwrite) NSString *authorizationHeader;
@end

@interface JudoKit ()
@property (nonatomic, strong, readwrite) JPSession *apiSession;
@property (nonatomic, strong) JPTransactionEnricher *enricher;
@property (nonatomic, strong) NSString *deviceIdentifier;
@property (nonatomic, strong) ApplePayManager *manager;
@property (nonatomic, strong) ApplePayConfiguration *configuration;
@property (nonatomic, strong) PKPaymentAuthorizationViewController *viewController;
@property (nonatomic, strong) JudoCompletionBlock completionBlock;
@property (nonatomic, strong) SliderTransitioningDelegate *transitioningDelegate;
@end

@implementation JudoKit

/**
 A method that checks if the device it is currently running on is jailbroken or not
 
 - returns: true if device is jailbroken
 */
- (BOOL)isCurrentDeviceJailbroken {
    return [NSFileManager.defaultManager fileExistsAtPath:@"/private/var/lib/apt/"];
}

- (instancetype)initWithToken:(NSString *)token secret:(NSString *)secret {
    return [self initWithToken:token secret:secret allowJailbrokenDevices:YES];
}

- (instancetype)initWithToken:(NSString *)token
                       secret:(NSString *)secret
       allowJailbrokenDevices:(BOOL)jailbrokenDevicesAllowed {

    self = [super init];

    if (!self)
        return self;

    // Check if device is jailbroken and SDK was set to restrict access.
    // self is returned here without setting the token and secret.
    // When the transaction is attempted it will fail citing unset credentials.
    if (!jailbrokenDevicesAllowed && [self isCurrentDeviceJailbroken]) {
        return self;
    }

    NSString *plainString = [NSString stringWithFormat:@"%@:%@", token, secret];
    NSData *plainData = [plainString dataUsingEncoding:NSISOLatin1StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];

    self.enricher = [[JPTransactionEnricher alloc] initWithToken:token secret:secret];
    self.apiSession = [JPSession new];
    [self.apiSession setAuthorizationHeader:[NSString stringWithFormat:@"Basic %@", base64String]];
    self.transitioningDelegate = [SliderTransitioningDelegate new];

    return self;
}

- (void)sendWithCompletion:(nonnull JPTransaction *)transaction
                completion:(nonnull JudoCompletionBlock)completion {

    [transaction sendWithCompletion:completion];
}

- (void)presentPaymentViewControllerWithJudoId:(NSString *)judoId
                                        amount:(JPAmount *)amount
                                     reference:(JPReference *)reference
                                   transaction:(TransactionType)type
                                   cardDetails:(JPCardDetails *)cardDetails
                                  paymentToken:(JPPaymentToken *)paymentToken
                                    completion:(JudoCompletionBlock)completion {

    JudoPayViewController *viewController = [[JudoPayViewController alloc] initWithJudoId:judoId
                                                                                   amount:amount
                                                                                reference:reference
                                                                              transaction:type
                                                                           currentSession:self
                                                                              cardDetails:cardDetails
                                                                               completion:completion];

    viewController.primaryAccountDetails = self.primaryAccountDetails;
    viewController.paymentToken = paymentToken;
    viewController.theme = self.theme;
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.activeViewController = viewController;
    [self.topMostViewController presentViewController:navigationController animated:YES completion:nil];
}

- (JPTransaction *)transactionForTypeClass:(Class)type
                                    judoId:(NSString *)judoId
                                    amount:(nullable JPAmount *)amount
                                 reference:(nonnull JPReference *)reference {

    JPTransaction *transaction = [type new];
    transaction.judoId = judoId;
    transaction.amount = amount;
    transaction.reference = reference;
    transaction.apiSession = self.apiSession;
    transaction.primaryAccountDetails = self.primaryAccountDetails;
    transaction.enricher = self.enricher;

    return transaction;
}

- (JPTransaction *)transactionForType:(TransactionType)type
                               judoId:(NSString *)judoId
                               amount:(JPAmount *)amount
                            reference:(JPReference *)reference {

    Class transactionTypeClass;

    switch (type) {
        case TransactionTypePayment:
            transactionTypeClass = JPPayment.class;
            break;

        case TransactionTypePreAuth:
            transactionTypeClass = JPPreAuth.class;
            break;

        case TransactionTypeRegisterCard:
            transactionTypeClass = JPRegisterCard.class;
            break;

        case TransactionTypeSaveCard:
            transactionTypeClass = JPSaveCard.class;
            break;

        case TransactionTypeCheckCard:
            transactionTypeClass = JPCheckCard.class;
            break;

        default:
            return nil;
    }

    return [self transactionForTypeClass:transactionTypeClass
                                  judoId:judoId
                                  amount:amount
                               reference:reference];
}

- (JPPayment *)paymentWithJudoId:(NSString *)judoId
                          amount:(JPAmount *)amount
                       reference:(JPReference *)reference {

    return (JPPayment *)[self transactionForTypeClass:JPPayment.class
                                               judoId:judoId
                                               amount:amount
                                            reference:reference];
}

- (JPPreAuth *)preAuthWithJudoId:(NSString *)judoId
                          amount:(JPAmount *)amount
                       reference:(JPReference *)reference {

    return (JPPreAuth *)[self transactionForTypeClass:JPPreAuth.class
                                               judoId:judoId
                                               amount:amount
                                            reference:reference];
}

- (JPRegisterCard *)registerCardWithJudoId:(NSString *)judoId
                                 reference:(JPReference *)reference {

    return (JPRegisterCard *)[self transactionForTypeClass:JPRegisterCard.class
                                                    judoId:judoId
                                                    amount:nil
                                                 reference:reference];
}

- (JPCheckCard *)checkCardWithJudoId:(NSString *)judoId
                            currency:(NSString *)currency
                           reference:(JPReference *)reference {

    return (JPCheckCard *)[self transactionForTypeClass:JPRegisterCard.class
                                                 judoId:judoId
                                                 amount:currency ? [JPAmount amount:@"0.0" currency:currency] : nil
                                              reference:reference];
}

- (JPSaveCard *)saveCardWithJudoId:(NSString *)judoId
                         reference:(JPReference *)reference {
    return (JPSaveCard *)[self transactionForTypeClass:JPSaveCard.class
                                                judoId:judoId
                                                amount:nil
                                             reference:reference];
}

- (JPTransactionProcess *)transactionProcessForType:(Class)type
                                          receiptId:(NSString *)receiptId
                                             amount:(JPAmount *)amount {

    JPTransactionProcess *transactionProc = [[type alloc] initWithReceiptId:receiptId
                                                                     amount:amount];

    transactionProc.apiSession = self.apiSession;
    return transactionProc;
}

- (JPCollection *)collectionWithReceiptId:(NSString *)receiptId
                                   amount:(JPAmount *)amount {

    return (JPCollection *)[self transactionProcessForType:JPCollection.class
                                                 receiptId:receiptId
                                                    amount:amount];
}

- (JPVoid *)voidWithReceiptId:(NSString *)receiptId
                       amount:(JPAmount *)amount {

    return (JPVoid *)[self transactionProcessForType:JPVoid.class
                                           receiptId:receiptId
                                              amount:amount];
}

- (JPRefund *)refundWithReceiptId:(NSString *)receiptId
                           amount:(JPAmount *)amount {

    return (JPRefund *)[self transactionProcessForType:JPRefund.class
                                             receiptId:receiptId
                                                amount:amount];
}

- (JPReceipt *)receipt:(NSString *)receiptId {
    JPReceipt *receipt = [[JPReceipt alloc] initWithReceiptId:receiptId];
    receipt.apiSession = self.apiSession;
    return receipt;
}

- (void)list:(Class)type
     paginated:(JPPagination *)pagination
    completion:(JudoCompletionBlock)completion {

    JPTransaction *transaction = [type new];
    transaction.apiSession = self.apiSession;
    [transaction listWithPagination:pagination completion:completion];
}

#pragma mark - Helper methods

- (UIViewController *)topMostViewController {
    UIViewController *topViewController = UIApplication.sharedApplication.keyWindow.rootViewController;

    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;

        if ([topViewController isKindOfClass:UINavigationController.class]) {
            UINavigationController *navigationController = (UINavigationController *)topViewController;
            topViewController = navigationController.viewControllers.lastObject;
        }

        if ([topViewController isKindOfClass:UITabBarController.class]) {
            UITabBarController *tabBarController = (UITabBarController *)topViewController;
            topViewController = tabBarController.selectedViewController;
        }
    }
    return topViewController;
}

#pragma mark - Getters

- (JPTheme *)theme {
    if (!_theme) {
        _theme = [JPTheme new];
    }
    return _theme;
}

@end

@implementation JudoKit (Invokers)

- (void)invokePayment:(nonnull NSString *)judoId
                     amount:(nonnull JPAmount *)amount
          consumerReference:(nonnull NSString *)reference
             paymentMethods:(PaymentMethods)methods
    applePayConfiguratation:(nullable ApplePayConfiguration *)applePayConfigs
                cardDetails:(nullable JPCardDetails *)cardDetails
         redirectCompletion:(nullable IDEALRedirectCompletion)redirectCompletion
                 completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion {

    JudoPaymentMethodsViewModel *viewModel = [[JudoPaymentMethodsViewModel alloc] initWithJudoId:judoId
                                                                                          amount:amount
                                                                               consumerReference:[[JPReference alloc] initWithConsumerReference:reference]
                                                                                  paymentMethods:methods
                                                                           primaryAccountDetails:self.primaryAccountDetails
                                                                           applePayConfiguration:applePayConfigs
                                                                                     cardDetails:cardDetails];

    JudoPaymentMethodsViewController *viewController = [[JudoPaymentMethodsViewController alloc] initWithTheme:self.theme
                                                                                                     viewModel:viewModel
                                                                                                currentSession:self
                                                                                            redirectCompletion:redirectCompletion
                                                                                                 andCompletion:completion];
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.activeViewController = viewController;
    [self.topMostViewController presentViewController:navigationController animated:YES completion:nil];
}

- (void)invokePayment:(NSString *)judoId
               amount:(JPAmount *)amount
    consumerReference:(NSString *)reference
          cardDetails:(JPCardDetails *)cardDetails
           completion:(void (^)(JPResponse *, NSError *))completion {

    [self presentPaymentViewControllerWithJudoId:judoId
                                          amount:amount
                                       reference:[[JPReference alloc] initWithConsumerReference:reference]
                                     transaction:TransactionTypePayment
                                     cardDetails:cardDetails
                                    paymentToken:nil
                                      completion:completion];
}

- (void)invokePayment:(NSString *)judoId
               amount:(JPAmount *)amount
            reference:(JPReference *)reference
          cardDetails:(JPCardDetails *)cardDetails
           completion:(void (^)(JPResponse *, NSError *))completion {

    [self presentPaymentViewControllerWithJudoId:judoId
                                          amount:amount
                                       reference:reference
                                     transaction:TransactionTypePayment
                                     cardDetails:cardDetails
                                    paymentToken:nil
                                      completion:completion];
}

- (void)invokePreAuth:(NSString *)judoId
               amount:(JPAmount *)amount
    consumerReference:(NSString *)reference
          cardDetails:(JPCardDetails *)cardDetails
           completion:(void (^)(JPResponse *, NSError *))completion {

    [self presentPaymentViewControllerWithJudoId:judoId
                                          amount:amount
                                       reference:[[JPReference alloc] initWithConsumerReference:reference]
                                     transaction:TransactionTypePreAuth
                                     cardDetails:cardDetails
                                    paymentToken:nil
                                      completion:completion];
}

- (void)invokeRegisterCard:(NSString *)judoId
         consumerReference:(NSString *)reference
                completion:(void (^)(JPResponse *, NSError *))completion {

    [self invokeAddCardForTypeClass:JPRegisterCard.class
                             judoId:judoId
                          reference:[JPReference consumerReference:reference]
                         completion:completion];
}

- (void)invokeCheckCard:(NSString *)judoId
               currency:(NSString *)currency
              reference:(JPReference *)reference
            cardDetails:(JPCardDetails *)cardDetails
             completion:(void (^)(JPResponse *_Nullable, NSError *_Nullable))completion {

    [self invokeAddCardForTypeClass:JPCheckCard.class
                             judoId:judoId
                          reference:reference
                         completion:completion];
}

- (void)invokeSaveCard:(NSString *)judoId
     consumerReference:(NSString *)reference
            completion:(void (^)(JPResponse *, NSError *))completion {

    [self invokeAddCardForTypeClass:JPSaveCard.class
                             judoId:judoId
                          reference:[JPReference consumerReference:reference]
                         completion:completion];
}

- (void)invokeTokenPayment:(NSString *)judoId
                    amount:(JPAmount *)amount
         consumerReference:(NSString *)reference
               cardDetails:(JPCardDetails *)cardDetails
              paymentToken:(JPPaymentToken *)paymentToken
                completion:(void (^)(JPResponse *, NSError *))completion {

    [self presentPaymentViewControllerWithJudoId:judoId
                                          amount:amount
                                       reference:[[JPReference alloc] initWithConsumerReference:reference]
                                     transaction:TransactionTypePayment
                                     cardDetails:cardDetails
                                    paymentToken:paymentToken
                                      completion:completion];
}

- (void)invokeTokenPreAuth:(NSString *)judoId
                    amount:(JPAmount *)amount
         consumerReference:(NSString *)reference
               cardDetails:(JPCardDetails *)cardDetails
              paymentToken:(JPPaymentToken *)paymentToken
                completion:(void (^)(JPResponse *, NSError *))completion {

    [self presentPaymentViewControllerWithJudoId:judoId
                                          amount:amount
                                       reference:[[JPReference alloc] initWithConsumerReference:reference]
                                     transaction:TransactionTypePreAuth
                                     cardDetails:cardDetails
                                    paymentToken:paymentToken
                                      completion:completion];
}

- (void)invokePreAuth:(NSString *)judoId
               amount:(JPAmount *)amount
            reference:(JPReference *)reference
          cardDetails:(JPCardDetails *)cardDetails
           completion:(void (^)(JPResponse *, NSError *))completion {

    [self presentPaymentViewControllerWithJudoId:judoId
                                          amount:amount
                                       reference:reference
                                     transaction:TransactionTypePreAuth
                                     cardDetails:cardDetails
                                    paymentToken:nil
                                      completion:completion];
}

- (void)invokeRegisterCard:(NSString *)judoId
                 reference:(JPReference *)reference
                completion:(void (^)(JPResponse *, NSError *))completion {

    [self invokeAddCardForTypeClass:JPRegisterCard.class
                             judoId:judoId
                          reference:reference
                         completion:completion];
}

- (void)invokeSaveCard:(NSString *)judoId
             reference:(JPReference *)reference
            completion:(void (^)(JPResponse *, NSError *))completion {

    [self invokeAddCardForTypeClass:JPSaveCard.class
                             judoId:judoId
                          reference:reference
                         completion:completion];
}

- (void)invokeTokenPayment:(NSString *)judoId
                    amount:(JPAmount *)amount
                 reference:(JPReference *)reference
               cardDetails:(JPCardDetails *)cardDetails
              paymentToken:(JPPaymentToken *)paymentToken
                completion:(void (^)(JPResponse *, NSError *))completion {

    [self presentPaymentViewControllerWithJudoId:judoId
                                          amount:amount
                                       reference:reference
                                     transaction:TransactionTypePayment
                                     cardDetails:cardDetails
                                    paymentToken:paymentToken
                                      completion:completion];
}

- (void)invokeTokenPreAuth:(NSString *)judoId
                    amount:(JPAmount *)amount
                 reference:(JPReference *)reference
               cardDetails:(JPCardDetails *)cardDetails
              paymentToken:(JPPaymentToken *)paymentToken
                completion:(void (^)(JPResponse *, NSError *))completion {

    [self presentPaymentViewControllerWithJudoId:judoId
                                          amount:amount
                                       reference:reference
                                     transaction:TransactionTypePreAuth
                                     cardDetails:cardDetails
                                    paymentToken:paymentToken
                                      completion:completion];
}

- (void)invokeAddCardForTypeClass:(Class)type
                           judoId:(NSString *)judoId
                        reference:(JPReference *)reference
                       completion:(void (^)(JPResponse *, NSError *))completion {

    JPTransaction *transaction = [self transactionForTypeClass:type
                                                        judoId:judoId
                                                        amount:nil
                                                     reference:reference];

    JPAddCardViewController *controller = [[JPAddCardBuilderImpl new] buildModuleWithTransaction:transaction
                                                                                           theme:self.theme
                                                                                      completion:completion];

    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitioningDelegate = self.transitioningDelegate;
    [self.topMostViewController presentViewController:controller animated:YES completion:nil];
}

- (void)invokeIDEALPaymentWithJudoId:(NSString *)judoId
                              amount:(double)amount
                           reference:(JPReference *)reference
                  redirectCompletion:(IDEALRedirectCompletion)redirectCompletion
                          completion:(JudoCompletionBlock)completion {

    IDEALFormViewController *controller = [[IDEALFormViewController alloc] initWithJudoId:judoId
                                                                                    theme:self.theme
                                                                                   amount:amount
                                                                                reference:reference
                                                                                  session:self.apiSession
                                                                          paymentMetadata:self.paymentMetadata
                                                                       redirectCompletion:redirectCompletion
                                                                               completion:completion];

    controller.modalPresentationStyle = UIModalPresentationFormSheet;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.activeViewController = controller;
    [self.topMostViewController presentViewController:navigationController animated:YES completion:nil];
}

@end

@implementation JudoKit (ApplePay)

#pragma mark - Apple Pay invocation method

- (void)invokeApplePayWithConfiguration:(ApplePayConfiguration *)configuration
                             completion:(JudoCompletionBlock)completion {

    self.configuration = configuration;
    self.manager = [[ApplePayManager alloc] initWithConfiguration:configuration];

    self.viewController = self.manager.pkPaymentAuthorizationViewController;

    if (self.viewController == nil) {
        completion(nil, NSError.judoApplePayConfigurationError);
        return;
    }

    self.viewController.delegate = self;

    self.completionBlock = completion;
    [self.topMostViewController presentViewController:self.viewController animated:YES completion:nil];
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate methods

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus))completion {

    JPTransaction *transaction;

    if (self.configuration.transactionType == TransactionTypePreAuth) {
        transaction = [self preAuthWithJudoId:self.configuration.judoId
                                       amount:self.manager.jpAmount
                                    reference:self.manager.jpReference];
    } else {
        transaction = [self paymentWithJudoId:self.configuration.judoId
                                       amount:self.manager.jpAmount
                                    reference:self.manager.jpReference];
    }

    NSError *error;
    [transaction setPkPayment:payment error:&error];

#ifndef DEBUG
    if (error) {
        self.completionBlock(nil, [NSError judoJSONSerializationFailedWithError:error]);
        completion(PKPaymentAuthorizationStatusFailure);
        return;
    }
#endif

    [transaction sendWithCompletion:^(JPResponse *response, NSError *error) {

#ifdef DEBUG
        response = self.mockJPResponse;
        error = nil;

        if (self.configuration.returnedContactInfo & ReturnedInfoBillingContacts) {
            response.billingInfo = [self.manager contactInformationFromPaymentContact:payment.billingContact];
        }

        if (self.configuration.returnedContactInfo & ReturnedInfoShippingContacts) {
            response.shippingInfo = [self.manager contactInformationFromPaymentContact:payment.shippingContact];
        }

        self.completionBlock(response, error);

        completion(PKPaymentAuthorizationStatusSuccess);
#else
            if (error || response.items.count == 0) {
                self.completionBlock(response, error);
                completion(PKPaymentAuthorizationStatusFailure);
                return;
            }

            if (self.configuration.returnedContactInfo & ReturnedInfoBillingContacts) {
                response.billingInfo = [self.manager contactInformationFromPaymentContact:payment.billingContact];
            }

            if (self.configuration.returnedContactInfo & ReturnedInfoShippingContacts) {
                response.shippingInfo = [self.manager contactInformationFromPaymentContact:payment.shippingContact];
            }

            self.completionBlock(response, error);
            completion(PKPaymentAuthorizationStatusSuccess);
#endif
    }];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (JPResponse *)mockJPResponse {

    NSString *path = [[NSBundle bundleForClass:JudoKit.class] pathForResource:@"MockJPTransactionData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *transactionDataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:kNilOptions
                                                                                error:nil];

    JPResponse *response = [JPResponse new];
    [response appendItem:transactionDataDictionary];

    return response;
}

@end
