//
//  ApplePayConfiguration.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 8/5/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "ApplePayConfiguration.h"

@implementation ApplePayConfiguration

- (instancetype)initWithJudoId:(NSString *)judoId
                        amount:(JPAmount *)amount
                     reference:(NSString *)reference
                    merchantId:(NSString *)merchantId
                       country:(NSString *)country {
    
    self = [super init];
    if (!self) return self;
    
    self.judoId = judoId;
    self.amount = amount;
    self.reference = reference;
    self.merchantId = merchantId;
    self.country = country;
    
    return self;
}

@end
