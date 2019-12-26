//
//  JPCardStorage.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/26/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "JPCardStorage.h"
#import "JPKeychainService.h"

@interface JPCardStorage()

@property (nonatomic, strong) NSMutableArray <JPStoredCardDetails *> *storedCards;

@end

@implementation JPCardStorage

- (instancetype)init {
    if (self = [super init]) {
        
        self.storedCards = [NSMutableArray new];
        NSArray *storedCardsArray = [JPKeychainService getObjectForKey:@"storedCards"];
        
        for (NSDictionary *storedCardDictionary in storedCardsArray) {
            JPStoredCardDetails *storedCard = [JPStoredCardDetails cardDetailsFromDictionary:storedCardDictionary];
            [self.storedCards addObject:storedCard];
        }
        
    }
    return self;
}

- (NSMutableArray<JPStoredCardDetails *> *)getStoredCardDetails {
    return self.storedCards;
}

- (NSArray *)convertStoredCardsToArray {
    NSMutableArray *cardDetailsDictionary = [NSMutableArray new];
    for (JPStoredCardDetails *cardDetails in self.storedCards) {
        [cardDetailsDictionary addObject:cardDetails.toDictionary];
    }
    return cardDetailsDictionary;
}

- (void)addCardDetails:(JPStoredCardDetails *)cardDetails {
    [self.storedCards addObject:cardDetails];
    NSArray *cardDetailsArray = [self convertStoredCardsToArray];
    [JPKeychainService saveObject:cardDetailsArray forKey:@"storedCards"];
}

@end
