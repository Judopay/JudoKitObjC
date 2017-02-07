//
//  JPCardDetails.m
//  JudoKitObjC
//
//  Copyright (c) 2016 Alternative Payments Ltd
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

#import "JPCardDetails.h"
#import "NSString+Card.h"

@interface JPCardDetails ()

@property (nonatomic, strong) NSDateFormatter *expiryDateFormatter;

@end

@implementation JPCardDetails

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
        self.cardLastFour = dictionary[@"cardLastfour"];
        self.endDate = dictionary[@"endDate"];
        self.cardToken = dictionary[@"cardToken"];
        self.cardNumber = dictionary[@"cardNumber"];
        self.cardNetwork = ((NSNumber *)dictionary[@"cardType"]).integerValue;
	}
	return self;
}

- (instancetype)initWithCardNumber:(NSString *)cardNumber expiryMonth:(NSInteger)month expiryYear:(NSInteger)year {
    self = [super init];
    if (self) {
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comp = [NSDateComponents new];
        comp.year = year;
        comp.month = month;
        NSDate *expiryDate = [calendar dateFromComponents:comp];
        self.endDate = [self.expiryDateFormatter stringFromDate:expiryDate];
        self.cardNumber = cardNumber;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.cardLastFour = [decoder decodeObjectForKey:@"cardLastFour"];
        self.endDate = [decoder decodeObjectForKey:@"endDate"];
        self.cardToken = [decoder decodeObjectForKey:@"cardToken"];
        self.cardNetwork = [decoder decodeIntegerForKey:@"cardNetwork"];
        self.cardNumber = nil;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.cardLastFour forKey:@"cardLastFour"];
    [encoder encodeObject:self.endDate forKey:@"endDate"];
    [encoder encodeObject:self.cardToken forKey:@"cardToken"];
    [encoder encodeInt64:self.cardNetwork forKey:@"cardNetwork"];
}

- (CardNetwork)cardNetwork {
    if (_cardNetwork == CardNetworkUnknown && self.cardNumber) {
        _cardNetwork = self.cardNumber.cardNetwork;
    }
    return _cardNetwork;
}

- (nullable NSString *)formattedCardLastFour {
    if (!self.cardLastFour && !self.cardNumber) {
        return nil;
    } else if (self.cardNumber) {
        self.cardLastFour = [self.cardNumber substringFromIndex:self.cardNumber.length - 4];
    }
    
    switch (self.cardNetwork) {
        case CardNetworkAMEX:
            return [NSString stringWithFormat:@"**** ****** *%@", self.cardLastFour];
            break;
        case CardNetworkUnknown:
            return [NSString stringWithFormat:@"**** %@", self.cardLastFour];
            break;
        default:
            return [NSString stringWithFormat:@"**** **** **** %@", self.cardLastFour];
            break;
    }
    
}

- (nullable NSString *)formattedExpiryDate {
    if (!self.endDate) {
        return nil;
    }
    
    if (self.endDate.length == 4) {
        NSString *prefix = [self.endDate substringToIndex:2];
        NSString *suffix = [self.endDate substringFromIndex:2];
        return [NSString stringWithFormat:@"%@/%@", prefix, suffix];
    }
    return self.endDate;
}

+ (nonnull NSString *)titleForCardNetwork:(CardNetwork)network {
    switch (network) {
        case CardNetworkUnknown:
        return @"Unknown Card Network";
        case CardNetworkVisa:
        return @"Visa";
        case CardNetworkMasterCard:
        return @"Mastercard";
        case CardNetworkVisaElectron:
        return @"Visa Electron";
        case CardNetworkSwitch:
        return @"Switch";
        case CardNetworkSolo:
        return @"Solo";
        case CardNetworkLaser:
        return @"Laser";
        case CardNetworkChinaUnionPay:
        return @"China UnionPay";
        case CardNetworkAMEX:
        return @"AmEx";
        case CardNetworkJCB:
        return @"JCB";
        case CardNetworkMaestro:
        return @"Maestro";
        case CardNetworkVisaDebit:
        return @"Visa Debit";
        case CardNetworkMasterCardDebit:
        return @"Mastercard Debit";
        case CardNetworkVisaPurchasing:
        return @"Visa Purchasing";
        case CardNetworkDiscover:
        return @"Discover";
        case CardNetworkCarnet:
        return @"Carnet";
        case CardNetworkCarteBancaire:
        return @"Carte Bancaire";
        case CardNetworkDinersClub:
        return @"Diners Club";
        case CardNetworkElo:
        return @"Elo";
        case CardNetworkFarmersCard:
        return @"Farmers Card";
        case CardNetworkSoriana:
        return @"Soriana";
        case CardNetworkPrivateLabelCard:
        return @"Private Label";
        case CardNetworkQCard:
        return @"Q Card";
        case CardNetworkStyle:
        return @"Style";
        case CardNetworkTrueRewards:
        return @"True Rewards";
        case CardNetworkUATP:
        return @"UATP";
        case CardNetworkBankCard:
        return @"Bank Card";
        case CardNetworkBanamex_Costco:
        return @"Banamex Costco";
        case CardNetworkInterPayment:
        return @"InterPayment";
        case CardNetworkInstaPayment:
        return @"InstaPayment";
        case CardNetworkDankort:
        return @"Dankort";
    }
}

#pragma mark - Lazy Loading

- (NSDateFormatter *)expiryDateFormatter {
    if (!_expiryDateFormatter) {
        _expiryDateFormatter = [NSDateFormatter new];
        _expiryDateFormatter.dateFormat = @"MM/yy";
    }
    return _expiryDateFormatter;
}


@end
