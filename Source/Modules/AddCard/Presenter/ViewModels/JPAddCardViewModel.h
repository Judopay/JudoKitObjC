//
//  JPAddCardViewModel.h
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
#import <Foundation/Foundation.h>

/**
 * An enum that defines the input field types present in the Add Card view
 */
typedef NS_ENUM(NSInteger, JPInputType) {
    JPInputTypeCardNumber,
    JPInputTypeCardholderName,
    JPInputTypeCardExpiryDate,
    JPInputTypeCardSecureCode,
    JPInputTypeCardCountry,
    JPInputTypeCardPostalCode,
};

#pragma mark - JPAddCardInputFieldViewModel

@interface JPAddCardInputFieldViewModel : NSObject
/**
 * The type of the input field
 */
@property (nonatomic, assign) JPInputType type;

/**
 * Designated initializer that is configured based on an input type
 *
 * @param inputType - An instance of JPInputType that is used to define the view model
 */
+ (instancetype _Nonnull)viewModelWithType:(JPInputType)inputType;

/**
 * Designated initializer that is configured based on an input type
 *
 * @param inputType - An instance of JPInputType that is used to define the view model
 */
- (instancetype _Nonnull)initWithType:(JPInputType)inputType;

/**
 * The text string of the input field
 */
@property (nonatomic, strong) NSString *_Nullable text;

/**
 * The placeholder string of the input field
 */
@property (nonatomic, strong) NSString *_Nonnull placeholder;

/**
 * The error string of the input field
 */
@property (nonatomic, strong) NSString *_Nullable errorText;

@end

#pragma mark - JPAddCardNumberInputViewModel

@interface JPAddCardNumberInputViewModel : JPAddCardInputFieldViewModel

/**
 * The detected card network of the view model
 */
@property (nonatomic, assign) CardNetwork cardNetwork;

@end

#pragma mark - JPAddCardButtonViewModel

@interface JPAddCardButtonViewModel : NSObject

/**
 * The title of the button
 */
@property (nonatomic, strong) NSString *_Nullable title;

/**
 * A boolean value that indicates if the button is enabled
 */
@property (nonatomic, assign) BOOL isEnabled;

@end

#pragma mark - JPAddCardPickerViewModel

@interface JPAddCardPickerViewModel : JPAddCardInputFieldViewModel

/**
 * An array of strings that act as picker titles
 */
@property (nonatomic, strong) NSArray *_Nonnull pickerTitles;

@end

#pragma mark - JPAddCardScanButtonViewModel

#pragma mark - JPAddCardViewModel

@interface JPAddCardViewModel : NSObject

/**
 * A boolean parameter that tells the view if AVS fields should be displayed
 */
@property (nonatomic, assign) BOOL shouldDisplayAVSFields;

/**
 * The JPAddCardInputFieldViewModel for the card number input field
 */
@property (nonatomic, strong) JPAddCardNumberInputViewModel *_Nonnull cardNumberViewModel;

/**
 * The JPAddCardInputFieldViewModel for the cardholder name input field
 */
@property (nonatomic, strong) JPAddCardInputFieldViewModel *_Nonnull cardholderNameViewModel;

/**
 * The JPAddCardInputFieldViewModel for the expiry date input field
 */
@property (nonatomic, strong) JPAddCardInputFieldViewModel *_Nonnull expiryDateViewModel;

/**
 * The JPAddCardInputFieldViewModel for the secure code input field
 */
@property (nonatomic, strong) JPAddCardInputFieldViewModel *_Nonnull secureCodeViewModel;

/**
 * The JPAddCardPickerViewModel for the country picker
 */
@property (nonatomic, strong) JPAddCardPickerViewModel *_Nonnull countryPickerViewModel;

/**
 * The JPAddCardInputFieldViewModel for the postal code input field
 */
@property (nonatomic, strong) JPAddCardInputFieldViewModel *_Nonnull postalCodeInputViewModel;

/**
 * The JPAddCardButtonViewModel for the add card button
 */
@property (nonatomic, strong) JPAddCardButtonViewModel *_Nonnull addCardButtonViewModel;

@end
