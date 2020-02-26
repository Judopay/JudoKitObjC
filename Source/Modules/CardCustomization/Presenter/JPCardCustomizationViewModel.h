//
//  JPCardCustomizationViewModel.h
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

#import "JPCardNetwork.h"
#import "JPCardPattern.h"
#import <Foundation/Foundation.h>

@interface JPCardCustomizationViewModel : NSObject
/**
 * A string that identifies the UITableViewCell that this view model applies to.
 * Must match the exact name of the UITableViewCell so that it can be registered correctly.
 */
@property (nonatomic, strong) NSString *_Nonnull identifier;

@end

@interface JPCardCustomizationTitleModel : JPCardCustomizationViewModel

/**
 * The large title of the Card Customization screen
 */
@property (nonatomic, strong) NSString *_Nonnull title;

@end

@interface JPCardCustomizationHeaderModel : JPCardCustomizationViewModel

/**
 * A string that represents the title of the selected card
 */
@property (nonatomic, strong) NSString *_Nonnull cardTitle;

/**
 * A string that represents the last four digits of the card
 */
@property (nonatomic, strong) NSString *_Nonnull cardLastFour;

/**
 * A string that represents thee expiration date of the card
 */
@property (nonatomic, strong) NSString *_Nonnull cardExpiryDate;

/**
 * A value that identifies the card network
 */
@property (nonatomic, assign) CardNetwork cardNetwork;

/**
 * A value for identifying the card's pattern
 */
@property (nonatomic, assign) JPCardPatternType cardPatternType;

@end

@interface JPCardCustomizationPatternModel : NSObject

/**
 * The card pattern that defines the background color and the shapes displayed on a card
 */
@property (nonatomic, strong) JPCardPattern *_Nonnull pattern;

/**
 * A boolean property that describes if the current pattern is selected or not
 */
@property (nonatomic, assign) BOOL isSelected;

@end

@interface JPCardCustomizationPatternPickerModel : JPCardCustomizationViewModel

/**
 * An array of JPCardCustomizationPatternModel objects that define the patterns selection in the Card Customization screen
 */
@property (nonatomic, strong) NSArray<JPCardCustomizationPatternModel *> *_Nonnull patternModels;

@end

@interface JPCardCustomizationTextInputModel : JPCardCustomizationViewModel

/**
 * The text inside the input field representing the card title
 */
@property (nonatomic, strong) NSString *_Nullable text;

@end

@interface JPCardCustomizationIsDefaultModel : JPCardCustomizationViewModel

/**
 * A boolean property that, if set to YES, describes the card as the default one
 */
@property (nonatomic, assign) BOOL isDefault;

@end

@interface JPCardCustomizationSubmitModel : JPCardCustomizationViewModel

/**
 * A boolean property that, if set to YES, enables the Save button on the Card Customization screen
 */
@property (nonatomic, assign) BOOL isSaveEnabled;

@end
