//
//  PostalAddress.h
//  JudoKitObjC
//
//  Copyright (c) 2016 Alternative Payments Ltd
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The representation of the postal address for a contact
 */
@interface PostalAddress : NSObject

/**
 * The street name in a postal address.
 */
@property (nonatomic, strong) NSString *_Nullable street;

/**
 * The city name in a postal address.
 */
@property (nonatomic, strong) NSString *_Nullable city;

/**
 * The state name in a postal address.
 */
@property (nonatomic, strong) NSString *_Nullable state;

/**
 * The postal code in a postal address.
 */
@property (nonatomic, strong) NSString *_Nullable postalCode;

/**
 * The country name in a postal address.
 */
@property (nonatomic, strong) NSString *_Nullable country;

/**
 * The ISO country code for the country in a postal address, using the ISO 3166-1 alpha-2 standard.
 */
@property (nonatomic, strong) NSString *_Nullable isoCode;

/**
 * The subadministrative area (such as a county or other region) in a postal address.
 */
@property (nonatomic, strong) NSString *_Nullable subAdministrativeArea;

/**
 * Additional information associated with the location, typically defined at the city or town level, in a postal address.
 */
@property (nonatomic, strong) NSString *_Nullable sublocality;

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
- (instancetype)initWithSteet:(nullable NSString *)street
                         city:(nullable NSString *)city
                        state:(nullable NSString *)state
                   postalCode:(nullable NSString *)postalCode
                      country:(nullable NSString *)country
                      isoCode:(nullable NSString *)isoCode
        subAdministrativeArea:(nullable NSString *)subAdministrativeArea
                  sublocality:(nullable NSString *)sublocality;

@end

NS_ASSUME_NONNULL_END
