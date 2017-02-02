//
//  WalletCard.h
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

#import <Foundation/Foundation.h>

@interface WalletCard : NSObject

@property (nonnull, atomic, strong, readonly) NSUUID *walletId;
@property (nonnull, atomic, strong, readonly) NSString *cardNumberLastFour;
@property (nonnull, atomic, strong, readonly) NSString *expiryDate;
@property (nonnull, atomic, strong, readonly) NSString *cardToken;
@property (atomic, readonly) NSInteger cardType;
@property (nullable, atomic, strong, readonly) NSString *assignedName;
@property (nonnull, atomic, strong, readonly) NSDate *dateCreated;
@property (nullable, atomic, strong, readonly) NSDate *dateUpdated;
@property (atomic, readonly) BOOL defaultPaymentMethod;

- (nonnull instancetype) initWithCardData:(nonnull NSString *)cardNumberLastFour
                         expiryDate:(nonnull NSString *)expiryDate
                         cardToken:(nonnull NSString *)cardToken
                         cardType:(NSInteger)cardType
                         assignedName:(nullable NSString *)assignedName
                         defaultPaymentMethod:(BOOL)defaultPaymentMethod;


- (nonnull WalletCard *)withDefaultCard;
- (nonnull WalletCard *)withNonDefaultCard;
- (nonnull WalletCard *)withAssignedCardName:(nonnull NSString *)assignedName;
- (BOOL)hasCardExpired;

@end
