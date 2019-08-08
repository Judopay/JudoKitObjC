//
//  JPBrowser.h
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

#import "JPDictionaryConvertible.h"
#import <UIKit/UIKit.h>

@interface JPBrowser : NSObject <JPDictionaryConvertible>
@property (nonatomic, strong, readonly) NSString *_Nullable acceptHeader;
@property (nonatomic, strong, readonly) NSTimeZone *_Nullable timeZone;
@property (nonatomic, strong, readonly) NSString *_Nullable userAgent;
@property (nonatomic, strong, readonly) NSString *_Nullable language;

@property (nonatomic, strong, readonly) NSString *_Nullable javaEnabled;
@property (nonatomic, strong, readonly) NSString *_Nullable javascriptEnabled;
@property (nonatomic, strong, readonly) NSString *_Nullable colorDepth;

@property (nonatomic, readonly) CGSize screenSize;

- (nonnull instancetype)init;

@end
