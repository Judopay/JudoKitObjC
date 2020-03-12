//
//  JPFloatingTextField.h
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
#import <UIKit/UIKit.h>

@interface JPFloatingTextField : UITextField

/**
 * A property that sets the color of the placeholder
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 * A property that sets the font of the placeholder
 */
@property (nonatomic, strong) UIFont *placeholderFont;

/**
 * A method used to apply a theme to the view
 *
 * @param theme - the JPTheme object used to configure the user interface
 */
- (void)applyTheme:(JPTheme *)theme;

/**
 * A method that displays the floating label above the text field's input text.
 *
 * @param text - the text of the floating label.
 */
- (void)displayFloatingLabelWithText:(NSString *)text;

/**
 * A method which hides the floating label above the text field's input text.
 */
- (void)hideFloatingLabel;

@end
