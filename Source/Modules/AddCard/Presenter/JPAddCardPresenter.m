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
#import "NSString+Localize.h"

@interface JPAddCardPresenterImpl ()
@property (nonatomic, strong) JPAddCardViewModel *addCardViewModel;
@end

@implementation JPAddCardPresenterImpl

//------------------------------------------------------------------------------------
# pragma mark - Delegate methods
//------------------------------------------------------------------------------------

- (void)prepareInitialViewModel {
    self.addCardViewModel.shouldDisplayAVSFields = [self.interactor isAVSEnabled];
    self.addCardViewModel.cardNumberViewModel.placeholder = @"card_number".localized;
    self.addCardViewModel.cardholderNameViewModel.placeholder = @"cardholder_name".localized;
    self.addCardViewModel.expiryDateViewModel.placeholder = @"expiry_date".localized;
    self.addCardViewModel.secureCodeViewModel.placeholder = @"secure_code".localized;
    self.addCardViewModel.countryPickerViewModel.placeholder = @"country".localized;
    self.addCardViewModel.countryPickerViewModel.pickerTitles = [self.interactor getSelectableCountryNames];
    self.addCardViewModel.postalCodeInputViewModel.placeholder = @"postal_code".localized;
    self.addCardViewModel.addCardButtonViewModel.title = @"add_card".localized;
    self.addCardViewModel.addCardButtonViewModel.isEnabled = false;
    
    [self.view updateViewWithViewModel:self.addCardViewModel];
}

- (void)handleInputChange:(NSString *)input forType:(JPInputType)type {
    
    switch (type) {
        case JPInputTypeCardNumber:
            [self updateCardNumberViewModelForInput:input];
            break;
        case JPInputTypeCardholderName:
            [self updateCardholderNameViewModelForInput:input];
            break;
        case JPInputTypeCardExpiryDate:
            [self updateExpiryDateViewModelForInput:input];
            break;
        case JPInputTypeCardSecureCode:
            [self updateSecureCodeViewModelForInput:input];
            break;
        case JPInputTypeCardCountry:
            [self updateCountryViewModelForInput:input];
            break;
        case JPInputTypeCardPostalCode:
            [self updatePostalCodeViewModelForInput:input];
            break;
    }
    
    [self.view updateViewWithViewModel:self.addCardViewModel];
}

//------------------------------------------------------------------------------------
# pragma mark - Helper methods
//------------------------------------------------------------------------------------

- (void)updateCardNumberViewModelForInput:(NSString *)input {
    JPValidationResult * result = [self.interactor validateCardNumberInput:input];
    self.addCardViewModel.cardNumberViewModel.errorText = result.errorMessage;
    
    if (result.isInputAllowed) {
        self.addCardViewModel.cardNumberViewModel.text = input;
        return;
    }
}

- (void)updateCardholderNameViewModelForInput:(NSString *)input {
    self.addCardViewModel.cardholderNameViewModel.text = input;
}

- (void)updateExpiryDateViewModelForInput:(NSString *)input {
    self.addCardViewModel.expiryDateViewModel.text = input;
}

- (void)updateSecureCodeViewModelForInput:(NSString *)input {
    self.addCardViewModel.secureCodeViewModel.text = input;
}

- (void)updateCountryViewModelForInput:(NSString *)input {
    self.addCardViewModel.countryPickerViewModel.text = input;
}

- (void)updatePostalCodeViewModelForInput:(NSString *)input {
    self.addCardViewModel.postalCodeInputViewModel.text = input;
}

//------------------------------------------------------------------------------------
# pragma mark - Lazy instantiated properties
//------------------------------------------------------------------------------------

- (JPAddCardViewModel *)addCardViewModel {
    if (!_addCardViewModel) {
        _addCardViewModel = [JPAddCardViewModel new];
        _addCardViewModel.cardNumberViewModel = [JPAddCardInputFieldViewModel new];
        _addCardViewModel.cardholderNameViewModel = [JPAddCardInputFieldViewModel new];
        _addCardViewModel.expiryDateViewModel = [JPAddCardInputFieldViewModel new];
        _addCardViewModel.secureCodeViewModel = [JPAddCardInputFieldViewModel new];
        _addCardViewModel.countryPickerViewModel = [JPAddCardPickerViewModel new];
        _addCardViewModel.postalCodeInputViewModel = [JPAddCardInputFieldViewModel new];
        _addCardViewModel.addCardButtonViewModel = [JPAddCardButtonViewModel new];
    }
    return _addCardViewModel;
}

@end
