//
//  JPReference.m
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

#import "JPReference.h"
#import "NSString+Additions.h"

@interface JPReference ()

@property (nonatomic, strong, readwrite) NSString *consumerReference;
@property (nonatomic, strong, readwrite) NSString *paymentReference;

@end

@implementation JPReference

+ (instancetype)consumerReference:(NSString *)ref {
    return [[JPReference alloc] initWithConsumerReference:ref];
}

- (instancetype)initWithConsumerReference:(NSString *)ref {
    self = [super init];
    if (self) {
        self.paymentReference = [JPReference generatePaymentReference];
        self.consumerReference = ref;
    }
    return self;
}

- (instancetype)initWithConsumerReference:(NSString *)ref
                         paymentReference:(NSString *)paymentReference {
    self = [super init];
    if (self) {
        self.paymentReference = paymentReference;
        self.consumerReference = ref;
    }
    return self;
}

+ (NSString *)generatePaymentReference {
    NSMutableString *string = [NSMutableString stringWithCapacity:39];
    for (int i = 0; i < 39; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(26))];
    }
    return string;
}

@end
