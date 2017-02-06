//
//  InMemoryWalletRepository.m
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

#import "InMemoryWalletRepository.h"

@interface InMemoryWalletRepository()

@property (nonnull, nonatomic, strong) NSMutableArray<WalletCard *> *repo;

@end

@implementation InMemoryWalletRepository

- (nonnull instancetype)init {
    self = [super init];
    
    if (self) {
        self.repo = [NSMutableArray new];
    }
    
    return self;
}

- (void)save:(nonnull WalletCard *)walletCard {
    [self.repo addObject:walletCard];
}

- (nonnull NSArray<WalletCard *> *)get {
    return [self.repo copy];
}

- (nullable WalletCard *)get:(nonnull NSUUID *)walletId {
    for (WalletCard *card in self.repo) {
        if ([walletId isEqual:card.walletId]) {
            return card;
        }
    }
    
    return nil;
}

- (void)remove:(nonnull NSUUID *)walletId {
    NSMutableArray<WalletCard *> *newCards = [NSMutableArray new];
    
    for (WalletCard *card in self.repo) {
        if (![walletId isEqual:card.walletId]) {
            [newCards addObject:card];
        }
    }
    
    self.repo = newCards;
}

@end
