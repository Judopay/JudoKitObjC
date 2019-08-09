//
//  NSString+Validation.m
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

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isNumeric {
    NSString *regexPattern = @"^[0-9]*$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:0 error:nil];
    return [regex matchesInString:self options:NSMatchingAnchored range:NSMakeRange(0, self.length)].count;
}

- (BOOL)isAlphaNumeric {
    NSCharacterSet *nonAlphaNumeric = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return [self rangeOfCharacterFromSet:nonAlphaNumeric].location == NSNotFound;
}

- (BOOL)isLuhnValid {
    NSUInteger total = 0;
    NSUInteger len = [self length];

    for (NSUInteger index = len; index > 0;) {
        BOOL odd = (len - index) & 1;
        --index;
        unichar character = [self characterAtIndex:index];
        if (character < '0' || character > '9')
            continue;
        character -= '0';
        if (odd)
            character *= 2;
        if (character >= 10) {
            total += 1;
            character -= 10;
        }
        total += character;
    }

    return (total % 10) == 0;
}

@end
