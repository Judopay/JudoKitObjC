//
//  JPConsumerDevice.h
//  JudoKitObjC
//
//  Copyright (c) 2019 Alternative Payments Ltd
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

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

#import "JPDictionaryConvertible.h"

@class JPClientDetails, JPGeoLocation, JPThreeDSecure;

@interface JPConsumerDevice : NSObject <JPDictionaryConvertible>
@property (nonatomic, strong, readonly) NSString *_Nullable ipAddress;
@property (nonatomic, strong, readonly) JPClientDetails *_Nullable clientDetails;
@property (nonatomic, strong, readonly) CLLocation *_Nullable geoLocation;
@property (nonatomic, strong, readonly) JPThreeDSecure *_Nullable threeDSecure;
@property (nonatomic, strong, readonly) NSString *_Nullable paymentType;

- (nonnull instancetype)initWithIpAddress:(nonnull NSString *)ipAddress
                            clientDetails:(nonnull JPClientDetails *)clientDetails
                              geoLocation:(nonnull CLLocation *)geoLocation
                             threeDSecure:(nonnull JPThreeDSecure *)threeDSecure;

+ (nonnull instancetype)deviceWithIpAddress:(nonnull NSString *)ipAddress
                              clientDetails:(nonnull JPClientDetails *)clientDetails
                                geoLocation:(nonnull CLLocation *)geoLocation
                               threeDSecure:(nonnull JPThreeDSecure *)threeDSecure;

@end
