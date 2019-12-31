//
//  JPCardStorage.m
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

#import "JPCardStorage.h"
#import "JPKeychainService.h"

@interface JPCardStorage ()

@property (nonatomic, strong) NSMutableArray<JPStoredCardDetails *> *storedCards;

@end

@implementation JPCardStorage

+ (instancetype)sharedInstance {
    static JPCardStorage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [JPCardStorage new];
    });
    return sharedInstance;
}

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
    return self.storedCards.copy;
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

- (BOOL)deleteCardDetails {
    [self.storedCards removeAllObjects];
    return [JPKeychainService deleteObjectForKey:@"storedCards"];
}

@end
