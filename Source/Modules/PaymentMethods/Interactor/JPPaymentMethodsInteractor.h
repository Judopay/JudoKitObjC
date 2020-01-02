//
//  JPPaymentMethodsInteractor.h
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

#import <Foundation/Foundation.h>

@class JPStoredCardDetails, JPTheme;

@protocol JPPaymentMethodsInteractor

/**
 * A method that returns the stored card details from the keychain
 *
 * @returns an array of JPStoredCardDetails objects
 */
- (NSArray<JPStoredCardDetails *> *)getStoredCardDetails;

/**
 * A method that updates the selected state of a card stored in the keychain
 */
- (void)selectCardAtIndex:(NSInteger)index;

/**
 * A method that returns YES if the 'Powered by Judo' headline should be displayed
 */
- (BOOL)shouldDisplayJudoHeadline;

@end

@interface JPPaymentMethodsInteractorImpl : NSObject <JPPaymentMethodsInteractor>

/**
 * A designated initializer that sets up the JPTheme object needed for view customization
 */
- (instancetype)initWithTheme:(JPTheme *)theme;

@end
