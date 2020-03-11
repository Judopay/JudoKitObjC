//
//  JPTransactionRouter.h
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

#import "JPTheme.h"
#import <Foundation/Foundation.h>
#import <PayCardsRecognizer/PayCardsRecognizer.h>

@class JPTransactionViewController;
@protocol JPTransactionPresenter;

@protocol JPTransactionRouter

/**
 * A method that, when called, will dismiss the Add Card view controller
 */
- (void)dismissViewController;

/**
 * A method that starts the scan camera flow and returns a completion result
 */
- (void)navigateToScanCamera;

@end

@interface JPTransactionRouterImpl : NSObject <JPTransactionRouter>

/**
 * A reference to the JPTheme instance responsible for customizing the user interface
 */
@property (nonatomic, strong) JPTheme *_Nullable theme;

/**
 * A weak reference to the JPTransactionViewController instance
 */
@property (nonatomic, weak) JPTransactionViewController *_Nullable viewController;

/**
 * A weak reference to a JPTransactionPresenter-conforming instance
 */
@property (nonatomic, weak) id<JPTransactionPresenter> _Nullable presenter;

@end

/**
 * An extension for handling the pay card recognizer delegate
 */
@interface JPTransactionRouterImpl (RecognizerDelegate) <PayCardsRecognizerPlatformDelegate>
@end
