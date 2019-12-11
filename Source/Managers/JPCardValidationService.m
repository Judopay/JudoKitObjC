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

@implementation JPCardValidationService

//------------------------------------------------------------------------------------
# pragma mark - Public Methods
//------------------------------------------------------------------------------------

- (JPValidationResult *)validateCardNumberInput:(NSString *)input {
    
    CardNetwork cardNetworkType = [JPCardNetwork cardNetworkForCardNumber:input];
    
    if (cardNetworkType == CardNetworkUATP) {
        return [self validateUATPNetworkForInput:input];
    }
    
    if (cardNetworkType == CardNetworkUnknown) {
        return [self validateUnknownNetworkForInput:input];
    }
    
    
    if (cardNetworkType == CardNetworkVisa) {
        // TODO: Validate VISA
    }
    
    if (cardNetworkType == CardNetworkMasterCard) {
        
    }
    
    if (cardNetworkType == CardNetworkMaestro) {
        
    }
    
    if (cardNetworkType == CardNetworkAMEX) {
        
    }
    
    if (cardNetworkType == CardNetworkChinaUnionPay) {
        
    }
    
    if (cardNetworkType == CardNetworkDankort) {
        
    }
    
    if (cardNetworkType == CardNetworkInterPayment) {
        
    }
    
    if (cardNetworkType == CardNetworkDinersClub) {
        
    }
    
    if (cardNetworkType == CardNetworkInstaPayment) {
        
    }
    
    if (cardNetworkType == CardNetworkJCB) {
        
    }
    
    if (cardNetworkType == CardNetworkDiscover) {
        
    }
    
    // 3. Create
    JPCardNetwork *cardNetwork = [JPCardNetwork cardNetworkWithType:cardNetworkType];
    
    return [JPValidationResult validationWithResult:YES
                                       inputAllowed:NO
                                       errorMessage:@"Invalid character"];
}

//------------------------------------------------------------------------------------
# pragma mark - Helper methods
//------------------------------------------------------------------------------------

- (JPValidationResult *)validateUATPNetworkForInput:(NSString *)input {
    return [JPValidationResult validationWithResult:NO
                                       inputAllowed:NO
                                       errorMessage:@"UATP not yet supported"];
}

- (JPValidationResult *)validate

- (JPValidationResult *)validateUnknownNetworkForInput:(NSString *)input {
    if (input.length < 16) {
        return [JPValidationResult validationWithResult:NO
                                           inputAllowed:YES
                                           errorMessage:nil];
    }
    
    return [JPValidationResult validationWithResult:YES
                                       inputAllowed:NO
                                       errorMessage:nil];
}

@end
