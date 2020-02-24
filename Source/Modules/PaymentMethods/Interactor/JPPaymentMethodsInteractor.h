//
//  JPPaymentMethodsInteractor.h
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

#import "JPSession.h"
#import "JPTransactionService.h"
#import <Foundation/Foundation.h>

@class JPConfiguration, JPTransactionService, JPStoredCardDetails;

@protocol JPPaymentMethodsInteractor

/**
 * A method that returns the stored card details from the keychain
 *
 * @returns an array of JPStoredCardDetails objects
 */
- (NSArray<JPStoredCardDetails *> *)getStoredCardDetails;

/**
 * A method that updates the selected state of a card stored in the keychain
 */
- (void)selectCardAtIndex:(NSUInteger)index;

/**
 * A method that returns the amount passed from the builder
 */
- (JPAmount *)getAmount;

/**
 * A method that returns the available payment methods
 */
- (NSArray<JPPaymentMethod *> *)getPaymentMethods;

/**
 * Sends a payment transaction based on a stored card token
 */
- (void)paymentTransactionWithToken:(NSString *)token
                      andCompletion:(JudoCompletionBlock)completion;

/**
 * Starts the Apple Pay payment / preAuth flow
 */
- (void)startApplePayWithCompletion:(JudoCompletionBlock)completion;

/**
 * A method for deleting a specific card details from the keychain by its index
 *
 * @param index - Card's index in cards list
 */
- (void)deleteCardWithIndex:(NSUInteger)index;

/**
 * A method that sets a card as selected based on an index
 */
- (void)setCardAsSelectedAtInded:(NSUInteger)index;

/**
 * A boolean value that returns YES if Apple Pay is set up on the device
 */
- (bool)isApplePaySetUp;

- (void)handle3DSecureTransactionFromError:(NSError *)error
                                completion:(JudoCompletionBlock)completion;

@end

@interface JPPaymentMethodsInteractorImpl : NSObject <JPPaymentMethodsInteractor>

/**
 * A designated initializer that sets up the JPTheme object needed for view customization
 *
 * @param transaction - an instance describing the JPTransaction details
 * @param reference - the reference needed for the transaction
 * @param session - the current instance of the JudoKit session
 * @param methods             An optional array of selected payment methods. Payment methods will show according to the order in which they have been added.                                                                                                 Setting nil will present the payment method screen with the default payment methods;
 * @param configuration - an instance of JPApplePayConfiguration that describes the Apple Pay flow
 * @param amount - the amount of the transaction
 *
 * @returns a configured instance of JPPaymentMethodsInteractor
 */
- (instancetype)initWithMode:(TransactionMode)mode
               configuration:(JPConfiguration *)configuration
          transactionService:(JPTransactionService *)transactionService
                  completion:(JudoCompletionBlock)completion;

@end
