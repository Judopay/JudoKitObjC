//
//  JPCardInputField.h
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import "JPTextField.h"
#import "JPAddCardViewModel.h"
#import "JPAddCardViewModel.h"

@class JPCardNumberField;

@interface JPCardNumberField : JPTextField
- (void)configureWithViewModel:(JPAddCardNumberInputViewModel *)viewModel;
@end
