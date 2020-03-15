//
//  JPIDEALService.h
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

#import "JPConfiguration.h"
#import "JPIDEALBank.h"
#import "JPTransactionService.h"
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IDEALStatus) {
    IDEALStatusSuccess,
    IDEALStatusPending,
    IDEALStatusPendingDelay,
    IDEALStatusTimeout,
    IDEALStatusFailed,
    IDEALStatusError
};

@interface JPIDEALService : NSObject

/**
 * A string describing the account holder name
 */
@property (nonatomic, strong) NSString *_Nullable accountHolderName;

/**
 * Creates an instance of an JPIDealService object
 *
 * @param configuration - an instance of JPConfiguration used to configure the iDEAL flow
 * @param transactionService - an instance of JPTransactionService responsible for Judo backend calls
 */
- (nonnull instancetype)initWithConfiguration:(nonnull JPConfiguration *)configuration
                           transactionService:(nonnull JPTransactionService *)transactionService;

/**
 * Method used for returning a redirect URL based on the specified iDEAL bank
 *
 * @param iDEALBank    An instance of JPIDEALBank that holds the iDEAL's bank name and identifier code
 * @param completion  A completion block that either returns the redirect URL string or returns an error
 */
- (void)redirectURLForIDEALBank:(nonnull JPIDEALBank *)iDEALBank
                     completion:(nonnull JudoCompletionBlock)completion;

/**
 * Method used for polling the iDEAL transaction status
 *
 * @param orderId         A string property returned from the redirect URL used to identify the transaction
 * @param checksum       A string property returned from the redirect URL used to validate the transaction
 * @param completion  A completion block that either returns the transaction status or returns an error
 */
- (void)pollTransactionStatusForOrderId:(nonnull NSString *)orderId
                               checksum:(nonnull NSString *)checksum
                             completion:(nonnull JudoCompletionBlock)completion;

/**
 * Method used to invalidate the timer and stop the polling process
*/
- (void)stopPollingTransactionStatus;

@end
