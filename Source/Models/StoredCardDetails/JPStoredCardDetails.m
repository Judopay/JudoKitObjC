//
//  JPStoredCardDetails.m
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

#import "JPStoredCardDetails.h"

@implementation JPStoredCardDetails

- (instancetype)initWithLastFour:(NSString *)lastFour
                      expiryDate:(NSString *)expiryDate
                     cardNetwork:(CardNetwork)network
                       cardToken:(NSString *)cardToken {
    if (self = [super init]) {
        self.cardLastFour = lastFour;
        self.expiryDate = expiryDate;
        self.cardNetwork = network;
        self.cardToken = cardToken;
    }
    return self;
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    NSString *cardTitle = dictionary[@"cardTitle"];
    NSNumber *patternType = dictionary[@"cardPatternType"];
    NSString *cardLastFour = dictionary[@"cardLastFour"];
    NSString *expiryDate = dictionary[@"expiryDate"];
    NSNumber *cardNetwork = dictionary[@"cardNetwork"];
    NSString *cardToken = dictionary[@"cardToken"];
    NSNumber *isDefault = dictionary[@"isDefault"];
    NSNumber *isSelected = dictionary[@"isSelected"];

    JPStoredCardDetails *storedCardDetails = [self initWithLastFour:cardLastFour
                                                         expiryDate:expiryDate
                                                        cardNetwork:cardNetwork.intValue
                                                          cardToken:cardToken];

    storedCardDetails.cardTitle = cardTitle;
    storedCardDetails.patternType = patternType.intValue;
    storedCardDetails.isDefault = isDefault.boolValue;
    storedCardDetails.isSelected = isSelected.boolValue;

    return storedCardDetails;
}

+ (instancetype)cardDetailsWithLastFour:(NSString *)lastFour
                             expiryDate:(NSString *)expiryDate
                            cardNetwork:(CardNetwork)network
                              cardToken:(NSString *)cardToken {

    return [[JPStoredCardDetails new] initWithLastFour:lastFour
                                            expiryDate:expiryDate
                                           cardNetwork:network
                                             cardToken:cardToken];
}

+ (instancetype)cardDetailsFromDictionary:(NSDictionary *)dictionary {
    return [[JPStoredCardDetails new] initFromDictionary:dictionary];
}

- (NSDictionary *)toDictionary {
    return @{
        @"cardTitle" : self.cardTitle,
        @"cardPatternType" : @(self.patternType),
        @"cardLastFour" : self.cardLastFour,
        @"expiryDate" : self.expiryDate,
        @"cardNetwork" : @(self.cardNetwork),
        @"cardToken" : self.cardToken,
        @"isDefault" : @(self.isDefault),
        @"isSelected" : @(self.isSelected)
    };
}

@end
