//
//  CardPreviewView.h
//  JudoKitObjC
//
//  Created by Gheorghe Cojocaru on 12/23/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardPreviewViewModel.h"
#import "JudoPaymentMethodsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CardPrevieAnimationType) {
    AnimateLeftTeRight,
    AnimateRightToLeft,
    AnimateBottomToTop
};


@interface CardPreviewView : UIView
@property (nonatomic, strong) CardPreviewViewModel* viewModel;
- (instancetype)initWithViewModel:(CardPreviewViewModel*)viewModel;
- (void)changePaymentMethodPreview:(CardPreviewViewModel*)viewModel animtionType:(CardPrevieAnimationType)animationType;
@end

NS_ASSUME_NONNULL_END
