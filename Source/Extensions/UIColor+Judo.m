//
//  UIColor+Judo.m
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
#import "UIColor+Judo.h"

@implementation UIColor (Judo)

- (UIColor *)inverseColor {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return [UIColor colorWithRed:1 - red green:1 - green blue:1 - blue alpha:alpha];
}

- (CGFloat)greyScale {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return 0.299 * red + 0.587 * green + 0.114 * blue;
}

- (BOOL)isDarkColor {
    return self.greyScale < 0.5;
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

+ (UIColor *)jellyBean {
    return [UIColor colorWithRed:30 / 255.0f green:120 / 255.0f blue:160 / 255.0f alpha:1.0f];
}

+ (UIColor *)hippieBlue {
    return [UIColor colorWithRed:0.34 green:0.59 blue:0.69 alpha:1.00];
}

+ (UIColor *)thunder {
    return [UIColor colorWithRed:75 / 255.0f green:75 / 255.0f blue:75 / 255.0f alpha:1.0f];
}

+ (UIColor *)magnesium {
    return [UIColor colorWithRed:180 / 255.0f green:180 / 255.0f blue:180 / 255.0f alpha:1.0];
}

+ (UIColor *)zircon {
    return [UIColor colorWithRed:245 / 255.0f green:245 / 255.0f blue:245 / 255.0f alpha:1.0f];
}

+ (UIColor *)lightGray {
    return [UIColor colorWithRed:210 / 255.0f green:210 / 255.0f blue:210 / 255.0f alpha:0.8f];
}

+ (UIColor *)cgRed {
    return [UIColor colorWithRed:235 / 255.0f green:55 / 255.0f blue:45 / 255.0f alpha:1.0];
}

+ (UIColor *)errorRed {
    return [UIColor colorWithRed:206 / 255.0f green:80 / 255.0f blue:65 / 255.0f alpha:1.0];
}

+ (UIColor *)idealPurple {
    return [UIColor colorWithRed:188 / 255.0f green:41 / 255.0f blue:101 / 255.0f alpha:1.0];
}

+ (UIColor *)jpGrayColor {
    return [UIColor colorFromHex:0x999999];
}

+ (UIColor *)jpDarkGrayColor {
    return [UIColor colorFromHex:0x262626];
}

+ (UIColor *)jpLightGrayColor {
    return [UIColor colorFromHex:0xF6F6F6];
}

+ (UIColor *)jpDarkColor {
    return [UIColor colorFromHex:0x262626];
}

+ (UIColor *)defaultTintColor {
    if ([UIApplication isUserInterfaceStyleDark]) {
        return [UIColor hippieBlue];
    }
    return [UIColor jellyBean];
}

+ (UIColor *)jpErrorColor {
    return [UIColor colorWithRed:226 / 255.0f green:25 / 225.0 blue:0.0 alpha:1.0];
}

+ (UIColor *)jpPlaceholderColor {
    return [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1.0];
}

+ (UIColor *)jpTextColor {
    return [UIColor colorWithRed:38 / 255.0f green:38 / 225.0 blue:38 / 255.0 alpha:1.0];
}

+ (UIColor *)jpTextFieldBackgroundColor {
    return [UIColor colorWithRed:246 / 255.0f green:246 / 255.0f blue:246 / 255.0f alpha:1.0];
}

+ (UIColor *)jpContentBackgroundColor {
    return [UIColor colorWithRed:238 / 255.0f green:238 / 255.0f blue:238 / 255.0f alpha:1.0];
}

@end
