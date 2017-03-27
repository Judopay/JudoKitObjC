//
//  NSError+JudoWallet.m
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

#import "NSError+JudoWallet.h"

NSString * _Nonnull const JudoWalletErrorDomain = @"com.judo.error.judowallet";

NSString * _Nonnull const JudoWalletCardLimitPassedDescription = @"WalletCardLimitPassed";
NSString * _Nonnull const JudoWalletCardLimitPassedError = @"Too many cards have been added to the wallet.";

NSString * _Nonnull const JudoWalletUnknownWalletCardDescription = @"UnknownWalletCard";
NSString * _Nonnull const JudoWalletUnknownWalletCardError = @"The wallet card is not known. Has it been added?";

NSString * _Nonnull const JudoWalletCannotResignDefaultCardDescription = @"CannotResignDefaultCard";
NSString * _Nonnull const JudoWalletCannotResignDefaultCardError = @"Card cannot resign default status of this card.";

NSString * _Nonnull const JudoWalletCannotRemoveDefaultCardDescription = @"CannotRemoveDefaultCard";
NSString * _Nonnull const JudoWalletCannotRemoveDefaultCardError = @"Default card cannot be removed if two or more cards are in wallet.";

NSInteger const JudoWalletErrorCode = 1;

@implementation NSError (JudoWallet)

+ (nonnull NSError *)walletCardLimitPassed:(nullable NSError *)underlyingError {
    return [self getError:JudoWalletCardLimitPassedDescription failureReason:JudoWalletCardLimitPassedError underlyingError:underlyingError];
}

+ (nonnull NSError *)unknownWalletCard:(nullable NSError *)underlyingError {
    return [self getError:JudoWalletUnknownWalletCardDescription failureReason:JudoWalletUnknownWalletCardError underlyingError:underlyingError];
}

+ (nonnull NSError *)cannotResignDefaultCard:(nullable NSError *)underlyingError {
    return [self getError:JudoWalletCannotResignDefaultCardDescription failureReason:JudoWalletCannotResignDefaultCardError underlyingError:underlyingError];
}

+ (nonnull NSError *)cannotRemoveDefaultCard:(nullable NSError *)underlyingError {
    return [self getError:JudoWalletCannotRemoveDefaultCardDescription failureReason:JudoWalletCannotRemoveDefaultCardError underlyingError:underlyingError];
}

+ (nonnull NSError *)getError:(NSString *)description failureReason:(nonnull NSString *)failureReason underlyingError:(nullable NSError *)underlyingError {
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    
    [userInfo setValue:NSLocalizedString(description, nil) forKey:NSLocalizedDescriptionKey];
    [userInfo setValue:NSLocalizedString(failureReason, nil) forKey:NSLocalizedFailureReasonErrorKey];
    
    if (underlyingError != nil) {
        [userInfo setValue:underlyingError forKey:NSUnderlyingErrorKey];
    }
    
    return [NSError errorWithDomain:JudoWalletErrorDomain code:JudoWalletErrorCode userInfo:[userInfo copy]];
}

@end
