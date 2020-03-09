//
//  JPConfiguration.m
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

#import "JPConfiguration.h"
#import "JPAmount.h"
#import "JPPaymentMethod.h"
#import "JPPrimaryAccountDetails.h"
#import "JPReference.h"

@interface JPConfiguration ()
@property (nonatomic, strong) NSString *_Nullable judoId;
@property (nonatomic, strong) NSString *_Nullable receiptId;
@end

@implementation JPConfiguration

#pragma mark - Initializers

- (instancetype)initWithJudoID:(nonnull NSString *)judoId
                        amount:(nonnull JPAmount *)amount
                     reference:(nonnull JPReference *)reference {
    if (self = [super init]) {
        self.judoId = judoId;
        self.amount = amount;
        self.reference = reference;
    }
    return self;
}

- (instancetype)initWithReceiptID:(nonnull NSString *)receiptId
                           amount:(nonnull JPAmount *)amount {
    if (self = [super init]) {
        self.receiptId = receiptId;
        self.amount = amount;
    }
    return self;
}

#pragma mark - Lazy properties

- (JPUIConfiguration *)uiConfiguration {
    if (!_uiConfiguration) {
        _uiConfiguration = [JPUIConfiguration new];
    }
    return _uiConfiguration;
}

@end
