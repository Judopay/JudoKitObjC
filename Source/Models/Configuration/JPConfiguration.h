//
//  JPConfiguration.h
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHx3ANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JPAddress.h"
#import "JPApplePayConfiguration.h"
#import "JPCardNetwork.h"
#import "JPSession.h"
#import "JPTransaction.h"
#import "JPUIConfiguration.h"
#import <Foundation/Foundation.h>

@class JPAmount, JPReference, JPPaymentMethod, JPPrimaryAccountDetails, JPPaymentSummaryItem;

@interface JPConfiguration : NSObject

/**
 * The Judo ID required for most JudoKit transactions
 */
@property (nonatomic, strong, readonly) NSString *_Nullable judoId;

/**
 * The Site ID required for iDEAL transactions
 */
@property (nonatomic, strong) NSString *_Nullable siteId;

/**
 * The Receipt ID required for Refund, Void and Collection transactions
 */
@property (nonatomic, strong, readonly) NSString *_Nullable receiptId;

/**
 * An object describing the amount of the transaction
 */
@property (nonatomic, strong) JPAmount *_Nonnull amount;

/**
 * An object containing transaction-related references
 */
@property (nonatomic, strong) JPReference *_Nonnull reference;

/**
 * An object containing information about the card address.
 * If set, will be sent to the Judo backend as part of the card details
 */
@property (nonatomic, strong) JPAddress *_Nullable cardAddress;

/**
 * An object responsible for handling UI-related configurations
 */
@property (nonatomic, strong) JPUIConfiguration *_Nonnull uiConfiguration;

/**
 * An array of JPPaymentMethod instances used to specify the payment methods that are to be displayed on the Judo Payment Method screen.
 */
@property (nonatomic, strong) NSArray<JPPaymentMethod *> *_Nullable paymentMethods;

/**
 * An NS_OPTION property used to pick between a set of supported card network values.
 */
@property (nonatomic, assign) CardNetwork supportedCardNetworks;

/**
 * An instance of JPPrimaryAccountDetails that, if set, will be passed in the transaction's request body.
 */
@property (nonatomic, strong) JPPrimaryAccountDetails *_Nullable primaryAccountDetails;

/**
 * An instance of JPApplePayConfiguration required for Apple Pay-related transactions.
 * Not setting this property will hide Apple Pay from the Judo Payment Method screen, even though it has been set as one of the payment methods.
 */
@property (nonatomic, strong) JPApplePayConfiguration *_Nullable applePayConfiguration;

/**
 * Designated initializer that sets the required parameters for most Judo transations.
 *  - Compatible with Payment, PreAuth, Register Card, Check Card, Save Card transactions.
 *  - Compatible with Apple Pay transactions.
 *  - Compatible with Judo Payment Method Selection screen.
 *
 *  @param judoId - the Judo ID of the merchant.
 *  @param amount - the JPAmount instance, contaning the amount and the currency of the transaction.
 *  @param reference - the JPReference instance, containing the consumer/payment references.
 *
 *  @returns a configured instance of JPConfiguration
 */
- (nonnull instancetype)initWithJudoID:(nonnull NSString *)judoId
                                amount:(nonnull JPAmount *)amount
                             reference:(nonnull JPReference *)reference;

/**
 * Designated initializer that sets the required parameters for receipt-related transactions
 *  - Compatible with Refund, Void, Collection transactions.
 *
 *  @param receiptId - the Receipt ID obtained from a transaction response.
 *  @param amount - the JPAmount instance, contaning the amount and the currency of the transaction.
 *
 *  @returns a configured instance of JPConfiguration
 */
- (nonnull instancetype)initWithReceiptID:(nonnull NSString *)receiptId
                                   amount:(nonnull JPAmount *)amount;

@end
