//
//  JPCardCustomizationInteractor.h
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

#import "JPCardPattern.h"
#import <Foundation/Foundation.h>

@class JPStoredCardDetails;

@protocol JPCardCustomizationInteractor

/**
 * A method that returns the details about the selected card
 *
 * @returns a configured instance of JPStoredCardDetails
 */
- (nonnull JPStoredCardDetails *)cardDetails;

/**
 * A method which updates the pattern type of the selected card in the JPCardStorage
 *
 * @param type - the JPCardPatternType value identifying the card
 */
- (void)updateStoredCardPatternWithType:(JPCardPatternType)type;

/**
 * A method that updates the stored card's title based on a provided input string
 *
 * @param input - the input string serving as the card's title
 */
- (void)updateStoredCardTitleWithInput:(nonnull NSString *)input;

@end

@interface JPCardCustomizationInteractorImpl : NSObject <JPCardCustomizationInteractor>

/**
 * Designated initializer that takes the card index to access it in the keychain storage
 *
 * @param index - the index of the card
 *
 * @returns a configured instance of JPCardCustomizationInteractorImpl
 */
- (nonnull instancetype)initWithCardIndex:(NSUInteger)index;

@end
