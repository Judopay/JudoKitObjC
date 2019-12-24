//
//  JPPaymentMethodsViewController.m
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

#import "JPPaymentMethodsViewController.h"
#import "JPPaymentMethodsView.h"
#import "JPPaymentMethodsViewModel.h"
#import "JPPaymentMethodSelectionCell.h"
#import "JPPaymentMethodsPresenter.h"

@interface JPPaymentMethodsViewController()

@property (nonatomic, strong) JPPaymentMethodsView *paymentMethodsView;
@property (nonatomic, strong) JPPaymentMethodsViewModel *viewModel;

@end

@implementation JPPaymentMethodsViewController

//------------------------------------------------------------------------
#pragma mark - View lifecycle
//------------------------------------------------------------------------

- (void)loadView {
    self.paymentMethodsView = [JPPaymentMethodsView new];
    self.view = self.paymentMethodsView;
    [self configureView];
    [self.presenter prepareInitialViewModel];
}

//------------------------------------------------------------------------
#pragma mark - Layout setup
//------------------------------------------------------------------------

- (void)configureView {
    self.paymentMethodsView.tableView.delegate = self;
    self.paymentMethodsView.tableView.dataSource = self;
}

//------------------------------------------------------------------------
#pragma mark - JPPaymentMethodsView protocol conformance
//------------------------------------------------------------------------

- (void)configureWithViewModel:(JPPaymentMethodsViewModel *)viewModel {
    self.viewModel = viewModel;
    
    for (JPPaymentMethodsModel *item in viewModel.items) {
        [self.paymentMethodsView.tableView registerClass:NSClassFromString(item.identifier)
                                  forCellReuseIdentifier:item.identifier];
    }
    
    [self.paymentMethodsView.tableView reloadData];
}

@end

@implementation JPPaymentMethodsViewController (TableViewDelegates)

//------------------------------------------------------------------------
#pragma mark - UITableView Data Source
//------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JPPaymentMethodsModel *model = self.viewModel.items[indexPath.row];
    JPPaymentMethodsCell *cell = [tableView dequeueReusableCellWithIdentifier:model.identifier
                                                                 forIndexPath:indexPath];
    [cell configureWithViewModel:model];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //TODO: Add the custom header view
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.yellowColor;
    return view;
}

//------------------------------------------------------------------------
#pragma mark - UITableView Delegate
//------------------------------------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 312.0f;
}

@end
