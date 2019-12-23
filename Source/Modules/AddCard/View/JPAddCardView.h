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
@class LoadingButton, JPTextField, JPCardNumberField, JPCardInputField, JPAddCardButton;

@interface JPAddCardView : UIView

/**
 * The dimmed, semi-transparent background view that fades in when the add card slider appears
 */
@property (nonatomic, strong) UIView *backgroundView;

/**
 * The cancel button that, when pressed, dismisses the Add Card view controller
 */
@property (nonatomic, strong) UIButton *cancelButton;

/**
 * A button that, when pressed, invokes the card scanning functionality
 */
@property (nonatomic, strong) UIButton *scanCardButton;

/**
 * The input field for adding the card number
 */
@property (nonatomic, strong) JPCardNumberField *cardNumberTextField;

/**
 * The input field for adding the cardholder name
 */
@property (nonatomic, strong) JPCardInputField *cardHolderTextField;

/**
 * The input field for adding the card expiration date
 */
@property (nonatomic, strong) JPCardInputField *cardExpiryTextField;

/**
 * The input field for adding the card secure code
 */
@property (nonatomic, strong) JPCardInputField *secureCodeTextField;

/**
 * The input field for selecting the country
 */
@property (nonatomic, strong) JPCardInputField *countryTextField;

/**
 * The picker view associated to the country input field;
 */
@property (nonatomic, strong) UIPickerView *countryPickerView;

/**
 * The input field for adding the postal code
 */
@property (nonatomic, strong) JPCardInputField *postcodeTextField;

/**
 * The Add Card button that, when tapped, displays a loading spinner
 */
@property (nonatomic, strong) JPAddCardButton *addCardButton;

/**
 * The Add Card view's bottom constraint that is used to move the view when the keyboard animates
 */
@property (nonatomic, strong) NSLayoutConstraint *bottomSliderConstraint;

/**
 * A method that configures the view based on a view model
 *
 * @param viewModel - an instance of JPAddCardViewModel used for view customization
 */
- (void)configureWithViewModel:(JPAddCardViewModel *)viewModel;

/**
 * A method that specifies if the user inteface should be enabled
 *
 * @param shouldEnable - set to YES if the interface is enabled and no if otherwise
 */
- (void)enableUserInterface:(BOOL)shouldEnable;

@end
