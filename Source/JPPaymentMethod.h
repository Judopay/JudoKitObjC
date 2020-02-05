//
//  JPPaymentMethod.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 2/5/20.
//  Copyright © 2020 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JPPaymentMethodType) {
    JPPaymentMethodTypeCard,
    JPPaymentMethodTypeIDeal,
    JPPaymentMethodTypeApplePay
};

@interface JPPaymentMethod : NSObject

/**
 * The title of the payment method
 */
@property (nonatomic, strong, readonly) NSString *title;

/**
 * The icon name of the payment method
 */
@property (nonatomic, strong, readonly) NSString *iconName;

/**
 * A pre-defined initializer that describes the card payment method
 */
+ (instancetype)card;

/**
 * A pre-defined initializer that describes the iDeal payment method
 */
+ (instancetype)iDeal;

/**
 * A pre-defined initializer that describes the Apple Pay payment method
 */
+ (instancetype)applePay;

/**
 * An initializer that creates a JPPaymentMethod instance based on a pre-defined type
 */
- (instancetype)initWithPaymentMethodType:(JPPaymentMethodType)type;

@end
