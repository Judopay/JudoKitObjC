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
               andErrorMessage:(NSString *)errorMessage {
    
    if (self = [super init]) {
        self.isValid = isValid;
        self.errorMessage = errorMessage;
    }
    
    return self;
}

+ (instancetype)validationResultWithResult:(BOOL)isValid
                           andErrorMessage:(NSString *)errorMessage {
    
    return [[JPValidationResult alloc] initWithResult:isValid
                                      andErrorMessage:errorMessage];
}

@end
