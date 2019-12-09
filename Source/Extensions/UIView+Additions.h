//
//  UIView+Additions.m
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

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, AnchorType) {
    AnchorTypeNone = 0,
    AnchorTypeTop = 1 << 0,
    AnchorTypeBottom = 1 << 1,
    AnchorTypeLeading = 1 << 2,
    AnchorTypeTrailing = 1 << 3,
    AnchorTypeAll = (AnchorTypeTop | AnchorTypeBottom | AnchorTypeLeading | AnchorTypeTrailing)
};

@interface UIView (Additions)

/**
 * Convenience method for setting a border
 *
 * @param color - the border color
 * @param width - the border width
 */
- (void)setBorderWithColor:(UIColor *)color
                  andWidth:(CGFloat)width;

/**
 * Convenience method for setting a rounder border
 *
 * @param color - the border color
 * @param width - the border width
 * @param cornerRadius - the border's corner radius
 */
- (void)setBorderWithColor:(UIColor *)color
                     width:(CGFloat)width
           andCornerRadius:(CGFloat)cornerRadius;

/**
 * Convenience method for rounding only specific corners of the view
 *
 * @param corners - rectangle corner values that have to be rounded
 * @param radius - the radius for rounding the corners
 */
- (void)roundCorners:(UIRectCorner)corners withRadius:(CGFloat)radius;

/**
 * Constraints the view to the superview with a specified padding
 *
 * @param view - the view to achor to
 * @param padding - the padding between the view and self
 */
- (void)pinToView:(UIView *)view withPadding:(CGFloat)padding;

/**
 * Constraints the view to the superview only for specific anchors
 *
 * @param anchors - the anchor values to be constrained to
 * @param view - the view to anchor to
 */
- (void)pinToAnchors:(AnchorType)anchors forView:(UIView *)view;

/**
 * Constraints the view to the superview only for specific anchors with padding
 *
 * @param anchors - the anchor values to be constrained to
 * @param view - the view to anchor to
 * @param padding - the padding between the view and self
 */
- (void)pinToAnchors:(AnchorType)anchors forView:(UIView *)view withPadding:(CGFloat)padding;

@end
