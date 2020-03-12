//
//  JP3DSViewController.h
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

#import "JP3DSConfiguration.h"
#import "JPSession.h"
#import "JPTheme.h"
#import "JPTransaction.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface JP3DSViewController : UIViewController <WKNavigationDelegate>

/**
 * A reference to the JPTheme instance responsible for customizing the user interface
 */
@property (nonatomic, strong) JPTheme *_Nullable theme;

/**
 * An instance of JPTransaction that is used to send a 3D Secure transaction to the Judo backend
 */
@property (nonatomic, strong) JPTransaction *_Nonnull transaction;

/**
 * Designated initializer that creates a configured instance of JP3DSViewController based on configuration provided
 *
 * @param configuration - an instance of JP3DSConfiguration that contains the necessary 3D Secure parameters (PaRes, MD, ACS URL, Receipt ID)
 * @param completion - a completion handler with an optional JPResponse / NSError
 */
- (nonnull instancetype)initWithConfiguration:(nonnull JP3DSConfiguration *)configuration
                                   completion:(nullable JudoCompletionBlock)completion;

@end
