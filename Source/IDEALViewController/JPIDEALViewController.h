//
//  JPIDEALViewController.h
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

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "JPConfiguration.h"
#import "JPIDEALService.h"
#import "JPTheme.h"
#import "JPTransactionService.h"

@interface JPIDEALViewController : UIViewController

/**
 * A reference to the JPTheme instance responsible for customizing the user interface
 */
@property (nonatomic, strong) JPTheme *_Nullable theme;

/**
 * Initializer that creates a configured instance of JPIDEALViewController
 *
 * @param iDEALBank - the iDEAL bank that is selected to complete the transaction
 * @param configuration - the JPConfiguration that configures the payment flow
 * @param transactionService - the service responsible for Judo backend calls
 * @param completion - the JPResponse / NSError completion block
 */
- (nonnull instancetype)initWithIDEALBank:(nonnull JPIDEALBank *)iDEALBank
                            configuration:(nonnull JPConfiguration *)configuration
                       transactionService:(nonnull JPTransactionService *)transactionService
                        completionHandler:(nullable JudoCompletionBlock)completion;

@end

@interface JPIDEALViewController (WKWebViewDelegate) <WKNavigationDelegate>

@end
