//
//  JPCardInputField.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/12/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "JPCardInputField.h"
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"

@implementation JPCardInputField

//------------------------------------------------------------------------------------
#pragma mark - View model configuration
//------------------------------------------------------------------------------------

- (void)configureWithViewModel:(JPAddCardInputFieldViewModel *)viewModel {

    self.type = viewModel.type;
    self.text = viewModel.text;

    UIFont *placeholderFont = (viewModel.errorText) ? UIFont.smallTextFont : UIFont.defaultTextFont;

    [self placeholderWithText:viewModel.placeholder
                        color:UIColor.jpPlaceholderColor
                      andFont:placeholderFont];

    if (viewModel.errorText) {
        [self displayErrorWithText:viewModel.errorText];
        return;
    }

    [self clearError];
}

@end
