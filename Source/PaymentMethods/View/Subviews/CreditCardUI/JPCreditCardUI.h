//
//  JPCreditCardUI.h
//  JudoKitObjC
//
//  Created by Gheorghe Cojocaru on 12/24/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JPPaymentMethodsViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface JPCreditCardUI : UIView
- (instancetype)initWithViewModel:(JPPaymentMethodsCardModel*)viewModel;
@end

NS_ASSUME_NONNULL_END
