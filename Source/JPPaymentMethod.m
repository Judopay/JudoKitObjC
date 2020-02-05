//
//  JPPaymentMethod.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 2/5/20.
//  Copyright © 2020 Judo Payments. All rights reserved.
//

#import "JPPaymentMethod.h"

@interface JPPaymentMethod ()
@end

@implementation JPPaymentMethod

+ (instancetype)card {
    return [[JPPaymentMethod alloc] initWithPaymentMethodType:JPPaymentMethodTypeCard];
}

+ (instancetype)iDeal {
    return [[JPPaymentMethod alloc] initWithPaymentMethodType:JPPaymentMethodTypeIDeal];
}

+ (instancetype)applePay {
    return [[JPPaymentMethod alloc] initWithPaymentMethodType:JPPaymentMethodTypeApplePay];
}

- (instancetype)initWithPaymentMethodType:(JPPaymentMethodType)type {
    if (self = [super init]) {
        switch (type) {
            case JPPaymentMethodTypeCard:
                _title = @"Cards";
                _iconName = @"cards-pay-icon";
                break;
                
            case JPPaymentMethodTypeIDeal:
                _title = @"iDeal";
                _iconName = @"ideal-pay-icon";
                break;
                
            case JPPaymentMethodTypeApplePay:
                _title = nil;
                _iconName = @"apple-pay-icon";
                break;
        }
    }
    return self;
}

@end
