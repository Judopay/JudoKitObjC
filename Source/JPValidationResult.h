//
//  JPValidationResult.h
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPValidationResult : NSObject

@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, assign) BOOL isInputAllowed;
@property (nonatomic, strong) NSString *errorMessage;

- (instancetype)initWithResult:(BOOL)isValid
                isInputAllowed:(BOOL)isInputAllowed
                  errorMessage:(NSString *)errorMessage;

+ (instancetype)validationWithResult:(BOOL)isValid
                        inputAllowed:(BOOL)isInputAllowed
                        errorMessage:(NSString *)errorMessage;

@end
