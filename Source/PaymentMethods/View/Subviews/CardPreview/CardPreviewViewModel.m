//
//  CardPreviewViewModel.m
//  JudoKitObjC
//
//  Created by Gheorghe Cojocaru on 12/23/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "CardPreviewViewModel.h"


@implementation CardPreviewViewModel

+ (instancetype)amount:(JPAmount *)amount
             cardModel:(JPPaymentMethodsCardModel *)cardModel
       payButtonTitlte:(NSString *)payButtonTitlte
      payButtonHandler:(SEL)payButtonHandler {
    return [[self alloc] initWithAmount:amount
                              cardModel:cardModel
                        payButtonTitlte:payButtonTitlte
                       payButtonHandler:payButtonHandler];
    
}



- (instancetype)initWithAmount:(JPAmount *)amount
                     cardModel:(JPPaymentMethodsCardModel *)cardModel
               payButtonTitlte:(NSString *)payButtonTitlte
              payButtonHandler:(SEL)payButtonHandler {
    self = [super init];
    if (self) {
        self.amount = amount;
        self.cardModel = cardModel;
        self.payButtonSel = payButtonHandler;
        self.payButtonTitle = payButtonTitlte;
    }
    return self;
}

@end
