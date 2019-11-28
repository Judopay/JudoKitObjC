//
//  UIFont+Custom.m
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

#import "UIFont+Custom.h"
#import "NSBundle+Additions.h"

#import <CoreText/CoreText.h>

@implementation UIFont (Custom)

+ (void)loadCustomFonts {
    [self registerFontWithFilename:@"SF-Pro-Display-Black"];
    [self registerFontWithFilename:@"SF-Pro-Display-BlackItalic"];
    [self registerFontWithFilename:@"SF-Pro-Display-Bold"];
    [self registerFontWithFilename:@"SF-Pro-Display-BoldItalic"];
    [self registerFontWithFilename:@"SF-Pro-Display-Heavy"];
    [self registerFontWithFilename:@"SF-Pro-Display-HeavyItalic"];
    [self registerFontWithFilename:@"SF-Pro-Display-Light"];
    [self registerFontWithFilename:@"SF-Pro-Display-LightItalic"];
    [self registerFontWithFilename:@"SF-Pro-Display-Medium"];
    [self registerFontWithFilename:@"SF-Pro-Display-MediumItalic"];
    [self registerFontWithFilename:@"SF-Pro-Display-Regular"];
    [self registerFontWithFilename:@"SF-Pro-Display-RegularItalic"];
    [self registerFontWithFilename:@"SF-Pro-Display-Semibold"];
    [self registerFontWithFilename:@"SF-Pro-Display-SemiboldItalic"];
    [self registerFontWithFilename:@"SF-Pro-Display-Thin"];
    [self registerFontWithFilename:@"SF-Pro-Display-ThinItalic"];
    [self registerFontWithFilename:@"SF-Pro-Display-Ultralight"];
    [self registerFontWithFilename:@"SF-Pro-Display-UltralightItalic"];
    [self registerFontWithFilename:@"SF-Pro-Text-Bold"];
    [self registerFontWithFilename:@"SF-Pro-Text-BoldItalic"];
    [self registerFontWithFilename:@"SF-Pro-Text-Heavy"];
    [self registerFontWithFilename:@"SF-Pro-Text-HeavyItalic"];
    [self registerFontWithFilename:@"SF-Pro-Text-Light"];
    [self registerFontWithFilename:@"SF-Pro-Text-LightItalic"];
    [self registerFontWithFilename:@"SF-Pro-Text-Medium"];
    [self registerFontWithFilename:@"SF-Pro-Text-MediumItalic"];
    [self registerFontWithFilename:@"SF-Pro-Text-Regular"];
    [self registerFontWithFilename:@"SF-Pro-Text-RegularItalic"];
    [self registerFontWithFilename:@"SF-Pro-Text-Semibold"];
    [self registerFontWithFilename:@"SF-Pro-Text-SemiboldItalic"];
}

+ (void)registerFontWithFilename:(NSString *)filename {
    if ([NSBundle.fontsBundle isLoaded]) {
        [NSBundle.fontsBundle load];
    }
    
    NSString *path = [NSBundle.fontsBundle pathForResource:filename ofType:@"otf"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    CFErrorRef error;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        NSLog(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
    }
    CFRelease(font);
    CFRelease(provider);
}

# pragma mark - SF Pro Display Font Family

+ (UIFont *)SFProDisplayBlackWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-Black" size:size];
}

+ (UIFont *)SFProDisplayBlackItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-BlackItalic" size:size];
}

+ (UIFont *)SFProDisplayBoldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-Bold" size:size];
}

+ (UIFont *)SFProDisplayBoldItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-BoldItalic" size:size];
}

+ (UIFont *)SFProDisplayHeavyWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-Heavy" size:size];
}

+ (UIFont *)SFProDisplayHeavyItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-HeavyItalic" size:size];
}

+ (UIFont *)SFProDisplayLightWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-Light" size:size];}

+ (UIFont *)SFProDisplayLightItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-LightItalic" size:size];
}

+ (UIFont *)SFProDisplayMediumWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-Medium" size:size];
}

+ (UIFont *)SFProDisplayMediumItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-MediumItalic" size:size];
}

+ (UIFont *)SFProDisplayRegularWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-Regular" size:size];
}

+ (UIFont *)SFProDisplayRegularItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-RegularItalic" size:size];
}

+ (UIFont *)SFProDisplaySemiboldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-Semibold" size:size];
}

+ (UIFont *)SFProDisplaySemiboldItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-SemiboldItalic" size:size];
}

+ (UIFont *)SFProDisplayThinWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-Thin" size:size];
}

+ (UIFont *)SFProDisplayThinItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-ThinItalic" size:size];
}

+ (UIFont *)SFProDisplayUltralightWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-Ultralight" size:size];
}

+ (UIFont *)SFProDisplayUltralightItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProDisplay-UltralightItalic" size:size];
}

# pragma mark - SF Pro Text Font Family

+ (UIFont *)SFProTextBoldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-Bold" size:size];
}

+ (UIFont *)SFProTextBoldItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-BoldItalic" size:size];
}

+ (UIFont *)SFProTextHeavyWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-Heavy" size:size];
}

+ (UIFont *)SFProTextHeavyItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-HeavyItalic" size:size];
}

+ (UIFont *)SFProTextLightWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-Light" size:size];
}

+ (UIFont *)SFProTextLightItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-LightItalic" size:size];
}

+ (UIFont *)SFProTextMediumWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-Medium" size:size];
}

+ (UIFont *)SFProTextMediumItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-MediumItalic" size:size];
}

+ (UIFont *)SFProTextRegularWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-Regular" size:size];
}

+ (UIFont *)SFProTextRegularItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-RegularItalic" size:size];
}

+ (UIFont *)SFProTextSemiboldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-Semibold" size:size];
}

+ (UIFont *)SFProTextSemiboldItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFProText-SemiboldItalic" size:size];
}

@end
