//
//  JPIDEALBank.h
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

#import <Foundation/Foundation.h>

/**
 *  Enumeration of all available iDEAL banks
 */
typedef NS_ENUM(NSUInteger, JPIDEALBankType) {
    JPIDEALBankING,
    JPIDEALBankABN,
    JPIDEALBankVanLanschotBankiers,
    JPIDEALBankTriodos,
    JPIDEALBankRabobank,
    JPIDEALBankSNS,
    JPIDEALBankASN,
    JPIDEALBankRegio,
    JPIDEALBankKnab,
    JPIDEALBankBunq,
    JPIDEALBankMoneyou,
    JPIDEALBankHandelsbanken
};

/**
 *  An JPIDEALBank object responsible for obtaining iDEAL bank information
 */
@interface JPIDEALBank : NSObject

/**
 *  The type of the iDEAL bank
 */
@property JPIDEALBankType type;

/**
 *  The title of the iDEAL bank
 */
@property (nonatomic, strong) NSString *_Nonnull title;

/**
 * The icon name of the iDEAL bank
 */
@property (nonatomic, strong) NSString *_Nonnull iconName;

/**
 *  The bank identifier code for the iDEAL bank
 */
@property (nonatomic, strong) NSString *_Nonnull bankIdentifierCode;

/**
 *  Create an JPIDEALBank instance based on a specified type
 *
 *  @param type - one of the predefined iDEALBank types
 *
 *  @return an JPIDEALBank instance
 */
+ (nonnull instancetype)bankWithType:(JPIDEALBankType)type;

/**
 *  Create an JPIDEALBank instance based on a specified type
 *
 *  @param type - one of the predefined iDEALBank types
 *
 *  @return an JPIDEALBank instance
 */
- (nonnull instancetype)initWithType:(JPIDEALBankType)type;

@end
