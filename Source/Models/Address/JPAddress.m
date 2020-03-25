//
//  JPAddress.m
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

#import "JPAddress.h"

@implementation JPAddress

- (instancetype)initWithLine1:(NSString *)line1
                        line2:(NSString *)line2
                        line3:(NSString *)line3
                         town:(NSString *)town
               billingCountry:(NSString *)billingCountry
                     postCode:(NSString *)postCode {

    if (self = [super init]) {
        self.line1 = line1;
        self.line2 = line2;
        self.line3 = line3;
        self.postCode = postCode;
        self.town = town;
        self.billingCountry = billingCountry;
    }
    return self;
}

- (nonnull instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self populateWith:dictionary];
    }
    return self;
}

- (id)copy {
    return [[JPAddress alloc] initWithLine1:self.line1
                                      line2:self.line2
                                      line3:self.line3
                                       town:self.town
                             billingCountry:self.billingCountry
                                   postCode:self.postCode];
}

- (void)populateWith:(NSDictionary *)dictionary {
    if (dictionary[@"line1"]) {
        self.line1 = dictionary[@"line1"];
    }
    if (dictionary[@"line2"]) {
        self.line2 = dictionary[@"line2"];
    }
    if (dictionary[@"line3"]) {
        self.line3 = dictionary[@"line3"];
    }
    if (dictionary[@"postCode"]) {
        self.postCode = dictionary[@"postCode"];
    }
    if (dictionary[@"town"]) {
        self.town = dictionary[@"town"];
    }
    if (dictionary[@"billingCountry"]) {
        self.billingCountry = dictionary[@"billingCountry"];
    }
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (self.line1) {
        dictionary[@"line1"] = self.line1;
    }
    if (self.line2) {
        dictionary[@"line2"] = self.line2;
    }
    if (self.line3) {
        dictionary[@"line3"] = self.line3;
    }
    if (self.postCode) {
        dictionary[@"postCode"] = self.postCode;
    }
    if (self.town) {
        dictionary[@"town"] = self.town;
    }
    if (self.billingCountry) {
        dictionary[@"billingCountry"] = self.billingCountry;
    }
    return [dictionary copy];
}

@end
