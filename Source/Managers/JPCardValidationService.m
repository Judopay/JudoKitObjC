//
//  JPCardValidationService.m
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

#import "JPCardValidationService.h"
#import "JPValidationResult.h"
#import "JPCardNetwork.h"
#import "NSString+Card.h"
#import "NSString+Localize.h"
#import "NSError+Judo.h"

@interface JPCardValidationService()

@property (nonatomic, strong) JPValidationResult *lastValidationResult;

@end

@implementation JPCardValidationService

//------------------------------------------------------------------------------------
# pragma mark - Public Methods
//------------------------------------------------------------------------------------

- (JPValidationResult *)validateCardNumberInput:(NSString *)input {
    
    NSError *error;
    NSString *presentationString = [input cardPresentationStringWithAcceptedNetworks:self.acceptedCardNetworks
                                                                               error:&error];
    
    NSString *trimmedString = [input stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 1. Invalidate input over 15 / 16 characters
    
    if (input.cardNetwork == CardNetworkAMEX || input.cardNetwork == CardNetworkUATP) {
        if (trimmedString.length > 15) {
            return self.lastValidationResult;
        }
    }
    
    if (trimmedString.length > 16) {
        return self.lastValidationResult;
    }
    
    // 2. If input is valid, return valid response
    
    if ([input isCardNumberValid]) {
        self.lastValidationResult = [JPValidationResult validationWithResult:YES
                                                                inputAllowed:YES
                                                                errorMessage:nil
                                                                 cardNetwork:input.cardNetwork
                                                              formattedInput:presentationString];
        return self.lastValidationResult;
    }

    // 3. If input is not valid
    if (input.cardNetwork == CardNetworkAMEX || input.cardNetwork == CardNetworkUATP) {
        if (trimmedString.length == 15) {
            error = NSError.judoInvalidCardNumberError;
        }
    }
    
    if (trimmedString.length == 16) {
        error = NSError.judoInvalidCardNumberError;
    }
    
    
    self.lastValidationResult = [JPValidationResult validationWithResult:NO
                                                            inputAllowed:(presentationString != nil)
                                                            errorMessage:error.localizedDescription
                                                             cardNetwork:input.cardNetwork
                                                          formattedInput:presentationString];
    return self.lastValidationResult;
}

//------------------------------------------------------------------------------------
# pragma mark - Helper getters
//------------------------------------------------------------------------------------

- (NSArray *)acceptedCardNetworks {
    return @[
        @(CardNetworkVisa), @(CardNetworkAMEX), @(CardNetworkMasterCard), @(CardNetworkMaestro),
        @(CardNetworkDiscover), @(CardNetworkJCB), @(CardNetworkDinersClub), @(CardNetworkChinaUnionPay),
    ];
}

@end
