//
//  JPEnhancedPaymentDetail.m
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

#import "JPEnhancedPaymentDetail.h"
#import "JPConsumerDevice.h"
#import "JPSDKInfo.h"

@implementation JPEnhancedPaymentDetail

static NSString *const kSDKInfoKey = @"SDK_INFO";
static NSString *const kConsumerDeviceKey = @"ConsumerDevice";

- (instancetype)initWithSdkInfo:(JPSDKInfo *)sdkInfo
                 consumerDevice:(JPConsumerDevice *)consumerDevice {
    if (self = [super init]) {
        _sdkInfo = sdkInfo;
        _consumerDevice = consumerDevice;
    }
    return self;
}

+ (instancetype)detailWithSdkInfo:(JPSDKInfo *)sdkInfo
                   consumerDevice:(JPConsumerDevice *)consumerDevice {
    return [[self alloc] initWithSdkInfo:sdkInfo
                          consumerDevice:consumerDevice];
}

#pragma mark - JPDictionaryConvertible
- (NSDictionary *)toDictionary {
    return @{
        kSDKInfoKey : [self.sdkInfo toDictionary],
        kConsumerDeviceKey : [self.consumerDevice toDictionary]
    };
}

@end
