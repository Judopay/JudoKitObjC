//
//  NSString+Manipulation.m
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

#import "NSString+Manipulation.h"

@implementation NSString (Manipulation)

- (NSString *)stringByReplacingCharactersInSet:(NSCharacterSet *)charSet withString:(NSString *)aString {
    NSMutableString *string = [NSMutableString stringWithCapacity:self.length];
    for (NSUInteger index = 0; index < self.length; ++index) {
        unichar character = [self characterAtIndex:index];
        if ([charSet characterIsMember:character]) {
            [string appendString:aString];
        } else {
            [string appendFormat:@"%C", character];
        }
    }
    return string;
}

- (NSString *)stringByRemovingWhitespaces {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (nonnull NSString *)formatWithPattern:(nonnull NSString *)pattern {
    const char *patternString = pattern.UTF8String;
    NSString *returnString = @"";
    NSInteger patternIndex = 0;

    for (int i = 0; i < self.length; i++) {
        const char element = patternString[patternIndex];

        if (element == 'X') {
            char num = [self characterAtIndex:i];
            returnString = [returnString stringByAppendingString:[NSString stringWithFormat:@"%c", num]];
        } else {
            char num = [self characterAtIndex:i];
            returnString = [returnString stringByAppendingString:[NSString stringWithFormat:@" %c", num]];
            patternIndex++;
        }

        patternIndex++;
    }

    return returnString;
}

- (nonnull NSDictionary<NSString *, NSString *> *)extractURLComponentsQueryItems {
    NSMutableDictionary *results = [NSMutableDictionary dictionary];

    for (NSString *pair in [self componentsSeparatedByString:@"&"]) {
        if ([pair rangeOfString:@"="].location != NSNotFound) {
            NSArray *components = [pair componentsSeparatedByString:@"="];
            NSString *key = [components firstObject];
            NSString *value = [[components lastObject] stringByRemovingPercentEncoding];

            results[key] = value;
        }
    }

    return results;
}

@end
