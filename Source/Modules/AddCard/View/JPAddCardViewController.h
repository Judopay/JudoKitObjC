//
//  JPAddCardViewController.h
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

#import "JPAddCardViewModel.h"
#import "JPTextField.h"
#import <UIKit/UIKit.h>

@protocol JPAddCardPresenter;

#pragma mark - JPAddCardViewDelegate

@protocol JPAddCardViewDelegate
/**
 * A method that is called once the Add Card flow completes
 */
- (void)didFinishAddingCard;

@end

#pragma mark - JPAddCardView

@protocol JPAddCardView

/**
 * A method that updates the view based on the provided view model
 */
- (void)updateViewWithViewModel:(JPAddCardViewModel *)viewModel;

/**
 * A method that updates the view with an error
 */
- (void)updateViewWithError:(NSError *)error;

/**
 * A method that signals that the Add Card flow is completed and the view should dismiss
 */
- (void)didFinishAddingCard;

/**
 * A method that triggers an UIAlertViewController with the option of navigating to Settings
 */
- (void)displayCameraPermissionsAlert;

/**
 * A method that triggers an UIAlertViewController with the restricted camera message
 */
- (void)displayCameraRestrictionAlert;

/**
 * A method that triggers an UIAlertViewController with the camera denied message due to simulator usage
 */
- (void)displayCameraSimulatorAlert;

@end

#pragma mark - JPAddCardViewController

@interface JPAddCardViewController : UIViewController <JPAddCardView>

/**
 * An object conforming to the JPAddCardViewDelegate protocol
 */
@property (nonatomic, strong) id<JPAddCardViewDelegate> delegate;

/**
 * A strong reference to a presenter object that adopts the JPAddCardPresenter protocol
 */
@property (nonatomic, strong) id<JPAddCardPresenter> presenter;

@end

/**
 * An extension that conforms to the UIPickerViewDelegate and UIPickerViewDataSource used for the country picker
 */
@interface JPAddCardViewController (CountryPickerDelegate) <UIPickerViewDelegate, UIPickerViewDataSource>
@end

/**
 * An extension that conforms to the InputFieldDelegate used for handling the credit card input
 */
@interface JPAddCardViewController (InputFieldDelegate) <JPTextFieldDelegate>
@end
