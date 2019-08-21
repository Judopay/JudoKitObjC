//
//  NSString+Card.m
//  JudoKitObjC
//
//  Copyright © 2016 Alternative Payments Ltd. All rights reserved.
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
#import "JPConstants.h"
#import "NSArray+Prefix.h"
#import "NSError+Judo.h"
#import "NSString+Card.h"
#import "NSString+Localize.h"
#import "NSString+Manipulation.h"
#import "NSString+Validation.h"

@implementation NSString (Card)

- (NSString *)cardPresentationStringWithAcceptedNetworks:(NSArray *)networks
                                                   error:(NSError **)error {
    // strip whitespaces
    NSString *strippedString = [self stringByRemovingWhitespaces];

    // check if count is between 0 and 16
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

    // Only try to format if a specific card number has been recognized
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
    if (network == CardNetworkUATP || network == CardNetworkAMEX) {
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

    // make sure to only check for the allowed networks
    BOOL networkAccepted = [networks containsObject:@(network)];

    if (!networkAccepted && network != CardNetworkUnknown) {
        if (error != NULL) {
            NSString *cardNetworkName = [JPCardNetwork nameOfCardNetwork:network];
            NSString *message = [NSString stringWithFormat:@"error_card_not_supported".localized, cardNetworkName];
            *error = [NSError judoInputMismatchErrorWithMessage:message];
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

@end
