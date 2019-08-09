//
//  BillingCountryInputField.m
//  JudoKitObjC
//
//  Copyright (c) 2016 Alternative Payments Ltd
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

#import "BillingCountryInputField.h"
#import "BillingCountry.h"

#import "FloatingTextField.h"

@interface JPInputField ()

- (void)setupView;

@end

@interface BillingCountryInputField () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *countryPicker;
@property (nonatomic, assign) BillingCountry selectedCountry;

@property (nonatomic, strong) NSArray *allCountries;

@end

@implementation BillingCountryInputField

- (void)setupView {
    [super setupView];

    self.countryPicker.delegate = self;
    self.countryPicker.dataSource = self;
    self.textField.placeholder = @" ";
    self.textField.text = @"UK";
    self.textField.inputView = self.countryPicker;

    [self setActive:YES];
}

- (NSString *)titleForBillingCountry:(BillingCountry)country {
    switch (country) {
        case BillingCountryUK:
            return @"UK";
        case BillingCountryCanada:
            return @"Canada";
        case BillingCountryUSA:
            return @"USA";
        default:
            return @"Other";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}

- (BOOL)isValid {
    return YES;
}

#pragma mark - PickerView Delegate & DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.allCountries.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self titleForBillingCountry:[self.allCountries[row] integerValue]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedCountry = [self.allCountries[row] integerValue];
    self.textField.text = [self titleForBillingCountry:self.selectedCountry];
    [self.delegate billingCountryInput:self didSelect:self.selectedCountry];
}

#pragma mark - Getters

- (NSArray *)allCountries {
    if (!_allCountries) {
        _allCountries = @[ @(BillingCountryUK), @(BillingCountryCanada), @(BillingCountryUSA), @(BillingCountryOther) ];
    }
    return _allCountries;
}

- (UIPickerView *)countryPicker {
    if (!_countryPicker) {
        _countryPicker = [UIPickerView new];
    }
    return _countryPicker;
}

@end
