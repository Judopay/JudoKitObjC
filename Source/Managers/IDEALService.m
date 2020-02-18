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
#import "JPAmount.h"
#import "JPOrderDetails.h"
#import "JPReference.h"
#import "JPResponse.h"
#import "JPTransactionData.h"
#import "NSError+Judo.h"

@interface IDEALService ()

@property (nonatomic, strong) NSString *siteId;
@property (nonatomic, strong) JPAmount *amount;
@property (nonatomic, strong) JPReference *reference;
@property (nonatomic, strong) NSDictionary *paymentMetadata;
@property (nonatomic, strong) JPSession *session;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL didTimeout;

@end

@implementation IDEALService

static NSString *redirectEndpoint = @"order/bank/sale";
static NSString *statusEndpoint = @"order/bank/statusrequest/";

- (instancetype)initWithSiteId:(NSString *)siteId
                        amount:(JPAmount *)amount
                     reference:(JPReference *)reference
                       session:(JPSession *)session
               paymentMetadata:(NSDictionary *)paymentMetadata {

    if (self = [super init]) {
        self.siteId = siteId;
        self.amount = amount;
        self.reference = reference;
        self.session = session;
        self.paymentMetadata = paymentMetadata;
        self.didTimeout = false;
    }

    return self;
}

- (void)redirectURLForIDEALBank:(IDEALBank *)iDealBank
                     completion:(JudoCompletionBlock)completion {

    NSString *fullURL = [NSString stringWithFormat:@"%@%@", self.session.baseURL, redirectEndpoint];

    [self.session POST:fullURL
            parameters:[self parametersForIDEALBank:iDealBank]
            completion:^(JPResponse *response, NSError *error) {
                JPTransactionData *data = response.items.firstObject;

                if (data.orderDetails.orderId && data.redirectUrl) {
                    completion(response, error);
                    return;
                }

                completion(nil, NSError.judoResponseParseError);
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

    NSString *fullURL = [NSString stringWithFormat:@"%@%@%@", self.session.baseURL, statusEndpoint, orderId];

    [self.session GET:fullURL
           parameters:nil
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

    NSNumber *amount = [NSNumber numberWithDouble:self.amount.amount.doubleValue];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{
        @"paymentMethod" : @"IDEAL",
        @"currency" : self.amount.currency,
        @"amount" : amount,
        @"country" : @"NL",
        @"accountHolderName" : self.accountHolderName,
        @"merchantPaymentReference" : self.reference.paymentReference,
        @"bic" : iDEALBank.bankIdentifierCode,
        @"merchantConsumerReference" : self.reference.consumerReference,
        @"siteId" : self.siteId
    }];

    if (self.paymentMetadata) {
        parameters[@"paymentMetadata"] = self.paymentMetadata;
    }

    return parameters;
}

@end
