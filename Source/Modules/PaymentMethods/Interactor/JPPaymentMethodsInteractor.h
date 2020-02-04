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

#import "JPReference.h"
#import "JPSession.h"
#import <Foundation/Foundation.h>

@class JPStoredCardDetails, JPTheme, JPAmount, JPTransaction;

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
- (void)selectCardAtIndex:(NSInteger)index;

/**
 * A method that returns YES if the 'Powered by Judo' headline should be displayed
 */
- (BOOL)shouldDisplayJudoHeadline;

/**
 * A method that returns the amount passed from the builder
 */
- (JPAmount *)getAmount;

/**
 * Sends a payment transaction based on a stored card token
 */
- (void)paymentTransactionWithToken:(NSString *)token
                      andCompletion:(JudoCompletionBlock)completion;

/**
* A method for deleting a specific card details from the keychain by its index
*
* @param index - Card's index in cards list
*/
- (void)deleteCardWithIndex:(NSInteger)index;

@end

@interface JPPaymentMethodsInteractorImpl : NSObject <JPPaymentMethodsInteractor>

/**
 * A designated initializer that sets up the JPTheme object needed for view customization
 *
 * @param transaction - an instance describing the JPTransaction details
 * @param reference - the reference needed for the transaction
 * @param theme - an instance of JPTheme that is used to configure the payment methods flow
 * @param amount - the amount of the transaction
 *
 * @returns a configured instance of JPPaymentMethodsInteractor
 */
- (instancetype)initWithTransaction:(JPTransaction *)transaction
                          reference:(JPReference *)reference
                              theme:(JPTheme *)theme
                          andAmount:(JPAmount *)amount;

@end
