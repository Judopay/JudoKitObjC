//
//  JPTransactionEnricher.m
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

#import "JPTransactionEnricher.h"

#import <CoreLocation/CoreLocation.h>
#import <DeviceDNA/DeviceDNA.h>

#import "Functions.h"
#import "JPBrowser.h"
#import "JPClientDetails.h"
#import "JPConsumerDevice.h"
#import "JPEnhancedPaymentDetail.h"
#import "JPSDKInfo.h"
#import "JPThreeDSecure.h"
#import "JPTransaction.h"
#import "JudoKit.h"

@interface JPTransactionEnricher () <CLLocationManagerDelegate>

@property (nonatomic, strong) DeviceDNA *deviceDNA;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastKnownLocation;
@property (nonatomic, assign) BOOL didFindLocation;

@property (nonatomic, copy, nullable) void (^completionBlock)(void);
@property (nonatomic, weak) JPTransaction *transaction;

@property (nonatomic, strong) NSArray *enricheablePaths;
@end

@implementation JPTransactionEnricher

- (instancetype)initWithToken:(NSString *)token secret:(NSString *)secret {
    if (self = [super init]) {
        Credentials *credentials = [[Credentials alloc] initWithToken:token secret:secret];
        _deviceDNA = [[DeviceDNA alloc] initWithCredentials:credentials];
        [self setDidFindLocation:NO];
        _locationManager = [CLLocationManager new];
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.delegate = self;

        _enricheablePaths = @[ @"transactions/payments",
                               @"transactions/preauths",
                               @"transactions/registercard",
                               @"transactions/checkcard" ];
    }
    return self;
}

- (void)enrichTransaction:(nonnull JPTransaction *)transaction
           withCompletion:(nonnull void (^)(void))completion {
    [self setDidFindLocation:NO];
    if (![self.enricheablePaths containsObject:transaction.transactionPath]) {
        completion();
        return;
    }

    self.completionBlock = completion;
    self.transaction = transaction;

    if (CLLocationManager.locationServicesEnabled && (CLLocationManager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || CLLocationManager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        [self.locationManager requestLocation];
    } else {
        [self enrichWithLocation:self.lastKnownLocation];
    }
}

- (void)enrichWithLocation:(CLLocation *)location {
    [self.deviceDNA getDeviceSignals:^(NSDictionary<NSString *, NSString *> *_Nullable device, NSError *_Nullable error) {
        JPEnhancedPaymentDetail *detail = [self buildEnhancedPaymentDetail:device andLocation:location];
        [self.transaction setPaymentDetail:detail];
        [self.transaction setDeviceSignal:device];
        self.completionBlock();
    }];
}

- (JPEnhancedPaymentDetail *)buildEnhancedPaymentDetail:(NSDictionary<NSString *, NSString *> *)device
                                            andLocation:(CLLocation *)location {

    JPThreeDSecure *threeDSecure = [JPThreeDSecure secureWithBrowser:[JPBrowser new]];

    JPConsumerDevice *consumerDevice = [JPConsumerDevice deviceWithIpAddress:getIPAddress()
                                                               clientDetails:[JPClientDetails detailsWithDictionary:device]
                                                                 geoLocation:location
                                                                threeDSecure:threeDSecure];

    return [JPEnhancedPaymentDetail detailWithSdkInfo:[JPSDKInfo infoWithVersion:JudoKitVersion name:@"iOS-ObjC"]
                                       consumerDevice:consumerDevice];
}

#pragma mark : CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count > 0) {
        self.lastKnownLocation = locations.lastObject;
    }
    if (self.didFindLocation == NO) {
        [self enrichWithLocation:self.lastKnownLocation];
        [self setDidFindLocation:YES];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self enrichWithLocation:self.lastKnownLocation];
}

- (CLLocation *)lastKnownLocation {
    if (!_lastKnownLocation) {
        _lastKnownLocation = [[CLLocation alloc] initWithLatitude:0.0 longitude:0.0];
    }
    return _lastKnownLocation;
}

@end
