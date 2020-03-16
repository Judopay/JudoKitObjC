//
//  JPSectionView.h
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

#import "JPTheme.h"
#import "JPSection.h"
#import <UIKit/UIKit.h>

@class JPSectionView;

@protocol JPSectionViewDelegate
/**
 * The method that is triggered once the user selects one of the sections of the section view
 *
 * @param sectionView - a reference to the current instance of JPSectionView
 * @param index - the index of the selected section
 */
- (void)sectionView:(JPSectionView *_Nonnull)sectionView didSelectSectionAtIndex:(NSUInteger)index;

@end

@interface JPSectionView : UIView

/**
 * A reference to the instance that adopts the JPSectionViewDelegate protocol
 */
@property (nonatomic, weak) id<JPSectionViewDelegate> _Nullable delegate;

/**
 * Designated initializer that creates a JPSectionView based on the provided sections
 *
 * @param sections - an array of JPSection objects that contain the images and titles of the sections
 * @param theme - the JPTheme reference that is used to configure the user interface
 *
 * @returns a configured instance of JPSectionView
 */
- (nonnull instancetype)initWithSections:(nonnull NSArray <JPSection *> *)sections
                                andTheme:(nonnull JPTheme *)theme;

/**
 * A method used to programmatically switch to a different section
 *
 * @param index - the index of the section
 */
- (void)switchToSectionAtIndex:(NSUInteger)index;

@end
