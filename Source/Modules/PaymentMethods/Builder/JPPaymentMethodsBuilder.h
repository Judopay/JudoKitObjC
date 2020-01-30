//
//  JPPaymentMethodsBuilder.h
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

#import "JPCardDetails.h"
#import "JPReference.h"
#import "JPSession.h"
#import <Foundation/Foundation.h>

@class JPPaymentMethodsViewController;
@class JudoKit, JPTheme, JPAmount, SliderTransitioningDelegate;

@protocol JPPaymentMethodsBuilder

/**
 * A method that builds the configured JPPaymentMethodsViewController for a Payment transaction
 *
 * @param judoId - the Judo ID of the merchant
 * @param session - the current JudoKit session needed for creating transactions
 * @param transitioningDelegate - a transitioning delegate needed for the custom Add Card transition animation
 * @param amount - the amount of the transaction
 * @param reference - the reference for this transaction
 * @param networks   The supported card networks
 * @param completionHandler - a response/error completion handler returned to the merchant
 */
- (JPPaymentMethodsViewController *)buildPaymentModuleWithJudoID:(NSString *)judoId
                                                         session:(JudoKit *)session
                                           transitioningDelegate:(SliderTransitioningDelegate *)transitioningDelegate
                                                          amount:(JPAmount *)amount
                                                       reference:(JPReference *)reference
                                           supportedCardNetworks:(CardNetwork)networks
                                               completionHandler:(JudoCompletionBlock)completion;

/**
 * A method that builds the configured JPPaymentMethodsViewController for a PreAuth transaction
 *
 * @param judoId - the Judo ID of the merchant
 * @param session - the current JudoKit session needed for creating transactions
 * @param transitioningDelegate - a transitioning delegate needed for the custom Add Card transition animation
 * @param amount - the amount of the transaction
 * @param reference - the reference for this transaction
 * @param networks   The supported card networks
 * @param completionHandler - a response/error completion handler returned to the merchant
 */
- (JPPaymentMethodsViewController *)buildPreAuthModuleWithJudoID:(NSString *)judoId
                                                         session:(JudoKit *)session
                                           transitioningDelegate:(SliderTransitioningDelegate *)transitioningDelegate
                                                          amount:(JPAmount *)amount
                                                       reference:(JPReference *)reference
                                           supportedCardNetworks:(CardNetwork)networks
                                               completionHandler:(JudoCompletionBlock)completion;
@end

@interface JPPaymentMethodsBuilderImpl : NSObject <JPPaymentMethodsBuilder>
@end
