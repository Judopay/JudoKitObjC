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
#import "NSString+Additions.h"

@interface JPAddCardPresenterImpl ()
@property (nonatomic, strong) JPAddCardViewModel *addCardViewModel;
@property (nonatomic, assign) BOOL isCardNumberValid;
@property (nonatomic, assign) BOOL isCardholderNameValid;
@property (nonatomic, assign) BOOL isExpiryDateValid;
@property (nonatomic, assign) BOOL isSecureCodeValid;
@property (nonatomic, assign) BOOL isCountryValid;
@property (nonatomic, assign) BOOL isPostalCodeValid;
@end

@implementation JPAddCardPresenterImpl

- (instancetype)init {
    if (self = [super init]) {
        self.isCardNumberValid = NO;
        self.isCardholderNameValid = NO;
        self.isExpiryDateValid = NO;
        self.isSecureCodeValid = NO;
        self.isCountryValid = NO;
        self.isPostalCodeValid = NO;
    }
    return self;
}

#pragma mark - Delegate methods

- (void)prepareInitialViewModel {
    self.addCardViewModel.shouldDisplayAVSFields = [self.interactor isAVSEnabled];
    self.addCardViewModel.cardNumberViewModel.placeholder = @"card_number".localized;
    self.addCardViewModel.cardholderNameViewModel.placeholder = @"cardholder_name".localized;
    self.addCardViewModel.expiryDateViewModel.placeholder = @"expiry_date".localized;
    self.addCardViewModel.secureCodeViewModel.placeholder = @"secure_code".localized;
    self.addCardViewModel.countryPickerViewModel.placeholder = @"country".localized;
    self.addCardViewModel.countryPickerViewModel.pickerTitles = [self.interactor getSelectableCountryNames];
    self.addCardViewModel.postalCodeInputViewModel.placeholder = @"postal_code".localized;
    self.addCardViewModel.addCardButtonViewModel.title = @"add_card_button".localized;
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
            [self updatePostalCodeViewModelForInput:@""];
            break;
        case JPInputTypeCardPostalCode:
            [self updatePostalCodeViewModelForInput:input];
            break;
    }

    [self updateAddCardButtonModelIfNeeded];
    [self.view updateViewWithViewModel:self.addCardViewModel];
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

               [weakSelf.interactor updateKeychainWithCardModel:weakSelf.addCardViewModel];
               [weakSelf.router dismissViewController];
               [weakSelf.view didFinishAddingCard];
           }];
}

- (void)handleScanCardButtonTap {
#if TARGET_OS_SIMULATOR
    [self.view displayCameraSimulatorAlert];
#else
    [self.interactor handleCameraPermissionsWithCompletion:^(AVAuthorizationStatus authorizationStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (authorizationStatus) {
                case AVAuthorizationStatusDenied:
                    [self.view displayCameraPermissionsAlert];
                    break;

                case AVAuthorizationStatusAuthorized:
                    [self.router navigateToScanCamera];
                    break;

                default:
                    [self.view displayCameraRestrictionAlert];
            }
        });
    }];
#endif
}

- (void)updateViewModelWithScanCardResult:(PayCardsRecognizerResult *)result {

    if (result.recognizedNumber != nil) {
        [self updateCardNumberViewModelForInput:result.recognizedNumber];
    }

    if (result.recognizedHolderName != nil) {
        [self updateCardholderNameViewModelForInput:result.recognizedHolderName];
    }

    if (result.recognizedExpireDateMonth != nil && result.recognizedExpireDateYear != nil) {
        [self updateExpiryDateViewModelForInput:[NSString stringWithFormat:@"%@/%@",
                                                                           result.recognizedExpireDateMonth,
                                                                           result.recognizedExpireDateYear]];
    }

    [self updateAddCardButtonModelIfNeeded];
    [self.view updateViewWithViewModel:self.addCardViewModel];
}

#pragma mark - Helper methods

- (void)updateAddCardButtonModelIfNeeded {

    BOOL firstCheck = self.isCardNumberValid && self.isCardholderNameValid;
    BOOL secondCheck = self.isExpiryDateValid && self.isSecureCodeValid;
    BOOL thirdCheck = self.isCountryValid && self.isPostalCodeValid;

    BOOL isCardValid = firstCheck && secondCheck;

    if ([self.interactor isAVSEnabled]) {
        isCardValid = isCardValid && thirdCheck;
    }

    self.addCardViewModel.addCardButtonViewModel.isEnabled = isCardValid;
}

- (void)updateCardNumberViewModelForInput:(NSString *)input {
    JPValidationResult *result = [self.interactor validateCardNumberInput:input];
    self.addCardViewModel.cardNumberViewModel.errorText = result.errorMessage;
    self.isCardNumberValid = result.isValid;

    if (result.isInputAllowed) {
        self.addCardViewModel.cardNumberViewModel.text = result.formattedInput;
        self.addCardViewModel.cardNumberViewModel.cardNetwork = result.cardNetwork;
        return;
    }
}

- (void)updateCardholderNameViewModelForInput:(NSString *)input {
    JPValidationResult *result = [self.interactor validateCardholderNameInput:input];
    self.addCardViewModel.cardholderNameViewModel.errorText = result.errorMessage;
    self.isCardholderNameValid = result.isValid;

    if (result.isInputAllowed) {
        self.addCardViewModel.cardholderNameViewModel.text = result.formattedInput;
        return;
    }
}

- (void)updateExpiryDateViewModelForInput:(NSString *)input {
    JPValidationResult *result = [self.interactor validateExpiryDateInput:input];
    self.addCardViewModel.expiryDateViewModel.errorText = result.errorMessage;
    self.isExpiryDateValid = result.isValid;

    if (result.isInputAllowed) {
        self.addCardViewModel.expiryDateViewModel.text = result.formattedInput;
        return;
    }
}

- (void)updateSecureCodeViewModelForInput:(NSString *)input {
    JPValidationResult *result = [self.interactor validateSecureCodeInput:input];
    self.addCardViewModel.secureCodeViewModel.errorText = result.errorMessage;
    self.isSecureCodeValid = result.isValid;

    if (result.isInputAllowed) {
        self.addCardViewModel.secureCodeViewModel.text = result.formattedInput;
        return;
    }
}

- (void)updateCountryViewModelForInput:(NSString *)input {
    JPValidationResult *result = [self.interactor validateCountryInput:input];
    self.addCardViewModel.countryPickerViewModel.errorText = result.errorMessage;
    self.isCountryValid = result.isValid;

    if (result.isInputAllowed) {
        self.addCardViewModel.countryPickerViewModel.text = result.formattedInput;
        return;
    }
}

- (void)updatePostalCodeViewModelForInput:(NSString *)input {
    JPValidationResult *result = [self.interactor validatePostalCodeInput:input];
    self.addCardViewModel.postalCodeInputViewModel.errorText = result.errorMessage;
    self.isPostalCodeValid = result.isValid;

    if (result.isInputAllowed) {
        self.addCardViewModel.postalCodeInputViewModel.text = result.formattedInput;
        return;
    }
}

- (JPCard *)cardFromViewModel:(JPAddCardViewModel *)viewModel {
    JPCard *card = [[JPCard alloc] initWithCardNumber:viewModel.cardNumberViewModel.text
                                       cardholderName:viewModel.cardholderNameViewModel.text
                                           expiryDate:viewModel.expiryDateViewModel.text
                                           secureCode:viewModel.secureCodeViewModel.text];

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

#pragma mark - Lazy instantiated properties

- (JPAddCardViewModel *)addCardViewModel {
    if (!_addCardViewModel) {
        _addCardViewModel = [JPAddCardViewModel new];
        _addCardViewModel.cardNumberViewModel = [JPAddCardNumberInputViewModel new];
        _addCardViewModel.cardholderNameViewModel = [JPAddCardInputFieldViewModel viewModelWithType:JPInputTypeCardholderName];
        _addCardViewModel.expiryDateViewModel = [JPAddCardInputFieldViewModel viewModelWithType:JPInputTypeCardExpiryDate];
        _addCardViewModel.secureCodeViewModel = [JPAddCardInputFieldViewModel viewModelWithType:JPInputTypeCardSecureCode];
        _addCardViewModel.countryPickerViewModel = [JPAddCardPickerViewModel new];
        _addCardViewModel.postalCodeInputViewModel = [JPAddCardInputFieldViewModel viewModelWithType:JPInputTypeCardPostalCode];
        _addCardViewModel.addCardButtonViewModel = [JPAddCardButtonViewModel new];
    }
    return _addCardViewModel;
}

@end
