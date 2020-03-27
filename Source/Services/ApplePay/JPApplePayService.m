//
//  JPApplePayService.m
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

#import "JPApplePayService.h"
#import "JPApplePayWrappers.h"
#import "JPContactInformation.h"
#import "JPPostalAddress.h"
#import "JPResponse.h"
#import "NSError+Additions.h"
#import "UIApplication+Additions.h"

@interface JPApplePayService ()
@property (nonatomic, assign) TransactionMode transactionMode;
@property (nonatomic, strong) JPApplePayConfiguration *configuration;
@property (nonatomic, strong) JPTransactionService *transactionService;
@property (nonatomic, strong) JudoCompletionBlock completionBlock;
@end

@implementation JPApplePayService

#pragma mark - Initializers

- (instancetype)initWithConfiguration:(JPApplePayConfiguration *)configuration
                   transactionService:(JPTransactionService *)transactionService {
    if (self = [super init]) {
        self.configuration = configuration;
        self.transactionService = transactionService;
    }
    return self;
}

#pragma mark - Public method

- (void)invokeApplePayWithMode:(TransactionMode)mode
                    completion:(JudoCompletionBlock)completion {
    self.transactionMode = mode;
    self.completionBlock = completion;
    [UIApplication.topMostViewController presentViewController:self.pkPaymentAuthorizationViewController
                                                      animated:YES
                                                    completion:nil];
}

#pragma mark - Apple Pay setup methods

+ (bool)isApplePaySupported {
    return [PKPaymentAuthorizationController canMakePayments];
}

- (bool)isApplePaySetUp {
    return [PKPaymentAuthorizationController canMakePaymentsUsingNetworks:self.pkPaymentNetworks];
}

#pragma mark - PKPaymentAuthorizationViewController delegate methods

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus))completion {

    JPConfiguration *configuration = [JPConfiguration new];

    TransactionType type = (self.transactionMode == TransactionModePreAuth) ? TransactionTypePreAuth : TransactionTypePayment;
    self.transactionService.transactionType = type;

    JPTransaction *transaction = [self.transactionService transactionWithConfiguration:configuration];

    NSError *error;
    [transaction setPkPayment:payment error:&error];

    if (error && self.completionBlock) {
        self.completionBlock(nil, [NSError judoJSONSerializationFailedWithError:error]);
        completion(PKPaymentAuthorizationStatusFailure);
        return;
    }

    __weak typeof(self) weakSelf = self;
    [transaction sendWithCompletion:^(JPResponse *response, NSError *error) {

        if (error || response.items.count == 0) {
            if (weakSelf.completionBlock)
                weakSelf.completionBlock(response, error);
            completion(PKPaymentAuthorizationStatusFailure);
            return;
        }

        if (weakSelf.configuration.returnedContactInfo & ReturnedInfoBillingContacts) {
            response.billingInfo = [weakSelf contactInformationFromPaymentContact:payment.billingContact];
        }

        if (weakSelf.configuration.returnedContactInfo & ReturnedInfoShippingContacts) {
            response.shippingInfo = [weakSelf contactInformationFromPaymentContact:payment.shippingContact];
        }

        if (weakSelf.completionBlock)
            weakSelf.completionBlock(response, error);
        completion(PKPaymentAuthorizationStatusSuccess);
    }];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getters

- (PKPaymentAuthorizationViewController *)pkPaymentAuthorizationViewController {

    PKPaymentAuthorizationViewController *viewController;

    viewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:self.pkPaymentRequest];
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;
    viewController.delegate = self;

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
        pkShippingMethod.label = shippingMethod.label;
        pkShippingMethod.amount = shippingMethod.amount;
        pkShippingMethod.type = [self pkSummaryItemTypeFromType:shippingMethod.type];
        [pkShippingMethods addObject:pkShippingMethod];
    }

    return pkShippingMethods;
}

- (NSArray<PKPaymentSummaryItem *> *)pkPaymentSummaryItems {

    NSMutableArray<PKPaymentSummaryItem *> *pkPaymentSummaryItems = [NSMutableArray new];

    for (JPPaymentSummaryItem *item in self.configuration.paymentSummaryItems) {
        PKPaymentSummaryItemType summaryItemType = [self pkSummaryItemTypeFromType:item.type];
        [pkPaymentSummaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:item.label
                                                                             amount:item.amount
                                                                               type:summaryItemType]];
    }

    return pkPaymentSummaryItems;
}

- (NSArray<PKPaymentNetwork> *)pkPaymentNetworks {

    NSMutableArray<PKPaymentNetwork> *pkPaymentNetworks = [[NSMutableArray alloc] init];

    CardNetwork cardNetworks = self.configuration.supportedCardNetworks;

    if (cardNetworks && CardNetworkVisa) {
        [pkPaymentNetworks addObject:PKPaymentNetworkVisa];
    }

    if (cardNetworks & CardNetworkAMEX) {
        [pkPaymentNetworks addObject:PKPaymentNetworkAmex];
    }

    if (cardNetworks & CardNetworkMasterCard) {
        [pkPaymentNetworks addObject:PKPaymentNetworkMasterCard];
    }

    if (cardNetworks & CardNetworkMaestro) {
        if (@available(iOS 12.0, *)) {
            [pkPaymentNetworks addObject:PKPaymentNetworkMaestro];
        }
    }

    if (cardNetworks & CardNetworkJCB) {
        [pkPaymentNetworks addObject:PKPaymentNetworkJCB];
    }

    if (cardNetworks & CardNetworkDiscover) {
        [pkPaymentNetworks addObject:PKPaymentNetworkDiscover];
    }

    if (cardNetworks & CardNetworkChinaUnionPay) {
        [pkPaymentNetworks addObject:PKPaymentNetworkChinaUnionPay];
    }

    return pkPaymentNetworks;
}

- (NSSet<PKContactField> *)pkContactFieldsFromFields:(ContactField)contactFields {

    NSMutableSet *pkContactFields = [NSMutableSet new];

    if (@available(iOS 11.0, *)) {

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

- (PKPaymentSummaryItemType)pkSummaryItemTypeFromType:(JPPaymentSummaryItemType)type {
    if (type == JPPaymentSummaryItemTypeFinal) {
        return PKPaymentSummaryItemTypeFinal;
    }

    return PKPaymentSummaryItemTypePending;
}

- (PKAddressField)pkAddressFieldsFromFields:(ContactField)contactFields {
    return (PKAddressField)contactFields;
}

- (nullable JPContactInformation *)contactInformationFromPaymentContact:(nullable PKContact *)contact {

    if (!contact)
        return nil;

    JPPostalAddress *postalAddress = [[JPPostalAddress alloc] initWithSteet:contact.postalAddress.street
                                                                       city:contact.postalAddress.city
                                                                      state:contact.postalAddress.state
                                                                 postalCode:contact.postalAddress.postalCode
                                                                    country:contact.postalAddress.country
                                                                    isoCode:contact.postalAddress.ISOCountryCode
                                                      subAdministrativeArea:contact.postalAddress.subAdministrativeArea
                                                                sublocality:contact.postalAddress.subLocality];

    return [[JPContactInformation alloc] initWithEmailAddress:contact.emailAddress
                                                         name:contact.name
                                                  phoneNumber:contact.phoneNumber.stringValue
                                                postalAddress:postalAddress];
}

@end
