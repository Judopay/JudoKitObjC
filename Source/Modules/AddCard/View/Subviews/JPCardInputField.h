//
//  JPCardInputField.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/12/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "JPAddCardViewModel.h"
#import "JPTextField.h"

@interface JPCardInputField : JPTextField
- (void)configureWithViewModel:(JPAddCardInputFieldViewModel *)viewModel;
@end
