//
//  JPAddCardPresenter.m
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

#import "JPAddCardPresenter.h"
#import "JPAddCardInteractor.h"
#import "JPAddCardRouter.h"
#import "JPAddCardViewController.h"

#import "JPAddress.h"
#import "JPCard.h"
#import "JPCountry.h"

@interface JPAddCardPresenterImpl ()
@property (nonatomic, strong) JPAddCardViewModel *addCardViewModel;
@end

@implementation JPAddCardPresenterImpl

#pragma mark - Delegate methods

- (void)loadInitialView {
    [self updateViewWithViewModel:self.addCardViewModel];
}

- (void)handleChangeInputOfType:(JPCardInputType)type withValue:(NSString *)value {
    [self updateInputViewModelForType:type withText:value andErrorText:nil];
    [self updateViewWithViewModel:self.addCardViewModel];
}

- (void)handleAddCardButtonTap {

    JPCard *card = [self cardFromViewModel:self.addCardViewModel];

    __weak typeof(self) weakSelf = self;
    [self.interactor addCard:card
           completionHandler:^(JPResponse *response, NSError *error) {
               if (error) {
                   [weakSelf.view updateViewWithError:error];
                   return;
               }

               [weakSelf.router dismissViewController];
           }];
}

- (void)didChangeCountryWithName:(NSString *)name {
    self.addCardViewModel.countryPickerViewModel.text = name;
    [self updateViewWithViewModel:self.addCardViewModel];
}

#pragma mark - Internal functionality

- (void)updateViewWithViewModel:(JPAddCardViewModel *)viewModel {

    JPCard *card = [self cardFromViewModel:viewModel];
    BOOL isCardValid = [self.interactor isCardValid:card];

    self.addCardViewModel.addCardButtonViewModel.isEnabled = isCardValid;
    [self.view updateViewWithViewModel:self.addCardViewModel];
}

- (void)updateInputViewModelForType:(JPCardInputType)type
                           withText:(NSString *)text
                       andErrorText:(NSString *)errorText {
    switch (type) {
        case JPCardInputTypeCardNumber:
            self.addCardViewModel.cardNumberViewModel.text = text;
            break;
        case JPCardInputTypeCardholderName:
            self.addCardViewModel.cardholderNameViewModel.text = text;
            break;
        case JPCardInputTypeExpiryDate:
            self.addCardViewModel.expiryDateViewModel.text = text;
            break;
        case JPCardInputTypeLastDigits:
            self.addCardViewModel.lastFourViewModel.text = text;
            break;
        case JPCardInputTypeCountry:
            self.addCardViewModel.countryPickerViewModel.text = text;
            break;
        case JPCardInputTypePostalCode:
            self.addCardViewModel.postalCodeInputViewModel.text = text;
            break;
    }
}

#pragma mark - Lazily instantiated properties

- (JPCard *)cardFromViewModel:(JPAddCardViewModel *)viewModel {
    JPCard *card = [[JPCard alloc] initWithCardNumber:viewModel.cardNumberViewModel.text
                                       cardholderName:viewModel.cardholderNameViewModel.text
                                           expiryDate:viewModel.expiryDateViewModel.text
                                           secureCode:viewModel.lastFourViewModel.text];

    if ([self.interactor isAVSEnabled]) {
        card.cardAddress = [JPAddress new];
        card.cardAddress.billingCountry = viewModel.countryPickerViewModel.text;
        card.cardAddress.postCode = viewModel.postalCodeInputViewModel.text;
    }

    //TODO: Handle Maestro-specific logic
    // card.startDate = viewModel.startDateViewModel.text;
    // card.issueNumber = viewModel.issueNumberViewModel.text;

    return card;
}

- (JPAddCardViewModel *)addCardViewModel {
    if (!_addCardViewModel) {
        _addCardViewModel = [JPAddCardViewModel new];
        _addCardViewModel.cardNumberViewModel = [self inputFieldViewModelWithPlaceholder:@"Card Number"];
        _addCardViewModel.cardholderNameViewModel = [self inputFieldViewModelWithPlaceholder:@"Cardholder Name"];
        _addCardViewModel.expiryDateViewModel = [self inputFieldViewModelWithPlaceholder:@"Expiry Date"];
        _addCardViewModel.lastFourViewModel = [self inputFieldViewModelWithPlaceholder:@"CVV"];
        _addCardViewModel.addCardButtonViewModel = [self buttonViewModelWithTitle:@"ADD CARD"];
        ;

        if ([self.interactor isAVSEnabled]) {
            NSArray *countries = [self.interactor getSelectableCounties];
            NSArray *countryNames = [self countryNamesForCountries:countries];
            _addCardViewModel.countryPickerViewModel = [self pickerViewModelWithPlaceholder:@"Country" pickerTitles:countryNames];
            _addCardViewModel.postalCodeInputViewModel = [self inputFieldViewModelWithPlaceholder:@"Postcode"];
            ;
        }
    }
    return _addCardViewModel;
}

- (JPAddCardInputFieldViewModel *)inputFieldViewModelWithPlaceholder:(NSString *)placeholder {
    JPAddCardInputFieldViewModel *viewModel = [JPAddCardInputFieldViewModel new];
    viewModel.placeholder = placeholder;
    return viewModel;
}

- (JPAddCardButtonViewModel *)buttonViewModelWithTitle:(NSString *)title {
    JPAddCardButtonViewModel *viewModel = [JPAddCardButtonViewModel new];
    viewModel.title = title;
    return viewModel;
}

- (JPAddCardPickerViewModel *)pickerViewModelWithPlaceholder:(NSString *)placeholder
                                                pickerTitles:(NSArray *)pickerTitles {
    JPAddCardPickerViewModel *viewModel = [JPAddCardPickerViewModel new];
    viewModel.placeholder = placeholder;
    viewModel.pickerTitles = pickerTitles;
    return viewModel;
}

- (NSArray *)countryNamesForCountries:(NSArray<JPCountry *> *)countries {
    NSMutableArray *countryNames = [NSMutableArray new];
    for (JPCountry *country in countries) {
        [countryNames addObject:country.name];
    }
    return countryNames;
}

@end
