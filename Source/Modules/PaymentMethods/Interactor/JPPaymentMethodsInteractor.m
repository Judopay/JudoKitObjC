//
//  JPPaymentMethodsInteractor.m
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

#import "JPPaymentMethodsInteractor.h"
#import "JPAmount.h"
#import "JPCardStorage.h"
#import "JPPaymentToken.h"
#import "JPTheme.h"
#import "JPTransaction.h"

@interface JPPaymentMethodsInteractorImpl ()
@property (nonatomic, strong) JPTransaction *transaction;
@property (nonatomic, strong) JPReference *reference;
@property (nonatomic, strong) JPTheme *theme;
@property (nonatomic, strong) JPAmount *amount;
@end

@implementation JPPaymentMethodsInteractorImpl

- (instancetype)initWithTransaction:(JPTransaction *)transaction
                          reference:(JPReference *)reference
                              theme:(JPTheme *)theme
                          andAmount:(JPAmount *)amount {
    if (self = [super init]) {
        self.transaction = transaction;
        self.reference = reference;
        self.theme = theme;
        self.amount = amount;
    }
    return self;
}

- (NSArray<JPStoredCardDetails *> *)getStoredCardDetails {
    return [JPCardStorage.sharedInstance getStoredCardDetails];
}

- (void)selectCardAtIndex:(NSInteger)index {

    NSArray<JPStoredCardDetails *> *storedCardDetails;
    storedCardDetails = [JPCardStorage.sharedInstance getStoredCardDetails];

    for (JPStoredCardDetails *cardDetails in storedCardDetails) {
        cardDetails.isSelected = NO;
    }
    storedCardDetails[index].isSelected = YES;

    [JPCardStorage.sharedInstance deleteCardDetails];

    for (JPStoredCardDetails *cardDetails in storedCardDetails) {
        [JPCardStorage.sharedInstance addCardDetails:cardDetails];
    }
}

- (BOOL)shouldDisplayJudoHeadline {
    return [self.theme displayJudoHeadline];
}

- (JPAmount *)getAmount {
    return self.amount;
}

- (void)paymentTransactionWithToken:(NSString *)token
                      andCompletion:(JudoCompletionBlock)completion {

    JPPaymentToken *paymentToken = [[JPPaymentToken alloc] initWithConsumerToken:self.reference.consumerReference
                                                                       cardToken:token];

    [self.transaction setPaymentToken:paymentToken];
    [self.transaction sendWithCompletion:completion];
}

@end
