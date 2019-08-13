//
//  ApplePayManager.h
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

#import "ApplePayConfiguration.h"
#import "ContactInformation.h"
#import "JPAmount.h"
#import "JPReference.h"
#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Object responsible for generating the PKPaymentAuthorizationViewController
 * based on the ApplePayConfiguration object set at initialization, while also
 * providing helper methods and getters related to the ApplePay transaction.
 */
@interface ApplePayManager : NSObject

/**
 * Designated initializer
 *
 * @param configuration - responsible for configuring the PKPaymentRequest object.
 */
- (instancetype)initWithConfiguration:(ApplePayConfiguration *)configuration;

/**
 * A helper getter that generates a JPAmount object based on the last PaymentSummaryItem element
 * defined in the ApplePayConfiguration. Needed as a parameter for JPTransaction.
 */
- (JPAmount *)jpAmount;

/**
 * A helper getter that generates a JPReference object based on the consumer reference
 * defined in the ApplePayConfiguration. Needed as a parameter for JPTransaction.
 */
- (JPReference *)jpReference;

/**
 * A helper method that converts a PKContact object into a ContactInformation object
 * that is passed into JPResult to give merchants access to either billing or shipping
 * contact information.
 */
- (nullable ContactInformation *)contactInformationFromPaymentContact:(nullable PKContact *)contact;

/**
 * The PKPaymentAuthorizationViewController that should pe presented in order to invoke
 * the ApplePay payment sheet. It is initialized from a PKPaymentRequest item that was
 * created based on the parameters passed by ApplePayConfiguration.
 */
- (nullable PKPaymentAuthorizationViewController *)pkPaymentAuthorizationViewController;

@end

NS_ASSUME_NONNULL_END
