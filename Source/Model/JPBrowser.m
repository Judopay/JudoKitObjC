//
//  JPBrowser.m
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

#import "JPBrowser.h"
#import "Functions.h"

#import <UIKit/UIKit.h>

@implementation JPBrowser

static NSString *const kAcceptHeaderKey = @"AcceptHeader";
static NSString *const kTimeZoneKey = @"TimeZone";
static NSString *const kUserAgentKey = @"UserAgent";
static NSString *const kLanguageKey = @"Language";
static NSString *const kJavaEnabledKey = @"JavaEnabled";
static NSString *const kJavascriptEnabledKey = @"JavascriptEnabled";
static NSString *const kColorDepthKey = @"ColorDepth";
static NSString *const kScreenHeightKey = @"ScreenHeight";
static NSString *const kScreenWidthKey = @"ScreenWidth";

- (instancetype)init {
    if (self = [super init]) {
        _acceptHeader = @"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8";
        _javaEnabled = @"false";
        _javascriptEnabled = @"true";
        _colorDepth = @"32";
        _userAgent = getUserAgent();
        _language = [[NSLocale preferredLanguages] firstObject];
        _timeZone = NSTimeZone.localTimeZone;
        _screenSize = UIScreen.mainScreen.nativeBounds.size;
    }

    return self;
}

#pragma mark - JPDictionaryConvertible
- (NSDictionary *)toDictionary {
    return @{
        kAcceptHeaderKey : self.acceptHeader,
        kTimeZoneKey : self.timeZone.abbreviation,
        kUserAgentKey : self.userAgent,
        kLanguageKey : self.language,
        kJavaEnabledKey : self.javaEnabled,
        kJavascriptEnabledKey : self.javascriptEnabled,
        kColorDepthKey : self.colorDepth,
        kScreenHeightKey : @(self.screenSize.height),
        kScreenWidthKey : @(self.screenSize.width)
    };
}

@end
