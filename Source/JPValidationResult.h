//
//  JPValidationResult.h
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPCardNetwork.h"

@interface JPValidationResult : NSObject

@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, assign) BOOL isInputAllowed;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, assign) CardNetwork cardNetwork;
@property (nonatomic, strong) NSString *formattedInput;

- (instancetype)initWithResult:(BOOL)isValid
                isInputAllowed:(BOOL)isInputAllowed
                  errorMessage:(NSString *)errorMessage
                formattedInput:(NSString *)formattedInput;

+ (instancetype)validationWithResult:(BOOL)isValid
                        inputAllowed:(BOOL)isInputAllowed
                        errorMessage:(NSString *)errorMessage
                      formattedInput:(NSString *)formattedInput;

@end
