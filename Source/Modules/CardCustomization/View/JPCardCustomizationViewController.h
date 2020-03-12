//
//  JPCardCustomizationViewController.h
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

#import "JPCardCustomizationPatternPickerCell.h"
#import "JPCardCustomizationSubmitCell.h"
#import "JPInputField.h"
#import "JPTheme.h"
#import <UIKit/UIKit.h>

@protocol JPCardCustomizationPresenter;
@class JPCardCustomizationView, JPCardCustomizationViewModel;

@protocol JPCardCustomizationView

/**
 * A method for updating the view layout based on an array of view models
 *
 * @param viewModels - an array of objects that subclass the JPCardCustomizationViewModel object.
 * @param shouldPreserveResponder - a boolean property that, if set to YES, will not reload the card title input field as to preserve the first responder.
 */
- (void)updateViewWithViewModels:(nonnull NSArray<JPCardCustomizationViewModel *> *)viewModels
         shouldPreserveResponder:(BOOL)shouldPreserveResponder;

@end

@interface JPCardCustomizationViewController : UIViewController <JPCardCustomizationView>

/**
 * A reference to the JPTheme instance responsible for customizing the user interface
 */
@property (nonatomic, strong) JPTheme *_Nullable theme;

/**
 * A strong reference to a presenter object that adopts the JPCardCustomizationPresenter protocol
 */
@property (nonatomic, strong) id<JPCardCustomizationPresenter> _Nonnull presenter;

/**
 * A reference to the JPCardCustomizationView instance which serves as the controller's main view
 */
@property (nonatomic, strong) JPCardCustomizationView *_Nonnull cardCustomizationView;

@end

@interface JPCardCustomizationViewController (TableViewDataSource) <UITableViewDataSource>
@end

@interface JPCardCustomizationViewController (TableViewDelegate) <UITableViewDelegate>
@end

@interface JPCardCustomizationViewController (PatternPickerDelegate) <JPCardCustomizationPatternPickerCellDelegate>
@end

@interface JPCardCustomizationViewController (TextInputDelegate) <JPInputFieldDelegate>
@end

@interface JPCardCustomizationViewController (SubmitDelegate) <JPCardCustomizationSubmitCellDelegate>
@end
