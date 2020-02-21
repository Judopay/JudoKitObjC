//
//  IDEALBankSelectionTableViewController.h
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

@class IDEALBank, IDEALBankSelectionTableViewController;

/**
 * A delegate protocol related to the bank selection logic
 */

@protocol IDEALBankSelectionDelegate <NSObject>

/**
 * A delegate method that is called when a bank from the iDEAL bank list is selected
 *
 * @param controller - the instance of an IDEALBankSelectionTableViewController
 * @param bank - the iDEAL bank model containing the bank title and identifier code
 */
- (void)tableViewController:(nonnull IDEALBankSelectionTableViewController *)controller
              didSelectBank:(nonnull IDEALBank *)bank;

@end

/**
 * A custom implementation of the UITableViewController used for displaying the list of iDEAL banks
 */
@interface IDEALBankSelectionTableViewController : UITableViewController

/**
 * An object conforming to the IDEALBankSelectionDelegate that will capture the bank selection event
 */
@property (nonatomic, weak) id<IDEALBankSelectionDelegate> _Nullable delegate;

@end
