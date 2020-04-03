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

#import "JPConfiguration.h"
#import "JPPaymentMethod.h"
#import "JPReceipt.h"
#import "JPSession.h"
#import "JPTransaction.h"
#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

static NSString *__nonnull const JudoKitName = @"iOS-ObjC";
static NSString *__nonnull const JudoKitVersion = @"8.2.1";

@interface JudoKit : NSObject

/**
 * A property that toggles sandbox mode on the Judo SDK.
 */
@property (nonatomic, assign) BOOL isSandboxed;

/**
 * Designated initializer that returns a configured JudoKit instance.
 *
 * @param token - an instance of NSString that serves as the merchant's token.
 * @param secret - an instance of NSString that serves as the merchant's secret.
 * @param jailbrokenDevicesAllowed - a boolean value that, if set to YES, will allow jailbroken devices to use the Judo SDK.
 *
 * @returns - a configured instance of JudoKit
 */
- (nullable instancetype)initWithToken:(nonnull NSString *)token
                                secret:(nonnull NSString *)secret
                allowJailbrokenDevices:(BOOL)jailbrokenDevicesAllowed;

/**
 * Convenience initializer that returns a configured JudoKit instance that allows jailbroken devices.
 *
 * @param token - an instance of NSString that serves as the merchant's token.
 * @param secret - an instance of NSString that serves as the merchant's secret.
 *
 * @returns - a configured instance of JudoKit.
*/
- (nullable instancetype)initWithToken:(nonnull NSString *)token
                                secret:(nonnull NSString *)secret;

/**
 * A method which returns a configured instance of JPTransaction for merchants to use in their own apps.
 *
 * @param type - an instance of TransactionType that describes the type of the transaction.
 * @param configuration - an instance of JPConfiguration used to configure the transaction.
 *
 * @returns - a configured instance of JPTransaction.
 */
- (nonnull JPTransaction *)transactionWithType:(TransactionType)type
                                 configuration:(nonnull JPConfiguration *)configuration;

/**
 * A method which invokes the Judo transaction interface which allows users to enter their card details and make a transaction.
 *
 * @param type - an instance of TransactionType that describes the type of the transaction.
 * @param configuration - an instance of JPConfiguration used to configure the transaction.
 * @param completion - a completion block with an optional JPResponse object or an NSError.
 */
- (void)invokeTransactionWithType:(TransactionType)type
                    configuration:(nonnull JPConfiguration *)configuration
                       completion:(nullable JudoCompletionBlock)completion;

/**
 * A method which invokes the Apple Pay sleeve which allows users to make Apple Pay transactions.
 *
 * @param mode - an instance of TransactionMode that specifies either a Payment or a Pre Auth transaction.
 * @param configuration - an instance of JPConfiguration used to configure the transaction.
 * @param completion - a completion block with an optional JPResponse object or an NSError.
 */
- (void)invokeApplePayWithMode:(TransactionMode)mode
                 configuration:(nonnull JPConfiguration *)configuration
                    completion:(nullable JudoCompletionBlock)completion;

/**
 * A method which invokes the Judo Payment Method Selection screen which allows users to pick between multiple payment methods to complete their transaction.
 *
 * @param mode - an instance of TransactionMode that specifies either a Payment or a Pre Auth transaction.
 * @param configuration - an instance of JPConfiguration used to configure the transaction.
 * @param completion - a completion block with an optional JPResponse object or an NSError.
 */
- (void)invokePaymentMethodScreenWithMode:(TransactionMode)mode
                            configuration:(nonnull JPConfiguration *)configuration
                               completion:(nullable JudoCompletionBlock)completion;

/**
 * A method which displays a list of all transactions of a specified type.
 *
 * @param type - an instance of TransactionType that describes the type of the transaction.
 * @param pagination - an instance of JPPagination in which pagination preferences are specified.
 * @param completion - a completion block with an optional JPResponse object or an NSError.
 */
- (void)listTransactionsOfType:(TransactionType)type
                     paginated:(nullable JPPagination *)pagination
                    completion:(nullable JudoCompletionBlock)completion;

/**
 * A method which returns a instance of JPReceipt based on a specified receipt ID.
 *
 * @param receiptId - an instance of NSString that serves as the receipt ID of a transaction.
 *
 * @returns - a configured instance of JPReceipt.
 */
- (nonnull JPReceipt *)receiptForReceiptId:(nonnull NSString *)receiptId;

@end
