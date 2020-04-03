//
//  JPApplePayService.h
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

#import "JPApplePayConfiguration.h"
#import "JPSession.h"
#import "JPTransactionService.h"

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

@interface JPApplePayService : NSObject <PKPaymentAuthorizationViewControllerDelegate>

/**
 * Designated initalizer that creates a configured instance of JPApplePayService for making Apple Pay transactions.
 *
 * @param configuration - an instance of JPApplePayConfiguration used to configure the Apple Pay flow.
 * @param transactionService - an instance of JPTransactionService responsible for making the Judo backend transaction.
 *
 * @returns - a configured instance of JPApplePayService.
 */
- (nonnull instancetype)initWithConfiguration:(nonnull JPConfiguration *)configuration
                           transactionService:(nonnull JPTransactionService *)transactionService;

/**
 * A boolean method which returns YES if the device supports Apple pay.
 */
+ (bool)isApplePaySupported;

/**
 * A boolean method which returns YES if the user can make transactions via Apple Pay.
 */
- (bool)isApplePaySetUp;

/**
 * A method for making Apple Pay transactions. Calling this method displayes the Apple Pay sheet.
 *
 * @param mode - an instance of JPTransactionMode that sets the transaction as either Payment or Pre Auth.
 * @param completion - a completion block with an optional JPResponse or an NSError;
 */
- (void)invokeApplePayWithMode:(TransactionMode)mode
                    completion:(nullable JudoCompletionBlock)completion;
@end
