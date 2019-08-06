//
//  AppDelegate.h
//  JudoKitObjCExample
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

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>
#import "JPCardDetails.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * The billing and shipping information available to be returned to the merchant after the payment
 */
typedef NS_OPTIONS(NSInteger, ReturnedContactInfo) {
    BillingContacts = 1 << 0,
    ShippingContacts = 1 << 1,
    BillingAddress = 1 << 2
};

/**
 * A configuration file responsible for creating the PKPaymentRequest object that will be used
 * when calling the PKAuthorizationController and invoke the Apple Pay sheet that prompts the
 * user to authorize the payment request.
 */
@interface ApplePayConfiguration : NSObject

/**
 * [REQUIRED] The JudoPay ID parameter
 */
@property (nonatomic, strong) NSString * _Nonnull judoId;

/**
 * [REQUIRED] The payment reference number
 */
@property (nonatomic, strong) NSString * _Nonnull reference;

/**
 * [REQUIRED] The merchant identifier that is the one specified in the app's entitlements
 */
@property (nonatomic, strong) NSString * _Nonnull merchantId;

/**
 * [REQUIRED] The three-letter ISO 4217 currency code used for the payment request
 */
@property (nonatomic, strong) NSString * _Nonnull currency;

/**
 * [REQUIRED] The two-letter ISO 3166 country code where the payment will be processed
 */
@property (nonatomic, strong) NSString * _Nonnull countryCode;

/**
 * [REQUIRED] An array of summary items that summarize the amount of the payment (total, shipping, tax, etc.)
 */
@property (nonatomic, strong) NSArray<PKPaymentSummaryItem *> * _Nonnull paymentSummaryItems;

/**
 * [DEFAULT] An array of supported card networks.
 *           If not set, defaults to Visa, MasterCard, AmEx and Maestro.
 *           NOTE: Maestro is only available starting with iOS 12.0.
 */
@property (nonatomic, strong) NSArray<NSNumber *> *supportedCardNetworks;

/**
 * [DEFAULT] A bit field of the payment processing protocols and card types that you support.
 *           If not set, defaults to 3D Security.
 */
@property (nonatomic, assign) PKMerchantCapability merchantCapabilities;

/**
 * [OPTIONAL] A list of fields required for a billing contant in order to process the transaction
 */
@property (nonatomic, strong) NSArray<PKContactField> * _Nullable requiredBillingContactFields;

/**
 * [OPTIONAL] A list of fields required for a shipping contant in order to process the transaction
 */
@property (nonatomic, strong) NSArray<PKContactField> * _Nullable requiredShippingContactFields;

/**
 * [OPTIONAL] An array that describes the supported shipping methods
 */
@property (nonatomic, strong) NSArray<PKShippingMethod *> * _Nullable shippingMethods;

/**
 * [DEFAULT] The type of shipping used for this request.
 *           If not set, defaults to PKShippingTypeShipping.
 */
@property (nonatomic, assign) PKShippingType shippingType;

/**
 * [DEFAULT] The billing / shipping information to be returned to the merchant.
 *           If not set, defaults to Billing Address and Billing Contact information.
 */
@property (nonatomic, assign) ReturnedContactInfo returnedContactInfo;

/**
 * Designated initializer necesary for the bare minimum configuration of a PKPaymentRequest object.
 * Will use the default property values for the configuration of its other parameters.
 *
 * @param judoId              - The JudoPay ID parameter
 * @param reference           - The payment reference number
 * @param merchantId          - The merchant identifier that is the one specified in the app's entitlements
 * @param currency            - The three-letter ISO 4217 currency code used for the payment request
 * @param countryCode         - The two-letter ISO 3166 country code where the payment will be processed
 * @param paymentSummaryItems - An array of summary items that summarize the amount of the payment (total, shipping, tax, etc.)
 */
- (instancetype) initWithJudoId: (NSString *)judoId
                      reference: (NSString *)reference
                     merchantId: (NSString *)merchantId
                       currency: (NSString *)currency
                    countryCode: (NSString *)countryCode
            paymentSummaryItems: (NSArray<PKPaymentSummaryItem *> *)paymentSummaryItems;

/**
 * Method that generates the PKPaymentRequest object that will be used when calling the PKAuthorizationController
 * and invoke the Apple Pay sheet that prompts the user to authorize the payment request
 */
- (PKPaymentRequest *)generatePaymentRequest;

@end

NS_ASSUME_NONNULL_END
