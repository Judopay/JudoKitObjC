//
//  JPCardHolderField.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/11/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "JPCardHolderField.h"
#import "UIColor+Judo.h"

@implementation JPCardHolderField

//------------------------------------------------------------------------------------
# pragma mark - View model configuration
//------------------------------------------------------------------------------------

- (void)configureWithViewModel:(JPAddCardInputFieldViewModel *)viewModel {
    
    [self placeholderWithText:viewModel.placeholder
                        color:UIColor.jpPlaceholderColor
                      andFont:[UIFont systemFontOfSize:16.0]];
}

@end
