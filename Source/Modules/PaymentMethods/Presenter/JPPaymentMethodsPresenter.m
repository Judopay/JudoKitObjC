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
#import "JPAmount.h"
#import "JPCardNetwork.h"
#import "JPConstants.h"
#import "JPPaymentMethodsInteractor.h"
#import "JPPaymentMethodsRouter.h"
#import "JPPaymentMethodsViewController.h"
#import "JPPaymentMethodsViewModel.h"
#import "JPStoredCardDetails.h"
#import "JPTransactionViewModel.h"
#import "NSError+Additions.h"
#import "NSString+Additions.h"

@interface JPPaymentMethodsPresenterImpl ()
@property (nonatomic, strong) JPPaymentMethodsViewModel *viewModel;
@property (nonatomic, strong) JPPaymentMethodsHeaderModel *headerModel;
@property (nonatomic, strong) JPPaymentMethodsSelectionModel *paymentSelectionModel;
@property (nonatomic, strong) JPPaymentMethodsEmptyListModel *emptyListModel;
@property (nonatomic, strong) JPPaymentMethodsCardHeaderModel *cardHeaderModel;
@property (nonatomic, strong) JPPaymentMethodsCardFooterModel *cardFooterModel;
@property (nonatomic, strong) JPPaymentMethodsCardListModel *cardListModel;
@property (nonatomic, strong) JPTransactionButtonViewModel *paymentButtonModel;
@property (nonatomic, strong) NSDateFormatter *dateFormater;
@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, assign) int previousIndex;
@end

@implementation JPPaymentMethodsPresenterImpl

#pragma mark - Protocol Conformance

- (void)viewModelNeedsUpdate {
    [self updateViewModelWithAnimationType:AnimationTypeSetup];
    [self.view configureWithViewModel:self.viewModel
                  shouldAnimateChange:NO];
}

- (void)viewModelNeedsUpdateWithAnimationType:(AnimationType)animationType
                          shouldAnimateChange:(BOOL)shouldAnimate {

    [self updateViewModelWithAnimationType:animationType];
    [self.view configureWithViewModel:self.viewModel
                  shouldAnimateChange:shouldAnimate];
}

- (void)didSelectCardAtIndex:(NSUInteger)index
               isEditingMode:(BOOL)isEditing {

    if (isEditing) {
        [self.router navigateToCardCustomizationWithIndex:index];
        return;
    }

    [self.interactor selectCardAtIndex:index];

    AnimationType animationType;
    animationType = self.headerModel.cardModel ? AnimationTypeBottomToTop : AnimationTypeSetup;

    [self viewModelNeedsUpdateWithAnimationType:animationType
                            shouldAnimateChange:YES];
}

#pragma mark - Action Handlers

- (void)handleTransactionButtonTap {
    [self.router navigateToTransactionModule];
}

- (void)handleBackButtonTap {
    [self.router dismissViewController];
}

- (void)handlePayButtonTap {
    [self.interactor paymentTransactionWithToken:self.selectedCard.cardToken
                                   andCompletion:^(JPResponse *response, NSError *error) {
                                       [self handleCallbackWithResponse:response
                                                               andError:error];
                                   }];
}

- (void)handleApplePayButtonTap {
    [self.interactor startApplePayWithCompletion:^(JPResponse *response, NSError *error) {
        [self handleCallbackWithResponse:response
                                andError:error];
    }];
}

- (void)handlePaymentResponse:(JPResponse *)response {
    NSInteger selectedCardIndex = [self indexOfSelectedCard];
    if (selectedCardIndex >= 0) {
        [self.interactor setLastUsedCardAtIndex:selectedCardIndex];
    }
    [self.router completeTransactionWithResponse:response andError:nil];
    [self.router dismissViewController];
}

- (void)handlePaymentError:(NSError *)error {

    if (error.code == JudoError3DSRequest) {
        [self handle3DSecureTransactionWithError:error];
        return;
    }

    [self.router completeTransactionWithResponse:nil andError:error];
    [self.view displayAlertWithTitle:@"card_transaction_unsuccesful_error".localized andError:error];
}

- (void)handle3DSecureTransactionWithError:(NSError *)error {
    [self.interactor handle3DSecureTransactionFromError:error
                                             completion:^(JPResponse *response, NSError *error) {
                                                 if (error) {
                                                     [self handlePaymentError:error];
                                                     return;
                                                 }
                                                 [self handlePaymentResponse:response];
                                             }];
}

- (void)deleteCardWithIndex:(NSUInteger)index {
    NSArray *storedCards = [self.interactor getStoredCardDetails];
    JPStoredCardDetails *selectedCard = storedCards[index];

    [self.interactor deleteCardWithIndex:index];
    [self.cardListModel.cardModels removeObjectAtIndex:index];
    self.viewModel.headerModel.cardModel = nil;

    if (selectedCard.isSelected && storedCards.count - 1 > 0) {
        [self.interactor setCardAsSelectedAtInded:0];
    }
    [self viewModelNeedsUpdateWithAnimationType:AnimationTypeBottomToTop
                            shouldAnimateChange:YES];
}

- (void)changeHeaderButtonTitle:(BOOL)isEditing {
    NSString *title = isEditing ? @"done_capitalized" : @"edit_capitalized";
    self.cardHeaderModel.editButtonTitle = title.localized;

    [self viewModelNeedsUpdateWithAnimationType:AnimationTypeNone
                            shouldAnimateChange:NO];
}

- (void)changePaymentMethodToIndex:(int)index {

    if (index == self.previousIndex) {
        return;
    }

    AnimationType animationType = AnimationTypeLeftToRight;

    if (index < self.previousIndex) {
        animationType = AnimationTypeRightToLeft;
    }

    JPPaymentMethod *previousMethod = self.paymentSelectionModel.paymentMethods[self.previousIndex];
    if (previousMethod.type == JPPaymentMethodTypeCard && self.cardListModel.cardModels.count == 0) {
        animationType = AnimationTypeSetup;
    }

    self.previousIndex = index;
    self.paymentSelectionModel.selectedPaymentMethod = index;

    [self viewModelNeedsUpdateWithAnimationType:animationType
                            shouldAnimateChange:YES];
}

- (void)orderCards {
    [self.interactor orderCards];
}

#pragma mark - Helper methods

- (void)handleCallbackWithResponse:(JPResponse *)response
                          andError:(NSError *)error {
    if (error) {
        [self handlePaymentError:error];
        return;
    }
    [self handlePaymentResponse:response];
}

- (void)setLastAddedCardAsSelected {
    NSArray *cards = [self.interactor getStoredCardDetails];
    [self.interactor setCardAsSelectedAtInded:cards.count - 1];
}

- (void)updateViewModelWithAnimationType:(AnimationType)animationType {
    [self.viewModel.items removeAllObjects];

    [self prepareHeaderModel];
    self.viewModel.headerModel.animationType = animationType;
    [self preparePaymentMethodModels];
}

- (void)preparePaymentMethodModels {

    NSArray *paymentMethods = [self.interactor getPaymentMethods];
    self.paymentSelectionModel.paymentMethods = paymentMethods;

    if (paymentMethods.count > 1) {
        [self.viewModel.items addObject:self.paymentSelectionModel];
    }

    int selectedPaymentIndex = self.paymentSelectionModel.selectedPaymentMethod;
    JPPaymentMethod *selectedPaymentMethod = self.paymentSelectionModel.paymentMethods[selectedPaymentIndex];

    self.viewModel.headerModel.paymentMethodType = selectedPaymentMethod.type;
    self.viewModel.headerModel.isApplePaySetUp = [self.interactor isApplePaySetUp];

    if (selectedPaymentMethod.type == JPPaymentMethodTypeCard) {
        [self prepareCardListModels];
    }
}

- (void)prepareCardListModels {
    NSArray<JPStoredCardDetails *> *cardDetailsArray = [self.interactor getStoredCardDetails];

    if (cardDetailsArray.count == 0) {
        [self.viewModel.items addObject:self.emptyListModel];
    } else {
        [self prepareCardModelsForStoredCardDetails:cardDetailsArray];
        [self.viewModel.items addObject:self.cardHeaderModel];
        [self.viewModel.items addObject:self.cardListModel];
        [self.viewModel.items addObject:self.cardFooterModel];
    }
}

- (void)prepareHeaderModel {
    self.headerModel.amount = [self.interactor getAmount];
    self.headerModel.payButtonModel = self.paymentButtonModel;
    self.headerModel.payButtonModel.isEnabled = NO;
    NSArray *storedCardDetails = [self.interactor getStoredCardDetails];

    for (JPStoredCardDetails *cardDetails in storedCardDetails) {
        if (cardDetails.isSelected) {
            self.headerModel.cardModel = [self cardModelFromStoredCardDetails:cardDetails];
            BOOL isCardExpired = self.headerModel.cardModel.cardExpirationStatus != CardExpired;
            self.headerModel.payButtonModel.isEnabled = isCardExpired;
        }
    }

    self.viewModel.headerModel = self.headerModel;
}

- (void)prepareCardModelsForStoredCardDetails:(NSArray<JPStoredCardDetails *> *)storedCardDetails {
    [self.cardListModel.cardModels removeAllObjects];
    for (JPStoredCardDetails *cardDetails in storedCardDetails) {
        JPPaymentMethodsCardModel *cardModel = [self cardModelFromStoredCardDetails:cardDetails];
        [self.cardListModel.cardModels addObject:cardModel];
    }
}

- (JPPaymentMethodsCardModel *)cardModelFromStoredCardDetails:(JPStoredCardDetails *)cardDetails {
    JPPaymentMethodsCardModel *cardModel = [JPPaymentMethodsCardModel new];
    cardModel.cardTitle = cardDetails.cardTitle;
    cardModel.cardNetwork = cardDetails.cardNetwork;
    cardModel.cardNumberLastFour = cardDetails.cardLastFour;
    cardModel.cardExpiryDate = cardDetails.expiryDate;
    cardModel.cardPatternType = cardDetails.patternType;
    cardModel.isDefaultCard = cardDetails.isDefault;
    cardModel.isSelected = cardDetails.isSelected;
    cardModel.cardExpirationStatus = [self determineCardExpirationStatusWithDate:cardDetails.expiryDate];
    return cardModel;
}

- (CardExpirationStatus)determineCardExpirationStatusWithDate:(NSString *)expirationDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *cardExpirationDate = [self.dateFormater dateFromString:expirationDate];
    NSDate *dateInTwoMonths = [calendar dateByAddingUnit:NSCalendarUnitMonth value:2 toDate:self.currentDate options:0];
    if ([cardExpirationDate compare:dateInTwoMonths] == NSOrderedAscending) {
        if ([cardExpirationDate compare:self.currentDate] == NSOrderedAscending) {
            return CardExpired;
        }
        return CardExpiresSoon;
    }
    return CardNotExpired;
}

- (JPStoredCardDetails *)selectedCard {
    for (JPStoredCardDetails *card in [self.interactor getStoredCardDetails]) {
        if (card.isSelected) {
            return card;
        }
    }
    return nil;
}

- (NSInteger)indexOfSelectedCard {
    NSInteger cardIndex = 0;
    for (JPStoredCardDetails *card in [self.interactor getStoredCardDetails]) {
        if (card.isSelected) {
            return cardIndex;
        }
        cardIndex++;
    }
    return -1;
}

#pragma mark - Lazy properties

- (JPPaymentMethodsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [JPPaymentMethodsViewModel new];
        _viewModel.items = [NSMutableArray new];
    }
    return _viewModel;
}

- (JPPaymentMethodsHeaderModel *)headerModel {
    if (!_headerModel) {
        _headerModel = [JPPaymentMethodsHeaderModel new];
        _headerModel.amount = [JPAmount amount:@"0.0" currency:@"GBP"];
    }
    return _headerModel;
}

- (JPPaymentMethodsSelectionModel *)paymentSelectionModel {
    if (!_paymentSelectionModel) {
        _paymentSelectionModel = [JPPaymentMethodsSelectionModel new];
        _paymentSelectionModel.identifier = @"JPPaymentMethodsSelectionCell";
    }
    return _paymentSelectionModel;
}

- (JPPaymentMethodsEmptyListModel *)emptyListModel {
    if (!_emptyListModel) {
        _emptyListModel = [JPPaymentMethodsEmptyListModel new];
        _emptyListModel.identifier = @"JPPaymentMethodsEmptyCardListCell";
        _emptyListModel.title = @"no_connected_cards".localized;
        _emptyListModel.addCardButtonTitle = @"add_card_button".localized;
        _emptyListModel.addCardButtonIconName = @"plus-icon";

        __weak typeof(self) weakSelf = self;
        _emptyListModel.onTransactionButtonTapHandler = ^{
            [weakSelf handleTransactionButtonTap];
        };
    }
    return _emptyListModel;
}

- (JPPaymentMethodsCardHeaderModel *)cardHeaderModel {
    if (!_cardHeaderModel) {
        _cardHeaderModel = [JPPaymentMethodsCardHeaderModel new];
        _cardHeaderModel.title = @"connected_cards".localized;
        _cardHeaderModel.editButtonTitle = @"edit_capitalized".localized;
        _cardHeaderModel.identifier = @"JPPaymentMethodsCardListHeaderCell";
    }
    return _cardHeaderModel;
}

- (JPPaymentMethodsCardFooterModel *)cardFooterModel {
    if (!_cardFooterModel) {
        _cardFooterModel = [JPPaymentMethodsCardFooterModel new];
        _cardFooterModel.addCardButtonTitle = @"add_card_button".localized;
        _cardFooterModel.addCardButtonIconName = @"plus-icon";
        _cardFooterModel.identifier = @"JPPaymentMethodsCardListFooterCell";

        __weak typeof(self) weakSelf = self;
        _cardFooterModel.onTransactionButtonTapHandler = ^{
            [weakSelf handleTransactionButtonTap];
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
    return cardModel;
}

- (JPTransactionButtonViewModel *)paymentButtonModel {
    if (!_paymentButtonModel) {
        _paymentButtonModel = [JPTransactionButtonViewModel new];
        _paymentButtonModel.title = @"pay_now_capitalized".localized;
        _paymentButtonModel.isEnabled = NO;
    }
    return _paymentButtonModel;
}

- (NSDateFormatter *)dateFormater {
    if (!_dateFormater) {
        _dateFormater = [[NSDateFormatter alloc] init];
        [_dateFormater setDateFormat:kMonthYearDateFormat];
    }
    return _dateFormater;
}

- (NSDate *)currentDate {
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}

@end
