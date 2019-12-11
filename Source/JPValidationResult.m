//
//  JPValidationResult.m
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import "JPValidationResult.h"

@implementation JPValidationResult

- (instancetype)initWithResult:(BOOL)isValid
                isInputAllowed:(BOOL)isInputAllowed
                  errorMessage:(NSString *)errorMessage {
    if (self = [super init]) {
        self.isValid = isValid;
        self.isInputAllowed = isInputAllowed;
        self.errorMessage = errorMessage;
    }
    return self;
}

+ (instancetype)validationWithResult:(BOOL)isValid
                        inputAllowed:(BOOL)isInputAllowed
                        errorMessage:(NSString *)errorMessage {
    
    return [[JPValidationResult alloc] initWithResult:isValid
                                       isInputAllowed:isInputAllowed
                                         errorMessage:errorMessage];
}

@end
