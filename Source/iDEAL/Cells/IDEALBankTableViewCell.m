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

#import "IDEALBankTableViewCell.h"
#import "IDEALBank.h"

@implementation IDEALBankTableViewCell

#pragma mark - Initializers

- (instancetype)initWithBank:(IDEALBank *)bank {
    
    if (self = [super initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:[NSString string]]) {
        
        [self setupLogoImageViewForBank: bank];
    }
    return self;
}

+ (instancetype)cellWithBank:(IDEALBank *)bank {
    return [[IDEALBankTableViewCell alloc] initWithBank:bank];
}

#pragma mark - Layout setup

- (void)setupLogoImageViewForBank:(IDEALBank *)bank {
    
    NSString *iconName = [NSString stringWithFormat:@"logo-%@", bank.bankIdentifierCode];
    UIImage *logoImage = [UIImage imageNamed:iconName];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:logoImage];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:imageView];
    [self setupConstraintsFor:imageView];
}

- (void)setupConstraintsFor:(UIView *)view {
    
    NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|"
                                                                   options: 0
                                                                   metrics:nil
                                                                     views:@{@"view": view}];
    
    NSArray *vConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[view]-15-|"
                                                                   options: 0
                                                                   metrics:nil
                                                                     views:@{@"view": view}];
    
    [NSLayoutConstraint activateConstraints:hConstraint];
    [NSLayoutConstraint activateConstraints:vConstraint];
}

@end
