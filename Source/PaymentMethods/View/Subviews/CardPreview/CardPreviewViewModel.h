//
//  CardPreviewViewModel.h
//  JudoKitObjC
//
//  Created by Gheorghe Cojocaru on 12/23/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPAmount.h"
#import "JPPaymentMethodsViewModel.h"
#import "JPSession.h"



NS_ASSUME_NONNULL_BEGIN

@interface CardPreviewViewModel : NSObject
@property (nonatomic, strong) JPAmount *_Nonnull amount;
@property (nonatomic, strong) NSString *_Nullable payButtonTitle;
@property (nonatomic, strong) JPPaymentMethodsCardModel *_Nullable cardModel;
@property (nonatomic, assign) SEL payButtonSel;


+ (instancetype)amount:(JPAmount *)amount
             cardModel:(JPPaymentMethodsCardModel *)cardModel
       payButtonTitlte:(NSString *)payButtonTitlte
      payButtonHandler:(SEL)payButtonHandler;

- (instancetype)initWithAmount:(JPAmount *)amount
                     cardModel:(JPPaymentMethodsCardModel *)cardModel
               payButtonTitlte:(NSString *)payButtonTitlte
              payButtonHandler:(SEL)payButtonHandler;

@end

NS_ASSUME_NONNULL_END
