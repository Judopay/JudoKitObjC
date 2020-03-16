//
//  JPCardCustomizationSubmitCell.h
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

#import "JPCardCustomizable.h"
#import "JPThemable.h"

@class JPCardCustomizationSubmitCell;

@protocol JPCardCustomizationSubmitCellDelegate

/**
 * A method that is triggered once the user taps `Save` on the Card Customization Screen
 *
 * @param cell - a reference to the JPCardCustomizationSubmitCell instance that calls the delegate method
 */
- (void)didTapSaveForSubmitCell:(nonnull JPCardCustomizationSubmitCell *)cell;

/**
 * A method that is triggered once the user taps `Cancel` on the Card Customization Screen
 *
 * @param cell - a reference to the JPCardCustomizationSubmitCell instance that calls the delegate method
 */
- (void)didTapCancelForSubmitCell:(nonnull JPCardCustomizationSubmitCell *)cell;

@end

@interface JPCardCustomizationSubmitCell : UITableViewCell <JPCardCustomizable, JPThemable>

/**
 * A weak reference to the object that adopts the JPCardCustomizationSubmitCellDelegate protocol
 */
@property (nonatomic, weak) id<JPCardCustomizationSubmitCellDelegate> _Nullable delegate;

@end
