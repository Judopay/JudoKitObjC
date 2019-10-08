//
//  DetailsTableViewController.m
//  JudoKitObjCExample
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

#import "DetailsTableViewController.h"

@implementation DetailsRow
- (nonnull instancetype)initWithTitle:(nonnull NSString *)title
                                value:(nonnull NSString *)value {
    if (self = [super init]) {
        self.value = value;
        self.title = title;
    }
    return self;
}

+ (nonnull instancetype)withTitle:(nonnull NSString *)title andValue:(nonnull NSString *)value {
    return [[DetailsRow alloc] initWithTitle:title value:value];
}

@end

@implementation DetailsSection
- (nonnull instancetype)initWithTitle:(nonnull NSString *)title
                                 rows:(nonnull NSArray<DetailsRow *> *)rows {
    if (self = [super init]) {
        self.rows = rows;
        self.title = title;
    }
    return self;
}
@end

@interface DetailsTableViewController ()

@end

@implementation DetailsTableViewController

- (instancetype _Nonnull)initWithData:(nonnull NSArray<DetailsSection *> *)data
                             andTitle:(NSString *)title {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.data = data;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.accessibilityIdentifier = self.title;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(dismiss:)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data[section].rows.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.data[section].title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseIdentifier"];
    }
    
    DetailsRow *row = self.data[indexPath.section].rows[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = row.title;
    cell.detailTextLabel.text = row.value;
    cell.detailTextLabel.numberOfLines = 0;
    cell.isAccessibilityElement = YES;
    cell.accessibilityIdentifier = row.title;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
