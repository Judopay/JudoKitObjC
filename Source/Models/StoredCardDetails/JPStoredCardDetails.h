//
//  JPStoredCardDetails.h
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
#import "JPCardPattern.h"
#import <Foundation/Foundation.h>

@interface JPStoredCardDetails : NSObject

/**
 * The title of the card
 */
@property (nonatomic, strong) NSString *cardTitle;

/**
 * The last four digits of the credit card
 */
@property (nonatomic, strong) NSString *cardLastFour;

/**
 * The expiry date of the card
 */
@property (nonatomic, strong) NSString *expiryDate;

/**
 * The card's network
 */
@property (nonatomic, assign) CardNetwork cardNetwork;

/**
 * The token associated with the card
 */
@property (nonatomic, strong) NSString *cardToken;

/**
 * The card's pattern type
 */
@property (nonatomic, assign) JPCardPatternType patternType;

/**
 * A boolean property describing if the card is set as the default card
 */
@property (nonatomic, assign) BOOL isDefault;

/**
 * A boolean property that describes if the card is currently selected
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 * The designated initializer that creates a new instance with the last four digits, expiry date and card network set
 *
 * @param lastFour - the last four digits of the credit card
 * @param expiryDate - the card's expiration date
 * @param network - the card's network
 * @param cardToken - the card's token
 *
 * @return an instance of JPStoredCardDetails
 */
- (instancetype)initWithLastFour:(NSString *)lastFour
                      expiryDate:(NSString *)expiryDate
                     cardNetwork:(CardNetwork)network
                       cardToken:(NSString *)cardToken;

/**
 * A designated initializer that creates a new instance based on a passed NSDictionary
 *
 * @param dictionary - an instance of NSDictionary that contains the necessary card details
 *
 * @return an instance of JPStoredCardDetails
 */
- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

/**
 * The designated initializer that creates a new instance with the last four digits, expiry date and card network set
 *
 * @param lastFour - the last four digits of the credit card
 * @param expiryDate - the card's expiration date
 * @param network - the card's network
 * @param cardToken - the card's token
 *
 * @return an instance of JPStoredCardDetails
 */
+ (instancetype)cardDetailsWithLastFour:(NSString *)lastFour
                             expiryDate:(NSString *)expiryDate
                            cardNetwork:(CardNetwork)network
                              cardToken:(NSString *)cardToken;

/**
 * A designated initializer that creates a new instance based on a passed NSDictionary
 *
 * @param dictionary - an instance of NSDictionary that contains the necessary card details
 *
 * @return an instance of JPStoredCardDetails
 */
+ (instancetype)cardDetailsFromDictionary:(NSDictionary *)dictionary;

/**
 * A convenience method that converts the properties into a dictionary
 */
- (NSDictionary *)toDictionary;

@end
