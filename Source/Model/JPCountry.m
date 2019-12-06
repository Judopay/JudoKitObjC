//
//  JPCountry.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/6/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "JPCountry.h"
#import "NSString+Localize.h"

@implementation JPCountry

+ (instancetype)countryWithType:(JPCountryType)countryType {
    return [[JPCountry alloc] initWithType:countryType];
}

- (instancetype)initWithType:(JPCountryType)countryType {
    if (self = [super init]) {
        self.name = [self countryNameForType:countryType];
    }
    return self;
}

- (NSString *)countryNameForType:(JPCountryType)type {
    switch (type) {
        case JPCountryTypeUSA:
            return @"country_usa".localized;
        case JPCountryTypeUK:
            return @"country_uk".localized;
        case JPCountryTypeCanada:
            return @"country_canada".localized;
        case JPCountryTypeOther:
            return @"country_other".localized;
    }
}

@end
