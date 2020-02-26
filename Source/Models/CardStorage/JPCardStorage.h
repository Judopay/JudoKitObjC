//
//  JPCardStorage.h
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

#import "JPStoredCardDetails.h"
#import <Foundation/Foundation.h>

@interface JPCardStorage : NSObject

/**
 * The shared JPCardStorage instance
 */
+ (instancetype)sharedInstance;

/**
 * A method that returns all the card details stored in the Keychain
 *
 * @returns An array of JPStoredCardDetails objects
 */
- (NSMutableArray<JPStoredCardDetails *> *)fetchStoredCardDetails;

/**
 * A method for fetching the stored card details from a specified index
 *
 * @param index - the index of the stored card details
 */
- (JPStoredCardDetails *)fetchStoredCardDetailsAtIndex:(NSUInteger)index;

/**
 * A method for adding new card details objects into the keychain
 *
 * @param cardDetails - An instance of JPStoredCardDetails that describes the card details
 */
- (void)addCardDetails:(JPStoredCardDetails *)cardDetails;

/**
 * A method for inserting card details at a specified index
 *
 * @param cardDetails - an instance of JPStoredCardDetails containing card information
 * @param index - the index where to insert the card details
 */
- (void)insertCardDetails:(JPStoredCardDetails *)cardDetails
                  atIndex:(NSUInteger)index;

/**
 * A method for deleting the existing card details from the keychain
 *
 * @returns a boolean value describing if the cards have been succesfully deleted
 */
- (BOOL)deleteCardDetails;

/**
 * A method for deleting a specific card details from the keychain by its index
 *
 * @param index - the card's index in the list
 */
- (void)deleteCardWithIndex:(NSUInteger)index;

/**
 * A method for updating a card in the storage based on a provided index
 *
 * @param index - the index of the card in the list
 */
- (void)updateCardDetails:(JPStoredCardDetails *)cardDetails
                  atIndex:(NSUInteger)index;

/**
 * A method that sets a card as selected based on an index
 */
- (void)setCardAsSelectedAtIndex:(NSUInteger)index;

@end
