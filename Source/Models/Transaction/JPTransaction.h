//
//  JPTransaction.h
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

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

@class JPResponse, JPPagination, JPSession, JPPaymentToken, JPCard, JPAmount, JPReference, JPVCOResult, JPEnhancedPaymentDetail,
    JPTransactionEnricher, JPPrimaryAccountDetails;

typedef NS_ENUM(NSUInteger, TransactionMode) {
    TransactionModePayment,
    TransactionModePreAuth,
};

typedef NS_ENUM(NSUInteger, TransactionType) {
    TransactionTypePayment,
    TransactionTypePreAuth,
    TransactionTypeRefund,
    TransactionTypeRegisterCard,
    TransactionTypeCheckCard,
    TransactionTypeSaveCard,
    TransactionTypeCollection,
    TransactionTypeVoid,
};

typedef NS_ENUM(NSUInteger, TransactionResult) {
    TransactionResultSuccess,
    TransactionResultDeclined,
    TransactionResultError
};

@interface JPTransaction : NSObject

@property (nonatomic, strong, readonly) NSString *_Nullable transactionPath;
@property (nonatomic, strong) NSString *_Nonnull judoId;
@property (nonatomic, strong) JPReference *_Nullable reference;
@property (nonatomic, strong) JPAmount *_Nullable amount;
@property (nonatomic, strong) JPCard *_Nullable card;
@property (nonatomic, strong) JPPaymentToken *_Nullable paymentToken;
@property (nonatomic, strong) JPPrimaryAccountDetails *_Nullable primaryAccountDetails;
@property (nonatomic, strong, readonly) PKPayment *_Nullable pkPayment;
@property (nonatomic, strong, readonly) JPVCOResult *_Nullable vcoResult;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSDictionary *_Nullable deviceSignal;
@property (nonatomic, strong) NSString *_Nullable mobileNumber;
@property (nonatomic, strong) NSString *_Nullable emailAddress;
@property (nonatomic, strong) JPSession *_Nullable apiSession;
@property (nonatomic, strong) JPTransactionEnricher *_Nullable enricher;
@property (nonatomic, strong) JPEnhancedPaymentDetail *_Nullable paymentDetail;

+ (nonnull instancetype)transactionWithType:(TransactionType)type;

+ (nonnull instancetype)transactionWithType:(TransactionType)type
                                  receiptId:(nonnull NSString *)receiptId
                                     amount:(nonnull JPAmount *)amount;

- (nonnull instancetype)initWithType:(TransactionType)type;

- (nonnull instancetype)initWithType:(TransactionType)type
                           receiptId:(nonnull NSString *)receiptId
                              amount:(nonnull JPAmount *)amount;

- (int)setPkPayment:(nonnull PKPayment *)pkPayment
              error:(NSError *__autoreleasing _Nullable *_Nullable)error;

- (void)setVCOResult:(nonnull JPVCOResult *)vcoResult;

- (nullable NSError *)validateTransaction;

- (void)sendWithCompletion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

- (void)threeDSecureWithParameters:(nonnull NSDictionary *)parameters
                         receiptId:(nonnull NSString *)receiptId
                        completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

- (void)listWithCompletion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

- (void)listWithPagination:(nullable JPPagination *)pagination
                completion:(nonnull void (^)(JPResponse *_Nullable, NSError *_Nullable))completion;

@end
