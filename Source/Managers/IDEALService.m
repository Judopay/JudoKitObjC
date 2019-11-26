//
//  IDEALService.m
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

#import "IDEALService.h"
#import "IDEALBank.h"
#import "JPOrderDetails.h"
#import "JPReference.h"
#import "JPResponse.h"
#import "JPSession.h"
#import "JPTransactionData.h"
#import "NSError+Judo.h"

@interface IDEALService ()

@property (nonatomic, strong) NSString *judoId;
@property (nonatomic, assign) double amount;
@property (nonatomic, strong) JPReference *reference;
@property (nonatomic, strong) NSDictionary *paymentMetadata;
@property (nonatomic, strong) JPSession *session;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL didTimeout;
@property (nonatomic, strong) IDEALRedirectCompletion redirectCompletion;

@end

@implementation IDEALService

static NSString *redirectEndpoint = @"order/bank/sale";
static NSString *statusEndpoint = @"order/bank/statusrequest";

- (instancetype)initWithJudoId:(NSString *)judoId
                        amount:(double)amount
                     reference:(JPReference *)reference
                       session:(JPSession *)session
               paymentMetadata:(NSDictionary *)paymentMetadata
            redirectCompletion:(IDEALRedirectCompletion)redirectCompletion {

    if (self = [super init]) {
        self.judoId = judoId;
        self.amount = amount;
        self.reference = reference;
        self.session = session;
        self.paymentMetadata = paymentMetadata;
        self.didTimeout = false;
        self.redirectCompletion = redirectCompletion;
    }

    return self;
}

- (void)redirectURLForIDEALBank:(IDEALBank *)iDealBank
                     completion:(JudoRedirectCompletion)completion {

    NSString *fullURL = [NSString stringWithFormat:@"%@%@", self.session.iDealEndpoint, redirectEndpoint];

    [self.session POST:fullURL
            parameters:[self parametersForIDEALBank:iDealBank]
            completion:^(JPResponse *response, NSError *error) {
                JPTransactionData *data = response.items.firstObject;

                if (data.orderDetails.orderId && data.redirectUrl) {

                    if (self.redirectCompletion) {
                        self.redirectCompletion(response);
                    }

                    completion(data.redirectUrl, data.orderDetails.orderId, error);
                    return;
                }

                completion(nil, nil, NSError.judoResponseParseError);
            }];
}

- (void)pollTransactionStatusForOrderId:(NSString *)orderId
                               checksum:(NSString *)checksum
                             completion:(JudoCompletionBlock)completion {

    self.timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                 repeats:NO
                                                   block:^(NSTimer *_Nonnull timer) {
                                                       self.didTimeout = true;
                                                       completion(nil, NSError.judoRequestTimeoutError);
                                                       return;
                                                   }];

    [self getStatusForOrderId:orderId checksum:checksum completion:completion];
}

- (void)getStatusForOrderId:(NSString *)orderId
                   checksum:(NSString *)checksum
                 completion:(JudoCompletionBlock)completion {

    if (self.didTimeout)
        return;

    NSString *fullURL = [NSString stringWithFormat:@"%@%@", self.session.iDealEndpoint, statusEndpoint];

    [self.session POST:fullURL
            parameters:[self pollingParametersForOrderID:orderId checksum:checksum]
            completion:^(JPResponse *response, NSError *error) {
                if (error) {
                    completion(nil, error);
                    [self.timer invalidate];
                    return;
                }

                if ([response.items.firstObject.orderDetails.orderStatus isEqual:@"PENDING"]) {

                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)),
                                   dispatch_get_main_queue(), ^{
                                       [self getStatusForOrderId:orderId checksum:checksum completion:completion];
                                   });
                    return;
                }

                completion(response, error);
                [self.timer invalidate];
            }];
}

- (void)stopPollingTransactionStatus {
    self.didTimeout = YES;
    [self.timer invalidate];
}

- (NSDictionary *)parametersForIDEALBank:(IDEALBank *)iDEALBank {

    NSNumber *amount = [NSNumber numberWithDouble:self.amount];
    NSString *trimmedPaymentReference = [self.reference.paymentReference substringToIndex:39];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{
        @"paymentMethod" : @"IDEAL",
        @"currency" : @"EUR",
        @"amount" : amount,
        @"country" : @"NL",
        @"accountHolderName" : self.accountHolderName,
        @"merchantPaymentReference" : trimmedPaymentReference,
        @"bic" : iDEALBank.bankIdentifierCode,
        @"merchantConsumerReference" : self.reference.consumerReference,
        @"siteId" : self.judoId
    }];

    if (self.paymentMetadata) {
        parameters[@"paymentMetadata"] = self.paymentMetadata;
    }

    return parameters;
}

- (NSDictionary *)pollingParametersForOrderID:(NSString *)orderId
                                     checksum:(NSString *)checksum {

    NSString *trimmedPaymentReference = [self.reference.paymentReference substringToIndex:39];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{
        @"paymentMethod" : @"IDEAL",
        @"orderId" : orderId,
        @"siteId" : self.judoId,
        @"merchantPaymentReference" : trimmedPaymentReference,
        @"merchantConsumerReference" : self.reference.consumerReference,
        @"checksum" : checksum
    }];

    if (self.paymentMetadata) {
        parameters[@"paymentMetadata"] = self.paymentMetadata;
    }

    return parameters;
}

@end
