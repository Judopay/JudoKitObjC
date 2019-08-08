//
//  PostalAddress.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 8/7/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The representation of the postal address for a contact
 */
@interface PostalAddress : NSObject

/**
 * The street name in a postal address.
 */
@property (nonatomic, strong) NSString * _Nullable street;

/**
 * The city name in a postal address.
 */
@property (nonatomic, strong) NSString * _Nullable city;

/**
 * The state name in a postal address.
 */
@property (nonatomic, strong) NSString * _Nullable state;

/**
 * The postal code in a postal address.
 */
@property (nonatomic, strong) NSString * _Nullable postalCode;

/**
 * The country name in a postal address.
 */
@property (nonatomic, strong) NSString * _Nullable country;

/**
 * The ISO country code for the country in a postal address, using the ISO 3166-1 alpha-2 standard.
 */
@property (nonatomic, strong) NSString * _Nullable isoCode;

/**
 * The subadministrative area (such as a county or other region) in a postal address.
 */
@property (nonatomic, strong) NSString * _Nullable subAdministrativeArea;

/**
 * Additional information associated with the location, typically defined at the city or town level, in a postal address.
 */
@property (nonatomic, strong) NSString * _Nullable sublocality;

/**
 * Designated initializer
 *
 * @param street     - the street name in a postal address.
 * @param city       - the city name in a postal address.
 * @param state      - the state name in a postal address.
 * @param postalCode - the postal code in a postal address.
 * @param country    - the country name in a postal address.
 * @param isoCode    - the ISO country code for the country in a postal address.
 * @param subAdministrativeArea - The subadministrative area in a postal address.
 * @param sublocality - Additional information associated with the location in a postal address.
 */
- (instancetype)initWithSteet: (nullable NSString *)street
                         city: (nullable NSString *)city
                        state: (nullable NSString *)state
                   postalCode: (nullable NSString *)postalCode
                      country: (nullable NSString *)country;

@end

NS_ASSUME_NONNULL_END
