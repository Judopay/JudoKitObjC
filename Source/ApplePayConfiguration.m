//
//  ApplePayConfiguration.m
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

#import "ApplePayConfiguration.h"

@implementation ApplePayConfiguration

#pragma mark - Initializers

- (instancetype)init {

    if (self = [super init]) {
        [self setupDefaults];
    }

    return self;
}

- (instancetype)initWithJudoId:(NSString *)judoId
                     reference:(NSString *)reference
                    merchantId:(NSString *)merchantId
                      currency:(NSString *)currency
                   countryCode:(NSString *)countryCode
           paymentSummaryItems:(NSArray<PaymentSummaryItem *> *)paymentSummaryItems {

    if (self = [super init]) {
        [self setupDefaults];
    }

    self.judoId = judoId;
    self.reference = reference;
    self.merchantId = merchantId;
    self.currency = currency;
    self.countryCode = countryCode;
    self.paymentSummaryItems = paymentSummaryItems;

    return self;
}

#pragma mark - Helper methods

- (void)setupDefaults {
    self.transactionType = TransactionTypePayment;
    self.merchantCapabilities = MerchantCapability3DS;
    self.shippingType = ShippingTypeShipping;
    self.returnedContactInfo = ReturnedInfoBillingContacts;
    self.supportedCardNetworks = @[ @(CardNetworkVisa), @(CardNetworkMasterCard), @(CardNetworkAMEX) ];

    // Adds Maestro to the list of available card networks if iOS 12 or above
    if (@available(iOS 12.0, *)) {
        self.supportedCardNetworks = [self.supportedCardNetworks arrayByAddingObject:@(CardNetworkMaestro)];
    }
}

@end
