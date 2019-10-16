//
//  IDEALFormViewController.m
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

#import "IDEALFormViewController.h"
#import "IDEALBankTableViewCell.h"
#import "IDEALBank.h"

@interface IDEALFormViewController ()

@property (nonatomic, strong) IDEALBank *_Nullable selectedBank;
@property (nonatomic, strong) UILabel *nameInputLabel;
@property (nonatomic, strong) UITextField *nameInputTextField;
@property (nonatomic, strong) UILabel *bankSelectionLabel;
@property (nonatomic, strong) UIButton *selectBankButton;
@property (nonatomic, strong) IDEALBankTableViewCell *selectedBankTableViewCell;

@end

@implementation IDEALFormViewController

- (void)viewDidLoad {
        
}

- (void)setupNameInputLabel {
    self.nameInputLabel = [UILabel new];
    self.nameInputLabel.text = @"Name:";
    self.nameInputLabel.textColor = UIColor.blackColor;
    self.nameInputLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold];
    
    [self.nameInputLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)setupNameInputTextField {
    self.nameInputTextField = [UITextField new];
    self.nameInputTextField.borderStyle = UITextBorderStyleLine;
    [self.nameInputTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)setupBankSelectionLabel {
    self.bankSelectionLabel = [UILabel new];
    self.bankSelectionLabel.text = @"Selected Bank:";
    self.bankSelectionLabel.textColor = UIColor.blackColor;
    self.bankSelectionLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold];
    
    [self.bankSelectionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
}

@end
