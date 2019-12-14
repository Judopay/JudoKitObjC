//
//  JPCardInputField.h
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import "JPAddCardViewModel.h"
#import "JPTextField.h"

@class JPCardNumberField;

@interface JPCardNumberField : JPTextField
- (void)configureWithViewModel:(JPAddCardNumberInputViewModel *)viewModel;
@end
