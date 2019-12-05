//
//  JPAddCardView.h
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

#import <UIKit/UIKit.h>

@class JPAddCardViewModel;
@class LoadingButton;

@interface JPAddCardView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *scanCardButton;
@property (nonatomic, strong) UITextField *cardInputTextField;
@property (nonatomic, strong) UITextField *cardholderNameTextField;
@property (nonatomic, strong) UITextField *expirationDateTextField;
@property (nonatomic, strong) UITextField *lastDigitsTextField;
@property (nonatomic, strong) UITextField *countryTextField;
@property (nonatomic, strong) UITextField *postcodeTextField;
@property (nonatomic, strong) LoadingButton *addCardButton;
@property (nonatomic, strong) NSLayoutConstraint *bottomSliderConstraint;

- (void)configureWithViewModel:(JPAddCardViewModel *)viewModel;
- (void)enableUserInterface:(BOOL)shouldEnable;
@end
