//
//  JPAddCardInteractor.h
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
#import "JPValidationResult.h"

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@class JPCard, JPCardValidationService, JPTransactionService, JPCountry, JPAddCardViewModel;

@protocol JPAddCardInteractor

/**
 *  A method for checking if AVS is enabled
 *
 *  @return YES if the merchant has set AVS as enabled and NO if otherwise
 */
- (BOOL)isAVSEnabled;

/**
 * A method that handles camera permissions requests
 *
 * @param completion - the completion handler that returns a boolean value describing the permission result
 */
- (void)handleCameraPermissionsWithCompletion:(void (^)(AVAuthorizationStatus))completion;

/**
 *  A method for executing the save / register card transaction
 *
 *  @param card - an instance of JPCard that contains the card details
 *  @param completion - a response / error completion block that is returned after thee transaction finishes
 */
- (void)addCard:(JPCard *)card completionHandler:(JudoCompletionBlock)completionHandler;

/**
 *  A method that returns all countries selectable for AVS
 *
 *  @return a list of country names
 */
- (NSArray<NSString *> *)getSelectableCountryNames;

/**
 *  A method for validating the card number
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateCardNumberInput:(NSString *)input;

/**
 *  A method for validating the cardholder name
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateCardholderNameInput:(NSString *)input;

/**
 *  A method for validating the expiry date
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateExpiryDateInput:(NSString *)input;

/**
 *  A method for validating the secure code
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateSecureCodeInput:(NSString *)input;

/**
 *  A method for validating the country
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validateCountryInput:(NSString *)input;

/**
 *  A method for validating the postal code
 *
 *  @param input - an input string
 *
 *  @return an instance of JPValidationResult that contains the validation status
 */
- (JPValidationResult *)validatePostalCodeInput:(NSString *)input;

/**
 *  Method that stores card details in the keychain
 *
 *  @param viewModel - the card details view model
 *  @param token - the token associated with the card
 *
 */
- (void)updateKeychainWithCardModel:(JPAddCardViewModel *)viewModel
                           andToken:(NSString *)token;

@end

@interface JPAddCardInteractorImpl : NSObject <JPAddCardInteractor>

/**
 *  A JPAddCardInteractorImpl initializer configured with the required services
 *
 *  @param cardValidationService - a JPCardValidationService instance for validating the card details
 *  @param transactionService - a JPTransactionService instance for handling the transaction
 *  @param completion - a JudoCompletionBlock that returns once the transaction finishes
 *
 *  @return an instance of JPAddCardInteractorImpl
 */
- (instancetype)initWithCardValidationService:(JPCardValidationService *)cardValidationService
                           transactionService:(JPTransactionService *)transactionService
                                   completion:(JudoCompletionBlock)completion;
@end
