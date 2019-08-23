//
//  PostalAddress.m
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

#import "PostalAddress.h"

@implementation PostalAddress

- (instancetype)initWithSteet:(NSString *)street
                         city:(NSString *)city
                        state:(NSString *)state
                   postalCode:(NSString *)postalCode
                      country:(NSString *)country
                      isoCode:(NSString *)isoCode
        subAdministrativeArea:(nullable NSString *)subAdministrativeArea
                  sublocality:(nullable NSString *)sublocality {

    if (self = [super init]) {
        self.street = street;
        self.city = city;
        self.state = state;
        self.postalCode = postalCode;
        self.country = country;
        self.isoCode = isoCode;
        self.subAdministrativeArea = subAdministrativeArea;
        self.sublocality = sublocality;
    }

    return self;
}

@end
