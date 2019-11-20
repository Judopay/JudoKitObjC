//
//  PBBAService.m
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

#import "PBBAService.h"
#import "JPSession.h"
#import "JPAmount.h"
#import "JPReference.h"

@interface PBBAService ()

@property (nonatomic, strong) NSString *judoId;
@property (nonatomic, strong) JPAmount *amount;
@property (nonatomic, strong) JPReference *reference;
@property (nonatomic, strong) NSDictionary *paymentMetadata;
@property (nonatomic, strong) JPSession *session;

@end

@implementation PBBAService

static NSString *redirectEndpoint = @"order/bank/sale";
static NSString *statusEndpoint = @"order/bank/statusrequest";

- (instancetype)initWithJudoId:(NSString *)judoId
                        amount:(JPAmount *)amount
                     reference:(JPReference *)reference
                       session:(JPSession *)session
               paymentMetadata:(NSDictionary *)paymentMetadata {
    if (self = [super init]) {
        self.judoId = judoId;
        self.amount = amount;
        self.reference = reference;
        self.session = session;
        self.paymentMetadata = paymentMetadata;
    }
    return self;
}

- (void)redirectURLWithCompletion:(JudoCompletionBlock)completion {
    
    NSString *fullURL = [NSString stringWithFormat:@"%@%@", self.session.iDealEndpoint, redirectEndpoint];

    [self.session POST:fullURL
            parameters:[self pbbaRedirectParameters]
            completion:completion];
}

- (NSDictionary *)pbbaRedirectParameters {
    return @{
        @"paymentMethod": @"PBBA",
        @"isTest": @0,
        @"currency": self.amount.currency,
        @"amount": @0.01,
        @"merchantPaymentReference": self.reference.paymentReference,
        @"countryCode": @"GB",
        @"merchantRedirectUrl": @"pending page",
        @"ageRestriction": @"",
        @"merchantConsumerReference": self.reference.consumerReference,
        @"merchantPaymentMetadata": @{@"freeformat": @"string"},
        @"siteId": self.judoId,
        @"mobileNumber": @"123123",
        @"emailAddress": @"myemail@gmail.com",
        @"paymentMetadata": @"metadata"
    };
}

@end
