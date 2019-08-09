//
//  JPCardNetwork.m
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
#import "JPConstants.h"
#import "NSArray+Prefix.h"

@implementation JPCardNetwork

+ (instancetype)networkWith:(CardNetwork)type
             numberPrefixes:(NSString *)prefixes {
    return [JPCardNetwork networkWith:type
                       numberPrefixes:prefixes
                   securityCodeLength:3
                        numberPattern:[self defaultNumberPattern]];
}

+ (instancetype)networkWith:(CardNetwork)type
             numberPrefixes:(NSString *)prefixes
         securityCodeLength:(NSUInteger)length
              numberPattern:(NSString *)pattern {
    JPCardNetwork *network = [JPCardNetwork new];
    network.network = type;
    network.numberPrefixes = [prefixes componentsSeparatedByString:@","];
    network.securityCodeLength = length;
    network.numberPattern = pattern;
    return network;
}

+ (NSDictionary<NSNumber *, NSString *> *)networkNames {
    static NSDictionary *_networkNames;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networkNames = @{
            @(CardNetworkUnknown) : @"Unknown Card Network",
            @(CardNetworkVisa) : @"Visa",
            @(CardNetworkMasterCard) : @"Mastercard",
            @(CardNetworkVisaElectron) : @"Visa Electron",
            @(CardNetworkSwitch) : @"Switch",
            @(CardNetworkSolo) : @"Solo",
            @(CardNetworkLaser) : @"Laser",
            @(CardNetworkChinaUnionPay) : @"China UnionPay",
            @(CardNetworkAMEX) : @"AmEx",
            @(CardNetworkJCB) : @"JCB",
            @(CardNetworkMaestro) : @"Maestro",
            @(CardNetworkVisaDebit) : @"Visa Debit",
            @(CardNetworkMasterCardDebit) : @"Mastercard Debit",
            @(CardNetworkVisaPurchasing) : @"Visa Purchasing",
            @(CardNetworkDiscover) : @"Discover",
            @(CardNetworkCarnet) : @"Carnet",
            @(CardNetworkCarteBancaire) : @"Carte Bancaire",
            @(CardNetworkDinersClub) : @"Diners Club",
            @(CardNetworkElo) : @"Elo",
            @(CardNetworkFarmersCard) : @"Farmers Card",
            @(CardNetworkSoriana) : @"Soriana",
            @(CardNetworkPrivateLabelCard) : @"Private Label",
            @(CardNetworkQCard) : @"Q Card",
            @(CardNetworkStyle) : @"Style",
            @(CardNetworkTrueRewards) : @"True Rewards",
            @(CardNetworkUATP) : @"UATP",
            @(CardNetworkBankCard) : @"Bank Card",
            @(CardNetworkBanamex_Costco) : @"Banamex Costco",
            @(CardNetworkInterPayment) : @"InterPayment",
            @(CardNetworkInstaPayment) : @"InstaPayment",
            @(CardNetworkDankort) : @"Dankort"
        };
    });

    return _networkNames;
}

+ (NSArray<JPCardNetwork *> *)supportedNetworks {
    static NSArray *_networks;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networks = @[
            [JPCardNetwork networkWith:CardNetworkVisa
                        numberPrefixes:kVisaPrefixes],

            [JPCardNetwork networkWith:CardNetworkUATP
                        numberPrefixes:kUATPPrefixes],

            [JPCardNetwork networkWith:CardNetworkDankort
                        numberPrefixes:kDankortPrefixes],

            [JPCardNetwork networkWith:CardNetworkInterPayment
                        numberPrefixes:kInterPaymentPrefixes],

            [JPCardNetwork networkWith:CardNetworkChinaUnionPay
                        numberPrefixes:kChinaUnionPayPrefixes],

            [JPCardNetwork networkWith:CardNetworkAMEX
                        numberPrefixes:kAMEXPrefixes
                    securityCodeLength:4
                         numberPattern:kAMEXPattern],

            [JPCardNetwork networkWith:CardNetworkMaestro
                        numberPrefixes:kMaestroPrefixes],

            [JPCardNetwork networkWith:CardNetworkDinersClub
                        numberPrefixes:kDinersClubPrefixes
                    securityCodeLength:3
                         numberPattern:kDinersClubPattern],

            [JPCardNetwork networkWith:CardNetworkInstaPayment
                        numberPrefixes:kInstaPaymentPrefixes],

            [JPCardNetwork networkWith:CardNetworkJCB
                        numberPrefixes:kJCBPrefixes],

            [JPCardNetwork networkWith:CardNetworkMasterCard
                        numberPrefixes:kMasterCardPrefixes],

            [JPCardNetwork networkWith:CardNetworkDiscover
                        numberPrefixes:kDiscoverPrefixes],
        ];
    });

    return _networks;
}

+ (CardNetwork)cardNetworkForCardNumber:(NSString *)cardNumber {
    __block CardNetwork network = CardNetworkUnknown;
    NSArray<JPCardNetwork *> *networks = [JPCardNetwork supportedNetworks];

    [networks enumerateObjectsUsingBlock:^(JPCardNetwork *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj.numberPrefixes containsPrefix:cardNumber]) {
            *stop = YES;
            network = obj.network;
            return;
        }
    }];

    return network;
}

+ (JPCardNetwork *)cardNetworkWithType:(CardNetwork)networkType {
    __block JPCardNetwork *network = nil;
    NSArray<JPCardNetwork *> *networks = [JPCardNetwork supportedNetworks];

    [networks enumerateObjectsUsingBlock:^(JPCardNetwork *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (obj.network == networkType) {
            *stop = YES;
            network = obj;
            return;
        }
    }];

    return network;
}

+ (NSString *)defaultNumberPattern {
    return kVISAPattern;
}

+ (NSString *)nameOfCardNetwork:(CardNetwork)network {
    NSDictionary *names = [JPCardNetwork networkNames];
    NSNumber *key = @(network);
    if ([names.allKeys containsObject:key]) {
        return names[key];
    }
    return names[@(CardNetworkUnknown)];
}

@end
