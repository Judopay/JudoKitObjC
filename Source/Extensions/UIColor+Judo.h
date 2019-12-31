//
//  UIColor+Judo.h
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

#import <UIKit/UIKit.h>

@interface UIColor (Judo)

- (nonnull UIColor *)inverseColor;

- (nonnull UIImage *)asImage;

- (CGFloat)greyScale;

- (BOOL)isDarkColor;

+ (UIColor *_Nonnull)colorFromHex:(int)hex;

+ (UIColor *_Nonnull)thunder;

+ (UIColor *_Nonnull)magnesium;

+ (UIColor *_Nonnull)zircon;

+ (UIColor *_Nonnull)lightGray;

+ (UIColor *_Nonnull)cgRed;

+ (UIColor *_Nonnull)idealPurple;

+ (UIColor *_Nonnull)defaultTintColor;

+ (UIColor *_Nonnull)jpErrorColor;

+ (UIColor *_Nonnull)jpPlaceholderColor;

+ (UIColor *_Nonnull)jpTextColor;

+ (UIColor *_Nonnull)jpSubtitleColor;

+ (UIColor *_Nonnull)jpTextFieldBackgroundColor;

+ (UIColor *_Nonnull)jpContentBackgroundColor;

@end
