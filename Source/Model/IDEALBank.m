//
//  IDEALBank.m
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

#import "IDEALBank.h"
#import <Foundation/Foundation.h>

@implementation IDEALBank

+ (instancetype)bankWithType:(IDEALBankType)type {
    return [[IDEALBank alloc] initWithType:type];
}

- (instancetype)initWithType:(IDEALBankType)type {
    if (self = [super init]) {
        self.title = [self titleForType:type];
        self.bankIdentifierCode = [self bankIdentifierCodeForType:type];
        self.type = type;
    }
    return self;
}

- (NSString *)titleForType:(IDEALBankType)type {
    NSArray *bankNames = @[
        @"None", @"Rabobank", @"ABN AMRO", @"Van Lanschot Bankiers",
        @"Triodos Bank", @"ING Bank", @"SNS Bank", @"ASN", @"RegioBank",
        @"Knab", @"Bunq", @"Moneyou", @"Handelsbanken"
    ];

    return bankNames[type];
}

- (NSString *)bankIdentifierCodeForType:(IDEALBankType)type {
    NSArray *bankIdentifierCodes = @[
        @"None", @"RABONL2U", @"ABNANL2A", @"FVLBNL22", @"TRIONL2U",
        @"INGBNL2A", @"SNSBNL2A", @"ASNBNL21", @"RBRBNL21", @"KNABNL2H",
        @"BUNQNL2A", @"MOYONL21", @"HANDNL2A"
    ];

    return bankIdentifierCodes[type];
}

@end
