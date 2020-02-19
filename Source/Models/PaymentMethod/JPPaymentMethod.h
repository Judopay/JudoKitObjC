//
//  JPPaymentMethod.h
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JPPaymentMethodType) {
    JPPaymentMethodTypeCard,
    JPPaymentMethodTypeIDeal,
    JPPaymentMethodTypeApplePay,
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
 * The type of the payment method
 */
@property (nonatomic, assign, readonly) JPPaymentMethodType type;

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
