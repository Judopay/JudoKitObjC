//
//  UIViewController+Additions.h
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
//

#import <UIKit/UIKit.h>

@class JPTheme;

@interface UIViewController (Additions)

/**
 * A method that applies a JPTheme to a specified view
 *
 * @param theme - an instance of a JPTheme object used for theming
 */
- (void)applyTheme:(JPTheme *)theme;

/**
 * Convenience method for connecting a button with a specified selector
 *
 * @param button - the target button
 * @param selector - the selector attributed to the button
 */
- (void)connectButton:(UIButton *)button withSelector:(SEL)selector;

/**
 * Convenience method for adding tap gesture recognizers to views
 *
 * @param view - the target view
 * @param selector - the selector attributed to the tap gesture
 */
- (void)addTapGestureForView:(UIView *)view withSelector:(SEL)selector;

/**
 * Convenience method for displaying alert controllers based on a specified error
 *
 * @param error - an NSError instance describing the current error
 */
- (void)displayAlertWithError:(NSError *)error;

/**
 * Method that triggers haptic feedback based on a specified feedback type
 */
- (void)triggerNotificationFeedbackWithType:(UINotificationFeedbackType)type;

/**
 * Convenience method for displaying alert controllers based on a specified error with an optional title
 *
 * @param title - an optional NSString that defines the title of the alert
 * @param error - an NSError instance describing the current error
 */
- (void)displayAlertWithTitle:(NSString *)title andError:(NSError *)error;

/**
 * A convenience method for quickly registering keyboard observers
 */
- (void)registerKeyboardObservers;

/**
 * A convenience method for quickly removing keyboard observsers
 */
- (void)removeKeyboardObservers;

/**
 * Methods that have to be overriden by the view controller with custom showing behaviour
 */
- (void)keyboardWillShow:(NSNotification *)notification;

/**
 * Methods that have to be overriden by the view controller with custom hiding behaviour
 */
- (void)keyboardWillHide:(NSNotification *)notification;

@end
