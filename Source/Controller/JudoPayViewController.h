//
//  JudoPayViewController.h
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

#import "JPTransactionData.h"
#import <UIKit/UIKit.h>

@class JudoKit, JPTransaction, JPTheme, JPAmount, JPReference, JPPaymentToken, JudoPayView, JPResponse, JPPrimaryAccountDetails;

/**
 *  the JudoPayViewController is the one solution build to guide a user through the journey of entering their card details.
 */
@interface JudoPayViewController : UIViewController

/**
 *  the current JudoKit Session
 */
@property (nonatomic, strong) JudoKit *_Nullable judoKitSession;

/**
 *  the theme of the current session
 */
@property (nonatomic, strong) JPTheme *_Nullable theme;

/**
 *  The transactionType of the current journey
 */
@property (nonatomic, assign) TransactionType type;

/**
 *  the object that holds information about the transaction
 */
@property (nonatomic, strong, readonly) JPTransaction *_Nonnull transaction;

/**
 *  The amount and currency to process, amount to two decimal places and currency in string
 */
@property (nonatomic, strong, readonly) JPAmount *_Nonnull amount;

/**
 *  The number (e.g. "123-456" or "654321") identifying the Merchant you wish to pay
 */
@property (nonatomic, strong, readonly) NSString *_Nonnull judoId;

/**
 *  Your reference for this consumer, this payment and an object containing any additional data you wish to tag this payment with. The property name and value are both limited to 50 characters, and the whole object cannot be more than 1024 characters
 */
@property (nonatomic, strong, readonly) JPReference *_Nonnull reference;

/**
 *  Card token and Consumer token
 */
@property (nonatomic, strong) JPPaymentToken *_Nullable paymentToken;

/**
 *  Optional property containing primary account details provided by the merchant
 */
@property (nonatomic, strong) JPPrimaryAccountDetails *_Nullable primaryAccountDetails;

/**
 *  Initializer to start a payment journey
 *
 *  @param judoId      The judoID of the recipient
 *  @param amount      An amount and currency for the transaction
 *  @param reference   A Reference for the transaction
 *  @param type        The type of the transaction
 *  @param session     The current judo apiSession
 *  @param cardDetails An object containing all card information - default: nil
 *  @param completion  Completion block called when transaction has been finished
 *
 *  @return a JPayViewController object for presentation on a view stack
 */
- (nonnull instancetype)initWithJudoId:(nonnull NSString *)judoId
                                amount:(nullable JPAmount *)amount
                             reference:(nonnull JPReference *)reference
                           transaction:(TransactionType)type
                        currentSession:(nonnull JudoKit *)session
                           cardDetails:(nullable JPCardDetails *)cardDetails
                            completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

@end
