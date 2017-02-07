//
//  WalletService.m
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

#import "WalletService.h"
#import "NSError+JudoWallet.h"

@interface WalletService()

@property(atomic, readwrite) NSInteger maxNumberOfCardsAllowed;
@property(atomic, readwrite) id<WalletRepositoryProtocol> repo;

@end

@implementation WalletService

- (nonnull instancetype)initWithWalletRepository:(nonnull id<WalletRepositoryProtocol>)walletRepository {
    self = [super init];
    
    if (self) {
        if ([walletRepository conformsToProtocol:@protocol(WalletRepositoryProtocol)]) {
            self.maxNumberOfCardsAllowed = 20;
            self.repo = walletRepository;
        }
    }
    
    return self;
}

- (void)add:(nonnull WalletCard *)card error:(NSError * _Nullable * _Nullable)error {
    if ([self walletIsFull]) {
        *error = [NSError walletCardLimitPassed:nil];
        return;
    }
    
    if ([self walletIsEmpty]) {
        [self.repo save:card.withDefaultCard];
    }
    else {
        if (card.defaultPaymentMethod) {
            [self resignCurrentDefault];
        }
        
        [self.repo save:card];
    }
}

- (void)update:(nonnull WalletCard *)card error:(NSError * _Nullable * _Nullable)error {
    WalletCard *currentCard = [self get:card.walletId];
    
    if (!currentCard) {
        *error = [NSError unknownWalletCard:nil];
        return;
    }
    
    if ([self isIllegallyResigningDefault:currentCard updatedCard:card]) {
        *error = [NSError cannotResignDefaultCard:nil];
        return;
    }
    
    [self.repo remove:card.walletId];
    [self add:card error:error];
}

- (void)remove:(nonnull WalletCard *)card error:(NSError * _Nullable * _Nullable)error {
    if ([[self getUnordered] count] > 1 && card.defaultPaymentMethod) {
        *error = [NSError cannotRemoveDefaultCard:nil];
        return;
    }
    
    [self.repo remove:card.walletId];
}

- (nullable WalletCard *)get:(nonnull NSUUID *)walletId {
    return [self.repo get:walletId];
}

- (nonnull NSArray<WalletCard *> *)get {
    NSArray<WalletCard *> *unorderedCards = [self getUnordered];
    NSArray *array = [unorderedCards sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        WalletCard *lhs = (WalletCard*)a;
        WalletCard *rhs = (WalletCard*)b;
        
        if (lhs.defaultPaymentMethod && !rhs.defaultPaymentMethod) {
            return true;
        }
        else if(!lhs.defaultPaymentMethod && rhs.defaultPaymentMethod) {
            return false;
        }
        
        return [lhs.dateCreated compare:rhs.dateCreated] == NSOrderedDescending;
    }];
    return [[array reverseObjectEnumerator] allObjects];
}

- (nullable WalletCard *)getDefault {
    NSArray<WalletCard *> *unorderedCards = [self getUnordered];
    
    for (WalletCard * card in unorderedCards) {
        if (card.defaultPaymentMethod) {
            return card;
        }
    }
    
    return nil;
}

- (void)makeDefault:(WalletCard *)card {
    [self.repo remove:card.walletId];
    [self.repo save:[card withDefaultCard]];
}

- (void)resignCurrentDefault{
    WalletCard *currentDefault = [self getDefault];
    
    if (currentDefault) {
        [self.repo remove:currentDefault.walletId];
        [self.repo save:[currentDefault withNonDefaultCard]];
    }
}

- (BOOL)isIllegallyResigningDefault:(WalletCard *)currentCard updatedCard:(WalletCard *)updatedCard {
    return ![self walletIsEmpty] && currentCard.defaultPaymentMethod && !updatedCard.defaultPaymentMethod;
}

- (NSArray<WalletCard *> *)getUnordered {
    return [self.repo get];
}

- (BOOL)walletIsEmpty {
    return [[self get] count] == 0;
}

- (BOOL)walletIsFull {
    return [[self get] count] >= self.maxNumberOfCardsAllowed;
}

@end
