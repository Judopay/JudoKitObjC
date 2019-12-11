//
//  JPCardInputField.h
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import "JPTextField.h"
#import "JPAddCardViewModel.h"

@class JPCardNumberField;

@protocol JPCardNumberFieldDelegate
- (void)cardNumberField:(JPCardNumberField *)cardNumberField shouldEditWithInput:(NSString *)input;
- (void)cardNumberField:(JPCardNumberField *)cardNumberField didEditWithInput:(NSString *)input;
@end

@interface JPCardNumberField : JPTextField <JPTextFieldDelegate>

@property (nonatomic, strong) id <JPCardNumberFieldDelegate> cardNumberDelegate;
- (void)configureWithViewModel:(JPAddCardInputFieldViewModel *)viewModel;
@end
