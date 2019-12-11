//
//  JPAddCardButton.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/11/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "JPAddCardButton.h"

@implementation JPAddCardButton

//------------------------------------------------------------------------------------
# pragma mark - View model configuration
//------------------------------------------------------------------------------------

- (void)configureWithViewModel:(JPAddCardButtonViewModel *)viewModel {
    self.alpha = 0.5;
    self.enabled = viewModel.isEnabled;
    self.alpha = (viewModel.isEnabled) ? 1.0 : 0.5;
    [self setTitle:viewModel.title forState:UIControlStateNormal];
}

@end
