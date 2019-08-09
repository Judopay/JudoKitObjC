//
//  JPTransactionData.m
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
#import "JPAmount.h"
#import "JPCardDetails.h"
#import "JPConsumer.h"
#import "JPPaymentToken.h"

@implementation JPTransactionData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self populateWith:dictionary];
    }
    return self;
}

- (void)populateWith:(NSDictionary *)dictionary {
    self.receiptId = dictionary[@"receiptId"];
    self.paymentReference = dictionary[@"yourPaymentReference"];
    self.type = [self transactionTypeForString:dictionary[@"type"]];
    self.createdAt = dictionary[@"createdAt"];
    self.result = [self transactionResultForString:dictionary[@"result"]];
    self.message = dictionary[@"message"];
    self.judoId = dictionary[@"judoId"];
    self.merchantName = dictionary[@"merchantName"];
    self.appearsOnStatementAs = dictionary[@"appearsOnStatementAs"];
    NSString *currency = dictionary[@"currency"];
    if (dictionary[@"refunds"]) {
        self.refunds = [[JPAmount alloc] initWithAmount:dictionary[@"refunds"] currency:currency];
    }
    self.originalAmount = dictionary[@"originalAmount"];

    self.netAmount = dictionary[@"netAmount"];
    NSString *amount = dictionary[@"amount"];
    if (amount != nil) {
        self.amount = [[JPAmount alloc] initWithAmount:amount currency:currency];
    }
    NSDictionary *cardDetailsDictionary = dictionary[@"cardDetails"];
    if (cardDetailsDictionary) {
        self.cardDetails = [[JPCardDetails alloc] initWithDictionary:cardDetailsDictionary];
    }
    self.consumer = [[JPConsumer alloc] initWithDictionary:dictionary[@"consumer"]];
    self.rawData = dictionary;
}

- (TransactionResult)transactionResultForString:(NSString *)resultString {
    if ([resultString isEqualToString:@"Success"]) {
        return TransactionResultSuccess;
    } else if ([resultString isEqualToString:@"Declined"]) {
        return TransactionResultDeclined;
    }
    return TransactionResultError;
}

- (TransactionType)transactionTypeForString:(NSString *)typeString {
    if ([typeString isEqualToString:@"Payment"]) {
        return TransactionTypePayment;
    } else if ([typeString isEqualToString:@"PreAuth"]) {
        return TransactionTypePreAuth;
    } else if ([typeString isEqualToString:@"RegisterCard"]) {
        return TransactionTypeRegisterCard;
    } else if ([typeString isEqualToString:@"Save"]) {
        return TransactionTypeSaveCard;
    }
    return TransactionTypeRefund;
}

- (JPPaymentToken *)paymentToken {
    return [[JPPaymentToken alloc] initWithConsumerToken:self.consumer.consumerToken cardToken:self.cardDetails.cardToken];
}

@end
