//
//  NSString+Additions.h
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
#import "JPTheme.h"
#import <Foundation/Foundation.h>

@interface NSString (Additions)

/**
 * A method which returns the card network from the string
 */
@property (nonatomic, assign, readonly) CardNetwork cardNetwork;

/**
 * A method which returns YES if the string represents a valid card number
 */
@property (nonatomic, assign, readonly) BOOL isCardNumberValid;

/**
 * A method that returns a formatted card number from the input
 *
 * @param networks - an array of supported card networks.
 * If the card number is not part of these networks, the method will return nil instead.
 *
 * @param error - a pointer to an NSError which stores information about the possible error
 */
- (nullable NSString *)cardPresentationStringWithAcceptedNetworks:(nonnull NSArray *)networks
                                                            error:(NSError *_Nullable *_Nullable)error;
/**
 * Returns the localized string based on the input key
 */
- (nonnull NSString *)localized;

/**
 * Converts ISO 4217 currency codes into their symbolic equivalent
 */
- (nullable NSString *)toCurrencySymbol;

/**
 * A method which replaces each character in the set with a specified string
 *
 * @param charSet - the character set to be replaced
 * @param aString - the string to replace the characters in the set
 */
- (nullable NSString *)stringByReplacingCharactersInSet:(nonnull NSCharacterSet *)charSet
                                             withString:(nonnull NSString *)aString;

/**
 * A method which returns an instance of the NSString without any whitespaces
 */
- (nonnull NSString *)stringByRemovingWhitespaces;

/**
 * A method which formats the string based on a specified pattern
 */
- (nonnull NSString *)formatWithPattern:(nonnull NSString *)pattern;

/**
 * A method which makes a word in string bold
 * @param substring - the substring to be made bold
 * @return - a  NSMutableAttributedString where provided word is bold
 *
*/
- (nonnull NSMutableAttributedString *)attributedStringWithBoldSubstring:(nonnull NSString *)substring;

@end
