//
//  JPIDEALService.m
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

#import "JPIDEALService.h"
#import "JPAmount.h"
#import "JPOrderDetails.h"
#import "JPReference.h"
#import "JPResponse.h"
#import "JPTransactionData.h"
#import "NSError+Additions.h"

@interface JPIDEALService ()
@property (nonatomic, strong) JPConfiguration *configuration;
@property (nonatomic, strong) JPTransactionService *transactionService;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL didTimeout;
@end

@implementation JPIDEALService

#pragma mark - Constants

static NSString *const kRedirectEndpoint = @"order/bank/sale";
static NSString *const kStatusRequestEndpoint = @"order/bank/statusrequest";
static const float kTimerDuration = 60.0f;

#pragma mark - Initializers

- (instancetype)initWithConfiguration:(JPConfiguration *)configuration
                   transactionService:(JPTransactionService *)transactionService {
    if (self = [super init]) {
        self.configuration = configuration;
        self.transactionService = transactionService;
    }
    return self;
}

- (void)dealloc {
    [self.timer invalidate];
}

#pragma mark - Public methods

- (void)redirectURLForIDEALBank:(JPIDEALBank *)iDealBank
                     completion:(JudoCompletionBlock)completion {

    NSDictionary *parameters = [self parametersForIDEALBank:iDealBank];

    if (!parameters) {
        completion(nil, NSError.judoSiteIDMissingError);
        return;
    }

    __weak typeof(self) weakSelf = self;
    [self.transactionService sendRequestWithEndpoint:kRedirectEndpoint
                                          httpMethod:HTTPMethodPOST
                                          parameters:parameters
                                          completion:^(JPResponse *response, NSError *error) {
                                              JPTransactionData *data = response.items.firstObject;

                                              if (data.orderDetails.orderId && data.redirectUrl) {
                                                  completion([weakSelf remapIdealResponseWithResponse:response], error);
                                                  return;
                                              }

                                              completion(nil, NSError.judoResponseParseError);
                                          }];
}

- (void)pollTransactionStatusForOrderId:(NSString *)orderId
                               checksum:(NSString *)checksum
                             completion:(JudoCompletionBlock)completion {

    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimerDuration
                                                 repeats:NO
                                                   block:^(NSTimer *_Nonnull timer) {

                                                       weakSelf.didTimeout = true;
                                                       completion(nil, NSError.judoRequestTimeoutError);
                                                       return;
                                                   }];
    [self getStatusForOrderId:orderId checksum:checksum completion:completion];
}

- (void)getStatusForOrderId:(NSString *)orderId
                   checksum:(NSString *)checksum
                 completion:(JudoCompletionBlock)completion {

    if (self.didTimeout) {
        return;
    }

    NSString *statusEndpoint = [NSString stringWithFormat:@"%@/%@", kStatusRequestEndpoint, orderId];

    __weak typeof(self) weakSelf = self;
    [self.transactionService sendRequestWithEndpoint:statusEndpoint
                                          httpMethod:HTTPMethodGET
                                          parameters:nil
                                          completion:^(JPResponse *response, NSError *error) {

                                              if (error) {
                                                  completion(nil, error);
                                                  [weakSelf.timer invalidate];
                                                  return;
                                              }

                                              if ([response.items.firstObject.orderDetails.orderStatus isEqual:@"PENDING"]) {
                                                  dispatch_time_t timeInterval = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
                                                  dispatch_after(timeInterval, dispatch_get_main_queue(), ^{
                                                      [weakSelf getStatusForOrderId:orderId checksum:checksum completion:completion];
                                                  });
                                                  return;
                                              }
                                              JPResponse *mappedResponse = [weakSelf remapIdealResponseWithResponse:response];
                                              completion(mappedResponse, error);
                                              [weakSelf.timer invalidate];
                                          }];
}

- (void)stopPollingTransactionStatus {
    self.didTimeout = YES;
    [self.timer invalidate];
}

- (NSDictionary *)parametersForIDEALBank:(JPIDEALBank *)iDEALBank {

    if (!self.configuration.siteId) {
        return nil;
    }

    JPAmount *amount = self.configuration.amount;
    JPReference *reference = self.configuration.reference;

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{
        @"paymentMethod" : @"IDEAL",
        @"currency" : amount.currency,
        @"amount" : @(amount.amount.doubleValue),
        @"country" : @"NL",
        @"accountHolderName" : @"IDEAL Bank",
        @"merchantPaymentReference" : reference.paymentReference,
        @"bic" : iDEALBank.bankIdentifierCode,
        @"merchantConsumerReference" : reference.consumerReference,
        @"siteId" : self.configuration.siteId
    }];

    return parameters;
}

- (JPResponse *)remapIdealResponseWithResponse:(JPResponse *)response {
    response.items.firstObject.receiptId = response.items.firstObject.orderDetails.orderId;
    return response;
}

@end
