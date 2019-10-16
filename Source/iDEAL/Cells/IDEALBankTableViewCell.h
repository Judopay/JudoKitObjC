//
//  IDEALBankTableViewCell.h
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

@class IDEALBank;

/**
 *  A custom UITableViewCell that is configured to display a specific bank logo based on the
 *  iDEAL bank model provided
 */
@interface IDEALBankTableViewCell : UITableViewCell

/**
 *  Initializes an IDEALBankTableViewCell based on a specified IDEAL bank model;
 *
 *  @param bank -  An IDEALBank object containing the bank title and identifier code
 *
 *  @return a configured instance of the IDEALBankTableViewCell object
 */
+ (instancetype)cellWithBank:(IDEALBank *)bank;

/**
 *  Initializes an IDEALBankTableViewCell based on a specified IDEAL bank model;
 *
 *  @param bank -  An IDEALBank object containing the bank title and identifier code
 *
 *  @return a configured instance of the IDEALBankTableViewCell object
 */
- (instancetype)initWithBank:(IDEALBank *)bank;

@end

