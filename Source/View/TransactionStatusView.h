//
//  TransactionStatusView.h
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

#import "IDEALService.h"
#import <UIKit/UIKit.h>

@class TransactionStatusView, JPTheme;

@protocol TransactionStatusViewDelegate
- (void)statusViewRetryButtonDidTap:(TransactionStatusView *)statusView;
@end

/**
 * A custom implementation of a UIView object that is used to display the iDEAL transaction status
 */
@interface TransactionStatusView : UIView

/**
 * The delegate property that will capture the transaction retry event
 */
@property (nonatomic, weak) id<TransactionStatusViewDelegate> delegate;

/**
 * Designated initializer that uses an IDEALStatus enum to setup its views
 *
 * @param status - An IDEALStatus enum that defines the iDEAL transaction status
 * @param theme - An instance of a JPTheme object used for customizing the appearance
 */
+ (instancetype)viewWithStatus:(IDEALStatus)status andTheme:(JPTheme *)theme;

/**
 * Designated initializer that uses an IDEALStatus enum to setup its views
 *
 * @param status - An IDEALStatus enum that defines the iDEAL transaction status
 * @param theme - An instance of a JPTheme object used for customizing the appearance
 */
- (instancetype)initWithStatus:(IDEALStatus)status andTheme:(JPTheme *)theme;

/**
 * Method used to update the UI when a transaction status changes
 *
 * @param status - An IDEALStatus enum that defines the iDEAL transaction status
*/
- (void)changeStatusTo:(IDEALStatus)status;

@end
