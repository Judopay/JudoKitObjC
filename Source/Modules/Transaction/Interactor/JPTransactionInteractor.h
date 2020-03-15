//
//  JPTransactionInteractor.h
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
#import "JPTransaction.h"
#import "JPValidationResult.h"

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@class JPCard, JPConfiguration, JPCardValidationService, JPTransactionService;
@class JPTransactionViewModel;

@protocol JPTransactionInteractor

/**
 * A method that returns YES if the Address Verification Service is enabled
 */
- (BOOL)isAVSEnabled;

/**
 * A method that returns the current transaction type
 */
- (TransactionType)transactionType;

/**
 * A method that handles the camera permission for the Scan Card functionality
 *
 * @param completion - the AVAuthorizationStatus which returns the camera permission status
 */
- (void)handleCameraPermissionsWithCompletion:(void (^)(AVAuthorizationStatus))completion;

/**
 * A method which returns the countries which the user can select in the country picker
 */
- (NSArray<NSString *> *)getSelectableCountryNames;

/**
 * A method for handling 3D Secure transactions
 *
 * @param error - the error that contains the 3D Secure details
 * @param completion - the completion block with an optional JPResponse or NSError
 */
- (void)handle3DSecureTransactionFromError:(NSError *)error
                                completion:(JudoCompletionBlock)completion;

/**
 * A method for returning the transaction response / error to the merchant
 *
 * @param response - the JPResponse returned from the transaction
 * @param error - the NSError returned from the transaction
 */
- (void)completeTransactionWithResponse:(JPResponse *)response
                                  error:(NSError *)error;

/**
 * A method for resetting the card validation results
 */
- (void)resetCardValidationResults;

/**
 * A method for validating the card number
 *
 * @param input - the input card number string
 *
 * @returns a JPValidationResult with the validation status details
 */
- (JPValidationResult *)validateCardNumberInput:(NSString *)input;

/**
 * A method for validating the cardholder name
 *
 * @param input - the input cardholder name string
 *
 * @returns a JPValidationResult with the validation status details
 */
- (JPValidationResult *)validateCardholderNameInput:(NSString *)input;

/**
 * A method for validating the expiry date
 *
 * @param input - the input expiry date string
 *
 * @returns a JPValidationResult with the validation status details
 */
- (JPValidationResult *)validateExpiryDateInput:(NSString *)input;

/**
 * A method for validating the secure code
 *
 * @param input - the input secure code string
 *
 * @returns a JPValidationResult with the validation status details
 */
- (JPValidationResult *)validateSecureCodeInput:(NSString *)input;

/**
 * A method for validating the country
 *
 * @param input - the input country string
 *
 * @returns a JPValidationResult with the validation status details
*/
- (JPValidationResult *)validateCountryInput:(NSString *)input;

/**
 * A method for validating the post code number
 *
 * @param input - the input post code number string
 *
 * @returns a JPValidationResult with the validation status details
 */
- (JPValidationResult *)validatePostalCodeInput:(NSString *)input;

/**
 * A method for sending a transaction to the Judo backend with specified card details
 *
 * @param card - the JPCard object which stores the card details
 * @param completionHandler - the completion block with an optional JPResponse / NSError
 */
- (void)sendTransactionWithCard:(JPCard *)card
              completionHandler:(JudoCompletionBlock)completionHandler;

/**
 * A method for updating the keychain information about the card
 *
 * @param viewModel - the card's view model that stores the card details
 * @param token - the card's token returned after a `Save Card` transaction
 */
- (void)updateKeychainWithCardModel:(JPTransactionViewModel *)viewModel
                           andToken:(NSString *)token;

@end

@interface JPTransactionInteractorImpl : NSObject <JPTransactionInteractor>

/**
 * Designated initializer which creates a configured JPTransactionInteractorImpl instance
 *
 * @param cardValidationService - the service which is used to validate card details
 * @param transactionService - the service which sends requests to the Judo backend
 * @param configuration - the JPConfiguration object used for customizing the payment flow
 * @param completion - the completion block with an optional JPResponse / NSError
 */
- (instancetype)initWithCardValidationService:(JPCardValidationService *)cardValidationService
                           transactionService:(JPTransactionService *)transactionService
                                configuration:(JPConfiguration *)configuration
                                   completion:(JudoCompletionBlock)completion;
@end
