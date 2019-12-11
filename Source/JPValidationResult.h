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
@property (nonatomic, strong) NSString *errorMessage;

- (instancetype)initWithResult:(BOOL)isValid
               andErrorMessage:(NSString *)errorMessage;

+ (instancetype)validationResultWithResult:(BOOL)isValid
                           andErrorMessage:(NSString *)errorMessage;

@end
