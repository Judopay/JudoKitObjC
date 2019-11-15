//
//  JPPrimaryAccountDetails.h
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

#import "JPPrimaryAccountDetails.h"

@implementation JPPrimaryAccountDetails

+ (instancetype)detailsFromDictionary:(NSDictionary *)dictionary {
    return [[JPPrimaryAccountDetails alloc] initFromDictionary:dictionary];
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {

    if (self = [super init]) {
        _name = dictionary[@"name"];
        _accountNumber = dictionary[@"accountNumber"];
        _dateOfBirth = dictionary[@"dateOfBirth"];
        _postCode = dictionary[@"postCode"];
    }

    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];

    if (_name) {
        dictionary[@"name"] = _name;
    }

    if (_accountNumber) {
        dictionary[@"accountNumber"] = _accountNumber;
    }

    if (_dateOfBirth) {
        dictionary[@"dateOfBirth"] = _dateOfBirth;
    }

    if (_postCode) {
        dictionary[@"postCode"] = _postCode;
    }

    return dictionary;
}

@end
