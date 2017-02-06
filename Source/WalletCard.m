//
//  WalletCard.m
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

#import "WalletCard.h"

@interface WalletCard()

@property (nonnull, atomic, strong, readwrite) NSUUID *walletId;
@property (nonnull, atomic, strong, readwrite) NSString *cardNumberLastFour;
@property (nonnull, atomic, strong, readwrite) NSString *expiryDate;
@property (nonnull, atomic, strong, readwrite) NSString *cardToken;
@property (atomic, readwrite) NSInteger cardType;
@property (nullable, atomic, strong, readwrite) NSString *assignedName;
@property (nonnull, atomic, strong, readwrite) NSDate *dateCreated;
@property (nullable, atomic, strong, readwrite) NSDate *dateUpdated;
@property (atomic, readwrite) BOOL defaultPaymentMethod;

@end

@implementation WalletCard

- (nonnull instancetype) initWithWalletId:(nonnull NSUUID *)walletId
                       cardNumberLastFour:(nonnull NSString *)cardNumberLastFour
                               expiryDate:(nonnull NSString *)expiryDate
                                cardToken:(nonnull NSString *)cardToken
                                 cardType:(NSInteger)cardType
                             assignedName:(nullable NSString *)assignedName
                              dateCreated:(nonnull NSDate *)dateCreated
                              dateUpdated:(nullable NSDate *)dateUpdated
                     defaultPaymentMethod:(BOOL)defaultPaymentMethod {
    self = [super init];
    
    if (self) {
        self.walletId = walletId;
        self.cardNumberLastFour = cardNumberLastFour;
        self.expiryDate = expiryDate;
        self.cardToken = cardToken;
        self.cardType = cardType;
        self.assignedName = assignedName;
        self.dateCreated = dateCreated;
        self.dateUpdated = dateUpdated;
        self.defaultPaymentMethod = defaultPaymentMethod;
    }
    
    return self;
}

- (nonnull instancetype) initWithCardData:(NSString *)cardNumberLastFour
                               expiryDate:(NSString *)expiryDate
                                cardToken:(NSString *)cardToken
                                 cardType:(NSInteger)cardType
                             assignedName:(NSString *)assignedName
                     defaultPaymentMethod:(BOOL)defaultPaymentMethod {
    return [self initWithWalletId:[NSUUID new] cardNumberLastFour:cardNumberLastFour expiryDate:expiryDate cardToken:cardToken cardType:cardType assignedName:assignedName dateCreated:[NSDate new] dateUpdated:nil defaultPaymentMethod:defaultPaymentMethod];
}

- (nonnull WalletCard *)withDefaultCard; {
    return [[WalletCard alloc] initWithWalletId:self.walletId cardNumberLastFour:self.cardNumberLastFour expiryDate:self.expiryDate cardToken:self.cardToken cardType:self.cardType assignedName:self.assignedName dateCreated:self.dateCreated dateUpdated:[NSDate new] defaultPaymentMethod:YES];
}

- (nonnull WalletCard *)withNonDefaultCard {
    return [[WalletCard alloc] initWithWalletId:self.walletId cardNumberLastFour:self.cardNumberLastFour expiryDate:self.expiryDate cardToken:self.cardToken cardType:self.cardType assignedName:self.assignedName dateCreated:self.dateCreated dateUpdated:[NSDate new] defaultPaymentMethod:NO];
}

- (nonnull WalletCard *)withAssignedCardName:(NSString *)assignedName {
    return [[WalletCard alloc] initWithWalletId:self.walletId cardNumberLastFour:self.cardNumberLastFour expiryDate:self.expiryDate cardToken:self.cardToken cardType:self.cardType assignedName:assignedName dateCreated:self.dateCreated dateUpdated:[NSDate new] defaultPaymentMethod:self.defaultPaymentMethod];
}

- (BOOL)hasCardExpired {
    NSArray<NSString *> *splitExpirydate = [self.expiryDate componentsSeparatedByString:@"/"];
    NSInteger month = [splitExpirydate[0] integerValue];
    NSString *yearAsString = [NSString stringWithFormat:@"%@%@", @"20", splitExpirydate[1]];
    NSInteger year = [yearAsString integerValue];
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = month;
    dateComponents.year = year;
    
    NSCalendar *calander = [NSCalendar currentCalendar];
    NSDate *date = [calander dateFromComponents:dateComponents];
    
    NSRange range = [calander rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:date];
    dateComponents.day = range.length;
    
    NSDate *now = [NSDate new];
    return [now compare:[calander dateFromComponents:dateComponents]] == NSOrderedDescending;
}

@end
