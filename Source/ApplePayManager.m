//
//  ApplePayManager.m
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

#import "ApplePayManager.h"
#import "ApplePayWrappers.h"

@interface ApplePayManager ()
@property ApplePayConfiguration *configuration;
@end

@implementation ApplePayManager

#pragma mark - Initializers

- (instancetype)initWithConfiguration:(ApplePayConfiguration *)configuration {
    if (self = [super init]) {
        self.configuration = configuration;
    }
    return self;
}

#pragma mark - Generated objects based on configuration

- (JPAmount *)jpAmount {

    PaymentSummaryItem *lastSummaryItem = self.configuration.paymentSummaryItems.lastObject;

    return [[JPAmount alloc] initWithAmount:lastSummaryItem.amount.stringValue
                                   currency:self.configuration.currency];
}

- (JPReference *)jpReference {
    return [[JPReference alloc] initWithConsumerReference:self.configuration.reference];
}

- (PKPaymentAuthorizationViewController *)pkPaymentAuthorizationViewController {

    PKPaymentAuthorizationViewController *viewController;

    viewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:self.pkPaymentRequest];
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;

    return viewController;
}

- (PKPaymentRequest *)pkPaymentRequest {

    PKPaymentRequest *paymentRequest = [PKPaymentRequest new];

    paymentRequest.merchantIdentifier = self.configuration.merchantId;
    paymentRequest.countryCode = self.configuration.countryCode;
    paymentRequest.currencyCode = self.configuration.currency;
    paymentRequest.supportedNetworks = self.pkPaymentNetworks;
    paymentRequest.merchantCapabilities = self.pkMerchantCapabilities;
    paymentRequest.shippingType = self.pkShippingType;
    paymentRequest.shippingMethods = self.pkShippingMethods;

    ContactField requiredShippingContactFields = self.configuration.requiredShippingContactFields;
    ContactField requiredBillingContactFields = self.configuration.requiredBillingContactFields;

    // For devices prior to iOS 11.0, PKAddressField properties will be set instead of PKContactField
    if (@available(iOS 11.0, *)) {

        NSSet<PKContactField> *pkShippingFields = [self pkContactFieldsFromFields:requiredShippingContactFields];
        NSSet<PKContactField> *pkBillingFields = [self pkContactFieldsFromFields:requiredBillingContactFields];

        paymentRequest.requiredShippingContactFields = pkShippingFields;
        paymentRequest.requiredBillingContactFields = pkBillingFields;

    } else {
        PKAddressField pkShippingFields = [self pkAddressFieldsFromFields:requiredShippingContactFields];
        PKAddressField pkBillingFields = [self pkAddressFieldsFromFields:requiredBillingContactFields];

        paymentRequest.requiredShippingAddressFields = pkShippingFields;
        paymentRequest.requiredBillingAddressFields = pkBillingFields;
    }

    paymentRequest.paymentSummaryItems = self.pkPaymentSummaryItems;

    return paymentRequest;
}

- (PKMerchantCapability)pkMerchantCapabilities {
    switch (self.configuration.merchantCapabilities) {
        case MerchantCapability3DS:
            return PKMerchantCapability3DS;
        case MerchantCapabilityEMV:
            return PKMerchantCapabilityEMV;
        case MerchantCapabilityCredit:
            return PKMerchantCapabilityCredit;
        case MerchantCapabilityDebit:
            return PKMerchantCapabilityDebit;
    }
}

- (PKShippingType)pkShippingType {
    switch (self.configuration.shippingType) {
        case ShippingTypeShipping:
            return PKShippingTypeShipping;
        case ShippingTypeDelivery:
            return PKShippingTypeDelivery;
        case ShippingTypeStorePickup:
            return PKShippingTypeStorePickup;
        case ShippingTypeServicePickup:
            return PKShippingTypeServicePickup;
    }
}

- (NSArray<PKShippingMethod *> *)pkShippingMethods {
    NSMutableArray *pkShippingMethods = [NSMutableArray new];

    for (PaymentShippingMethod *shippingMethod in self.configuration.shippingMethods) {
        PKShippingMethod *pkShippingMethod = [PKShippingMethod new];
        pkShippingMethod.identifier = shippingMethod.identifier;
        pkShippingMethod.detail = shippingMethod.detail;
        [pkShippingMethods addObject:pkShippingMethod];
    }

    return pkShippingMethods;
}

- (NSArray<PKPaymentSummaryItem *> *)pkPaymentSummaryItems {

    NSMutableArray<PKPaymentSummaryItem *> *pkPaymentSummaryItems = [NSMutableArray new];

    for (PaymentSummaryItem *item in self.configuration.paymentSummaryItems) {
        [pkPaymentSummaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:item.label
                                                                             amount:item.amount]];
    }

    return pkPaymentSummaryItems;
}

- (NSArray<PKPaymentNetwork> *)pkPaymentNetworks {

    NSMutableArray<PKPaymentNetwork> *pkPaymentNetworks = [[NSMutableArray alloc] init];

    for (NSNumber *cardNetwork in self.configuration.supportedCardNetworks) {
        PKPaymentNetwork network = [self pkPaymentNetworkForCardNetwork:cardNetwork.intValue];
        if (network)
            [pkPaymentNetworks addObject:network];
    }

    return pkPaymentNetworks;
}

#pragma mark - Conversions to PassKit objects

- (nullable PKPaymentNetwork)pkPaymentNetworkForCardNetwork:(CardNetwork)cardNetwork { //!OCLINT

    switch (cardNetwork) {

        case CardNetworkAMEX:
            return PKPaymentNetworkAmex;

        case CardNetworkCarteBancaire:
            return PKPaymentNetworkCarteBancaire;

        case CardNetworkChinaUnionPay:
            return PKPaymentNetworkChinaUnionPay;

        case CardNetworkDiscover:
            return PKPaymentNetworkDiscover;

        case CardNetworkJCB:
            return PKPaymentNetworkJCB;

        case CardNetworkMasterCard:
            return PKPaymentNetworkMasterCard;

        case CardNetworkVisa:
            return PKPaymentNetworkVisa;

        case CardNetworkVisaElectron:
            if (@available(iOS 12.0, *)) {
                return PKPaymentNetworkElectron;
            }

        case CardNetworkMaestro:
            if (@available(iOS 12.0, *)) {
                return PKPaymentNetworkMaestro;
            }

        case CardNetworkElo:
            if (@available(iOS 12.1.1, *)) {
                return PKPaymentNetworkElo;
            }

        default:
            return nil;
    }
}

- (NSSet<PKContactField> *)pkContactFieldsFromFields:(ContactField)contactFields {

    NSMutableSet *pkContactFields = [NSMutableSet new];

    if (@available(iOS 11.0, *)) { //!OCLINT (remove OCLINT warning regarding early exit)

        if (contactFields & ContactFieldPostalAddress) {
            [pkContactFields addObject:PKContactFieldPostalAddress];
        }

        if (contactFields & ContactFieldPhone) {
            [pkContactFields addObject:PKContactFieldPhoneNumber];
        }

        if (contactFields & ContactFieldEmail) {
            [pkContactFields addObject:PKContactFieldEmailAddress];
        }

        if (contactFields & ContactFieldName) {
            [pkContactFields addObject:PKContactFieldName];
        }
    }

    return pkContactFields;
}

- (PKAddressField)pkAddressFieldsFromFields:(ContactField)contactFields {
    return (PKAddressField)contactFields;
}

- (nullable ContactInformation *)contactInformationFromPaymentContact:(nullable PKContact *)contact {

    if (!contact)
        return nil;

    PostalAddress *postalAddress = [[PostalAddress alloc] initWithSteet:contact.postalAddress.street
                                                                   city:contact.postalAddress.city
                                                                  state:contact.postalAddress.state
                                                             postalCode:contact.postalAddress.postalCode
                                                                country:contact.postalAddress.country
                                                                isoCode:contact.postalAddress.ISOCountryCode
                                                  subAdministrativeArea:contact.postalAddress.subAdministrativeArea
                                                            sublocality:contact.postalAddress.subLocality];

    return [[ContactInformation alloc] initWithEmailAddress:contact.emailAddress
                                                       name:contact.name
                                                phoneNumber:contact.phoneNumber.stringValue
                                              postalAddress:postalAddress];
}

@end
