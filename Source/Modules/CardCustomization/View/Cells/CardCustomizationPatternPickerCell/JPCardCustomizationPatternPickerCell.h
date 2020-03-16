//
//  JPCardCustomizationPatternPickerCell.h
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
#import "JPCardPattern.h"

@class JPCardCustomizationPatternPickerCell;

@protocol JPCardCustomizationPatternPickerCellDelegate

/**
 * A method that triggers once the user selects one of the pattern options from the collection
 *
 * @param pickerCell - a reference to the JPCardCustomizationPatternPickerCell instancee
 * @param type - the type of a JPCardPattern used to identify the pattern
 */
- (void)patternPickerCell:(JPCardCustomizationPatternPickerCell *)pickerCell
    didSelectPatternWithType:(JPCardPatternType)type;

@end

@interface JPCardCustomizationPatternPickerCell : UITableViewCell <JPCardCustomizable>

/**
 * A weak reference to the object that adopts the JPCardCustomizationPatternPickerCellDelegate protocol
 */
@property (nonatomic, weak) id<JPCardCustomizationPatternPickerCellDelegate> delegate;

@end

@interface JPCardCustomizationPatternPickerCell (CollectionViewDataSource) <UICollectionViewDataSource>

@end

@interface JPCardCustomizationPatternPickerCell (FlowDelegate) <UICollectionViewDelegateFlowLayout>

@end
