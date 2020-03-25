//
//  JPSection.h
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

#import <UIKit/UIKit.h>

@interface JPSection : NSObject

/**
 * The image of the section
 */
@property (nonatomic, strong) UIImage *_Nonnull image;

/**
 * The optional title of the section
 */
@property (nonatomic, strong) NSString *_Nullable title;

/**
 * Designated initializer that creates a section with an image and optional title
 *
 * @param image - the UIImage instance of the section
 * @param title - the optional NSString instance of the section
 *
 * @returns a configured instance of JPSection
 */
+ (nonnull instancetype)sectionWithImage:(nonnull UIImage *)image
                                andTitle:(nullable NSString *)title;

/**
 * Designated initializer that creates a section with an image and optional title
 *
 * @param image - the UIImage instance of the section
 * @param title - the optional NSString instance of the section
 *
 * @returns a configured instance of JPSection
*/
- (nonnull instancetype)initWithImage:(nonnull UIImage *)image
                             andTitle:(nullable NSString *)title;

@end
