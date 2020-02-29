//
//  JPCardView.h
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

#import "JPCardNetwork.h"
#import "JPCardPattern.h"
#import "JPPaymentMethodsViewModel.h"
#import <UIKit/UIKit.h>

@interface JPCardPaymentMethodView : UIView

/**
 * A method that configures the custom card view
 *
 * @param title - the title of the card
 * @param expiryDate - the expiration date of the card
 * @param cardNetwork - the card network
 * @param cardLastFour - the last four digits of the card
 * @param patternType - a JPCardPatternType value used to identify the card pattern
 */
- (void)configureWithTitle:(NSString *)title
                expiryDate:(NSString *)expiryDate
                   network:(CardNetwork)cardNetwork
              cardLastFour:(NSString *)cardLastFour
               patternType:(JPCardPatternType)patternType;

/**
 * A method that configures the custom card view based on an expiration status
 *
 * @param expirationStatus - the expiration status of the card
 */
- (void)configureExpirationStatus:(CardExpirationStatus)expirationStatus;

@end
