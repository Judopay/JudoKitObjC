//
//  JPConfigurationValidationService.m
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

#import "JPConfigurationValidationService.h"

typedef NS_ENUM(NSUInteger, JPValidationError) {
    JPValidationErrorMissingParameter, // empty or null parameter
    JPValidationErrorInvalidParameter  // invalid parameter
};

@interface JPConfigurationValidationServiceImp ()
@property (nonatomic, nonnull) NSArray *validCurrencies;
@end

@implementation JPConfigurationValidationServiceImp

- (instancetype)init {
    if (self = [super init]) {
        _validCurrencies = @[ @"AED", @"AUD", @"BRL",
                              @"CAD", @"CHF", @"CZK",
                              @"DKK", @"EUR", @"GBP",
                              @"HKD", @"HUF", @"JPY",
                              @"NOK", @"NZD", @"PLN",
                              @"SEK", @"SGD", @"QAR",
                              @"SAR", @"USD", @"ZAR" ];
    }
    return self;
}

- (BOOL)isTransactionValidWithConfiguration:(JPConfiguration *)configuration
                             validationType:(JPValidationType)validationType
                            transactionType:(TransactionType)transactionType
                                 completion:(JudoCompletionBlock)completion {
    switch (validationType) {
        case JPValidationTypeTransaction:
            return [self isTransactionValidWithConfiguration:configuration transactionType:transactionType completion:completion];
        case JPValidationTypeApplePay:
            return [self isAppleTransactionValidWithConfiguration:configuration completion:completion];
        default:
            return false;
    }
}

- (BOOL)isTransactionValidWithConfiguration:(JPConfiguration *)configuration
                            transactionType:(TransactionType)transactionType
                                 completion:(JudoCompletionBlock)completion {
    NSError *error;
    [self checkAmount:configuration.amount transactionType:transactionType error:&error];
    [self checkForValidJudoId:configuration error:&error];
    [self checkIfConsumerReferenceIsValid:configuration error:&error];

    if (error) {
        completion(nil, error);
    }

    return error ? false : true;
}

- (BOOL)isAppleTransactionValidWithConfiguration:(JPConfiguration *)configuration
                                      completion:(JudoCompletionBlock)completion {
    NSError *error;
    [self checkForValidCurrency:configuration.applePayConfiguration.currency error:&error];
    [self checkForEmptyMerchantId:configuration.applePayConfiguration.merchantId error:&error];
    [self checkForValidCountryCode:configuration.applePayConfiguration.countryCode error:&error];
    [self checkApplePaymentItemsLength:configuration error:&error];
    [self checkForShippingMethodsLength:configuration error:&error];
    [self checkIfAppleConfigNonNull:configuration error:&error];

    if (error) {
        completion(nil, error);
    }

    return error ? false : true;
}

- (void)checkApplePaymentItemsLength:(JPConfiguration *)configuration error:(NSError **)error {
    if ([configuration.applePayConfiguration.paymentSummaryItems count] == 0) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorMissingParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"Payment items couldn't be empty"}];
    }
}

- (void)checkForShippingMethodsLength:(JPConfiguration *)configuration error:(NSError **)error {
    if ((configuration.applePayConfiguration.requiredShippingContactFields != ContactFieldNone) &&
        ([configuration.applePayConfiguration.shippingMethods count] == 0)) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorMissingParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"Specify shipinng methonds"}];
    }
}

- (void)checkForValidJudoId:(JPConfiguration *)configuration error:(NSError **)error {
    if (![configuration.judoId length]) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorMissingParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"JudoId cannot be null or empty"}];
    }
}

- (void)checkForValidCurrency:(NSString *)curency error:(NSError **)error {
    if ([curency length] == 0) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorMissingParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"Currency cannot be empty"}];
    } else if (![self.validCurrencies containsObject:curency]) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorInvalidParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"Unsuported Currency"}];
    }
}

- (void)checkForEmptyMerchantId:(NSString *)merchantId error:(NSError **)error {
    if ([merchantId length] == 0) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorMissingParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"Merchant Id cannot be empty"}];
    }
}

- (void)checkForValidCountryCode:(NSString *)countryCode error:(NSError **)error {
    if ([countryCode length] != 2) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorInvalidParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"Country Code is invalid"}];
    }
}

- (void)checkIfAppleConfigNonNull:(JPConfiguration *)configuration error:(NSError **)error {
    if (!configuration.applePayConfiguration) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorMissingParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"Apple Configuration is empty"}];
    }
}

- (void)checkIfAmountIsNumber:(NSString *)amount error:(NSError **)error {
    NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    if (![formater numberFromString:amount]) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorInvalidParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"Amount should be a number"}];
    }
}

- (void)checkIfConsumerReferenceIsValid:(JPConfiguration *)configuration error:(NSError **)error {
    if ([configuration.reference.consumerReference length] > kMaximumLengthForConsumerReference) {
        *error = [NSError errorWithDomain:kJudoErrorDomain
                                     code:JPValidationErrorInvalidParameter
                                 userInfo:@{NSLocalizedDescriptionKey : @"Consumer Reference is invalid"}];
    }
}

- (void)checkAmount:(JPAmount *)amount transactionType:(TransactionType)transactionType error:(NSError **)error {
    BOOL isTypeSaveCard = transactionType == TransactionTypeSaveCard;
    BOOL isTypeRegisterCard = transactionType == TransactionTypeRegisterCard;
    BOOL isTypeChekCard = transactionType == TransactionTypeCheckCard;

    if (!(isTypeChekCard || isTypeSaveCard || isTypeRegisterCard)) {
        [self checkForValidCurrency:amount.currency error:error];
        [self checkIfAmountIsNumber:amount.amount error:error];
    }
}

@end
