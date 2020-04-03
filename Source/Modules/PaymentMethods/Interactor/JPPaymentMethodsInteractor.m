//
//  JPPaymentMethodsInteractor.m
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

#import "JPPaymentMethodsInteractor.h"
#import "JP3DSService.h"
#import "JPAmount.h"
#import "JPApplePayConfiguration.h"
#import "JPApplePayService.h"
#import "JPCardStorage.h"
#import "JPConfiguration.h"
#import "JPConstants.h"
#import "JPIDEALBank.h"
#import "JPPaymentMethod.h"
#import "JPPaymentToken.h"
#import "JPReference.h"
#import "JPTransactionService.h"

@interface JPPaymentMethodsInteractorImpl ()
@property (nonatomic, assign) TransactionMode transactionMode;
@property (nonatomic, strong) JPConfiguration *configuration;
@property (nonatomic, strong) JPTransactionService *transactionService;
@property (nonatomic, strong) JudoCompletionBlock completion;
@property (nonatomic, strong) JPApplePayService *applePayService;
@property (nonatomic, strong) JP3DSService *threeDSecureService;
@property (nonatomic, strong) NSArray<JPPaymentMethod *> *paymentMethods;
@end

@implementation JPPaymentMethodsInteractorImpl

#pragma mark - Initializers

- (instancetype)initWithMode:(TransactionMode)mode
               configuration:(JPConfiguration *)configuration
          transactionService:(JPTransactionService *)transactionService
                  completion:(JudoCompletionBlock)completion {

    if (self = [super init]) {
        self.transactionMode = mode;
        self.configuration = configuration;
        self.transactionService = transactionService;
        self.completion = completion;
        self.paymentMethods = configuration.paymentMethods;
    }
    return self;
}

#pragma mark - Get stored cards

- (NSArray<JPStoredCardDetails *> *)getStoredCardDetails {
    return [JPCardStorage.sharedInstance fetchStoredCardDetails];
}

#pragma mark - Select card at index

- (void)selectCardAtIndex:(NSUInteger)index {

    NSArray<JPStoredCardDetails *> *storedCardDetails;
    storedCardDetails = [JPCardStorage.sharedInstance fetchStoredCardDetails];

    for (JPStoredCardDetails *cardDetails in storedCardDetails) {
        cardDetails.isSelected = NO;
    }
    storedCardDetails[index].isSelected = YES;
    [JPCardStorage.sharedInstance deleteCardDetails];

    for (JPStoredCardDetails *cardDetails in storedCardDetails) {
        [JPCardStorage.sharedInstance addCardDetails:cardDetails];
    }
}

#pragma mark - Set card at index as default

- (void)setCardAsDefaultAtIndex:(NSInteger)index {
    [JPCardStorage.sharedInstance setCardDefaultState:YES atIndex:index];
}

#pragma mark - Set card as selected at index

- (void)setCardAsSelectedAtIndex:(NSUInteger)index {
    [JPCardStorage.sharedInstance setCardAsSelectedAtIndex:index];
}

#pragma mark - Order cards

- (void)orderCards {
    [JPCardStorage.sharedInstance orderCards];
}

- (NSArray *)getIDEALBankTypes {
    return @[
        @(JPIDEALBankING), @(JPIDEALBankABN), @(JPIDEALBankVanLanschotBankiers),
        @(JPIDEALBankTriodos), @(JPIDEALBankRabobank), @(JPIDEALBankSNS),
        @(JPIDEALBankASN), @(JPIDEALBankRegio), @(JPIDEALBankKnab),
        @(JPIDEALBankBunq), @(JPIDEALBankMoneyou), @(JPIDEALBankHandelsbanken)
    ];
}

#pragma mark - Set card last card used to maek a successfull payment at index

- (void)setLastUsedCardAtIndex:(NSUInteger)index {
    [JPCardStorage.sharedInstance setLastUsedCardAtIndex:index];
}

#pragma mark - Get JPAmount

- (JPAmount *)getAmount {
    return self.configuration.amount;
}

#pragma mark - Get payment methods

- (NSArray<JPPaymentMethod *> *)getPaymentMethods {
    NSMutableArray *defaultPaymentMethods;
    defaultPaymentMethods = [NSMutableArray arrayWithArray:@[ JPPaymentMethod.card ]];

    if ([JPApplePayService isApplePaySupported]) {
        [defaultPaymentMethods addObject:JPPaymentMethod.applePay];
    } else {
        [self removePaymentMethodWithType:JPPaymentMethodTypeApplePay];
    }

    if ([self.configuration.amount.currency isEqualToString:kCurrencyEuro]) {
        [defaultPaymentMethods addObject:JPPaymentMethod.iDeal];
    } else {
        [self removePaymentMethodWithType:JPPaymentMethodTypeIDeal];
    }

    return (self.paymentMethods.count != 0) ? self.paymentMethods : defaultPaymentMethods;
}

#pragma mark - Remove Apple Pay from payment methods

- (void)removePaymentMethodWithType:(JPPaymentMethodType)type {
    if (self.paymentMethods.count == 0)
        return;

    NSMutableArray *tempArray = [self.paymentMethods mutableCopy];

    for (JPPaymentMethod *method in self.paymentMethods) {
        if (method.type == type) {
            [tempArray removeObject:method];
        }
    }

    self.paymentMethods = tempArray;
}

#pragma mark - Payment transaction

- (void)paymentTransactionWithToken:(NSString *)token
                      andCompletion:(JudoCompletionBlock)completion {
    BOOL isPreAuth = (self.transactionMode == TransactionTypePreAuth);
    self.transactionService.transactionType = isPreAuth ? TransactionTypePreAuth : TransactionModePayment;
    NSString *consumerReference = self.configuration.reference.consumerReference;
    JPPaymentToken *paymentToken = [[JPPaymentToken alloc] initWithConsumerToken:consumerReference
                                                                       cardToken:token];

    JPTransaction *transaction = [self.transactionService transactionWithConfiguration:self.configuration];
    transaction.paymentToken = paymentToken;
    self.threeDSecureService.transaction = transaction;
    [transaction sendWithCompletion:completion];
}

#pragma mark - Apple Pay payment

- (void)startApplePayWithCompletion:(JudoCompletionBlock)completion {
    [self.applePayService invokeApplePayWithMode:self.transactionMode completion:completion];
}

#pragma mark - Delete card at index

- (void)deleteCardWithIndex:(NSUInteger)index {
    [JPCardStorage.sharedInstance deleteCardWithIndex:index];
}

#pragma mark - Is Apple Pay ready

- (bool)isApplePaySetUp {
    return [self.applePayService isApplePaySetUp];
}

- (void)handle3DSecureTransactionFromError:(NSError *)error
                                completion:(JudoCompletionBlock)completion {
    [self.threeDSecureService invoke3DSecureViewControllerWithError:error
                                                         completion:completion];
}

- (JPApplePayService *)applePayService {
    if (!_applePayService && self.configuration.applePayConfiguration) {
        _applePayService = [[JPApplePayService alloc] initWithConfiguration:self.configuration
                                                         transactionService:self.transactionService];
    }
    return _applePayService;
}

- (JP3DSService *)threeDSecureService {
    if (!_threeDSecureService) {
        _threeDSecureService = [JP3DSService new];
    }
    return _threeDSecureService;
}

@end
