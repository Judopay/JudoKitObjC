//
//  JPTheme.h
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

@import UIKit;

/**
 *  A class which can be used to easily customize the SDKs view
 */
@interface JPTheme : NSObject

/**
 *  An array of accepted card networks
 */
@property (nonatomic, strong) NSArray<NSNumber *> *_Nonnull acceptedCardNetworks;

/**
 *  A tint color that is used to generate a theme for the judo payment form
 */
@property (nonatomic, strong) UIColor *_Nonnull tintColor;

/**
 *  Set the address verification service to true to prompt the user to input his country and post code information
 */
@property (nonatomic, assign) BOOL avsEnabled;

/**
 *  a boolean indicating whether a security message should be shown below the input
 */
@property (nonatomic, assign) BOOL showSecurityMessage;

#pragma mark - Buttons

/**
 *  the title for the payment button
 */
@property (nonatomic, strong) NSString *_Nonnull paymentButtonTitle;

/**
 *  the title for the button when registering a card
 */
@property (nonatomic, strong) NSString *_Nonnull registerCardButtonTitle;

/**
 *  the title for the back button of the navigation controller
 */
@property (nonatomic, strong) NSString *_Nonnull registerCardNavBarButtonTitle;

/**
 *  the title for the back button
 */
@property (nonatomic, strong) NSString *_Nonnull backButtonTitle;

#pragma mark - Titles

/**
 *  the title for a payment
 */
@property (nonatomic, strong) NSString *_Nonnull paymentTitle;

/**
 *  the title for a card registration
 */
@property (nonatomic, strong) NSString *_Nonnull registerCardTitle;

/**
 *  the title for a check card operation
 */
@property (nonatomic, strong) NSString *_Nonnull checkCardTitle;

/**
 *  the title for a refund
 */
@property (nonatomic, strong) NSString *_Nonnull refundTitle;

/**
 *  the title for the iDEAL transaction
 */
@property (nonatomic, strong) NSString *_Nonnull iDEALTitle;

/**
 *  the title for an authentication
 */
@property (nonatomic, strong) NSString *_Nonnull authenticationTitle;

#pragma mark - Navigation Bar

/**
 * Title of the left navigation bar button
 */
@property (nonatomic, strong) NSString *_Nonnull judoLeftBarButtonTitle;

/**
 * Title of the right navigation bar button
 */
@property (nonatomic, strong) NSString *_Nonnull judoRightBarButtonTitle;

/**
 * Color of the left navigation bar button
 */
@property (nonatomic, strong) UIColor *_Nonnull judoNavigationButtonColor;

/**
 * Color of the right navigation bar button
 */
@property (nonatomic, strong) UIColor *_Nonnull judoNavigationTitleColor;

#pragma mark - Loading

/**
 *  when a register card transaction is currently running
 */
@property (nonatomic, strong) NSString *_Nonnull loadingIndicatorRegisterCardTitle;

/**
 *  the title of the loading indicator during a transaction
 */
@property (nonatomic, strong) NSString *_Nonnull loadingIndicatorProcessingTitle;

/**
 *  the title of the loading indicator during a redirect to a 3DS webview
 */
@property (nonatomic, strong) NSString *_Nonnull redirecting3DSTitle;

/**
 *  the title of the loading indicator during the verification of the transaction
 */
@property (nonatomic, strong) NSString *_Nonnull verifying3DSPaymentTitle;

/**
 *  the title of the loading indicator during the verification of the card registration
 */
@property (nonatomic, strong) NSString *_Nonnull verifying3DSRegisterCardTitle;

/**
 *  the title displayed on the transaction status view indicating a successful iDEAL transaction;
 */
@property (nonatomic, strong) NSString *_Nonnull idealTransactionSuccessTitle;

/**
 *  the title displayed on the transaction status view indicating a pending iDEAL transaction;
 */
@property (nonatomic, strong) NSString *_Nonnull idealTransactionPendingTitle;

/**
 *  the title displayed on the transaction status view indicating a failed iDEAL transaction;
 */
@property (nonatomic, strong) NSString *_Nonnull idealTransactionFailedTitle;

/**
 *  the title of the Retry button present in the iDEAL flow
 */
@property (nonatomic, strong) NSString *_Nonnull judoIDEALRetryButtonTitle;

/**
 *  the title of the Select Bank cell present in the iDEAL flow
 */
@property (nonatomic, strong) NSString *_Nonnull judoSelectBankTitle;

/**
 *  the title of the Selected Bank label present in the iDEAL flow
 */
@property (nonatomic, strong) NSString *_Nonnull judoSelectedBankTitle;

/**
 *  the title of the floating title of the name input field present in the iDEAL flow
 */
@property (nonatomic, strong) NSString *_Nonnull judoIDEALNameInputFloatingTitle;

/**
 *  the placeholder of the name input field
 */
@property (nonatomic, strong) NSString *_Nonnull judoIDEALNameInputPlaceholder;

#pragma mark - Input fields

/**
 *  the height of the input fields
 */
@property (nonatomic, assign) CGFloat inputFieldHeight;

#pragma mark - Security Message

/**
 *  the message that is shown below the input fields the ensure safety when entering card information
 */
@property (nonatomic, strong) NSString *_Nonnull securityMessageString;

/**
 *  the text size of the security message
 */
@property (nonatomic, assign) CGFloat securityMessageTextSize;

#pragma mark - Colors

/**
 *  The default text color
 */
@property (nonatomic, strong) UIColor *_Nonnull judoTextColor;

/**
 *  The default navigation bar title color
 */
@property (nonatomic, strong) UIColor *_Nonnull judoNavigationBarTitleColor;

/**
 *  The color that is used for active input fields
 */
@property (nonatomic, strong) UIColor *_Nonnull judoInputFieldTextColor;

/**
 *  The color that is used for the placeholders of the input fields
 */
@property (nonatomic, strong) UIColor *_Nonnull judoPlaceholderTextColor;

/**
 *  The color that is used for the border color of the input fields
 */
@property (nonatomic, strong) UIColor *_Nonnull judoInputFieldBorderColor;

/**
 *  The background color of the contentView
 */
@property (nonatomic, strong) UIColor *_Nonnull judoContentViewBackgroundColor;

/**
 *  The button color
 */
@property (nonatomic, strong) UIColor *_Nonnull judoButtonColor;

/**
 *  The title color of the button
 */
@property (nonatomic, strong) UIColor *_Nonnull judoButtonTitleColor;

/**
 *  The background color of the loadingView
 */
@property (nonatomic, strong) UIColor *_Nonnull judoLoadingBackgroundColor;

/**
 *  The color that is used when an error occurs during entry
 */
@property (nonatomic, strong) UIColor *_Nonnull judoErrorColor;

/**
 *  The color of the block that is shown when something is loading
 */
@property (nonatomic, strong) UIColor *_Nonnull judoLoadingBlockViewColor;

/**
 *  Input field background color
 */
@property (nonatomic, strong) UIColor *_Nonnull judoInputFieldBackgroundColor;

/**
 *  The color of the activity indicator spinner
 */
@property (nonatomic, strong) UIColor *_Nonnull judoActivityIndicatorColor;

/**
 *  The navigation bar color
 */
@property (nonatomic, strong) UIColor *_Nonnull judoNavigationBarColor;

/**
 *  The type of the activity indicator spinner
 */
@property (nonatomic, assign) UIActivityIndicatorViewStyle judoActivityIndicatorType;

#pragma marks - Payment Methods

/**
 *  Buttons corner radius
 */
@property (nonatomic, assign) CGFloat buttonCornerRadius;

/**
 *  The height of the buttons
 */
@property (nonatomic, assign) CGFloat buttonHeight;

/**
 *  The padding between buttons and left/right edge of the screen
 */
@property (nonatomic, assign) CGFloat buttonsSpacing;

/**
 * The font to be used by buttons
 */
@property (nonatomic, strong) UIFont *_Nonnull buttonFont;

/**
 * The font to be used by text elements
 */
@property (nonatomic, strong) UIFont *_Nonnull judoTextFont;

/**
 * The border width of input fields
 */
@property (nonatomic, assign) CGFloat judoInputFieldBorderWidth;

@end
