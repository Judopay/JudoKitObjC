//
//  IDEALFormViewController.h
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

#import <UIKit/UIKit.h>

#import "IDEALBankSelectionTableViewController.h"
#import "JPSession.h"

@class JPTheme;

/**
 *  A custom UIViewController used for displaying the iDEAL transaction form.
 */
@interface IDEALFormViewController : UIViewController <IDEALBankSelectionDelegate>

/**
 *  Initializer that displays the iDEAL transaction form
 *
 *  @param theme - An instance of a JPTheme object that defines the style of the form
 *  @param completion -  Completion block called when transaction has been finished
 *
 *  @return an initialized IDEALFormViewController object
 */
- (nonnull instancetype)initWithTheme:(nonnull JPTheme *)theme
                           completion:(nonnull JudoCompletionBlock)completion;

@end
