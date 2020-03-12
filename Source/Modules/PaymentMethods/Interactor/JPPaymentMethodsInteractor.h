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
- (void)setCardAsSelectedAtIndex:(NSUInteger)index;

/**
 * A method that sets a card as last used card to make a successfull payment
 * @param index - the index of the card in the list
*/
- (void)setLastUsedCardAtIndex:(NSUInteger)index;

/**
* A method that sets a card as default based on an index
*/
- (void)setCardAsDefaultAtIndex:(NSInteger)index;

/**
 * A boolean value that returns YES if Apple Pay is set up on the device
 */
- (bool)isApplePaySetUp;

/**
 * A method that handles 3D Secure transactions
 *
 * @param error - the NSError object that triggers a 3D Secure transaction
 * @param completion - the JPResponse / NSError completion block
 */
- (void)handle3DSecureTransactionFromError:(NSError *)error
                                completion:(JudoCompletionBlock)completion;

/**
 * A method that reorders cards so that the default card is always on top
 */
- (void)orderCards;

/**
 * A method which returns all the iDEAL bank types available
 */
- (NSArray *)getIDEALBankTypes;

@end

@interface JPPaymentMethodsInteractorImpl : NSObject <JPPaymentMethodsInteractor>

/**
 * A designated initializer that sets up the JPTheme object needed for view customization
 *
 * @param mode - the transaction mode value that can be set to either Payment or PreAuth
 * @param configuration - reference to the JPConfiguration object used to configure the payment flow
 * @param transactionService - the service used to handle Judo backend calls
 * @param completion - a JPResponse / NSError completion block
 *
 * @returns a configured instance of JPPaymentMethodsInteractor
 */
- (instancetype)initWithMode:(TransactionMode)mode
               configuration:(JPConfiguration *)configuration
          transactionService:(JPTransactionService *)transactionService
                  completion:(JudoCompletionBlock)completion;

@end
