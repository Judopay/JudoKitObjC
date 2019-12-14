//
//  JPAddCardButton.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/11/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "JPAddCardViewModel.h"
#import "LoadingButton.h"

@interface JPAddCardButton : LoadingButton
- (void)configureWithViewModel:(JPAddCardButtonViewModel *)viewModel;
@end
