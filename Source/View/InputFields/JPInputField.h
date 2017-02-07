//
//  JPInputField.h
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

#import <UIKit/UIKit.h>
#import "JPCardDetails.h"
#import "BillingCountry.h"

@class JPTheme;

@class FloatingTextField, CardLogoView;

@class IssueNumberInputField, CardInputField, DateInputField, BillingCountryInputField, PostCodeInputField, JPInputField;

/**
 *  The JudoPayInputDelegate is a delegate protocol that is used to pass information about the state of entering information for making transactions
 */
@protocol JudoPayInputDelegate <NSObject>

/**
 *  Delegate method that is triggered when the CardInputField encountered an error
 *
 *  @param input The input field calling the delegate method
 *  @param error The error that occured
 */
- (void)cardInput:(CardInputField *)input didFailWithError:(NSError *)error;

/**
 *  Delegate method that is triggered when the CardInputField did find a valid number
 *
 *  @param input            The input field calling the delegate method
 *  @param cardNumberString The card number that has been entered as a String
 */
- (void)cardInput:(CardInputField *)input didFindValidNumber:(NSString *)cardNumberString;

/**
 *  Delegate method that is triggered when the CardInputField detected a network
 *
 *  @param input   The input field calling the delegate method
 *  @param network The network that has been identified
 */
- (void)cardInput:(CardInputField *)input didDetectNetwork:(CardNetwork)network;

/**
 *  Delegate method that is triggered when the date input field has encountered an error
 *
 *  @param input The input field calling the delegate method
 *  @param error The error that occured
 */
- (void)dateInput:(DateInputField *)input didFailWithError:(NSError *)error;

/**
 *  Delegate method that is triggered when the date input field has found a valid date
 *
 *  @param input The input field calling the delegate method
 *  @param date  The valid date that has been entered
 */
- (void)dateInput:(DateInputField *)input didFindValidDate:(NSString *)date;

/**
 *  Delegate method that is triggered when the issueNumberInputField entered a code
 *
 *  @param input       The issueNumberInputField calling the delegate method
 *  @param issueNumber The issue number that has been entered as a String
 */
- (void)issueNumberInputDidEnterCode:(IssueNumberInputField *)input withIssueNumber:(NSString *)issueNumber;

/**
 *  Delegate method that is triggered when the billingCountry input field selected a BillingCountry
 *
 *  @param input          The input field calling the delegate method
 *  @param billingCountry The billing country that has been selected
 */
- (void)billingCountryInput:(BillingCountryInputField *)input didSelect:(BillingCountry)billingCountry;

/**
 *  Delegate method that is triggered when the post code input field has received an invalid entry
 *
 *  @param input The input field calling the delegate method
 *  @param error The error that occured
 */
- (void)postCodeInputField:(PostCodeInputField *)input didFailWithError:(NSError *)error;

/**
 *  Delegate method that is triggered when the judoPayInputField was validated
 *
 *  @param input The input field calling the delegate method
 *  @param valid A boolean that indicates whether the input is valid or invalid
 */
- (void)judoPayInput:(JPInputField *)input didValidate:(BOOL)valid;

/**
 *  Delegate method that is called whenever any inputField has been manipulated
 *
 *  @param input The input field calling the delegate method
 */
- (void)judoPayInputDidChangeText:(JPInputField *)input;

@end

/**
 *   The JudoPayInputField is a UIView subclass that is used to help to validate and visualize common information related to payments. This class delivers the common ground for the UI and UX. Text fields can either be used in a side-by-side motion (title on the left and input text field on the right) or with a floating title that floats to the top as soon as a user starts entering their details.
 
 It is not recommended to use this class directly but rather use the subclasses of JudoPayInputField that are also provided in judoKit as this class does not do any validation which are necessary for making any kind of transaction.

 */
@interface JPInputField : UIView <UITextFieldDelegate>

/**
 *  The textfield inside the input view
 */
@property (nonatomic, strong) FloatingTextField *textField;

/**
 *  The current theme
 */
@property (nonatomic, strong) JPTheme *theme;

/**
 *  The delegate for the input field validation methods
 */
@property (nonatomic, weak) id<JudoPayInputDelegate> delegate;

/**
 *  The attributed placeholder string for the current input field
 */
@property (nonatomic, strong, readonly) NSAttributedString *placeholder;

/**
 *  Boolean indicating whether the receiver has to show a logo
 */
@property (nonatomic, assign, readonly) BOOL containsLogo;

/**
 *  If the receiving input field contains a logo, this method returns Some
 */
@property (nonatomic, strong, readonly) CardLogoView *logoView;

/**
 *  Title of the receiver input field
 */
@property (nonatomic, strong, readonly) NSString *title;

/**
 *  Width of the title
 */
@property (nonatomic, assign, readonly) CGFloat titleWidth;

/**
 *  Hint label text
 */
@property (nonatomic, strong, readonly) NSString *hintLabelText;

/**
 *  Checks if the receiving input field has content that is valid
 */
@property (nonatomic, assign, readonly) BOOL isValid;


/**
 *  Designated Initializer for the JPInputField and its subclasses
 *
 *  @param theme the current theme
 *
 *  @return a JPInputField instance
 */
- (instancetype)initWithTheme:(JPTheme *)theme;

/**
 *  Helper method that will wiggle the input field and show a red line at the bottom in which is was executed
 *
 *  @param showRedBlock Boolean stating whether to show a red line at the bottom or not
 */
- (void)errorAnimation:(BOOL)showRedBlock;

/**
 *  In the case of an updated card logo, this method animates the change
 */
- (void)updateCardLogo;

/**
 *  Method that dismisses the error generated in the `errorAnmiation:` method
 */
- (void)dismissError;

/**
 *  Set current object as active text field visually
 *
 *  @param isActive Boolean stating whether textfield has become active or inactive
 */
- (void)setActive:(BOOL)isActive;

/**
 *  Helper call for delegate method
 */
- (void)didChangeInputText;

/**
 *  method that is called when text field content was changed
 *
 *  @param textField the textfield of which the content has changed
 */
- (void)textFieldDidChangeValue:(UITextField *)textField;
  
/**
 *  method to display a label hint
 *
 *  @param message the message to display
 */
- (void)displayHint:(NSString *)message;

/**
 *  method to display a label error
 *
 *  @param message the message to display
 */
- (void)displayError:(NSString *)message;
    
@end
