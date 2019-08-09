//
//  JPCardDetails.h
//  JudoKitObjC
//
//  Copyright (c) 2016 Alternative Payments Ltd
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

#import <Foundation/Foundation.h>

/**
 *  The CardNetwork enum depicts the Card Network type of a given Card object
 */
typedef NS_ENUM(NSUInteger, CardNetwork) {
    /**
     * Unknown
     */
    CardNetworkUnknown,
    /**
     * Visa Card Network
     */
    CardNetworkVisa,
    /**
     * MasterCard Network
     */
    CardNetworkMasterCard,
    /**
     * Visa Electron Network
     */
    CardNetworkVisaElectron,
    /**
     * Switch Network
     */
    CardNetworkSwitch,
    /**
     * Solo Network
     */
    CardNetworkSolo,
    /**
     * Laser Network
     */
    CardNetworkLaser,
    /**
     * China UnionPay Network
     */
    CardNetworkChinaUnionPay,
    /**
     * American Express Card Network
     */
    CardNetworkAMEX,
    /**
     * JCB Network
     */
    CardNetworkJCB,
    /**
     * Maestro Card Network
     */
    CardNetworkMaestro,
    /**
     * Visa Debit Card Network
     */
    CardNetworkVisaDebit,
    /**
     * MasterCard Network
     */
    CardNetworkMasterCardDebit,
    /**
     * Visa Purchasing Network
     */
    CardNetworkVisaPurchasing,
    /**
     * Discover Network
     */
    CardNetworkDiscover,
    /**
     * Carnet Network
     */
    CardNetworkCarnet,
    /**
     * Carte Bancaire Network
     */
    CardNetworkCarteBancaire,
    /**
     * Diners Club Network
     */
    CardNetworkDinersClub,
    /**
     * Elo Network
     */
    CardNetworkElo,
    /**
     * Farmers Card Network
     */
    CardNetworkFarmersCard,
    /**
     * Soriana Network
     */
    CardNetworkSoriana,
    /**
     * Private Label Card Network
     */
    CardNetworkPrivateLabelCard,
    /**
     * Q Card Network
     */
    CardNetworkQCard,
    /**
     * Style Network
     */
    CardNetworkStyle,
    /**
     * True Rewards Network
     */
    CardNetworkTrueRewards,
    /**
     * UATP Network
     */
    CardNetworkUATP,
    /**
     * Bank Card Network
     */
    CardNetworkBankCard,
    /**
     * Banamex Costco Network
     */
    CardNetworkBanamex_Costco,
    /**
     * InterPayment Network
     */
    CardNetworkInterPayment,
    /**
     * InstaPayment Network
     */
    CardNetworkInstaPayment,
    /**
     * Dankort Network
     */
    CardNetworkDankort
};

/**
 *  The CardDetails object stores information that is returned from a successful payment or pre-auth. This class also implements the `NSCoding` protocol to enable serialization for persistency
 */
@interface JPCardDetails : NSObject <NSCoding>

/**
*  The last four digits of the card used for this transaction
*/
@property (nonatomic, strong) NSString *_Nullable cardLastFour;

/**
 *  Expiry date of the card used for this transaction formatted as a two digit month and year i.e. MM/YY
 */
@property (nonatomic, strong) NSString *_Nullable endDate;

/**
 *  Can be used to charge future payments against this card
 */
@property (nonatomic, strong) NSString *_Nullable cardToken;

/**
 *  The card network
 */
@property (nonatomic, assign) CardNetwork cardNetwork;

/**
 *  The card number if available
 */
@property (nonatomic, strong) NSString *_Nullable cardNumber;

/**
 *  Designated initializer for Card Details
 *
 *  @param dictionary all parameters as a dictionary
 *
 *  @return a JPCardDetails object
 */
- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

- (nonnull instancetype)initWithCardNumber:(nonnull NSString *)cardNumber
                               expiryMonth:(NSInteger)month
                                expiryYear:(NSInteger)year;

/**
 *  Get a formatted string with the right whitespacing for a certain card type
 *
 *  @return a string with the last four digits with the right format
 */
- (nullable NSString *)formattedCardLastFour;

/**
 *  Get a formatted string with the right slash for a date
 *
 *  @return a string with the date as shown on the credit card with the right format
 */
- (nullable NSString *)formattedExpiryDate;

@end
