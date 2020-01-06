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
 * The font used for prominent UI elements (San Francisco Semibold - 24)
 */
+ (UIFont *)largeTitle;

/**
 * The font used for smaller prominent UI elements (San Francisco Semibold - 18)
 */
+ (UIFont *)title;

/**
 * The headline font (San Francisco Semibold - 16)
*/
+ (UIFont *)headline;

/**
 * The headline light font (San Francisco Regular - 16)
 */
+ (UIFont *)headlineLight;

/**
 * Body font (San Francisco Regular - 14)
 */
+ (UIFont *)body;

/**
 * The bold version of the body font (San Francisco Semibold - 14)
 */
+ (UIFont *)bodyBold;

/**
 * The caption font (San Francisco Regular - 10)
 */
+ (UIFont *)caption;

@end
