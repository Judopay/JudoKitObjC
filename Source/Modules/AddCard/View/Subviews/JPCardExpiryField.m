//
//  JPCardExpiryField.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/11/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "JPCardExpiryField.h"
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"

@implementation JPCardExpiryField

//------------------------------------------------------------------------------------
# pragma mark - View model configuration
//------------------------------------------------------------------------------------

- (void)configureWithViewModel:(JPAddCardInputFieldViewModel *)viewModel {
    [self placeholderWithText:viewModel.placeholder
                        color:UIColor.jpPlaceholderColor
                      andFont:UIFont.defaultTextFont];
}

@end
