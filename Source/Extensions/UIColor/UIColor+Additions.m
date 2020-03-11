//
//  UIColor+Additions.m
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

#import "UIApplication+Additions.h"
#import "UIColor+Additions.h"

@implementation UIColor (Judo)

- (UIColor *)inverseColor {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return [UIColor colorWithRed:1 - red green:1 - green blue:1 - blue alpha:alpha];
}

- (UIImage *)asImage {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor *)colorFromHex:(int)hex {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0x00FF00) >> 8)) / 255.0
                            blue:((float)((hex & 0x0000FF) >> 0)) / 255.0
                           alpha:1.0];
}

+ (UIColor *)jpBlackColor {
    return [UIColor colorFromHex:0x262626];
}

+ (UIColor *)jpDarkGrayColor {
    return [UIColor colorFromHex:0x999999];
}

+ (UIColor *)jpGrayColor {
    return [UIColor colorFromHex:0xE5E5E5];
}

+ (UIColor *)jpLightGrayColor {
    return [UIColor colorFromHex:0xF6F6F6];
}

+ (UIColor *)jpRedColor {
    return [UIColor colorFromHex:0xE21900];
}

+ (UIColor *)jpWhiteColor {
    return [UIColor colorFromHex:0xFFFFFF];
}

@end
