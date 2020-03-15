//
//  JPApplePayConfiguration.h
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

#import "JPApplePayWrappers.h"
#import "JPCardDetails.h"
#import "JPTransaction.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A configuration file responsible for setting all the necessary parameters
 * for a successful initialization of the PKPaymentAuthorizationViewController,
 * and serves as the only method for modifying the payment request parameters.
 */
@interface JPApplePayConfiguration : NSObject

/**
 * [REQUIRED] The merchant identifier that is the one specified in the app's entitlements
 */
@property (nonatomic, strong) NSString *_Nonnull merchantId;

/**
 * [REQUIRED] The three-letter ISO 4217 currency code used for the payment request
 */
@property (nonatomic, strong) NSString *_Nonnull currency;

/**
 * [REQUIRED] The two-letter ISO 3166 country code where the payment will be processed
 */
@property (nonatomic, strong) NSString *_Nonnull countryCode;

/**
 * [REQUIRED] An array of summary items that summarize the amount of the payment (total, shipping, tax, etc.)
 *            The last summary item must specify the total amount to be payed.
 */
@property (nonatomic, strong) NSArray<JPPaymentSummaryItem *> *_Nonnull paymentSummaryItems;

/**
 * [DEFAULT] An array of supported card networks.
 *           If not set, defaults to Visa, MasterCard, AmEx and Maestro.
 *
 * [NOTE: Maestro is only available starting with iOS 12.0]
 */
@property (nonatomic, assign) CardNetwork supportedCardNetworks;

/**
 * [DEFAULT] A bitmask of the payment processing protocols and card types that you support.
 *           If not set, defaults to 3D Security.
 */
@property (nonatomic, assign) MerchantCapability merchantCapabilities;

/**
 * [OPTIONAL] A bitmask specifying the required billing contant fields in order to process the transaction
 */
@property (nonatomic, assign) ContactField requiredBillingContactFields;

/**
 * [OPTIONAL] A bitmask specifying the required shipping contant fields in order to process the transaction
 */
@property (nonatomic, assign) ContactField requiredShippingContactFields;

/**
 * [OPTIONAL] An array that describes the supported shipping methods
 */
@property (nonatomic, strong) NSArray<PaymentShippingMethod *> *_Nullable shippingMethods;

/**
 * [DEFAULT] The type of shipping used for this request.
 *           If not set, defaults to PKShippingTypeShipping.
 */
@property (nonatomic, assign) PaymentShippingType shippingType;

/**
 * [DEFAULT] The billing / shipping information to be returned to the merchant.
 *           If not set, defaults to Billing Contact information.
 */
@property (nonatomic, assign) ReturnedInfo returnedContactInfo;

/**
 * Designated initializer necesary for the bare minimum configuration of a PKPaymentRequest object.
 * Will use the default property values for the configuration of its other parameters.
 *
 * @param merchantId          - The merchant identifier that is the one specified in the app's entitlements
 * @param currency            - The three-letter ISO 4217 currency code used for the payment request
 * @param countryCode         - The two-letter ISO 3166 country code where the payment will be processed
 * @param paymentSummaryItems - An array of items that summarize the amount of the payment (total, shipping, tax, etc.)
 */
- (instancetype)initWithMerchantId:(NSString *)merchantId
                          currency:(NSString *)currency
                       countryCode:(NSString *)countryCode
               paymentSummaryItems:(NSArray<JPPaymentSummaryItem *> *)paymentSummaryItems;

@end

NS_ASSUME_NONNULL_END
