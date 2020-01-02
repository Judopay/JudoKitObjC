//
//  JPPaymentMethodsViewModel.h
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

#import "JPCardDetails.h"
#import <Foundation/Foundation.h>

#pragma mark - JPPaymentMethodsModel

@interface JPPaymentMethodsModel : NSObject
/**
 * A string that identifies the UITableViewCell that this view model applies to.
 * Must match the exact name of the UITableViewCell so that it can be registered correctly.
 */
@property (nonatomic, strong) NSString *identifier;

@end

#pragma mark - JPPaymentMethodsSelectionModel

@interface JPPaymentMethodsSelectionModel : JPPaymentMethodsModel
@end

#pragma mark - JPPaymentMethodsEmptyListModel

@interface JPPaymentMethodsEmptyListModel : JPPaymentMethodsModel

/**
 * The text displayed when no card has been added
 */
@property (nonatomic, strong) NSString *title;

/**
 * The title of the Add Card button
 */
@property (nonatomic, strong) NSString *addCardButtonTitle;

/**
 * The icon name of the Add Card button that is displayed on the left side of the title
 */
@property (nonatomic, strong) NSString *addCardButtonIconName;

/**
 * The action handler of the Add Card button that handles the tap events
 */
@property (nonatomic, copy) void (^onAddCardButtonTapHandler)(void);

@end

#pragma mark - JPPaymentMethodsCardHeaderModel

@interface JPPaymentMethodsCardHeaderModel : JPPaymentMethodsModel

/**
 * The title of the header displayed above the card selection list
 */
@property (nonatomic, strong) NSString *title;

/**
 * The title of the Edit button displayed above the card selection list
 */
@property (nonatomic, strong) NSString *editButtonTitle;

@end

#pragma mark - JPPaymentMethodsCardFooterModel

@interface JPPaymentMethodsCardFooterModel : JPPaymentMethodsModel

/**
 * The title of the Add Card button displayed below the card selection list
 */
@property (nonatomic, strong) NSString *addCardButtonTitle;

/**
 * The icon name of the Add Card button displayed below the card selection list
 */
@property (nonatomic, strong) NSString *addCardButtonIconName;

/**
 * The action handler of the Add Card button displayed below the card selection list
 */
@property (nonatomic, copy) void (^onAddCardButtonTapHandler)(void);

@end

#pragma mark - JPPaymentMethodsCardModel

@interface JPPaymentMethodsCardModel : NSObject

/**
 * The title of the card
 */
@property (nonatomic, strong) NSString *cardTitle;

/**
 * The card network used for displaying the card logo and name
 */
@property (nonatomic, assign) CardNetwork cardNetwork;

/**
 * The last four digits of the card
 */
@property (nonatomic, strong) NSString *cardNumberLastFour;

/**
 * A value that specifies if the card is set as the default credit card of the user
 */
@property (nonatomic, assign) BOOL isDefaultCard;

/**
 * A value that specifies if the card is currently selected
 */
@property (nonatomic, assign) BOOL isSelected;

@end

#pragma mark - JPPaymentMethodsCardListModel

@interface JPPaymentMethodsCardListModel : JPPaymentMethodsModel
/**
 * An array of JPPaymentMethodsCardModel objects that describe the added cards
 */
@property (nonatomic, strong) NSMutableArray<JPPaymentMethodsCardModel *> *cardModels;

@end

#pragma mark - JPPaymentMethodsCardListModel

@interface JPPaymentMethodsViewModel : NSObject

/**
 * A property that is set to YES if the 'Powered by Judo' headline should be displayed;
 */
@property (nonatomic, assign) BOOL shouldDisplayHeadline;

/**
 * An array of JPPaymentMethodsModel objects that define the layout of the view
 */
@property (nonatomic, strong) NSMutableArray<JPPaymentMethodsModel *> *items;

@end
