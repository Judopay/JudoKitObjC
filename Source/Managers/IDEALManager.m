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

@interface IDEALManager()
@property (nonatomic, strong) JPSession *session;
@end

@implementation IDEALManager

static NSString *redirectEndpoint = @"http://private-e715f-apiapi8.apiary-mock.com/order/bank/sale";
static NSString *statusEndpoint = @"http://private-e715f-apiapi8.apiary-mock.com/order/bank/sale";

- (instancetype)initWithSession:(JPSession *)session {
    if (self = [super init]) {
        self.session = session;
    }

    return self;
}

- (void)getRedirectURLWithJudoId:(NSString *)judoId
                          amount:(JPAmount *)amount
                       reference:(JPReference *)reference
                       idealBank:(IDEALBank *)iDealBank
                      completion:(void (^)(NSString *redirectURL, NSError *error))completion {

    NSDictionary *parameters = @{
        @"paymentMethod": @"IDEAL",
        @"currency": amount.currency,
        @"amount": amount.amount,
        @"country": @"NL",
        @"accountHolderName": @"A N Other",
        @"merchantPaymentReference": reference.paymentReference,
        @"bic": iDealBank.bankIdentifierCode,
        @"merchantConsumerReference": reference.consumerReference,
        @"siteId": judoId
    };
    
    [self.session requestWithMethod:@"POST"
                               path:redirectEndpoint
                         parameters:parameters
                         completion:^(JPResponse *response, NSError *error) {
        
        JPTransactionData *data = response.items.firstObject;
        completion(data.redirectUrl, error);
    }];
}

@end
