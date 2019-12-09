//
//  JPAddCardViewController.m
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

#import "JPAddCardViewController.h"
#import "JPAddCardPresenter.h"
#import "JPAddCardView.h"
#import "LoadingButton.h"
#import "UIViewController+Additions.h"
#import "UIViewController+KeyboardObservers.h"

@interface JPAddCardViewController ()
@property (nonatomic, strong) JPAddCardView *addCardView;
@property (nonatomic, strong) NSArray *countryNames;
@end

@implementation JPAddCardViewController

#pragma mark - View lifecycle

- (void)loadView {
    self.addCardView = [JPAddCardView new];
    [self.presenter loadInitialView];
    self.view = self.addCardView;
    [self addTargets];
    [self addGestureRecognizers];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self registerKeyboardObservers];
    [self.addCardView.cardInputTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self removeKeyboardObservers];
    [self.addCardView endEditing:YES];
    [super viewWillDisappear:animated];
}

#pragma mark - User actions

- (void)onBackgroundViewTap {
    [self.addCardView endEditing:YES];
}

- (void)onCancelButtonTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onScanCardButtonTap {
    //TODO: Implement scan card functionality
}

- (void)onAddCardButtonTap {
    [self.addCardView.addCardButton startLoading];
    [self.addCardView enableUserInterface:NO];
    [self.presenter handleAddCardButtonTap];
}

- (void)onCardNumberValueDidChange {
    [self.presenter handleChangeInputOfType:JPCardInputTypeCardNumber
                                  withValue:self.addCardView.cardInputTextField.text];
}

- (void)onCardholderNameValueDidChange {
    [self.presenter handleChangeInputOfType:JPCardInputTypeCardholderName
                                  withValue:self.addCardView.cardholderNameTextField.text];
}

- (void)onExpiryDateValueDidChange {
    [self.presenter handleChangeInputOfType:JPCardInputTypeExpiryDate
                                  withValue:self.addCardView.expirationDateTextField.text];
}

- (void)onLastDigitsValueDidChange {
    [self.presenter handleChangeInputOfType:JPCardInputTypeLastDigits
                                  withValue:self.addCardView.lastDigitsTextField.text];
}

- (void)onCountryValueDidChangee {
    [self.presenter handleChangeInputOfType:JPCardInputTypeCountry
                                  withValue:self.addCardView.countryTextField.text];
}

- (void)onPostalCodeValueDidChange {
    [self.presenter handleChangeInputOfType:JPCardInputTypePostalCode
                                  withValue:self.addCardView.postcodeTextField.text];
}

#pragma mark - Protocol methods

- (void)updateViewWithViewModel:(JPAddCardViewModel *)viewModel {
    if (viewModel.countryPickerViewModel) {
        self.addCardView.countryPickerView.delegate = self;
        self.addCardView.countryPickerView.dataSource = self;
        self.countryNames = viewModel.countryPickerViewModel.pickerTitles;
    }
    [self.addCardView configureWithViewModel:viewModel];
}

- (void)updateViewWithError:(NSError *)error {
    [self.addCardView enableUserInterface:YES];
    [self.addCardView.addCardButton stopLoading];
    [self displayAlertWithError:error];
}

#pragma mark - Setup

- (void)addTargets {
    [self connectButton:self.addCardView.cancelButton withSelector:@selector(onCancelButtonTap)];
    [self connectButton:self.addCardView.scanCardButton withSelector:@selector(onScanCardButtonTap)];
    [self connectButton:self.addCardView.addCardButton withSelector:@selector(onAddCardButtonTap)];

    [self.addCardView.cardInputTextField addTarget:self
                                            action:@selector(onCardNumberValueDidChange)
                                  forControlEvents:UIControlEventEditingChanged];

    [self.addCardView.cardholderNameTextField addTarget:self
                                                 action:@selector(onCardholderNameValueDidChange)
                                       forControlEvents:UIControlEventEditingChanged];

    [self.addCardView.expirationDateTextField addTarget:self
                                                 action:@selector(onExpiryDateValueDidChange)
                                       forControlEvents:UIControlEventEditingChanged];

    [self.addCardView.lastDigitsTextField addTarget:self
                                             action:@selector(onLastDigitsValueDidChange)
                                   forControlEvents:UIControlEventEditingChanged];

    [self.addCardView.countryTextField addTarget:self
                                          action:@selector(onCountryValueDidChangee)
                                forControlEvents:UIControlEventEditingChanged];

    [self.addCardView.postcodeTextField addTarget:self
                                           action:@selector(onPostalCodeValueDidChange)
                                 forControlEvents:UIControlEventEditingChanged];
}

- (void)addGestureRecognizers {
    [self addTapGestureForView:self.addCardView.backgroundView withSelector:@selector(onBackgroundViewTap)];
}

#pragma mark - Keyboard handling logic

- (void)keyboardWillShow:(NSNotification *)notification {

    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.addCardView.bottomSliderConstraint.constant = -keyboardSize.height;

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    self.addCardView.bottomSliderConstraint.constant = 0;

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];
}

@end

@implementation JPAddCardViewController (CountryPickerDelegate)

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.countryNames.count;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    [self.presenter didChangeCountryWithName:self.countryNames[row]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    return self.countryNames[row];
}

@end
