//
//  IDEALBankTableViewCell.m
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

#import "IDEALBank.h"
#import "IDEALBankTableViewCell.h"
#import "NSString+Localize.h"

@interface IDEALBankTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bankLogoImageView;

@end

@implementation IDEALBankTableViewCell

- (void)configureWithBank:(IDEALBank *)bank {
    
    NSBundle *bundle = [NSBundle bundleForClass:IDEALBankTableViewCell.class];
    
    NSString *iconBundlePath = [bundle pathForResource:@"icons" ofType:@"bundle"];
    NSBundle *iconBundle = [NSBundle bundleWithPath:iconBundlePath];
    
    NSString *iconName = [NSString stringWithFormat:@"logo-%@", bank.bankIdentifierCode];
    NSString *iconFilePath = [iconBundle pathForResource:iconName ofType:@"png"];
    
    self.bankLogoImageView.image =[UIImage imageWithContentsOfFile:iconFilePath];
    self.bankLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.bankLogoImageView.isAccessibilityElement = YES;
    self.bankLogoImageView.accessibilityLabel = bank.title;
    self.bankLogoImageView.accessibilityHint = [NSString stringWithFormat:@"select_bank".localized, bank.title];
}

@end
