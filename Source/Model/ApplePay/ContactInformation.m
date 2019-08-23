//
//  ContactInformation.m
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

#import "ContactInformation.h"

@implementation ContactInformation

- (instancetype)initWithEmailAddress:(NSString *)emailAddress
                                name:(NSPersonNameComponents *)name
                         phoneNumber:(NSString *)phoneNumber
                       postalAddress:(PostalAddress *)postalAddress {

    if (self = [super init]) {
        self.emailAddress = emailAddress;
        self.name = name;
        self.phoneNumber = phoneNumber;
        self.postalAddress = postalAddress;
    }

    return self;
}

- (NSString *)toString {
    NSMutableString *contactString = [NSMutableString new];

    if (self.emailAddress) {
        [contactString appendFormat:@"Email: %@\n", self.emailAddress];
    }

    if (self.name) {
        [contactString appendFormat:@"Name: %@\n", [self nameStringFromNameComponents:self.name]];
    }

    if (self.phoneNumber) {
        [contactString appendFormat:@"Phone: %@\n", self.phoneNumber];
    }

    if (self.postalAddress) {
        [contactString appendFormat:@"Postal Address: %@\n", [self addressStringFromPostalAddress:self.postalAddress]];
    }

    return contactString;
}

- (NSString *)nameStringFromNameComponents:(NSPersonNameComponents *)nameComponents {
    NSMutableString *nameString = [NSMutableString new];

    if (nameComponents.namePrefix) {
        [nameString appendFormat:@"%@ ", nameComponents.namePrefix];
    }

    if (nameComponents.givenName) {
        [nameString appendFormat:@"%@ ", nameComponents.givenName];
    }

    if (nameComponents.middleName) {
        [nameString appendFormat:@"%@ ", nameComponents.middleName];
    }

    if (nameComponents.familyName) {
        [nameString appendFormat:@"%@ ", nameComponents.familyName];
    }

    if (nameComponents.nameSuffix) {
        [nameString appendString:nameComponents.nameSuffix];
    }

    return nameString;
}

- (NSString *)addressStringFromPostalAddress:(PostalAddress *)postalAddress {
    NSMutableString *postalString = [NSMutableString new];

    if (postalAddress.street) {
        [postalString appendFormat:@"%@ ", postalAddress.street];
    }

    if (postalAddress.city) {
        [postalString appendFormat:@"%@ ", postalAddress.city];
    }

    if (postalAddress.country) {
        [postalString appendFormat:@"%@ ", postalAddress.country];
    }

    if (postalAddress.state) {
        [postalString appendFormat:@"%@ ", postalAddress.state];
    }

    if (postalAddress.postalCode) {
        [postalString appendFormat:@"%@ ", postalAddress.postalCode];
    }

    return postalString;
}

@end
