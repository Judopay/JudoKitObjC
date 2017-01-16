//
//  JPFieldMetaDataGenerator.h
//  JudoKitObjC
//
//  Created by Ashley Barrett on 12/01/2017.
//  Copyright © 2017 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPTrackedField.h"

@interface JPFieldMetaDataGenerator : NSObject

+ (nonnull NSDictionary<NSString *, id> *)generateAsDictionary:(nonnull NSDictionary<NSString *, NSArray<JPTrackedField *> *> *)fieldSessions;
    
@end
