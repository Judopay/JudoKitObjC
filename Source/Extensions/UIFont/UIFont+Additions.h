//
//  UIFont.h
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

#import <UIKit/UIKit.h>

@interface UIFont (Additions)

/**
 * The font used for prominent UI elements of size 24 and weight semibold
 */
+ (nonnull UIFont *)largeTitle;

/**
 * The font used for smaller prominent UI elements  of size 18 and weight semibold
 */
+ (nonnull UIFont *)title;

/**
 * The headline font of size 16 and weight semibold
*/
+ (nonnull UIFont *)headline;

/**
 * The headline light font of size 16 and weight regular
 */
+ (nonnull UIFont *)headlineLight;

/**
 * Body font of size 14 and weight regular
 */
+ (nonnull UIFont *)body;

/**
 * The bold version of the body font of size 14 and weight semibold
 */
+ (nonnull UIFont *)bodyBold;

/**
 * The caption font of size 10 and weight regular
 */
+ (nonnull UIFont *)caption;

/**
 * The bold version of the caption font of size 10 and weight semibold
 */
+ (nonnull UIFont *)captionBold;

/**
 * Returns the weight of the font
 */
- (UIFontWeight)weight;

@end
