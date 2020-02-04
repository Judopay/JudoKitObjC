//
//  JPPaymentMethodsCardListHeaderCell.h
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

#import "JPPaymentMethodsCell.h"
#import <UIKit/UIKit.h>

/**
* A delegate protocol related action button logic
*/
@protocol JPPaymentMethodsCardListHeaderCellDelegate
/**
 * A delegate method to notify when the action button was tapped
 */
- (void)didTapActionButton;
@end

@interface JPPaymentMethodsCardListHeaderCell : JPPaymentMethodsCell

/**
 * The title label of the header above the card list
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 * The Edit button of the header above the card list
 */
@property (nonatomic, strong) UIButton *actionButton;

/**
*  The delegate that will handle action button logic
*/
@property (nonatomic, weak) id<JPPaymentMethodsCardListHeaderCellDelegate> _Nullable delegate;
@end
