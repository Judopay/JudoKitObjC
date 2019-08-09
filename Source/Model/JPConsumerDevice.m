//
//  JPConsumerDevice.m
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

#import "JPConsumerDevice.h"
#import "CLLocation+JPDictionaryConvertible.h"
#import "JPClientDetails.h"
#import "JPThreeDSecure.h"

@implementation JPConsumerDevice

static NSString *const kIPAddressKey = @"IpAddress";
static NSString *const kClientDetailsKey = @"ClientDetails";
static NSString *const kGeoLocationKey = @"GeoLocation";
static NSString *const kThreeDSecureKey = @"ThreeDSecure";
static NSString *const kPaymentTypeKey = @"PaymentType";
static NSString *const kPaymentTypeEcomm = @"ECOMM";

- (instancetype)initWithIpAddress:(NSString *)ipAddress
                    clientDetails:(JPClientDetails *)clientDetails
                      geoLocation:(CLLocation *)geoLocation
                     threeDSecure:(JPThreeDSecure *)threeDSecure {
    if (self = [super init]) {
        _ipAddress = ipAddress;
        _clientDetails = clientDetails;
        _geoLocation = geoLocation;
        _threeDSecure = threeDSecure;
        _paymentType = kPaymentTypeEcomm;
    }
    return self;
}

+ (instancetype)deviceWithIpAddress:(NSString *)ipAddress
                      clientDetails:(JPClientDetails *)clientDetails
                        geoLocation:(CLLocation *)geoLocation
                       threeDSecure:(JPThreeDSecure *)threeDSecure {
    return [[self alloc] initWithIpAddress:ipAddress
                             clientDetails:clientDetails
                               geoLocation:geoLocation
                              threeDSecure:threeDSecure];
}

#pragma mark - JPDictionaryConvertible
- (NSDictionary *)toDictionary {
    return @{
        kIPAddressKey : self.ipAddress,
        kClientDetailsKey : [self.clientDetails toDictionary],
        kGeoLocationKey : [self.geoLocation toDictionary],
        kThreeDSecureKey : [self.threeDSecure toDictionary],
        kPaymentTypeKey : self.paymentType
    };
}

@end
