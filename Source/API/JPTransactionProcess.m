//
//  JPTransactionProcess.m
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

#import "JPTransactionProcess.h"

#import "JPAmount.h"
#import "JPReference.h"

#import "JPSession.h"

@interface JPTransactionProcess ()

@property (nonatomic, strong) NSMutableDictionary *parameters;

@end

@implementation JPTransactionProcess

- (instancetype)initWithReceiptId:(NSString *)receiptId amount:(JPAmount *)amount {
    self = [super init];
    if (self) {
        self.parameters = [NSMutableDictionary dictionary];
        self.parameters[@"receiptId"] = receiptId;
        self.parameters[@"amount"] = amount.amount;
        self.parameters[@"currency"] = amount.currency;
        self.parameters[@"yourPaymentReference"] = [JPReference generatePaymentReference];
    }
    return self;
}

- (void)sendWithCompletion:(void (^)(JPResponse *, NSError *))completion {
    NSString *fullURL = [NSString stringWithFormat:@"%@%@", self.apiSession.endpoint, self.transactionProcessingPath];
    [self.apiSession POST:fullURL parameters:self.parameters completion:completion];
}

#pragma mark - getters

- (NSString *)receiptId {
    return self.parameters[@"receiptId"];
}

- (JPAmount *)amount {
    return [JPAmount amount:self.parameters[@"amount"] currency:self.parameters[@"currency"]];
}

- (NSString *)paymentReference {
    return self.parameters[@"yourPaymentReference"];
}

- (NSString *)transactionProcessingPath {
    return @"/";
}

- (CLLocationCoordinate2D)location {
    if (self.parameters[@"consumerLocation"]) {
        NSNumber *lat = self.parameters[@"consumerLocation.latitude"];
        NSNumber *lon = self.parameters[@"consumerLocation.longitude"];
        return CLLocationCoordinate2DMake(lat.doubleValue, lon.doubleValue);
    }
    return CLLocationCoordinate2DMake(LONG_MAX, LONG_MAX);
}

- (NSDictionary *)deviceSignal {
    return self.parameters[@"clientDetails"];
}

#pragma mark - setters

- (void)setLocation:(CLLocationCoordinate2D)location {
    self.parameters[@"consumerLocation"] = @{@"latitude" : @(location.latitude), @"longitude" : @(location.longitude)};
}

- (void)setDeviceSignal:(NSDictionary *)deviceSignal {
    self.parameters[@"clientDetails"] = deviceSignal;
}

@end
