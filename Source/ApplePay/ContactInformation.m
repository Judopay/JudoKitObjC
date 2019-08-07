//
//  ContactInformation.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 8/7/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "ContactInformation.h"

@implementation ContactInformation

- (instancetype)initWithEmailAddress:(NSString *)emailAddress
                                name:(NSPersonNameComponents *)name
                         phoneNumber:(NSString *)phoneNumber
                       postalAddress:(PostalAddress *)postalAddress {
    
    if (self = [super init]) {
        self.emailAddress = emailAddress;
        self.name = name;
        self.phoneNumber = phoneNumber;
        self.postalAddress = postalAddress;
    }
    
    return self;
}

@end
