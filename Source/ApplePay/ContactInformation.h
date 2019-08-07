//
//  ContactInformation.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 8/7/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostalAddress.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactInformation : NSObject

@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSPersonNameComponents *name;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) PostalAddress *postalAddress;

- (instancetype)initWithEmailAddress: (NSString *)emailAddress
                                name: (NSPersonNameComponents *)name
                         phoneNumber:(NSString *)phoneNumber
                       postalAddress:(PostalAddress *)postalAddress;

@end

NS_ASSUME_NONNULL_END
