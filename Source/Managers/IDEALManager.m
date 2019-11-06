//
//  IDEALManager.m
//  JudoKitObjC
//
//  Copyright (c) 2019 Alternative Payments Ltd
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

#import "IDEALManager.h"
#import "IDEALBank.h"
#import "JPAmount.h"
#import "JPSession.h"
#import "JPReference.h"
#import "JPResponse.h"
#import "JPTransactionData.h"
#import "NSError+Judo.h"

@interface IDEALManager()

@property (nonatomic, strong) NSString *judoId;
@property (nonatomic, strong) JPAmount *amount;
@property (nonatomic, strong) JPReference *reference;
@property (nonatomic, strong) NSDictionary *merchantPaymentMetadata;
@property (nonatomic, strong) NSDictionary *paymentMetadata;
@property (nonatomic, strong) JPSession *session;

@end

@implementation IDEALManager

static NSString *redirectEndpoint = @"http://private-e715f-apiapi8.apiary-mock.com/order/bank/sale";
static NSString *statusEndpoint = @"http://private-e715f-apiapi8.apiary-mock.com/order/bank/sale";

- (instancetype)initWithJudoId:(NSString *)judoId
                        amount:(JPAmount *)amount
                     reference:(JPReference *)reference
                       session:(JPSession *)session
       merchantPaymentMetadata:(NSDictionary *)merchantPaymentMetadata
               paymentMetadata:(NSDictionary *)paymentMetadata {
    
    if (self = [super init]) {
        self.judoId = judoId;
        self.amount = amount;
        self.reference = reference;
        self.session = session;
        self.merchantPaymentMetadata = merchantPaymentMetadata;
        self.paymentMetadata = paymentMetadata;
    }
    
    return self;
}

- (void)getRedirectURLForIDEALBank:(IDEALBank *)iDealBank
                      completion:(JudoRedirectCompletion)completion {
    
    [self.session requestWithMethod:@"POST"
                               path:redirectEndpoint
                         parameters:[self parametersForIDEALBank:iDealBank]
                         completion:^(JPResponse *response, NSError *error) {
        
        JPTransactionData *data = response.items.firstObject;
        
        if (data.orderId && data.redirectUrl) {
            completion(data.redirectUrl, data.orderId, error);
            return;
        }
        
        completion(nil, nil, NSError.judoResponseParseError);
    }];
}

- (void)poolTransactionStatusForOrderId:(NSString *)orderId
                               checksum:(NSString *)checksum
                              completion:(JudoPoolingCompletion)completion {
    // TODO: Handle pooling logic
}

- (NSDictionary *)parametersForIDEALBank:(IDEALBank *)iDEALBank {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{
        @"paymentMethod": @"IDEAL",
        @"currency": self.amount.currency,
        @"amount": self.amount.amount,
        @"country": @"NL",
        @"accountHolderName": @"A N Other",
        @"merchantPaymentReference": self.reference.paymentReference,
        @"bic": iDEALBank.bankIdentifierCode,
        @"merchantConsumerReference": self.reference.consumerReference,
        @"siteId": self.judoId
    }];
    
    if (self.merchantPaymentMetadata) {
        parameters[@"merchantPaymentMetadata"] = self.merchantPaymentMetadata;
    }
    
    if (self.paymentMetadata) {
        parameters[@"paymentMetadata"] = self.paymentMetadata;
    }
    
    return parameters;
}

@end
