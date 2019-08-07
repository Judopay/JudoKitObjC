//
//  PostalAddress.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 8/7/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostalAddress : NSObject

@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *isoCode;
@property (nonatomic, strong) NSString *subAdministrativeArea;
@property (nonatomic, strong) NSString *sublocality;

- (instancetype)initWithSteet: (NSString *)street
                         city: (NSString *)city
                        state: (NSString *)state
                   postalCode: (NSString *)postalCode
                      country: (NSString *)country;

@end

NS_ASSUME_NONNULL_END
