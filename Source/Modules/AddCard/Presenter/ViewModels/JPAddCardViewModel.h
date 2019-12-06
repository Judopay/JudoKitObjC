//
//  JPAddCardViewModel.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/2/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JPCardInputType) {
    JPCardInputTypeCardNumber,
    JPCardInputTypeCardholderName,
    JPCardInputTypeExpiryDate,
    JPCardInputTypeLastDigits,
    JPCardInputTypeCountry,
    JPCardInputTypePostalCode
};

@interface JPAddCardInputFieldViewModel : NSObject
@property (nonatomic, assign) JPCardInputType type;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *errorText;
@end

@interface JPAddCardButtonViewModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isEnabled;
@end

@interface JPAddCardPickerViewModel : JPAddCardInputFieldViewModel
@property (nonatomic, strong) NSArray *pickerTitles;
@end

@interface JPAddCardViewModel : NSObject
@property (nonatomic, strong) JPAddCardInputFieldViewModel *cardNumberViewModel;
@property (nonatomic, strong) JPAddCardInputFieldViewModel *cardholderNameViewModel;
@property (nonatomic, strong) JPAddCardInputFieldViewModel *expiryDateViewModel;
@property (nonatomic, strong) JPAddCardInputFieldViewModel *lastFourViewModel;
@property (nonatomic, strong) JPAddCardPickerViewModel *countryPickerViewModel;
@property (nonatomic, strong) JPAddCardInputFieldViewModel *postalCodeInputViewModel;
@property (nonatomic, strong) JPAddCardButtonViewModel *addCardButtonViewModel;
@end
