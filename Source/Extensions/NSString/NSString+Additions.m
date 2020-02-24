//
//  NSString+Additions.m
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

#import "JPCardNetwork.h"
#import "NSBundle+Additions.h"
#import "NSError+Additions.h"
#import "NSString+Additions.h"
#import "UIFont+Additions.h"
#import <Foundation/Foundation.h>

@implementation NSString (Additions)

- (nonnull NSString *)localized {
    if (NSBundle.stringsBundle != nil) {
        return NSLocalizedStringFromTableInBundle(self, nil, NSBundle.stringsBundle, nil);
    }
    return NSLocalizedStringFromTableInBundle(self, nil, NSBundle.frameworkBundle, nil);
}

- (NSString *)toCurrencySymbol {
    return [NSLocale.currentLocale displayNameForKey:NSLocaleCurrencySymbol value:self];
}

- (NSString *)cardPresentationStringWithAcceptedNetworks:(NSArray *)networks
                                                   error:(NSError **)error {

    NSString *strippedString = [self stringByRemovingWhitespaces];

    if (strippedString.length == 0) {
        return @"";
    }

    CardNetwork network = strippedString.cardNetwork;
    BOOL isValidCardNumber = [self isValidCardNumber:strippedString
                                          forNetwork:network
                                    acceptedNetworks:networks
                                               error:error];

    if (!isValidCardNumber) {
        return nil;
    }

    if (network == CardNetworkUnknown) {
        return strippedString;
    }

    JPCardNetwork *cardNetwork = [JPCardNetwork cardNetworkWithType:network];
    NSString *pattern = [JPCardNetwork defaultNumberPattern];

    if (cardNetwork) {
        pattern = cardNetwork.numberPattern;
    }

    return [strippedString formatWithPattern:pattern];
}

- (CardNetwork)cardNetwork {
    return [JPCardNetwork cardNetworkForCardNumber:self];
}

- (BOOL)isCardNumberValid {
    NSString *strippedSelf = [self stringByRemovingWhitespaces];

    if ([strippedSelf rangeOfString:@"."].location != NSNotFound || !strippedSelf.isLuhnValid) {
        return false;
    }

    CardNetwork network = self.cardNetwork;
    if (network == CardNetworkAMEX) {
        return strippedSelf.length == 15;
    }

    return strippedSelf.length == 16;
}

- (BOOL)isValidCardNumber:(NSString *)number
               forNetwork:(CardNetwork)network
         acceptedNetworks:(NSArray *)networks
                    error:(NSError **)error {

    if (number.length > 16 || ![number isNumeric]) {
        if (error != NULL) {
            *error = [NSError judoInputMismatchErrorWithMessage:@"check_card_number".localized];
        }
        return NO;
    }

    if (network == CardNetworkAMEX && number.length > 15) {
        if (error != NULL) {
            *error = [NSError judoInputMismatchErrorWithMessage:@"check_card_number".localized];
        }
        return NO;
    }

    return YES;
}

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
    NSUInteger patternIndex = 0;

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

- (BOOL)isNumeric {
    NSString *regexPattern = @"^[0-9]*$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:0 error:nil];
    return [regex matchesInString:self options:NSMatchingAnchored range:NSMakeRange(0, self.length)].count;
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

- (nonnull NSMutableAttributedString *)attributedStringWithBoldSubstring:(nonnull NSString *)substring {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange substringRange = [self rangeOfString:substring];
    if (substringRange.location != NSNotFound) {
        [attributedString addAttributes:@{NSFontAttributeName : UIFont.captionBold} range:substringRange];
    }
    return attributedString;
}

@end
