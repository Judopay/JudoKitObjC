//
//  JPPaymentMethodsCardModel.h
//  JudoKitObjC
//
//  Created by Gheorghe Cojocaru on 12/24/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPCardDetails.h"



@interface JPPaymentMethodsCardModel : NSObject
@property (nonatomic, strong) NSString *cardTitle;
@property (nonatomic, assign) CardNetwork cardNetwork;
@property (nonatomic, strong) NSString *cardNumberLastFour;
@property (nonatomic, assign) BOOL isDefaultCard;
@end
