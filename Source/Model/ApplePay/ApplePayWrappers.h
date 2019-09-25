//
//  ApplePayWrappers.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Lists the available merchant capabilities.
 * Default is MerchantCapability3DS.
 */
typedef NS_ENUM(NSInteger, MerchantCapability) {
    MerchantCapability3DS,
    MerchantCapabilityEMV,
    MerchantCapabilityCredit,
    MerchantCapabilityDebit
};

/**
 * Lists the available payment summary item types.
 * Default is PaymentSummaryItemTypeFinal.
 */
typedef NS_ENUM(NSInteger, PaymentSummaryItemType) {
    PaymentSummaryItemTypeFinal,
    PaymentSummaryItemTypePending
};

/**
 * Lists the available payment shipping types.
 * Default is ShippingTypeShipping.
 */
typedef NS_ENUM(NSInteger, PaymentShippingType) {
    ShippingTypeShipping,
    ShippingTypeDelivery,
    ShippingTypeStorePickup,
    ShippingTypeServicePickup
};

/**
 * Lists the available contact fields required for ApplePay
 */
typedef NS_OPTIONS(NSInteger, ContactField) {
    ContactFieldNone = 0,
    ContactFieldPostalAddress = 1 << 0,
    ContactFieldPhone = 1 << 1,
    ContactFieldEmail = 1 << 2,
    ContactFieldName = 1 << 3,
    ContactFieldAll = (ContactFieldPostalAddress | ContactFieldPhone | ContactFieldEmail | ContactFieldName)
};

/**
 * Lists the available options for the returned contact info after the transaction.
 * Default is ReturnedInfoBillingContacts.
 */
typedef NS_OPTIONS(NSInteger, ReturnedInfo) {
    ReturnedInfoNone = 0,
    ReturnedInfoBillingContacts = 1 << 0,
    ReturnedInfoShippingContacts = 1 << 1,
    ReturnedInfoAll = (ReturnedInfoBillingContacts | ReturnedInfoShippingContacts)
};

/**
 * An object used in ApplePayConfiguration to specify the purchase items, price
 * and payment type, either final or pending (ex: taxi fares)
 */
@interface PaymentSummaryItem : NSObject

/**
 * The title of the purchased item
 */
@property (nonatomic, strong) NSString *label;

/**
 * The amount to be payed for this specific item
 */
@property (nonatomic, strong) NSDecimalNumber *amount;

/**
 * The type of the payment (final or pending)
 * Defaults to PaymentSummaryItemTypeFinal
 */
@property (nonatomic, assign) PaymentSummaryItemType type;

/**
 * Designated initializer
 *
 * @param label  - title of the item
 * @param amount - amount to be payed for this item
 * @param type   - payment type for this item (final / pending)
 */
- (instancetype)initWithLabel:(NSString *)label
                       amount:(NSDecimalNumber *)amount
                         type:(PaymentSummaryItemType)type;

/**
 * Convenience initializer that sets payment type to PaymentSummaryItemTypeFinal by default
 *
 * @param label  - title of the item
 * @param amount - amount to be payed for this item
 */
- (instancetype)initWithLabel:(NSString *)label
                       amount:(NSDecimalNumber *)amount;

@end

/**
 * Defines a shipping method for delivering physical goods.
 * Inherits from PaymentSummaryItem
 */
@interface PaymentShippingMethod : PaymentSummaryItem

/**
 * Identifier for the shipping method, used by the app.
 */
@property (nonatomic, strong) NSString *identifier;

/**
 * A user-readable description of the shipping method.
 */
@property (nonatomic, strong) NSString *detail;

/**
 * Designated initializer
 *
 * @param identifier - identifier for the shipping method, used by the app.
 * @param detail     - a user-readable description of the shipping method.
 * @param label  - title of the item
 * @param amount - amount to be payed for this item
 * @param type   - payment type for this item (final / pending)
 */
- (instancetype)initWithIdentifier:(NSString *)identifier
                         detail:(NSString *)detail
                             label:(NSString *)label
                         amount:(NSDecimalNumber *)amount
                           type:(PaymentSummaryItemType)type;

@end

NS_ASSUME_NONNULL_END
