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
#import "JPTransactionButton.h"
#import "NSString+Additions.h"
#import "UIColor+Additions.h"
#import "UIImage+Additions.h"
#import "UIViewController+Additions.h"

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
}

- (void)viewWillAppear:(BOOL)animated {
    [self.presenter viewModelNeedsUpdate];
    [super viewWillAppear:animated];
}

#pragma mark - User Actions

- (void)onBackButtonTap {
    [self.presenter handleBackButtonTap];
}

- (void)onPayButtonTap {
    [self.paymentMethodsView.headerView.payButton startLoading];
    self.paymentMethodsView.userInteractionEnabled = NO;
    [self.presenter handlePayButtonTap];
}

- (void)onApplePayButtonTap {
    [self.presenter handleApplePayButtonTap];
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

- (void)configureTargets {
    [self.paymentMethodsView.headerView.payButton addTarget:self
                                                     action:@selector(onPayButtonTap)
                                           forControlEvents:UIControlEventTouchUpInside];

    [self.paymentMethodsView.headerView.applePayButton addTarget:self
                                                          action:@selector(onApplePayButtonTap)
                                                forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Protocol Conformance

- (void)configureWithViewModel:(JPPaymentMethodsViewModel *)viewModel {
    self.viewModel = viewModel;

    [self.paymentMethodsView.headerView configureWithViewModel:viewModel.headerModel];

    for (JPPaymentMethodsModel *item in viewModel.items) {
        [self.paymentMethodsView.tableView registerClass:NSClassFromString(item.identifier)
                                  forCellReuseIdentifier:item.identifier];
    }

    [self handlePaymentMethodChangeBehaviorForViewModel:viewModel];
    [self configureTargets];
}

- (void)handlePaymentMethodChangeBehaviorForViewModel:(JPPaymentMethodsViewModel *)viewModel {
    [self.paymentMethodsView.tableView beginUpdates];

    NSRange oldRange = NSMakeRange(1, self.paymentMethodsView.tableView.numberOfSections - 1);
    NSIndexSet *oldIndexSet = [NSIndexSet indexSetWithIndexesInRange:oldRange];

    NSRange newRange = NSMakeRange(1, viewModel.items.count - 1);
    NSIndexSet *newIndexSet = [NSIndexSet indexSetWithIndexesInRange:newRange];

    UITableViewRowAnimation fadeAnimation = UITableViewRowAnimationFade;
    [self.paymentMethodsView.tableView deleteSections:oldIndexSet withRowAnimation:fadeAnimation];
    [self.paymentMethodsView.tableView insertSections:newIndexSet withRowAnimation:fadeAnimation];

    [self.paymentMethodsView.tableView endUpdates];
}

- (void)displayAlertWithTitle:(NSString *)title andError:(NSError *)error {
    [self.paymentMethodsView.headerView.payButton stopLoading];
    self.paymentMethodsView.userInteractionEnabled = YES;
    [self triggerNotificationFeedbackWithType:UINotificationFeedbackTypeError];
    [super displayAlertWithTitle:title andError:error];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yValue = -scrollView.contentOffset.y;
    CGFloat height = MIN(MAX(yValue, 370 * getWidthAspectRatio()), 418 * getWidthAspectRatio());
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

    if ([model isKindOfClass:JPPaymentMethodsCardHeaderModel.class]) {
        JPPaymentMethodsCardListHeaderCell *headerCell = (JPPaymentMethodsCardListHeaderCell *)cell;
        headerCell.delegate = self;
    }

    if ([model isKindOfClass:JPPaymentMethodsSelectionModel.class]) {
        JPPaymentMethodsSelectionCell *selectionCell = (JPPaymentMethodsSelectionCell *)cell;
        selectionCell.sectionView.delegate = self;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    JPPaymentMethodsModel *model = self.viewModel.items[indexPath.section];
    return [model isKindOfClass:JPPaymentMethodsCardListModel.class];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"delete_card_alert_title".localized
                                                                             message:@"delete_card_alert_message".localized
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel".localized
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];

    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"delete".localized
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *_Nonnull action) {
                                                             [self.presenter deleteCardWithIndex:indexPath.row];
                                                             [self.presenter viewModelNeedsUpdate];
                                                         }];

    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

#pragma mark - JPTransactionViewDelegate

@implementation JPPaymentMethodsViewController (TransactionDelegate)

- (void)didFinishAddingCard {
    [self.presenter setLastAddedCardAsSelected];
    [self.presenter viewModelNeedsUpdate];
    [self.paymentMethodsView.tableView setEditing:NO animated:YES];
    [self.presenter changeHeaderButtonTitle:self.paymentMethodsView.tableView.isEditing];
}

@end

@implementation JPPaymentMethodsViewController (EditCardsDelegate)

- (void)didTapActionButton {
    BOOL isEditing = self.paymentMethodsView.tableView.isEditing == YES;
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [self.presenter changeHeaderButtonTitle:!isEditing];
    }];
    [self.paymentMethodsView.tableView setEditing:!isEditing animated:YES];
    [CATransaction commit];
}

@end

@implementation JPPaymentMethodsViewController (JPSectionViewDelegate)

- (void)sectionView:(JPSectionView *)sectionView didSelectSectionAtIndex:(int)index {
    [self.presenter changePaymentMethodToIndex:index];
}

@end
