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
    JPCardPatternType randomType = (JPCardPatternType)(arc4random_uniform((int)JPCardPatternTypeOlive) + 1);
    return [JPCardPattern patternWithType:randomType];
}

+ (instancetype)patternWithType:(JPCardPatternType)type {
    return [[JPCardPattern alloc] initWithType:type];
}

- (instancetype)initWithType:(JPCardPatternType)type {
    if (self = [super init]) {
        _type = type;
        _color = [self backgroundColorForType:type];
        _image = [self imageForType:type];
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
            return [UIImage imageWithResourceName:@"pattern-lines"];
        case JPCardPatternTypeBlue:
            return [UIImage imageWithResourceName:@"pattern-waves"];
        case JPCardPatternTypeGreen:
            return [UIImage imageWithResourceName:@"pattern-triangles"];
        case JPCardPatternTypeRed:
            return [UIImage imageWithResourceName:@"pattern-lines"];
        case JPCardPatternTypeOrange:
            return [UIImage imageWithResourceName:@"pattern-bubbles"];
        case JPCardPatternTypeGold:
            return [UIImage imageWithResourceName:@"pattern-erratic"];
        case JPCardPatternTypeCyan:
            return [UIImage imageWithResourceName:@"pattern-triangles"];
        case JPCardPatternTypeOlive:
            return [UIImage imageWithResourceName:@"pattern-erratic"];
    }
    return [UIImage new];
}

@end
