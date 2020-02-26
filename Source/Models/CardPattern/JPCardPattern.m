//
//  JPCardPattern.m
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

#import "JPCardPattern.h"
#import "UIColor+Additions.h"
#import "UIImage+Additions.h"

@implementation JPCardPattern

#pragma mark - Initializers

+ (instancetype)black {
    return [JPCardPattern patternWithType:JPCardPatternTypeBlack];
}

+ (instancetype)blue {
    return [JPCardPattern patternWithType:JPCardPatternTypeBlue];
}

+ (instancetype)green {
    return [JPCardPattern patternWithType:JPCardPatternTypeGreen];
}

+ (instancetype)red {
    return [JPCardPattern patternWithType:JPCardPatternTypeRed];
}

+ (instancetype)orange {
    return [JPCardPattern patternWithType:JPCardPatternTypeOrange];
}

+ (instancetype)gold {
    return [JPCardPattern patternWithType:JPCardPatternTypeGold];
}

+ (instancetype)cyan {
    return [JPCardPattern patternWithType:JPCardPatternTypeCyan];
}

+ (instancetype)olive {
    return [JPCardPattern patternWithType:JPCardPatternTypeOlive];
}

+ (instancetype)random {
    JPCardPatternType randomType = (JPCardPatternType)(arc4random() % (int)JPCardPatternTypeOlive);
    return [JPCardPattern patternWithType:randomType];
}

+ (instancetype)patternWithType:(JPCardPatternType)type {
    return [[JPCardPattern alloc] initWithType:type];
}

- (instancetype)initWithType:(JPCardPatternType)type {
    if (self = [super init]) {
        _type = type;
        _color = [self backgroundColorForType:type];
        _image = [self imageForType: type];
    }
    return self;
}

#pragma mark - Helper methods

- (UIColor *)backgroundColorForType:(JPCardPatternType)type {
    switch (type) {
        case JPCardPatternTypeBlack:
            return [UIColor colorFromHex:0x262626];
        case JPCardPatternTypeBlue:
            return [UIColor colorFromHex:0x10316b];
        case JPCardPatternTypeGreen:
            return [UIColor colorFromHex:0x216338];
        case JPCardPatternTypeRed:
            return [UIColor colorFromHex:0xc2151b];
        case JPCardPatternTypeOrange:
            return [UIColor colorFromHex:0xe25822];
        case JPCardPatternTypeGold:
            return [UIColor colorFromHex:0xf9a01b];
        case JPCardPatternTypeCyan:
            return [UIColor colorFromHex:0x719192];
        case JPCardPatternTypeOlive:
            return [UIColor colorFromHex:0x808c12];
    }
    return UIColor.whiteColor;
}

- (UIImage *)imageForType:(JPCardPatternType)type {
    switch (type) {
        case JPCardPatternTypeBlack:
            return [UIImage imageWithResourceName:@"black_pattern"];
        case JPCardPatternTypeBlue:
            return [UIImage imageWithResourceName:@"blue_pattern"];
        case JPCardPatternTypeGreen:
            return [UIImage imageWithResourceName:@"green_pattern"];
        case JPCardPatternTypeRed:
            return [UIImage imageWithResourceName:@"red_pattern"];
        case JPCardPatternTypeOrange:
            return [UIImage imageWithResourceName:@"orange_pattern"];
        case JPCardPatternTypeGold:
            return [UIImage imageWithResourceName:@"gold_pattern"];
        case JPCardPatternTypeCyan:
            return [UIImage imageWithResourceName:@"cyan_pattern"];
        case JPCardPatternTypeOlive:
            return [UIImage imageWithResourceName:@"olive_pattern"];
    }
    return [UIImage new];
}

@end
