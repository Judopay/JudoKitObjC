//
//  ApplePayConfiguration.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 8/5/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPAmount.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplePayConfiguration : NSObject

@property (nonatomic, strong) NSString * _Nonnull judoId;
@property (nonatomic, strong) JPAmount * _Nonnull amount;
@property (nonatomic, strong) NSString * _Nonnull reference;
@property (nonatomic, strong) NSString * _Nonnull merchantId;
@property (nonatomic, strong) NSString * _Nonnull country;

// @property (nonatomic, strong, readonly) NSArray<PKPaymentNetwork> *supportedNetworks;
// @property (nonatomic, strong, readonly) PKMerchantCapability merchantCapabilities;
// @property (nonatomic, strong, readonly) NSArray<PKPaymentSummaryItem *> *paymentSummaryItems;

- (instancetype)initWithJudoId: (NSString *)judoId
                        amount:(JPAmount *)amount
                     reference: (NSString *)reference
                    merchantId: (NSString *)merchantId
                       country: (NSString *)country;

@end

NS_ASSUME_NONNULL_END
