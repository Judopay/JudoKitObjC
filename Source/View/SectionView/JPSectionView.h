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
#import <UIKit/UIKit.h>

@class JPSectionView;

@protocol JPSectionViewDelegate
/**
 * The method that is triggered once the user selects one of the sections of the section view
 *
 * @param sectionView - a reference to the current instance of JPSectionView
 * @param index - the index of the selected section
 */
- (void)sectionView:(JPSectionView *_Nonnull)sectionView didSelectSectionAtIndex:(int)index;

@end

@interface JPSectionView : UIView

/**
 * A reference to the instance that adopts the JPSectionViewDelegate protocol
 */
@property (nonatomic, weak) id<JPSectionViewDelegate> _Nullable delegate;

/**
 * A method used to apply a theme to the view
 *
 * @param theme - the JPTheme object used to configure the user interface
 */
- (void)applyTheme:(nonnull JPTheme *)theme;

/**
 * A method that adds a section to the section view.
 *
 * @param image - a UIImage instance that showcases the section's logo
 * @param title - an NSString that is displayed next to the logo
 */
- (void)addSectionWithImage:(UIImage *_Nullable)image
                   andTitle:(NSString *_Nullable)title;

/**
 * A method for removing all sections from the section view
 */
- (void)removeSections;

/**
 * Method that forces a section change to a specified index
 *
 * @param index - the index of the selected section
 */
- (void)changeSelectedSectionToIndex:(NSUInteger)index;

@end
