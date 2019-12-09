//
//  JPCountry.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/6/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JPCountryType) {
    JPCountryTypeUSA,
    JPCountryTypeUK,
    JPCountryTypeCanada,
    JPCountryTypeOther
};

@interface JPCountry : NSObject
@property (nonatomic, strong) NSString *name;

+ (instancetype)countryWithType:(JPCountryType)countryType;
- (instancetype)initWithType:(JPCountryType)countryType;
@end
