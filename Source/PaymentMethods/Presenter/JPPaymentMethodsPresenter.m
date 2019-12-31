//
//  JPPaymentMethodsPresenter.m
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

#import "JPPaymentMethodsPresenter.h"
#import "JPPaymentMethodsViewModel.h"
#import "JPPaymentMethodsViewController.h"
#import "JPPaymentMethodsRouter.h"
#import "JPPaymentMethodsInteractor.h"
#import "JPStoredCardDetails.h"
#import "JPCardNetwork.h"

@interface JPPaymentMethodsPresenterImpl()
@property (nonatomic, strong) JPPaymentMethodsViewModel *viewModel;
@property (nonatomic, strong) JPPaymentMethodsSelectionModel *paymentSelectionModel;
@property (nonatomic, strong) JPPaymentMethodsEmptyListModel *emptyListModel;
@property (nonatomic, strong) JPPaymentMethodsCardHeaderModel *cardHeaderModel;
@property (nonatomic, strong) JPPaymentMethodsCardFooterModel *cardFooterModel;
@property (nonatomic, strong) JPPaymentMethodsCardListModel *cardListModel;
@end

@implementation JPPaymentMethodsPresenterImpl

//------------------------------------------------------------------------
#pragma mark - Protocol Methods
//------------------------------------------------------------------------

- (void)prepareInitialViewModel {
    [self updateViewModel];
    [self.view configureWithViewModel:self.viewModel];
}

- (void)viewModelNeedsUpdate {
    [self updateViewModel];
    [self.view configureWithViewModel:self.viewModel];
}

- (void)didSelectCardAtIndex:(NSInteger)index {
    [self.interactor selectCardAtIndex:index];
    [self viewModelNeedsUpdate];
}

- (void)updateViewModel {
    [self.viewModel.items removeAllObjects];
    [self.viewModel.items addObject:self.paymentSelectionModel];
    
    NSArray <JPStoredCardDetails *> *cardDetailsArray = [self.interactor getStoredCardDetails];
    
    if (cardDetailsArray.count == 0) {
        [self.viewModel.items addObject:self.emptyListModel];
    } else {
        [self prepareCardModelsForStoredCardDetails:cardDetailsArray];
        [self.viewModel.items addObject:self.cardHeaderModel];
        [self.viewModel.items addObject:self.cardListModel];
        [self.viewModel.items addObject:self.cardFooterModel];
    }
}

- (void)prepareCardModelsForStoredCardDetails:(NSArray <JPStoredCardDetails *>*)storedCardDetails {
    [self.cardListModel.cardModels removeAllObjects];
    for (JPStoredCardDetails *cardDetails in storedCardDetails) {
        JPPaymentMethodsCardModel *cardModel = [self cardModelFromStoredCardDetails:cardDetails];
        [self.cardListModel.cardModels addObject:cardModel];
    }
}

- (JPPaymentMethodsCardModel *)cardModelFromStoredCardDetails:(JPStoredCardDetails *)cardDetails {
    JPPaymentMethodsCardModel *cardModel = [JPPaymentMethodsCardModel new];
    cardModel.cardTitle = @"Card for shopping";
    cardModel.cardNetwork = cardDetails.cardNetwork;
    cardModel.cardNumberLastFour = cardDetails.cardLastFour;
    cardModel.isDefaultCard = cardDetails.isDefault;
    cardModel.isSelected = cardDetails.isSelected;
    return cardModel;
}

//------------------------------------------------------------------------
#pragma mark - Handlers
//------------------------------------------------------------------------

- (void)handleAddCardButtonTap {
    [self.router navigateToAddCardModule];
}

//------------------------------------------------------------------------
#pragma mark - Lazy instantiated properties
//------------------------------------------------------------------------

- (JPPaymentMethodsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [JPPaymentMethodsViewModel new];
        _viewModel.shouldDisplayHeadline = NO;
        _viewModel.items = [NSMutableArray new];
    }
    return _viewModel;
}

- (JPPaymentMethodsSelectionModel *)paymentSelectionModel {
    if (!_paymentSelectionModel) {
        _paymentSelectionModel = [JPPaymentMethodsSelectionModel new];
        _paymentSelectionModel.identifier = @"JPPaymentMethodSelectionCell";
    }
    return _paymentSelectionModel;
}

- (JPPaymentMethodsEmptyListModel *)emptyListModel {
    if (!_emptyListModel) {
        _emptyListModel = [JPPaymentMethodsEmptyListModel new];
        _emptyListModel.identifier = @"JPPaymentMethodEmptyCardListCell";
        _emptyListModel.title = @"You didn't connect any cards yet";
        _emptyListModel.addCardButtonTitle = @"ADD CARD";
        _emptyListModel.addCardButtonIconName = @"plus-icon";
        
        __weak typeof(self) weakSelf = self;
        _emptyListModel.onAddCardButtonTapHandler = ^{
            [weakSelf handleAddCardButtonTap];
        };
    }
    return _emptyListModel;
}

- (JPPaymentMethodsCardHeaderModel *)cardHeaderModel {
    if (!_cardHeaderModel) {
        _cardHeaderModel = [JPPaymentMethodsCardHeaderModel new];
        _cardHeaderModel.title = @"Connected cards";
        _cardHeaderModel.editButtonTitle = @"EDIT";
        _cardHeaderModel.identifier = @"JPPaymentMethodsCardListHeaderCell";
    }
    return _cardHeaderModel;
}

- (JPPaymentMethodsCardFooterModel *)cardFooterModel {
    if (!_cardFooterModel) {
        _cardFooterModel = [JPPaymentMethodsCardFooterModel new];
        _cardFooterModel.addCardButtonTitle = @"ADD CARD";
        _cardFooterModel.addCardButtonIconName = @"plus-icon";
        _cardFooterModel.identifier = @"JPPaymentMethodsCardListFooterCell";
        
        __weak typeof(self) weakSelf = self;
        _cardFooterModel.onAddCardButtonTapHandler = ^{
            [weakSelf handleAddCardButtonTap];
        };
    }
    return _cardFooterModel;
}

- (JPPaymentMethodsCardListModel *)cardListModel {
    if (!_cardListModel) {
        _cardListModel = [JPPaymentMethodsCardListModel new];
        _cardListModel.cardModels = [NSMutableArray new];
        _cardListModel.identifier = @"JPPaymentMethodsCardCell";
    }
    return _cardListModel;
}

- (JPPaymentMethodsCardModel *)cardModel {
    JPPaymentMethodsCardModel *cardModel = [JPPaymentMethodsCardModel new];
    cardModel.cardTitle = @"Card for online shopping";
    cardModel.cardNumberLastFour = @"1122";
    cardModel.cardNetwork = CardNetworkVisa;
    cardModel.isSelected = NO;
    return cardModel;
}

@end
