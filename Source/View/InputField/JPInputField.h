//
//  JPInputField.h
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

#import "JPTheme.h"
#import "JPTransactionViewModel.h"
#import <UIKit/UIKit.h>

@class JPInputField;

@protocol JPInputFieldDelegate <NSObject>

/**
 * A method which triggers everytime an input change should occur
 *
 * @param inputField - a reference to the current instance of JPInputField
 * @param text - the new input string that should change
 */
- (BOOL)inputField:(JPInputField *)inputField shouldChangeText:(NSString *)text;

@end

@interface JPInputField : UIView

/**
 * An NS_ENUM which describes the type of the input field
 */
@property (nonatomic, assign) JPInputType type;

/**
 * The text of the input field
 */
@property (nonatomic, strong) NSString *text;

/**
 * The color of the input field's text
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 * The font of the input field's text
 */
@property (nonatomic, strong) UIFont *font;

/**
 * A property that sets the color of the placeholder
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 * A property that sets the font of the placeholder
 */
@property (nonatomic, strong) UIFont *placeholderFont;

/**
 * A property that sets the placeholder
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 * The input view of the input field.
 * Defaults to a keyboard, but can be set to any other type of UIView instance.
 */
@property (nonatomic, strong) UIView *inputView;

/**
 * A property which sets the toggles the input field interaction ability
 */
@property (nonatomic, assign) BOOL enabled;

/**
 * A property that changes the keyboard type of the input field
 */
@property (nonatomic, assign) UIKeyboardType keyboardType;

/**
 * A property that changes the keyboard's return type
 */
@property (nonatomic, assign) UIReturnKeyType returnType;

/**
 * A reference to the object that adopts the JPInputFieldDelegate protocol
 */
@property (nonatomic, weak) id<JPInputFieldDelegate> delegate;

/**
 * A method used to apply a theme to the view
 *
 * @param theme - the JPTheme object used to configure the user interface
 */
- (void)applyTheme:(JPTheme *)theme;

/**
 * A method that displays an inline error above the input text.
 */
- (void)displayErrorWithText:(NSString *)text;

/**
 * A method that removes the inline error above the input text
 */
- (void)clearError;

@end

@interface JPInputField (UITextFieldDelegate) <UITextFieldDelegate>
@end
