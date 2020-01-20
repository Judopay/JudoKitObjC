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
#import "Functions.h"
#import "JPPaymentMethodsCardListHeaderCell.h"
#import "JPPaymentMethodsHeaderView.h"
#import "JPPaymentMethodsPresenter.h"
#import "JPPaymentMethodsSelectionCell.h"
#import "JPPaymentMethodsView.h"
#import "JPPaymentMethodsViewModel.h"
#import "UIColor+Judo.h"
#import "UIImage+Icons.h"

@interface JPPaymentMethodsViewController ()

@property (nonatomic, strong) JPPaymentMethodsView *paymentMethodsView;
@property (nonatomic, strong) JPPaymentMethodsViewModel *viewModel;

@end

@implementation JPPaymentMethodsViewController

#pragma mark - View Lifecycle

- (void)loadView {
    self.paymentMethodsView = [JPPaymentMethodsView new];
    self.view = self.paymentMethodsView;
    [self configureView];
    [self.presenter viewModelNeedsUpdate];
}

#pragma mark - Layout Setup

- (void)configureView {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageWithIconName:@"back-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackButtonTap) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backBarButton.customView.heightAnchor constraintEqualToConstant:22.0].active = YES;
    [backBarButton.customView.widthAnchor constraintEqualToConstant:22.0].active = YES;
    self.navigationItem.leftBarButtonItem = backBarButton;

    self.paymentMethodsView.tableView.delegate = self;
    self.paymentMethodsView.tableView.dataSource = self;
}

- (void)onBackButtonTap {
    [self.presenter handleBackButtonTap];
}

#pragma mark - Protocol Conformance

- (void)configureWithViewModel:(JPPaymentMethodsViewModel *)viewModel {
    self.viewModel = viewModel;

    [self.paymentMethodsView.headerView configureWithViewModel:viewModel.headerModel];

    self.paymentMethodsView.judoHeadlineImageView.hidden = !viewModel.shouldDisplayHeadline;
    self.paymentMethodsView.judoHeadlineHeightConstraint.constant = viewModel.shouldDisplayHeadline ? 20.0 : 0.0;

    for (JPPaymentMethodsModel *item in viewModel.items) {
        [self.paymentMethodsView.tableView registerClass:NSClassFromString(item.identifier)
                                  forCellReuseIdentifier:item.identifier];
    }

    [self.paymentMethodsView.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yValue = -scrollView.contentOffset.y;
    CGFloat height = MIN(MAX(yValue, 350 * getWidthAspectRatio()), 400 * getWidthAspectRatio());
    CGRect newFrame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, height);
    self.paymentMethodsView.headerView.frame = newFrame;
}

@end

#pragma mark - UITableViewDataSource

@implementation JPPaymentMethodsViewController (TableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.viewModel.items[section] isKindOfClass:JPPaymentMethodsCardListModel.class]) {
        JPPaymentMethodsCardListModel *cardListModel;
        cardListModel = (JPPaymentMethodsCardListModel *)self.viewModel.items[section];
        return cardListModel.cardModels.count;
    }

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JPPaymentMethodsModel *model = self.viewModel.items[indexPath.section];
    JPPaymentMethodsCell *cell = [tableView dequeueReusableCellWithIdentifier:model.identifier
                                                                 forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([model isKindOfClass:JPPaymentMethodsCardListModel.class]) {
        JPPaymentMethodsCardListModel *cardListModel;
        cardListModel = (JPPaymentMethodsCardListModel *)model;
        [cell configureWithViewModel:(JPPaymentMethodsModel *)cardListModel.cardModels[indexPath.row]];
        return cell;
    }

    [cell configureWithViewModel:model];
    return cell;
}

@end

#pragma mark - UITableViewDelegate

@implementation JPPaymentMethodsViewController (TableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    JPPaymentMethodsModel *model = self.viewModel.items[indexPath.section];

    if (![model isKindOfClass:JPPaymentMethodsCardListModel.class]) {
        return;
    }

    [self.presenter didSelectCardAtIndex:indexPath.row];
}

@end

#pragma mark - JPAddCardViewDelegate

@implementation JPPaymentMethodsViewController (AddCardDelegate)

- (void)didFinishAddingCard {
    [self.presenter viewModelNeedsUpdate];
}

@end
