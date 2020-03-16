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
#import "JPCardPattern.h"
#import "JPPaymentMethod.h"
#import <Foundation/Foundation.h>

@class JPAmount, JPTransactionButtonViewModel;

#pragma mark - JPPaymentMethodsModel

typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTypeNone,
    AnimationTypeSetup,
    AnimationTypeLeftToRight,
    AnimationTypeRightToLeft,
    AnimationTypeBottomToTop
};

typedef NS_ENUM(NSUInteger, CardExpirationStatus) {
    CardNotExpired,
    CardExpired,
    CardExpiresSoon
};

@interface JPPaymentMethodsModel : NSObject
/**
 * A string that identifies the UITableViewCell that this view model applies to.
 * Must match the exact name of the UITableViewCell so that it can be registered correctly.
 */
@property (nonatomic, strong) NSString *_Nonnull identifier;

@end

#pragma mark - JPPaymentMethodsSelectionModel

@interface JPPaymentMethodsSelectionModel : JPPaymentMethodsModel

/**
 * The index of the currently selected payment method
 */
@property (nonatomic, assign) NSUInteger selectedPaymentMethod;

/**
 * An array of available payment methods
 */
@property (nonatomic, strong) NSArray<JPPaymentMethod *> *_Nullable paymentMethods;

@end

#pragma mark - JPPaymentMethodsEmptyListModel

@interface JPPaymentMethodsEmptyListModel : JPPaymentMethodsModel

/**
 * The text displayed when no card has been added
 */
@property (nonatomic, strong) NSString *_Nullable title;

/**
 * The title of the Add Card button
 */
@property (nonatomic, strong) NSString *_Nullable addCardButtonTitle;

/**
 * The icon name of the Add Card button that is displayed on the left side of the title
 */
@property (nonatomic, strong) NSString *_Nullable addCardButtonIconName;

/**
 * The action handler of the Add Card button that handles the tap events
 */
@property (nonatomic, copy) void (^_Nullable onTransactionButtonTapHandler)(void);

@end

#pragma mark - JPPaymentMethodsCardHeaderModel

@interface JPPaymentMethodsCardHeaderModel : JPPaymentMethodsModel

/**
 * The title of the header displayed above the card selection list
 */
@property (nonatomic, strong) NSString *_Nullable title;

/**
 * The title of the Edit button displayed above the card selection list
 */
@property (nonatomic, strong) NSString *_Nullable editButtonTitle;

@end

#pragma mark - JPPaymentMethodsCardFooterModel

@interface JPPaymentMethodsCardFooterModel : JPPaymentMethodsModel

/**
 * The title of the Add Card button displayed below the card selection list
 */
@property (nonatomic, strong) NSString *_Nullable addCardButtonTitle;

/**
 * The icon name of the Add Card button displayed below the card selection list
 */
@property (nonatomic, strong) NSString *_Nullable addCardButtonIconName;

/**
 * The action handler of the Add Card button displayed below the card selection list
 */
@property (nonatomic, copy) void (^_Nullable onTransactionButtonTapHandler)(void);

@end

#pragma mark - JPPaymentMethodsCardModel

@interface JPPaymentMethodsCardModel : NSObject

/**
 * The title of the card
 */
@property (nonatomic, strong) NSString *_Nullable cardTitle;

/**
 * The card network used for displaying the card logo and name
 */
@property (nonatomic, assign) CardNetwork cardNetwork;

/**
 * The last four digits of the card
 */
@property (nonatomic, strong) NSString *_Nullable cardNumberLastFour;

/**
 * The card's expiration date string
 */
@property (nonatomic, strong) NSString *_Nullable cardExpiryDate;

/**
 * The card's pattern type
 */
@property (nonatomic, assign) JPCardPatternType cardPatternType;

/**
 * A value that specifies if the card is set as the default credit card of the user
 */
@property (nonatomic, assign) BOOL isDefaultCard;

/**
 * A value that specifies if the card is currently selected
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 * A value that specifies card expiration staus
 */
@property (nonatomic, assign) CardExpirationStatus cardExpirationStatus;

@end

#pragma mark - JPPaymentMethodsCardListModel

@interface JPPaymentMethodsCardListModel : JPPaymentMethodsModel

/**
 * An array of JPPaymentMethodsCardModel objects that describe the added cards
 */
@property (nonatomic, strong) NSMutableArray<JPPaymentMethodsCardModel *> *_Nullable cardModels;

@end

#pragma mark - IDEAL Bank Model

@interface JPPaymentMethodsIDEALBankModel : NSObject

/**
 * The iDEAL bank's title
 */
@property (nonatomic, strong) NSString *_Nonnull bankTitle;

/**
 * The iDEAL bank's icon name
 */
@property (nonatomic, strong) NSString *_Nonnull bankIconName;

/**
 * A boolean value that describes if the bank is the currently selected one
 */
@property (nonatomic, assign) BOOL isSelected;

@end

#pragma mark - JPPaymentMethodsHeaderModel

@interface JPPaymentMethodsHeaderModel : NSObject

/**
 * The amount displayed to the user
 */
@property (nonatomic, strong) JPAmount *_Nonnull amount;

/**
 * The payment button model
 */
@property (nonatomic, strong) JPTransactionButtonViewModel *_Nonnull payButtonModel;

/**
 * The currently selected card model
 */
@property (nonatomic, strong) JPPaymentMethodsCardModel *_Nullable cardModel;

/**
 * The currently selected bank model
 */
@property (nonatomic, strong) JPPaymentMethodsIDEALBankModel *_Nullable bankModel;

/**
 * Card appearance animation type
 */
@property (nonatomic, assign) AnimationType animationType;

/**
 * The currently selected payment method type
 */
@property (nonatomic, assign) JPPaymentMethodType paymentMethodType;

/**
 * A boolean value that returns YES if Apple Pay is set up
 */
@property (nonatomic, assign) bool isApplePaySetUp;

@end

#pragma mark - IDEAL Bank List Model

@interface JPPaymentMethodsIDEALBankListModel : JPPaymentMethodsModel

/**
 * An array of JPPaymentMethodIDEALBankModel objects that describe the iDEAL banks
 */
@property (nonatomic, strong) NSMutableArray<JPPaymentMethodsIDEALBankModel *> *_Nullable bankModels;

@end

#pragma mark - JPPaymentMethodsCardListModel

@interface JPPaymentMethodsViewModel : NSObject

/**
 * A property that defines the way the Payment Method header behaves
 */
@property (nonatomic, strong) JPPaymentMethodsHeaderModel *_Nullable headerModel;

/**
 * An array of JPPaymentMethodsModel objects that define the layout of the view
 */
@property (nonatomic, strong) NSMutableArray<JPPaymentMethodsModel *> *_Nullable items;

@end
