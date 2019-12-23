//
//  JPValidationResult.h
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

#import "JPCardNetwork.h"
#import <Foundation/Foundation.h>

@interface JPValidationResult : NSObject

/**
 * A boolean property that defines if the card field is valid
 */
@property (nonatomic, assign) BOOL isValid;

/**
 * A boolean property that defines if the input should be accepted
 */
@property (nonatomic, assign) BOOL isInputAllowed;

/**
 * An error message string related to the input
 */
@property (nonatomic, strong) NSString *errorMessage;

/**
 * A property that will return one of the pre-defined card network types (only for card number)
 */
@property (nonatomic, assign) CardNetwork cardNetwork;

/**
 * A property that will return a formatted input
 */
@property (nonatomic, strong) NSString *formattedInput;

/**
 * A designated initializer that configures the required parameters
 *
 * @param isValid - a boolean property that defines if the card field is valid
 * @param isInputAllowed - a boolean property that defines if the input should be accepted
 * @param errorMessage - an error message string related to the input
 * @param formattedInput - a property that will return a formatted input
 *
 * @return a configured instance of JPValidationResult
 */
- (instancetype)initWithResult:(BOOL)isValid
                isInputAllowed:(BOOL)isInputAllowed
                  errorMessage:(NSString *)errorMessage
                formattedInput:(NSString *)formattedInput;

/**
 * A designated initializer that configures the required parameters
 *
 * @param isValid - a boolean property that defines if the card field is valid
 * @param isInputAllowed - a boolean property that defines if the input should be accepted
 * @param errorMessage - an error message string related to the input
 * @param formattedInput - a property that will return a formatted input
 *
 * @return a configured instance of JPValidationResult
 */
+ (instancetype)validationWithResult:(BOOL)isValid
                        inputAllowed:(BOOL)isInputAllowed
                        errorMessage:(NSString *)errorMessage
                      formattedInput:(NSString *)formattedInput;

@end
