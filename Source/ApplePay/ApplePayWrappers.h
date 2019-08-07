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

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Apple pay properties

typedef NS_ENUM(NSInteger, MerchantCapability) {
    MerchantCapability3DS,
    MerchantCapabilityEMV,
    MerchantCapabilityCredit,
    MerchantCapabilityDebit
};

typedef NS_ENUM(NSInteger, PaymentSummaryItemType) {
    PaymentSummaryItemTypeFinal,
    PaymentSummaryItemTypePending
};

typedef NS_ENUM(NSInteger, PaymentShippingType) {
    ShippingTypeShipping,
    ShippingTypeDelivery,
    ShippingTypeStorePickup,
    ShippingTypeServicePickup
};

#pragma mark - Apple pay constants

typedef NS_OPTIONS(NSInteger, ContactField) {
    ContactFieldNone = 0,
    ContactFieldPostalAddress = 1 << 0,
    ContactFieldPhone = 1 << 1,
    ContactFieldEmail = 1 << 2,
    ContactFieldName = 1 << 3,
    ContactFieldAll = (ContactFieldPostalAddress|ContactFieldPhone|ContactFieldEmail|ContactFieldName)
};

typedef NS_OPTIONS(NSInteger, ReturnedInfo) {
    ReturnedInfoNone = 0,
    ReturnedInfoBillingContacts = 1 << 0,
    ReturnedInfoShippingAddress = 1 << 1,
    ReturnedInfoAll = (ReturnedInfoBillingContacts|ReturnedInfoShippingAddress)
};

#pragma mark - Apple Pay PaymentSummaryItem

@interface PaymentSummaryItem : NSObject

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, assign) PaymentSummaryItemType type;

- (instancetype)initWithLabel: (NSString *)label
                       amount:(NSDecimalNumber *)amount
                         type:(PaymentSummaryItemType)type;

- (instancetype)initWithLabel: (NSString *)label
                       amount: (NSDecimalNumber *)amount;

@end

#pragma mark - Apple Pay PaymentShippingMethod

@interface PaymentShippingMethod : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *detail;

@end

NS_ASSUME_NONNULL_END
