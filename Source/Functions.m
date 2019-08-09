//
//  Functions.m
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <arpa/inet.h>
#import <ifaddrs.h>

#import "Functions.h"
#import "JudoKit.h"
#import "NSString+Manipulation.h"

NSString *getUserAgent() {
    UIDevice *device = UIDevice.currentDevice;
    NSBundle *mainBundle = NSBundle.mainBundle;

    NSMutableArray<NSString *> *userAgentParts = [NSMutableArray new];

    //Base user agent
    [userAgentParts addObject:[NSString stringWithFormat:@"iOS-ObjC/%@", JudoKitVersion]];

    //Model
    [userAgentParts addObject:device.model];

    //Operating system
    [userAgentParts addObject:[NSString stringWithFormat:@"%@/%@", device.systemName, device.systemVersion]];

    NSString *appName = [mainBundle objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *appVersion = [mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

    if (appName && appVersion) {
        //App Name and version
        NSString *appNameMinusSpaces = [appName stringByRemovingWhitespaces];
        [userAgentParts addObject:[NSString stringWithFormat:@"%@/%@", appNameMinusSpaces, appVersion]];
    }

    NSString *platformName = [mainBundle objectForInfoDictionaryKey:@"DTPlatformName"];

    if (platformName) {
        //Platform running on (simulator or device)
        [userAgentParts addObject:platformName];
    }

    return [userAgentParts componentsJoinedByString:@" "];
}

NSString *getIPAddress() {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;

    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);

    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {

            BOOL isValidFamily = temp_addr->ifa_addr->sa_family == AF_INET;
            BOOL isValidName = [[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"];

            if (isValidFamily && isValidName) {
                address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
            }

            temp_addr = temp_addr->ifa_next;
        }
    }

    freeifaddrs(interfaces);
    return address;
}
