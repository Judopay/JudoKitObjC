//
//  JPTransaction.m
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

#import "JPTransaction.h"
#import "JPAddress.h"
#import "JPAmount.h"
#import "JPCard.h"
#import "JPEnhancedPaymentDetail.h"
#import "JPPagination.h"
#import "JPPaymentToken.h"
#import "JPReference.h"
#import "JPRegisterCard.h"
#import "JPResponse.h"
#import "JPSaveCard.h"
#import "JPSession.h"
#import "JPTransactionEnricher.h"
#import "JPVCOResult.h"

#import "NSError+Judo.h"

@interface JPReference ()

@property (nonatomic, strong, readwrite) NSString *paymentReference;
@property (nonatomic, strong, readwrite) NSString *consumerReference;

@end

@interface JPTransaction ()

@property (nonatomic, strong) NSString *currentTransactionReference;
@property (nonatomic, assign) BOOL initialRecurringPayment;
@property (nonatomic, strong) NSMutableDictionary *parameters;

@property (nonatomic, strong) PKPayment *pkPayment;
@property (nonatomic, strong) JPVCOResult *vcoResult;
@end

@implementation JPTransaction

- (instancetype)init {
    self = [super init];
    if (self) {
        self.parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)sendWithCompletion:(JudoCompletionBlock)completion {

    if (!completion) {
        return;
    }

    NSError *validationError = [self validateTransaction];

    if (validationError) {
        completion(nil, validationError);
        return;
    }

    self.currentTransactionReference = self.reference.paymentReference;

    [self.enricher enrichTransaction:self
                      withCompletion:^{
                          [self.apiSession POST:self.transactionPath parameters:self.parameters completion:completion];
                      }];
}

- (NSError *)validateTransaction { //!OCLINT
    if (!self.judoId) {
        return [NSError judoJudoIdMissingError];
    }

    if (!self.card && !self.paymentToken && !self.pkPayment && !self.vcoResult) {
        return [NSError judoPaymentMethodMissingError];
    }

    if (!self.reference) {
        return [NSError judoReferenceMissingError];
    }

    if (![self isKindOfClass:JPRegisterCard.class] && ![self isKindOfClass:JPSaveCard.class] && !self.amount) {
        return [NSError judoAmountMissingError];
    }

    if (self.reference.paymentReference == self.currentTransactionReference) {
        return [NSError judoDuplicateTransactionError];
    }

    return nil;
}

- (void)threeDSecureWithParameters:(NSDictionary *)parameters receiptId:(NSString *)receiptId completion:(JudoCompletionBlock)completion {
    [self.apiSession PUT:[NSString stringWithFormat:@"transactions/%@", receiptId]
              parameters:parameters
              completion:completion];
}

- (void)listWithCompletion:(JudoCompletionBlock)completion {
    [self listWithPagination:nil completion:completion];
}

- (void)listWithPagination:(JPPagination *)pagination completion:(JudoCompletionBlock)completion {
    NSString *path = self.transactionPath;
    if (pagination) {
        path = [path stringByAppendingFormat:@"?pageSize=%li&offset=%li&sort=%@", (long)pagination.pageSize, (long)pagination.offset, pagination.sort];
    }
    [self.apiSession GET:path parameters:nil completion:completion];
}

#pragma mark - getters and setters

- (NSString *)judoId {
    return self.parameters[@"judoId"];
}

- (void)setJudoId:(NSString *)judoId {
    self.parameters[@"judoId"] = judoId;
}

- (JPAmount *)amount {
    if (self.parameters[@"amount"] && self.parameters[@"currency"]) {
        NSString *amount = self.parameters[@"amount"];
        NSString *currency = self.parameters[@"currency"];
        return [JPAmount amount:amount currency:currency];
    }
    return nil;
}

- (void)setAmount:(JPAmount *)amount {
    self.parameters[@"amount"] = amount.amount;
    self.parameters[@"currency"] = amount.currency;
}

- (JPReference *)reference {
    if (self.parameters[@"yourConsumerReference"] && self.parameters[@"yourPaymentReference"]) {
        JPReference *reference = [JPReference new];
        reference.consumerReference = self.parameters[@"yourConsumerReference"];
        reference.paymentReference = self.parameters[@"yourPaymentReference"];
        reference.metaData = self.parameters[@"yourPaymentMetaData"];
        return reference;
    }
    return nil;
}

- (void)setReference:(JPReference *)reference {
    self.parameters[@"yourConsumerReference"] = reference.consumerReference;
    self.parameters[@"yourPaymentReference"] = reference.paymentReference;
    self.parameters[@"yourPaymentMetaData"] = reference.metaData;
}

- (JPCard *)card {
    if (self.parameters[@"cardNumber"] && self.parameters[@"expiryDate"] && self.parameters[@"cv2"]) {
        JPCard *card = [JPCard new];
        card.cardNumber = self.parameters[@"cardNumber"];
        card.expiryDate = self.parameters[@"expiryDate"];
        card.secureCode = self.parameters[@"cv2"];

        card.startDate = self.parameters[@"startDate"];
        card.issueNumber = self.parameters[@"issueNumber"];

        card.cardAddress = [[JPAddress alloc] initWithDictionary:self.parameters[@"cardAddress"]];

        return card;
    }
    return nil;
}

- (void)setCard:(JPCard *)card {
    if (card.cardNumber) {
        self.parameters[@"cardNumber"] = card.cardNumber;
    }
    if (card.expiryDate) {
        self.parameters[@"expiryDate"] = card.expiryDate;
    }
    if (card.secureCode) {
        self.parameters[@"cv2"] = card.secureCode;
    }

    if (card.startDate) {
        self.parameters[@"startDate"] = card.startDate;
    }
    if (card.issueNumber) {
        self.parameters[@"issueNumber"] = card.issueNumber;
    }

    if (card.cardAddress) {
        self.parameters[@"cardAddress"] = card.cardAddress.dictionaryRepresentation;
    }
}

- (JPPaymentToken *)paymentToken {
    if (self.parameters[@"consumerToken"] && self.parameters[@"cardToken"]) {
        JPPaymentToken *paymentToken = [[JPPaymentToken alloc] initWithConsumerToken:self.parameters[@"consumerToken"]
                                                                           cardToken:self.parameters[@"cardToken"]];
        paymentToken.secureCode = self.parameters[@"cv2"];
        return paymentToken;
    }
    return nil;
}

- (void)setPaymentToken:(JPPaymentToken *)paymentToken {
    self.parameters[@"consumerToken"] = paymentToken.consumerToken;
    self.parameters[@"cardToken"] = paymentToken.cardToken;
    if (paymentToken.secureCode) {
        self.parameters[@"cv2"] = paymentToken.secureCode;
    }
}

- (PKPayment *)pkPayment {
    return _pkPayment;
}

- (int)setPkPayment:(PKPayment *)pkPayment
              error:(NSError *__autoreleasing *)error {
    
    self.pkPayment = pkPayment;

    NSMutableDictionary *tokenDict = [NSMutableDictionary dictionary];

    if (pkPayment.token.paymentMethod) {
        tokenDict[@"paymentInstrumentName"] = pkPayment.token.paymentMethod.displayName;
        tokenDict[@"paymentNetwork"] = pkPayment.token.paymentMethod.network;
    } else {
        tokenDict[@"paymentInstrumentName"] = pkPayment.token.paymentInstrumentName;
        tokenDict[@"paymentNetwork"] = pkPayment.token.paymentNetwork;
    }

    tokenDict[@"paymentData"] = [NSJSONSerialization JSONObjectWithData:pkPayment.token.paymentData
                                                                options:NSJSONReadingAllowFragments
                                                                  error:error];

    self.parameters[@"pkPayment"] = @{@"token" : tokenDict};
    [self handleApplePayMetadataFromPKPayment:pkPayment];
    
    return error ? 1 : 0;
}

- (void)handleApplePayMetadataFromPKPayment:(PKPayment *)pkPayment {
    
    NSString *emailAddress = pkPayment.billingContact.emailAddress;
    NSString *phoneNumber = pkPayment.billingContact.phoneNumber.stringValue;
    
    if (emailAddress != nil) {
        self.parameters[@"emailAddress"] = emailAddress;
    }
    
    if (phoneNumber != nil) {
        self.parameters[@"mobileNumber"] = phoneNumber;
    }
    
    NSMutableDictionary *cardAddress = [NSMutableDictionary new];
    
    cardAddress[@"address1"] = pkPayment.billingContact.postalAddress.street;
    cardAddress[@"city"] = pkPayment.billingContact.postalAddress.city;
    cardAddress[@"postCode"] = pkPayment.billingContact.postalAddress.postalCode;
    cardAddress[@"countryCode"] = pkPayment.billingContact.postalAddress.ISOCountryCode;
    
    cardAddress[@"line1"] = pkPayment.billingContact.postalAddress.street;
    cardAddress[@"line2"] = pkPayment.billingContact.postalAddress.city;
    cardAddress[@"line3"] = pkPayment.billingContact.postalAddress.postalCode;
    
    self.parameters[@"cardAddress"] = cardAddress;
}

- (JPVCOResult *)vcoResult {
    return _vcoResult;
}

- (void)setVCOResult:(JPVCOResult *)vcoResult {
    self.vcoResult = vcoResult;
    self.parameters[@"wallet"] = @{@"callid" : vcoResult.callId,
                                   @"encryptedKey" : vcoResult.encryptedKey,
                                   @"encryptedPaymentData" : vcoResult.encryptedPaymentData};
}

- (NSString *)mobileNumber {
    return self.parameters[@"mobileNumber"];
}

- (void)setMobileNumber:(NSString *)mobileNumber {
    self.parameters[@"mobileNumber"] = mobileNumber;
}

- (NSString *)emailAddress {
    return self.parameters[@"emailAddress"];
}

- (void)setEmailAddress:(NSString *)emailAddress {
    self.parameters[@"emailAddress"] = emailAddress;
}

- (NSDictionary *)deviceSignal {
    return self.parameters[@"clientDetails"];
}

- (void)setDeviceSignal:(NSDictionary *)deviceSignal {
    self.parameters[@"clientDetails"] = deviceSignal;
}

- (BOOL)initialRecurringPayment {
    return ((NSNumber *)self.parameters[@"initialRecurringPayment"]).boolValue;
}

- (void)setInitialRecurringPayment:(BOOL)initialRecurringPayment {
    self.parameters[@"initialRecurringPayment"] = [NSNumber numberWithBool:initialRecurringPayment];
}

- (void)setPaymentDetail:(JPEnhancedPaymentDetail *)paymentDetail {
    _paymentDetail = paymentDetail;

    NSDictionary *dict = [paymentDetail toDictionary];
    self.parameters[@"EnhancedPaymentDetail"] = dict;
}

#pragma mark - TransactionPath

- (NSString *)transactionPath {
    return @"/";
}

@end
