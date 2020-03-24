//
//  JPTransactionService.m
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

#import "JPTransactionService.h"
#import "JPCard.h"
#import "JPTransactionEnricher.h"
#import "JPReference.h"
#import "NSError+Additions.h"

@interface JPTransactionService ()
@property (nonatomic, strong) JPSession *session;
@property (nonatomic, strong) JPTransactionEnricher *enricher;
@end

@implementation JPTransactionService

#pragma mark - Initializers

- (instancetype)initWithToken:(NSString *)token
                    andSecret:(NSString *)secret {
    if (self = [super init]) {
        [self setupSessionWithToken:token andSecret:secret];
        [self setupTransactionEnricherWithToken:token andSecret:secret];
    }
    return self;
}

#pragma mark - Setup methods

- (void)setupTransactionEnricherWithToken:(NSString *)token
                                andSecret:(NSString *)secret {
    self.enricher = [[JPTransactionEnricher alloc] initWithToken:token
                                                          secret:secret];
}

- (void)setupSessionWithToken:(NSString *)token
                    andSecret:(NSString *)secret {

    NSString *formattedString = [NSString stringWithFormat:@"%@:%@", token, secret];
    NSData *encodedStringData = [formattedString dataUsingEncoding:NSISOLatin1StringEncoding];
    NSString *base64String = [encodedStringData base64EncodedStringWithOptions:0];

    NSString *authorizationHeader = [NSString stringWithFormat:@"Basic %@", base64String];
    self.session = [JPSession sessionWithAuthorizationHeader:authorizationHeader];
}

#pragma mark - Public methods

- (JPTransaction *)transactionWithConfiguration:(JPConfiguration *)configuration {

    if (configuration.receiptId) {
        return [self receiptTransactionWithConfiguration:configuration];
    }

    JPTransaction *transaction = [JPTransaction transactionWithType:self.transactionType];
    transaction.judoId = configuration.judoId;
    transaction.amount = configuration.amount;
    transaction.reference = configuration.reference;
    transaction.primaryAccountDetails = configuration.primaryAccountDetails;
    transaction.apiSession = self.session;
    transaction.enricher = self.enricher;

    return transaction;
}

- (JPTransaction *)receiptTransactionWithConfiguration:(JPConfiguration *)configuration {

    JPTransaction *transaction = [JPTransaction transactionWithType:self.transactionType
                                                          receiptId:configuration.receiptId
                                                             amount:configuration.amount];
    transaction.apiSession = self.session;
    transaction.enricher = self.enricher;

    return transaction;
}

- (JPReceipt *)receiptForReceiptId:(NSString *)receiptId {
    JPReceipt *receipt = [[JPReceipt alloc] initWithReceiptId:receiptId];
    receipt.apiSession = self.session;
    return receipt;
}

- (void)listTransactionsOfType:(TransactionType)type
                     paginated:(JPPagination *)pagination
                    completion:(JudoCompletionBlock)completion {

    JPTransaction *transaction = [JPTransaction transactionWithType:type];
    transaction.apiSession = self.session;
    [transaction listWithPagination:pagination completion:completion];
}

- (void)sendRequestWithEndpoint:(NSString *)endpoint
                     httpMethod:(HTTPMethod)httpMethod
                     parameters:(NSDictionary *)parameters
                     completion:(JudoCompletionBlock)completion {

    NSString *url = [NSString stringWithFormat:@"%@%@", self.session.baseURL, endpoint];

    if (httpMethod == HTTPMethodPOST) {
        [self.session POST:url parameters:parameters completion:completion];
        return;
    }
    [self.session GET:url parameters:parameters completion:completion];
}

#pragma mark - Setters

- (void)setIsSandboxed:(BOOL)isSandboxed {
    _isSandboxed = isSandboxed;
    self.session.sandboxed = isSandboxed;
}

@end
