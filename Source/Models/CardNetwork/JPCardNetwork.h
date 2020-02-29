//
//  JPCardNetwork.h
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

#import "JPCardDetails.h"
#import <Foundation/Foundation.h>

@interface JPCardNetwork : NSObject

/**
 * An array of NSString objects containing a list of card prefixes.
 */
@property (nonatomic, strong) NSArray<NSString *> *numberPrefixes;

/**
 * The card network type
 */
@property (nonatomic, assign) CardNetwork network;

/**
 * An integer specifying the security code length for the current network
 */
@property (nonatomic, assign) NSUInteger securityCodeLength;

/**
 * An instance of NSString that returns the card format for the current network
 */
@property (nonatomic, strong) NSString *numberPattern;

/**
 * Designated initializer that returns a configured JPCardNetwork based on a type
 *
 * @param type - the card network type.
 * @param prefixes - an array of NSString instances containing a list of prefixes.
 *
 * @returns a configured instance of JPCardNetwork
 */
+ (instancetype)networkWith:(CardNetwork)type
             numberPrefixes:(NSString *)prefixes;

/**
 * Designated initializer that returns a configured JPCardNetwork
 *
 * @param type - the card network type.
 * @param prefixes - an array of NSString instances containing a list of prefixes.
 * @param length - an unsigned integer that represents the length of the security code.
 * @param pattern - an NSString that describes the card number format.
 *
 * @returns a configured instance of JPCardNetwork
 */
+ (instancetype)networkWith:(CardNetwork)type
             numberPrefixes:(NSString *)prefixes
         securityCodeLength:(NSUInteger)length
              numberPattern:(NSString *)pattern;

/**
 * Designated initializer that returns a configured JPCardNetwork based on a type
 *
 * @param networkType - the card network type.
 *
 * @returns a configured instance of JPCardNetwork
 */
+ (instancetype)cardNetworkWithType:(CardNetwork)networkType;

/**
 * A getter that returns an array of supported card networks
 */
+ (NSArray<JPCardNetwork *> *)supportedNetworks;

/**
 * A method that returns the name of the card network based on a specified network type
 *
 * @param network - the card network type
 *
 * @returns the card network name;
 */
+ (NSString *)nameOfCardNetwork:(CardNetwork)network;

/**
 * A method that returns the card network based on the provided card number
 *
 * @param cardNumber - the provided card number
 *
 * @returns one of the pre-defined card network types
 */
+ (CardNetwork)cardNetworkForCardNumber:(NSString *)cardNumber;

/**
 * A getter that returns the default number pattern
 */
+ (NSString *)defaultNumberPattern;
@end
