//
//  PostalAddress.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 8/7/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "PostalAddress.h"

@implementation PostalAddress

- (instancetype)initWithSteet: (NSString *)street
                         city: (NSString *)city
                        state: (NSString *)state
                   postalCode: (NSString *)postalCode
                      country: (NSString *)country {
    
    if (self = [super init]) {
        self.street = street;
        self.city = city;
        self.state = state;
        self.postalCode = postalCode;
        self.country = country;
    }
    
    return self;
}

@end
