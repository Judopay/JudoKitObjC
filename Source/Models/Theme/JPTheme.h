//
//  JPTheme.h
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

@import UIKit;

@interface JPTheme : NSObject

/**
 * The large title font used to represent header elements, such as screen titles.
 * Defaults to San Francisco 24 - Semibold.
 */
@property (nonatomic, strong) UIFont *largeTitle;

/**
 * The title font used to represent prominent elements, such as card titles or subheaders.
 * Defaults to San Francisco 18 - Semibold.
 */
@property (nonatomic, strong) UIFont *title;

/**
 * The headline font is used to represent most prominent buttons.
 * Defaults to San Francisco 16 - Semibold.
 */
@property (nonatomic, strong) UIFont *headline;

/**
 * A lighter version of the headline font, used to represent the text inside input fields.
 * Defaults to San Francisco 16 - Regular.
 */
@property (nonatomic, strong) UIFont *headlineLight;

/**
 * A body font is used to represent basic text elements.
 * Defaults to San Francisco 14 - Regular.
 */
@property (nonatomic, strong) UIFont *body;

/**
 * The bold version of the body font used to display bold text, such as card titles in a list or smaller flat buttons.
 * Defaults to San Francisco 14 - Semibold.
 */
@property (nonatomic, strong) UIFont *bodyBold;

/**
 * The caption font is used to represent all small text elements, whether a subtitle or a superscript.
 * Defaults to San Francisco 10 - Regular.
 */
@property (nonatomic, strong) UIFont *caption;

/**
 * The bold version of the caption font used to highlight certain text elements in a subtitle
 * Defaults to San Francisco 10 - Semibold.
 */
@property (nonatomic, strong) UIFont *captionBold;

@end
