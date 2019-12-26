//
//  JPCardStorage.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/26/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPStoredCardDetails.h"

@interface JPCardStorage : NSObject

-(NSMutableArray <JPStoredCardDetails *> *)getStoredCardDetails;
-(void)addCardDetails:(JPStoredCardDetails *)cardDetails;

@end
