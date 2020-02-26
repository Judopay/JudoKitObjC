//
//  JPCardPattern.h
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JPCardPatternType) {
    JPCardPatternTypeBlack = 1,
    JPCardPatternTypeBlue,
    JPCardPatternTypeGreen,
    JPCardPatternTypeRed,
    JPCardPatternTypeOrange,
    JPCardPatternTypeGold,
    JPCardPatternTypeCyan,
    JPCardPatternTypeOlive,
};

@interface JPCardPattern : NSObject

/**
 * The card pattern type used to identify the pattern
 */
@property (nonatomic, assign, readonly) JPCardPatternType type;

/**
 * The color of the pattern
 */
@property (nonatomic, strong, readonly) UIColor *color;

/**
 * The associated pattern image
 */
@property (nonatomic, strong, readonly) UIImage *image;

/**
 * Convenience initializer that creates a JPCardPattern with a JPCardPatternTypeBlack type
 *
 * @returns a configured instance of JPCardPattern
 */
+ (instancetype)black;

/**
 * Convenience initializer that creates a JPCardPattern with a JPCardPatternTypeBlue type
 *
 * @returns a configured instance of JPCardPattern
 */
+ (instancetype)blue;

/**
 * Convenience initializer that creates a JPCardPattern with a JPCardPatternTypeGreen type
 *
 * @returns a configured instance of JPCardPattern
 */
+ (instancetype)green;

/**
 * Convenience initializer that creates a JPCardPattern with a JPCardPatternTypeRed type
 *
 * @returns a configured instance of JPCardPattern
 */
+ (instancetype)red;

/**
 * Convenience initializer that creates a JPCardPattern with a JPCardPatternTypeOrange type
 *
 * @returns a configured instance of JPCardPattern
 */
+ (instancetype)orange;

/**
 * Convenience initializer that creates a JPCardPattern with a JPCardPatternTypeGold type
 *
 * @returns a configured instance of JPCardPattern
 */
+ (instancetype)gold;

/**
 * Convenience initializer that creates a JPCardPattern with a JPCardPatternTypeCyan type
 *
 * @returns a configured instance of JPCardPattern
 */
+ (instancetype)cyan;

/**
 * Convenience initializer that creates a JPCardPattern with a JPCardPatternTypeOlive type
 */
+ (instancetype)olive;

/**
 * Convenience initializer that creates a JPCardPattern with a random type
 */
+ (instancetype)random;

/**
 * Convenience initializer that creates a JPCardPattern based on a provided type;
 *
 * @param type - the pattern type
 *
 * @returns a configured instance of JPCardPattern
 */
+ (instancetype)patternWithType:(JPCardPatternType)type;

/**
 * Designated initializer that creates a JPCardPattern based on a provided type;
 *
 * @param type - the pattern type
 *
 * @returns a configured instance of JPCardPattern
 */
- (instancetype)initWithType:(JPCardPatternType)type;

@end
