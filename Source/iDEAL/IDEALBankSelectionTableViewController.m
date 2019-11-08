//
//  IDEALBankSelectionTableViewController.m
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

#import "IDEALBankSelectionTableViewController.h"
#import "IDEALBankTableViewCell.h"
#import "IDEALBank.h"

@implementation IDEALBankSelectionTableViewController

NSString * const bankCellIdentifier = @"IDEALBankTableViewCell";

- (NSArray*) bankList {
    return @[
        [IDEALBank bankWithType:IDEALBankRabobank],
        [IDEALBank bankWithType:IDEALBankABN],
        [IDEALBank bankWithType:IDEALBankVanLanschotBankiers],
        [IDEALBank bankWithType:IDEALBankTriodos],
        [IDEALBank bankWithType:IDEALBankING],
        [IDEALBank bankWithType:IDEALBankSNS],
        [IDEALBank bankWithType:IDEALBankASN],
        [IDEALBank bankWithType:IDEALBankRegio],
        [IDEALBank bankWithType:IDEALBankKnab],
        [IDEALBank bankWithType:IDEALBankBunq],
        [IDEALBank bankWithType:IDEALBankMoneyou],
        [IDEALBank bankWithType:IDEALBankHandelsbanken]
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle bundleForClass:IDEALBank.class];
    UINib* nib = [UINib nibWithNibName:bankCellIdentifier bundle: bundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:bankCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bankList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    IDEALBank *bank = self.bankList[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bankCellIdentifier
                                                            forIndexPath:indexPath];
    
    if ([cell isKindOfClass:IDEALBankTableViewCell.class]) {
        [((IDEALBankTableViewCell *)cell) configureWithBank:bank];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IDEALBank *bank = self.bankList[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectBank:)]) {
        [self.delegate didSelectBank:bank];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
