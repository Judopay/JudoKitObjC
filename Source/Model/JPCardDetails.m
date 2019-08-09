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
    if (self = [super init]) {
        self.cardLastFour = dictionary[@"cardLastfour"];
        self.endDate = dictionary[@"endDate"];
        self.cardToken = dictionary[@"cardToken"];
        self.cardNumber = dictionary[@"cardNumber"];
        self.cardNetwork = ((NSNumber *)dictionary[@"cardType"]).integerValue;
    }
    return self;
}

- (instancetype)initWithCardNumber:(NSString *)cardNumber
                       expiryMonth:(NSInteger)month
                        expiryYear:(NSInteger)year {
    if (self = [super init]) {
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

    if (self.cardNetwork == CardNetworkAMEX) {
        return [NSString stringWithFormat:@"**** ****** *%@", self.cardLastFour];
    }

    if (self.cardNetwork == CardNetworkUnknown) {
        return [NSString stringWithFormat:@"**** %@", self.cardLastFour];
    }

    return [NSString stringWithFormat:@"**** **** **** %@", self.cardLastFour];
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

#pragma mark - Lazy Loading

- (NSDateFormatter *)expiryDateFormatter {
    if (!_expiryDateFormatter) {
        _expiryDateFormatter = [NSDateFormatter new];
        _expiryDateFormatter.dateFormat = @"MM/yy";
    }
    return _expiryDateFormatter;
}

@end
