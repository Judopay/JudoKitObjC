//
//  CardLogoView.h
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

#import "CardLogoView.h"

@interface CardLogoView ()

@property (nonatomic, assign, readwrite) CardLogoType type;

@end

@implementation CardLogoView

- (instancetype)initWithType:(CardLogoType)type {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    switch (self.type) {
        case CardLogoTypeVisa:
            [self drawIc_card_visaCanvas];
            break;
        case CardLogoTypeMasterCard:
            [self drawIc_card_mastercardCanvas];
            break;
        case CardLogoTypeAMEX:
            [self drawIc_card_amexCanvas];
            break;
        case CardLogoTypeMaestro:
            [self drawIc_card_maestroCanvas];
            break;
        case CardLogoTypeCID:
            [self drawIc_card_cidvCanvas];
            break;
        case CardLogoTypeCVC:
            [self drawIc_card_cvcCanvas];
            break;
        default:
            [self drawIc_card_unknownCanvas];
            break;
    }
}

#pragma mark Drawing Methods

- (void)drawIc_card_amexCanvas {
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor *gradientColor = [UIColor colorWithRed:0.402 green:0.75 blue:0.935 alpha:1];
    UIColor *gradientColor2 = [UIColor colorWithRed:0.144 green:0.465 blue:0.732 alpha:1];
    UIColor *gradientColor3 = [UIColor colorWithRed:0.037 green:0.312 blue:0.619 alpha:1];
    UIColor *fillColor = [UIColor colorWithRed:0.647 green:0.647 blue:0.647 alpha:1];
    UIColor *fillColor2 = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1];
    UIColor *fillColor3 = [UIColor colorWithRed:0.037 green:0.312 blue:0.619 alpha:1];
    UIColor *fillColor4 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

    //// Gradient Declarations
    CGFloat sVGID_5_Locations[] = {0, 0.61, 1};
    CGGradientRef sVGID_5_ = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) @[ (id)gradientColor.CGColor, (id)gradientColor2.CGColor, (id)gradientColor3.CGColor ], sVGID_5_Locations);

    //// Group
    {
        //// Group 2
        {
            //// Bezier Drawing
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(43.77, 0)];
            [bezierPath addLineToPoint:CGPointMake(2.23, 0)];
            [bezierPath addCurveToPoint:CGPointMake(0, 2.22) controlPoint1:CGPointMake(1, 0) controlPoint2:CGPointMake(0, 0.99)];
            [bezierPath addLineToPoint:CGPointMake(0, 3.33)];
            [bezierPath addLineToPoint:CGPointMake(0, 26.67)];
            [bezierPath addLineToPoint:CGPointMake(0, 27.79)];
            [bezierPath addCurveToPoint:CGPointMake(2.23, 30) controlPoint1:CGPointMake(0, 29.01) controlPoint2:CGPointMake(1, 30)];
            [bezierPath addLineToPoint:CGPointMake(43.77, 30)];
            [bezierPath addCurveToPoint:CGPointMake(46, 27.79) controlPoint1:CGPointMake(45, 30) controlPoint2:CGPointMake(46, 29.01)];
            [bezierPath addLineToPoint:CGPointMake(46, 2.22)];
            [bezierPath addCurveToPoint:CGPointMake(43.77, 0) controlPoint1:CGPointMake(46, 0.99) controlPoint2:CGPointMake(45, 0)];
            [bezierPath closePath];
            bezierPath.miterLimit = 4;

            [fillColor setFill];
            [bezierPath fill];

            //// Rectangle Drawing
            UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.55, 0.57, 44.9, 28.35) cornerRadius:1.6];
            [fillColor2 setFill];
            [rectanglePath fill];
        }

        //// Bezier 2 Drawing
        UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint:CGPointMake(4.71, 16.18)];
        [bezier2Path addCurveToPoint:CGPointMake(4.04, 15.51) controlPoint1:CGPointMake(4.34, 16.18) controlPoint2:CGPointMake(4.04, 15.88)];
        [bezier2Path addLineToPoint:CGPointMake(4.04, 12.21)];
        [bezier2Path addCurveToPoint:CGPointMake(4.71, 11.54) controlPoint1:CGPointMake(4.04, 11.84) controlPoint2:CGPointMake(4.34, 11.54)];
        [bezier2Path addLineToPoint:CGPointMake(10.29, 11.54)];
        [bezier2Path addCurveToPoint:CGPointMake(10.96, 12.21) controlPoint1:CGPointMake(10.66, 11.54) controlPoint2:CGPointMake(10.96, 11.84)];
        [bezier2Path addLineToPoint:CGPointMake(10.96, 15.51)];
        [bezier2Path addCurveToPoint:CGPointMake(10.29, 16.18) controlPoint1:CGPointMake(10.96, 15.88) controlPoint2:CGPointMake(10.66, 16.18)];
        [bezier2Path addLineToPoint:CGPointMake(4.71, 16.18)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint:CGPointMake(4.71, 11.89)];
        [bezier2Path addCurveToPoint:CGPointMake(4.39, 12.21) controlPoint1:CGPointMake(4.53, 11.89) controlPoint2:CGPointMake(4.39, 12.04)];
        [bezier2Path addLineToPoint:CGPointMake(4.39, 15.51)];
        [bezier2Path addCurveToPoint:CGPointMake(4.71, 15.83) controlPoint1:CGPointMake(4.39, 15.69) controlPoint2:CGPointMake(4.54, 15.83)];
        [bezier2Path addLineToPoint:CGPointMake(10.29, 15.83)];
        [bezier2Path addCurveToPoint:CGPointMake(10.61, 15.51) controlPoint1:CGPointMake(10.47, 15.83) controlPoint2:CGPointMake(10.61, 15.68)];
        [bezier2Path addLineToPoint:CGPointMake(10.61, 12.21)];
        [bezier2Path addCurveToPoint:CGPointMake(10.29, 11.89) controlPoint1:CGPointMake(10.61, 12.03) controlPoint2:CGPointMake(10.47, 11.89)];
        [bezier2Path addLineToPoint:CGPointMake(4.71, 11.89)];
        [bezier2Path closePath];
        bezier2Path.miterLimit = 4;

        [fillColor setFill];
        [bezier2Path fill];

        //// Group 3
        {
            //// Group 4
            {
                //// SVGID_1_ Drawing
                UIBezierPath *sVGID_1_Path = [UIBezierPath bezierPath];
        [sVGID_1_Path moveToPoint:CGPointMake(41.83, 3.69)];
        [sVGID_1_Path addLineToPoint:CGPointMake(29.36, 3.69)];
        [sVGID_1_Path addLineToPoint:CGPointMake(29.36, 16.2)];
        [sVGID_1_Path addLineToPoint:CGPointMake(41.82, 16.2)];
        [sVGID_1_Path addLineToPoint:CGPointMake(41.82, 12.07)];
        [sVGID_1_Path addCurveToPoint:CGPointMake(41.9, 11.79) controlPoint1:CGPointMake(41.87, 12) controlPoint2:CGPointMake(41.9, 11.91)];
        [sVGID_1_Path addCurveToPoint:CGPointMake(41.82, 11.52) controlPoint1:CGPointMake(41.9, 11.66) controlPoint2:CGPointMake(41.87, 11.58)];
        [sVGID_1_Path addLineToPoint:CGPointMake(41.82, 3.69)];
        [sVGID_1_Path addLineToPoint:CGPointMake(41.83, 3.69)];
        [sVGID_1_Path closePath];
        sVGID_1_Path.miterLimit = 4;

        [fillColor3 setFill];
        [sVGID_1_Path fill];
    }

    //// Group 5
    {
        //// Group 6
        {
            //// Group 7
            {
                //// Bezier 4 Drawing
                UIBezierPath *bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint:CGPointMake(28.56, 15.94)];
    [bezier4Path addLineToPoint:CGPointMake(28.45, 15.94)];
    [bezier4Path addCurveToPoint:CGPointMake(28.44, 15.79) controlPoint1:CGPointMake(28.44, 15.9) controlPoint2:CGPointMake(28.44, 15.82)];
    [bezier4Path addCurveToPoint:CGPointMake(28.36, 15.71) controlPoint1:CGPointMake(28.44, 15.75) controlPoint2:CGPointMake(28.43, 15.71)];
    [bezier4Path addLineToPoint:CGPointMake(28.2, 15.71)];
    [bezier4Path addLineToPoint:CGPointMake(28.2, 15.94)];
    [bezier4Path addLineToPoint:CGPointMake(28.1, 15.94)];
    [bezier4Path addLineToPoint:CGPointMake(28.1, 15.39)];
    [bezier4Path addLineToPoint:CGPointMake(28.36, 15.39)];
    [bezier4Path addCurveToPoint:CGPointMake(28.55, 15.54) controlPoint1:CGPointMake(28.45, 15.39) controlPoint2:CGPointMake(28.55, 15.42)];
    [bezier4Path addCurveToPoint:CGPointMake(28.49, 15.66) controlPoint1:CGPointMake(28.55, 15.61) controlPoint2:CGPointMake(28.52, 15.64)];
    [bezier4Path addCurveToPoint:CGPointMake(28.54, 15.76) controlPoint1:CGPointMake(28.52, 15.67) controlPoint2:CGPointMake(28.54, 15.7)];
    [bezier4Path addLineToPoint:CGPointMake(28.54, 15.86)];
    [bezier4Path addCurveToPoint:CGPointMake(28.56, 15.91) controlPoint1:CGPointMake(28.54, 15.89) controlPoint2:CGPointMake(28.54, 15.89)];
    [bezier4Path addLineToPoint:CGPointMake(28.56, 15.94)];
    [bezier4Path closePath];
    [bezier4Path moveToPoint:CGPointMake(28.45, 15.55)];
    [bezier4Path addCurveToPoint:CGPointMake(28.37, 15.47) controlPoint1:CGPointMake(28.45, 15.48) controlPoint2:CGPointMake(28.4, 15.47)];
    [bezier4Path addLineToPoint:CGPointMake(28.2, 15.47)];
    [bezier4Path addLineToPoint:CGPointMake(28.2, 15.63)];
    [bezier4Path addLineToPoint:CGPointMake(28.35, 15.63)];
    [bezier4Path addCurveToPoint:CGPointMake(28.45, 15.55) controlPoint1:CGPointMake(28.4, 15.63) controlPoint2:CGPointMake(28.45, 15.62)];
    [bezier4Path closePath];
    [bezier4Path moveToPoint:CGPointMake(28.9, 15.67)];
    [bezier4Path addCurveToPoint:CGPointMake(28.31, 15.08) controlPoint1:CGPointMake(28.9, 15.34) controlPoint2:CGPointMake(28.64, 15.08)];
    [bezier4Path addCurveToPoint:CGPointMake(27.72, 15.67) controlPoint1:CGPointMake(27.98, 15.08) controlPoint2:CGPointMake(27.72, 15.34)];
    [bezier4Path addCurveToPoint:CGPointMake(28.31, 16.26) controlPoint1:CGPointMake(27.72, 16) controlPoint2:CGPointMake(27.98, 16.26)];
    [bezier4Path addCurveToPoint:CGPointMake(28.9, 15.67) controlPoint1:CGPointMake(28.64, 16.26) controlPoint2:CGPointMake(28.9, 16)];
    [bezier4Path closePath];
    [bezier4Path moveToPoint:CGPointMake(28.81, 15.67)];
    [bezier4Path addCurveToPoint:CGPointMake(28.31, 16.17) controlPoint1:CGPointMake(28.81, 15.95) controlPoint2:CGPointMake(28.6, 16.17)];
    [bezier4Path addCurveToPoint:CGPointMake(27.81, 15.67) controlPoint1:CGPointMake(28.02, 16.17) controlPoint2:CGPointMake(27.81, 15.94)];
    [bezier4Path addCurveToPoint:CGPointMake(28.31, 15.16) controlPoint1:CGPointMake(27.81, 15.39) controlPoint2:CGPointMake(28.02, 15.16)];
    [bezier4Path addCurveToPoint:CGPointMake(28.81, 15.67) controlPoint1:CGPointMake(28.6, 15.16) controlPoint2:CGPointMake(28.81, 15.39)];
    [bezier4Path closePath];
    bezier4Path.miterLimit = 4;

    [fillColor3 setFill];
    [bezier4Path fill];
}
}
}

//// Group 8
{
    //// SVGID_4_
    {
        CGContextSaveGState(context);
        CGContextBeginTransparencyLayer(context, NULL);

        //// Clip Bezier 5
        UIBezierPath *bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint:CGPointMake(41.83, 3.69)];
        [bezier5Path addLineToPoint:CGPointMake(29.36, 3.69)];
        [bezier5Path addLineToPoint:CGPointMake(29.36, 16.2)];
        [bezier5Path addLineToPoint:CGPointMake(41.82, 16.2)];
        [bezier5Path addLineToPoint:CGPointMake(41.82, 12.07)];
        [bezier5Path addCurveToPoint:CGPointMake(41.9, 11.79) controlPoint1:CGPointMake(41.87, 12) controlPoint2:CGPointMake(41.9, 11.91)];
        [bezier5Path addCurveToPoint:CGPointMake(41.82, 11.52) controlPoint1:CGPointMake(41.9, 11.66) controlPoint2:CGPointMake(41.87, 11.58)];
        [bezier5Path addLineToPoint:CGPointMake(41.82, 3.69)];
        [bezier5Path addLineToPoint:CGPointMake(41.83, 3.69)];
        [bezier5Path closePath];
        bezier5Path.miterLimit = 0;

        [bezier5Path addClip];

        //// Rectangle 2 Drawing
        UIBezierPath *rectangle2Path = [UIBezierPath bezierPathWithRect:CGRectMake(25.36, 0.92, 13.39, 13.39)];
        CGContextSaveGState(context);
        [rectangle2Path addClip];
        CGContextDrawRadialGradient(context, sVGID_5_,
                                    CGPointMake(32.05, 7.61), 0,
                                    CGPointMake(32.05, 7.61), 6.69,
                                    kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
        CGContextRestoreGState(context);

        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }
}

//// Group 10
{
    //// Bezier 6 Drawing
    UIBezierPath *bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path moveToPoint:CGPointMake(29.36, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(29.96, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(30.1, 9.7)];
    [bezier6Path addLineToPoint:CGPointMake(30.4, 9.7)];
    [bezier6Path addLineToPoint:CGPointMake(30.53, 10.03)];
    [bezier6Path addLineToPoint:CGPointMake(31.71, 10.03)];
    [bezier6Path addLineToPoint:CGPointMake(31.71, 9.77)];
    [bezier6Path addLineToPoint:CGPointMake(31.81, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(32.43, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(32.53, 9.77)];
    [bezier6Path addLineToPoint:CGPointMake(32.53, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(35.46, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(35.46, 9.49)];
    [bezier6Path addLineToPoint:CGPointMake(35.52, 9.49)];
    [bezier6Path addCurveToPoint:CGPointMake(35.57, 9.56) controlPoint1:CGPointMake(35.56, 9.49) controlPoint2:CGPointMake(35.57, 9.49)];
    [bezier6Path addLineToPoint:CGPointMake(35.57, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(37.08, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(37.08, 9.9)];
    [bezier6Path addCurveToPoint:CGPointMake(37.64, 10.02) controlPoint1:CGPointMake(37.21, 9.97) controlPoint2:CGPointMake(37.39, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(38.28, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(38.42, 9.69)];
    [bezier6Path addLineToPoint:CGPointMake(38.72, 9.69)];
    [bezier6Path addLineToPoint:CGPointMake(38.85, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(40.08, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(40.08, 9.71)];
    [bezier6Path addLineToPoint:CGPointMake(40.26, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(41.25, 10.02)];
    [bezier6Path addLineToPoint:CGPointMake(41.25, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(40.27, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(40.27, 8.22)];
    [bezier6Path addLineToPoint:CGPointMake(40.13, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(39.13, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(39.13, 8.22)];
    [bezier6Path addLineToPoint:CGPointMake(39, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(37.65, 7.98)];
    [bezier6Path addCurveToPoint:CGPointMake(37.06, 8.1) controlPoint1:CGPointMake(37.43, 7.98) controlPoint2:CGPointMake(37.22, 8.01)];
    [bezier6Path addLineToPoint:CGPointMake(37.06, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(36.13, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(36.13, 8.1)];
    [bezier6Path addCurveToPoint:CGPointMake(35.74, 7.98) controlPoint1:CGPointMake(36.03, 8.01) controlPoint2:CGPointMake(35.89, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(32.34, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(32.11, 8.51)];
    [bezier6Path addLineToPoint:CGPointMake(31.88, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(30.81, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(30.81, 8.22)];
    [bezier6Path addLineToPoint:CGPointMake(30.7, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(29.79, 7.98)];
    [bezier6Path addLineToPoint:CGPointMake(29.36, 8.95)];
    [bezier6Path addLineToPoint:CGPointMake(29.36, 10.02)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(40.93, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(40.44, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(39.78, 8.63)];
    [bezier6Path addLineToPoint:CGPointMake(39.78, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(39.07, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(38.93, 9.4)];
    [bezier6Path addLineToPoint:CGPointMake(38.2, 9.4)];
    [bezier6Path addLineToPoint:CGPointMake(38.07, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(37.66, 9.73)];
    [bezier6Path addCurveToPoint:CGPointMake(37.15, 9.57) controlPoint1:CGPointMake(37.49, 9.73) controlPoint2:CGPointMake(37.28, 9.69)];
    [bezier6Path addCurveToPoint:CGPointMake(36.96, 9.01) controlPoint1:CGPointMake(37.03, 9.45) controlPoint2:CGPointMake(36.96, 9.28)];
    [bezier6Path addCurveToPoint:CGPointMake(37.15, 8.44) controlPoint1:CGPointMake(36.96, 8.79) controlPoint2:CGPointMake(37, 8.59)];
    [bezier6Path addCurveToPoint:CGPointMake(37.68, 8.27) controlPoint1:CGPointMake(37.26, 8.32) controlPoint2:CGPointMake(37.44, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(38.02, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(38.02, 8.58)];
    [bezier6Path addLineToPoint:CGPointMake(37.69, 8.58)];
    [bezier6Path addCurveToPoint:CGPointMake(37.42, 8.67) controlPoint1:CGPointMake(37.56, 8.58) controlPoint2:CGPointMake(37.49, 8.6)];
    [bezier6Path addCurveToPoint:CGPointMake(37.32, 9) controlPoint1:CGPointMake(37.36, 8.73) controlPoint2:CGPointMake(37.32, 8.85)];
    [bezier6Path addCurveToPoint:CGPointMake(37.42, 9.34) controlPoint1:CGPointMake(37.32, 9.16) controlPoint2:CGPointMake(37.35, 9.27)];
    [bezier6Path addCurveToPoint:CGPointMake(37.66, 9.42) controlPoint1:CGPointMake(37.47, 9.4) controlPoint2:CGPointMake(37.57, 9.42)];
    [bezier6Path addLineToPoint:CGPointMake(37.82, 9.42)];
    [bezier6Path addLineToPoint:CGPointMake(38.31, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(38.84, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(39.43, 9.66)];
    [bezier6Path addLineToPoint:CGPointMake(39.43, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(39.96, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(40.57, 9.29)];
    [bezier6Path addLineToPoint:CGPointMake(40.57, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(40.93, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(40.93, 9.73)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(36.79, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(36.43, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(36.43, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(36.79, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(36.79, 9.73)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(36.23, 8.66)];
    [bezier6Path addCurveToPoint:CGPointMake(35.98, 9.05) controlPoint1:CGPointMake(36.23, 8.89) controlPoint2:CGPointMake(36.07, 9.01)];
    [bezier6Path addCurveToPoint:CGPointMake(36.15, 9.17) controlPoint1:CGPointMake(36.06, 9.08) controlPoint2:CGPointMake(36.12, 9.13)];
    [bezier6Path addCurveToPoint:CGPointMake(36.21, 9.44) controlPoint1:CGPointMake(36.2, 9.24) controlPoint2:CGPointMake(36.21, 9.31)];
    [bezier6Path addLineToPoint:CGPointMake(36.21, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(35.86, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(35.86, 9.55)];
    [bezier6Path addCurveToPoint:CGPointMake(35.8, 9.27) controlPoint1:CGPointMake(35.86, 9.46) controlPoint2:CGPointMake(35.87, 9.34)];
    [bezier6Path addCurveToPoint:CGPointMake(35.55, 9.21) controlPoint1:CGPointMake(35.75, 9.22) controlPoint2:CGPointMake(35.67, 9.21)];
    [bezier6Path addLineToPoint:CGPointMake(35.18, 9.21)];
    [bezier6Path addLineToPoint:CGPointMake(35.18, 9.74)];
    [bezier6Path addLineToPoint:CGPointMake(34.83, 9.74)];
    [bezier6Path addLineToPoint:CGPointMake(34.83, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(35.63, 8.27)];
    [bezier6Path addCurveToPoint:CGPointMake(36.06, 8.34) controlPoint1:CGPointMake(35.81, 8.27) controlPoint2:CGPointMake(35.94, 8.28)];
    [bezier6Path addCurveToPoint:CGPointMake(36.23, 8.66) controlPoint1:CGPointMake(36.16, 8.4) controlPoint2:CGPointMake(36.23, 8.5)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(34.58, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(33.41, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(33.41, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(34.58, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(34.58, 8.58)];
    [bezier6Path addLineToPoint:CGPointMake(33.76, 8.58)];
    [bezier6Path addLineToPoint:CGPointMake(33.76, 8.84)];
    [bezier6Path addLineToPoint:CGPointMake(34.56, 8.84)];
    [bezier6Path addLineToPoint:CGPointMake(34.56, 9.14)];
    [bezier6Path addLineToPoint:CGPointMake(33.76, 9.14)];
    [bezier6Path addLineToPoint:CGPointMake(33.76, 9.43)];
    [bezier6Path addLineToPoint:CGPointMake(34.58, 9.43)];
    [bezier6Path addLineToPoint:CGPointMake(34.58, 9.73)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(33.14, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(32.78, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(32.78, 8.58)];
    [bezier6Path addLineToPoint:CGPointMake(32.27, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(31.96, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(31.45, 8.58)];
    [bezier6Path addLineToPoint:CGPointMake(31.45, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(30.74, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(30.61, 9.4)];
    [bezier6Path addLineToPoint:CGPointMake(29.88, 9.4)];
    [bezier6Path addLineToPoint:CGPointMake(29.75, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(29.37, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(30, 8.26)];
    [bezier6Path addLineToPoint:CGPointMake(30.52, 8.26)];
    [bezier6Path addLineToPoint:CGPointMake(31.12, 9.65)];
    [bezier6Path addLineToPoint:CGPointMake(31.12, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(31.69, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(32.15, 9.27)];
    [bezier6Path addLineToPoint:CGPointMake(32.57, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(33.15, 8.27)];
    [bezier6Path addLineToPoint:CGPointMake(33.15, 9.73)];
    [bezier6Path addLineToPoint:CGPointMake(33.14, 9.73)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(38.8, 9.1)];
    [bezier6Path addLineToPoint:CGPointMake(38.56, 8.52)];
    [bezier6Path addLineToPoint:CGPointMake(38.32, 9.1)];
    [bezier6Path addLineToPoint:CGPointMake(38.8, 9.1)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(35.77, 8.87)];
    [bezier6Path addCurveToPoint:CGPointMake(35.59, 8.9) controlPoint1:CGPointMake(35.72, 8.9) controlPoint2:CGPointMake(35.66, 8.9)];
    [bezier6Path addLineToPoint:CGPointMake(35.17, 8.9)];
    [bezier6Path addLineToPoint:CGPointMake(35.17, 8.57)];
    [bezier6Path addLineToPoint:CGPointMake(35.6, 8.57)];
    [bezier6Path addCurveToPoint:CGPointMake(35.77, 8.6) controlPoint1:CGPointMake(35.66, 8.57) controlPoint2:CGPointMake(35.72, 8.57)];
    [bezier6Path addCurveToPoint:CGPointMake(35.84, 8.73) controlPoint1:CGPointMake(35.81, 8.62) controlPoint2:CGPointMake(35.84, 8.67)];
    [bezier6Path addCurveToPoint:CGPointMake(35.77, 8.87) controlPoint1:CGPointMake(35.84, 8.79) controlPoint2:CGPointMake(35.81, 8.84)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(30.49, 9.1)];
    [bezier6Path addLineToPoint:CGPointMake(30.25, 8.52)];
    [bezier6Path addLineToPoint:CGPointMake(30.01, 9.1)];
    [bezier6Path addLineToPoint:CGPointMake(30.49, 9.1)];
    [bezier6Path closePath];
    bezier6Path.miterLimit = 4;

    [fillColor4 setFill];
    [bezier6Path fill];

    //// Bezier 7 Drawing
    UIBezierPath *bezier7Path = [UIBezierPath bezierPath];
    [bezier7Path moveToPoint:CGPointMake(36.15, 11.27)];
    [bezier7Path addCurveToPoint:CGPointMake(35.54, 11.76) controlPoint1:CGPointMake(36.15, 11.68) controlPoint2:CGPointMake(35.85, 11.76)];
    [bezier7Path addLineToPoint:CGPointMake(35.1, 11.76)];
    [bezier7Path addLineToPoint:CGPointMake(35.1, 12.25)];
    [bezier7Path addLineToPoint:CGPointMake(34.42, 12.25)];
    [bezier7Path addLineToPoint:CGPointMake(33.99, 11.77)];
    [bezier7Path addLineToPoint:CGPointMake(33.54, 12.25)];
    [bezier7Path addLineToPoint:CGPointMake(32.15, 12.25)];
    [bezier7Path addLineToPoint:CGPointMake(32.15, 10.78)];
    [bezier7Path addLineToPoint:CGPointMake(33.56, 10.78)];
    [bezier7Path addLineToPoint:CGPointMake(34, 11.27)];
    [bezier7Path addLineToPoint:CGPointMake(34.44, 10.79)];
    [bezier7Path addLineToPoint:CGPointMake(35.56, 10.79)];
    [bezier7Path addCurveToPoint:CGPointMake(36.15, 11.27) controlPoint1:CGPointMake(35.84, 10.79) controlPoint2:CGPointMake(36.15, 10.87)];
    [bezier7Path closePath];
    [bezier7Path moveToPoint:CGPointMake(33.37, 11.95)];
    [bezier7Path addLineToPoint:CGPointMake(32.51, 11.95)];
    [bezier7Path addLineToPoint:CGPointMake(32.51, 11.66)];
    [bezier7Path addLineToPoint:CGPointMake(33.28, 11.66)];
    [bezier7Path addLineToPoint:CGPointMake(33.28, 11.36)];
    [bezier7Path addLineToPoint:CGPointMake(32.51, 11.36)];
    [bezier7Path addLineToPoint:CGPointMake(32.51, 11.09)];
    [bezier7Path addLineToPoint:CGPointMake(33.39, 11.09)];
    [bezier7Path addLineToPoint:CGPointMake(33.77, 11.52)];
    [bezier7Path addLineToPoint:CGPointMake(33.37, 11.95)];
    [bezier7Path closePath];
    [bezier7Path moveToPoint:CGPointMake(34.76, 12.12)];
    [bezier7Path addLineToPoint:CGPointMake(34.22, 11.52)];
    [bezier7Path addLineToPoint:CGPointMake(34.76, 10.94)];
    [bezier7Path addLineToPoint:CGPointMake(34.76, 12.12)];
    [bezier7Path closePath];
    [bezier7Path moveToPoint:CGPointMake(35.56, 11.47)];
    [bezier7Path addLineToPoint:CGPointMake(35.1, 11.47)];
    [bezier7Path addLineToPoint:CGPointMake(35.1, 11.1)];
    [bezier7Path addLineToPoint:CGPointMake(35.56, 11.1)];
    [bezier7Path addCurveToPoint:CGPointMake(35.77, 11.28) controlPoint1:CGPointMake(35.69, 11.1) controlPoint2:CGPointMake(35.77, 11.15)];
    [bezier7Path addCurveToPoint:CGPointMake(35.56, 11.47) controlPoint1:CGPointMake(35.78, 11.4) controlPoint2:CGPointMake(35.69, 11.47)];
    [bezier7Path closePath];
    [bezier7Path moveToPoint:CGPointMake(37.92, 10.79)];
    [bezier7Path addLineToPoint:CGPointMake(39.09, 10.79)];
    [bezier7Path addLineToPoint:CGPointMake(39.09, 11.09)];
    [bezier7Path addLineToPoint:CGPointMake(38.27, 11.09)];
    [bezier7Path addLineToPoint:CGPointMake(38.27, 11.36)];
    [bezier7Path addLineToPoint:CGPointMake(39.07, 11.36)];
    [bezier7Path addLineToPoint:CGPointMake(39.07, 11.66)];
    [bezier7Path addLineToPoint:CGPointMake(38.27, 11.66)];
    [bezier7Path addLineToPoint:CGPointMake(38.27, 11.95)];
    [bezier7Path addLineToPoint:CGPointMake(39.09, 11.95)];
    [bezier7Path addLineToPoint:CGPointMake(39.09, 12.25)];
    [bezier7Path addLineToPoint:CGPointMake(37.92, 12.25)];
    [bezier7Path addLineToPoint:CGPointMake(37.92, 10.79)];
    [bezier7Path closePath];
    [bezier7Path moveToPoint:CGPointMake(37.48, 11.58)];
    [bezier7Path addCurveToPoint:CGPointMake(37.65, 11.7) controlPoint1:CGPointMake(37.56, 11.61) controlPoint2:CGPointMake(37.62, 11.66)];
    [bezier7Path addCurveToPoint:CGPointMake(37.71, 11.97) controlPoint1:CGPointMake(37.7, 11.77) controlPoint2:CGPointMake(37.71, 11.84)];
    [bezier7Path addLineToPoint:CGPointMake(37.71, 12.26)];
    [bezier7Path addLineToPoint:CGPointMake(37.36, 12.26)];
    [bezier7Path addLineToPoint:CGPointMake(37.36, 12.08)];
    [bezier7Path addCurveToPoint:CGPointMake(37.3, 11.79) controlPoint1:CGPointMake(37.36, 11.99) controlPoint2:CGPointMake(37.37, 11.86)];
    [bezier7Path addCurveToPoint:CGPointMake(37.05, 11.72) controlPoint1:CGPointMake(37.25, 11.74) controlPoint2:CGPointMake(37.17, 11.72)];
    [bezier7Path addLineToPoint:CGPointMake(36.67, 11.72)];
    [bezier7Path addLineToPoint:CGPointMake(36.67, 12.26)];
    [bezier7Path addLineToPoint:CGPointMake(36.32, 12.26)];
    [bezier7Path addLineToPoint:CGPointMake(36.32, 10.79)];
    [bezier7Path addLineToPoint:CGPointMake(37.13, 10.79)];
    [bezier7Path addCurveToPoint:CGPointMake(37.56, 10.86) controlPoint1:CGPointMake(37.31, 10.79) controlPoint2:CGPointMake(37.44, 10.8)];
    [bezier7Path addCurveToPoint:CGPointMake(37.74, 11.19) controlPoint1:CGPointMake(37.67, 10.93) controlPoint2:CGPointMake(37.74, 11.02)];
    [bezier7Path addCurveToPoint:CGPointMake(37.48, 11.58) controlPoint1:CGPointMake(37.73, 11.42) controlPoint2:CGPointMake(37.57, 11.54)];
    [bezier7Path closePath];
    [bezier7Path moveToPoint:CGPointMake(37.27, 11.39)];
    [bezier7Path addCurveToPoint:CGPointMake(37.1, 11.42) controlPoint1:CGPointMake(37.22, 11.42) controlPoint2:CGPointMake(37.16, 11.42)];
    [bezier7Path addLineToPoint:CGPointMake(36.67, 11.42)];
    [bezier7Path addLineToPoint:CGPointMake(36.67, 11.09)];
    [bezier7Path addLineToPoint:CGPointMake(37.1, 11.09)];
    [bezier7Path addCurveToPoint:CGPointMake(37.27, 11.12) controlPoint1:CGPointMake(37.16, 11.09) controlPoint2:CGPointMake(37.22, 11.09)];
    [bezier7Path addCurveToPoint:CGPointMake(37.34, 11.25) controlPoint1:CGPointMake(37.31, 11.14) controlPoint2:CGPointMake(37.34, 11.19)];
    [bezier7Path addCurveToPoint:CGPointMake(37.27, 11.39) controlPoint1:CGPointMake(37.34, 11.31) controlPoint2:CGPointMake(37.31, 11.36)];
    [bezier7Path closePath];
    [bezier7Path moveToPoint:CGPointMake(40.43, 11.48)];
    [bezier7Path addCurveToPoint:CGPointMake(40.54, 11.79) controlPoint1:CGPointMake(40.5, 11.55) controlPoint2:CGPointMake(40.54, 11.64)];
    [bezier7Path addCurveToPoint:CGPointMake(39.99, 12.25) controlPoint1:CGPointMake(40.54, 12.11) controlPoint2:CGPointMake(40.34, 12.25)];
    [bezier7Path addLineToPoint:CGPointMake(39.3, 12.25)];
    [bezier7Path addLineToPoint:CGPointMake(39.3, 11.93)];
    [bezier7Path addLineToPoint:CGPointMake(39.98, 11.93)];
    [bezier7Path addCurveToPoint:CGPointMake(40.12, 11.89) controlPoint1:CGPointMake(40.04, 11.93) controlPoint2:CGPointMake(40.09, 11.92)];
    [bezier7Path addCurveToPoint:CGPointMake(40.16, 11.8) controlPoint1:CGPointMake(40.14, 11.87) controlPoint2:CGPointMake(40.16, 11.84)];
    [bezier7Path addCurveToPoint:CGPointMake(40.12, 11.7) controlPoint1:CGPointMake(40.16, 11.76) controlPoint2:CGPointMake(40.14, 11.72)];
    [bezier7Path addCurveToPoint:CGPointMake(39.99, 11.66) controlPoint1:CGPointMake(40.09, 11.68) controlPoint2:CGPointMake(40.06, 11.67)];
    [bezier7Path addCurveToPoint:CGPointMake(39.25, 11.21) controlPoint1:CGPointMake(39.66, 11.65) controlPoint2:CGPointMake(39.25, 11.67)];
    [bezier7Path addCurveToPoint:CGPointMake(39.75, 10.77) controlPoint1:CGPointMake(39.25, 11) controlPoint2:CGPointMake(39.38, 10.77)];
    [bezier7Path addLineToPoint:CGPointMake(40.45, 10.77)];
    [bezier7Path addLineToPoint:CGPointMake(40.45, 11.08)];
    [bezier7Path addLineToPoint:CGPointMake(39.8, 11.08)];
    [bezier7Path addCurveToPoint:CGPointMake(39.66, 11.11) controlPoint1:CGPointMake(39.74, 11.08) controlPoint2:CGPointMake(39.69, 11.08)];
    [bezier7Path addCurveToPoint:CGPointMake(39.61, 11.22) controlPoint1:CGPointMake(39.62, 11.13) controlPoint2:CGPointMake(39.61, 11.17)];
    [bezier7Path addCurveToPoint:CGPointMake(39.68, 11.33) controlPoint1:CGPointMake(39.61, 11.27) controlPoint2:CGPointMake(39.64, 11.31)];
    [bezier7Path addCurveToPoint:CGPointMake(39.82, 11.35) controlPoint1:CGPointMake(39.72, 11.34) controlPoint2:CGPointMake(39.76, 11.35)];
    [bezier7Path addLineToPoint:CGPointMake(40.01, 11.35)];
    [bezier7Path addCurveToPoint:CGPointMake(40.43, 11.48) controlPoint1:CGPointMake(40.22, 11.37) controlPoint2:CGPointMake(40.35, 11.4)];
    [bezier7Path closePath];
    [bezier7Path moveToPoint:CGPointMake(41.83, 12.07)];
    [bezier7Path addCurveToPoint:CGPointMake(41.36, 12.26) controlPoint1:CGPointMake(41.74, 12.19) controlPoint2:CGPointMake(41.58, 12.26)];
    [bezier7Path addLineToPoint:CGPointMake(40.68, 12.26)];
    [bezier7Path addLineToPoint:CGPointMake(40.68, 11.94)];
    [bezier7Path addLineToPoint:CGPointMake(41.35, 11.94)];
    [bezier7Path addCurveToPoint:CGPointMake(41.5, 11.9) controlPoint1:CGPointMake(41.42, 11.94) controlPoint2:CGPointMake(41.47, 11.93)];
    [bezier7Path addCurveToPoint:CGPointMake(41.54, 11.81) controlPoint1:CGPointMake(41.52, 11.88) controlPoint2:CGPointMake(41.54, 11.85)];
    [bezier7Path addCurveToPoint:CGPointMake(41.5, 11.71) controlPoint1:CGPointMake(41.54, 11.77) controlPoint2:CGPointMake(41.52, 11.73)];
    [bezier7Path addCurveToPoint:CGPointMake(41.38, 11.67) controlPoint1:CGPointMake(41.47, 11.69) controlPoint2:CGPointMake(41.44, 11.68)];
    [bezier7Path addCurveToPoint:CGPointMake(40.64, 11.22) controlPoint1:CGPointMake(41.05, 11.66) controlPoint2:CGPointMake(40.64, 11.68)];
    [bezier7Path addCurveToPoint:CGPointMake(41.14, 10.78) controlPoint1:CGPointMake(40.64, 11.01) controlPoint2:CGPointMake(40.77, 10.78)];
    [bezier7Path addLineToPoint:CGPointMake(41.84, 10.78)];
    [bezier7Path addLineToPoint:CGPointMake(41.84, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(41.19, 10.5)];
    [bezier7Path addCurveToPoint:CGPointMake(40.75, 10.62) controlPoint1:CGPointMake(40.99, 10.5) controlPoint2:CGPointMake(40.85, 10.55)];
    [bezier7Path addLineToPoint:CGPointMake(40.75, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(39.79, 10.5)];
    [bezier7Path addCurveToPoint:CGPointMake(39.37, 10.62) controlPoint1:CGPointMake(39.64, 10.5) controlPoint2:CGPointMake(39.46, 10.54)];
    [bezier7Path addLineToPoint:CGPointMake(39.37, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(37.66, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(37.66, 10.62)];
    [bezier7Path addCurveToPoint:CGPointMake(37.19, 10.5) controlPoint1:CGPointMake(37.52, 10.52) controlPoint2:CGPointMake(37.3, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(36.06, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(36.06, 10.62)];
    [bezier7Path addCurveToPoint:CGPointMake(35.56, 10.5) controlPoint1:CGPointMake(35.95, 10.52) controlPoint2:CGPointMake(35.71, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(34.3, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(34, 10.81)];
    [bezier7Path addLineToPoint:CGPointMake(33.73, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(31.84, 10.5)];
    [bezier7Path addLineToPoint:CGPointMake(31.84, 12.55)];
    [bezier7Path addLineToPoint:CGPointMake(33.69, 12.55)];
    [bezier7Path addLineToPoint:CGPointMake(33.99, 12.23)];
    [bezier7Path addLineToPoint:CGPointMake(34.27, 12.55)];
    [bezier7Path addLineToPoint:CGPointMake(35.41, 12.55)];
    [bezier7Path addLineToPoint:CGPointMake(35.41, 12.07)];
    [bezier7Path addLineToPoint:CGPointMake(35.52, 12.07)];
    [bezier7Path addCurveToPoint:CGPointMake(36.01, 12) controlPoint1:CGPointMake(35.67, 12.07) controlPoint2:CGPointMake(35.85, 12.07)];
    [bezier7Path addLineToPoint:CGPointMake(36.01, 12.55)];
    [bezier7Path addLineToPoint:CGPointMake(36.95, 12.55)];
    [bezier7Path addLineToPoint:CGPointMake(36.95, 12.02)];
    [bezier7Path addLineToPoint:CGPointMake(37, 12.02)];
    [bezier7Path addCurveToPoint:CGPointMake(37.06, 12.08) controlPoint1:CGPointMake(37.06, 12.02) controlPoint2:CGPointMake(37.06, 12.02)];
    [bezier7Path addLineToPoint:CGPointMake(37.06, 12.55)];
    [bezier7Path addLineToPoint:CGPointMake(39.92, 12.55)];
    [bezier7Path addCurveToPoint:CGPointMake(40.4, 12.42) controlPoint1:CGPointMake(40.1, 12.55) controlPoint2:CGPointMake(40.29, 12.5)];
    [bezier7Path addLineToPoint:CGPointMake(40.4, 12.55)];
    [bezier7Path addLineToPoint:CGPointMake(41.31, 12.55)];
    [bezier7Path addCurveToPoint:CGPointMake(41.83, 12.45) controlPoint1:CGPointMake(41.5, 12.55) controlPoint2:CGPointMake(41.69, 12.52)];
    [bezier7Path addLineToPoint:CGPointMake(41.83, 12.07)];
    [bezier7Path closePath];
    [bezier7Path moveToPoint:CGPointMake(41.83, 11.1)];
    [bezier7Path addLineToPoint:CGPointMake(41.19, 11.1)];
    [bezier7Path addCurveToPoint:CGPointMake(41.05, 11.13) controlPoint1:CGPointMake(41.12, 11.1) controlPoint2:CGPointMake(41.08, 11.1)];
    [bezier7Path addCurveToPoint:CGPointMake(41, 11.24) controlPoint1:CGPointMake(41.01, 11.15) controlPoint2:CGPointMake(41, 11.19)];
    [bezier7Path addCurveToPoint:CGPointMake(41.08, 11.35) controlPoint1:CGPointMake(41, 11.29) controlPoint2:CGPointMake(41.03, 11.33)];
    [bezier7Path addCurveToPoint:CGPointMake(41.21, 11.37) controlPoint1:CGPointMake(41.11, 11.36) controlPoint2:CGPointMake(41.15, 11.37)];
    [bezier7Path addLineToPoint:CGPointMake(41.4, 11.37)];
    [bezier7Path addCurveToPoint:CGPointMake(41.8, 11.49) controlPoint1:CGPointMake(41.6, 11.38) controlPoint2:CGPointMake(41.72, 11.41)];
    [bezier7Path addCurveToPoint:CGPointMake(41.83, 11.53) controlPoint1:CGPointMake(41.81, 11.5) controlPoint2:CGPointMake(41.82, 11.51)];
    [bezier7Path addLineToPoint:CGPointMake(41.83, 11.1)];
    [bezier7Path closePath];
    bezier7Path.miterLimit = 4;

    [fillColor4 setFill];
    [bezier7Path fill];
}
}

//// Group 11
{
    //// Group 12
    {
        //// Group 13
        {
            //// Group 14
            {
                //// Bezier 8 Drawing
                UIBezierPath *bezier8Path = [UIBezierPath bezierPath];
                [bezier8Path moveToPoint:CGPointMake(9.04, 23.82)];
                [bezier8Path addCurveToPoint:CGPointMake(9, 24.11) controlPoint1:CGPointMake(9.04, 23.94) controlPoint2:CGPointMake(9.03, 24.03)];
                [bezier8Path addCurveToPoint:CGPointMake(8.87, 24.3) controlPoint1:CGPointMake(8.98, 24.19) controlPoint2:CGPointMake(8.93, 24.25)];
                [bezier8Path addCurveToPoint:CGPointMake(8.62, 24.4) controlPoint1:CGPointMake(8.81, 24.35) controlPoint2:CGPointMake(8.73, 24.38)];
                [bezier8Path addCurveToPoint:CGPointMake(8.22, 24.43) controlPoint1:CGPointMake(8.51, 24.42) controlPoint2:CGPointMake(8.38, 24.43)];
                [bezier8Path addLineToPoint:CGPointMake(8.2, 24.43)];
                [bezier8Path addCurveToPoint:CGPointMake(8.07, 24.43) controlPoint1:CGPointMake(8.16, 24.43) controlPoint2:CGPointMake(8.11, 24.43)];
                [bezier8Path addCurveToPoint:CGPointMake(7.92, 24.42) controlPoint1:CGPointMake(8.02, 24.43) controlPoint2:CGPointMake(7.97, 24.43)];
                [bezier8Path addCurveToPoint:CGPointMake(7.78, 24.39) controlPoint1:CGPointMake(7.87, 24.41) controlPoint2:CGPointMake(7.82, 24.41)];
                [bezier8Path addCurveToPoint:CGPointMake(7.65, 24.34) controlPoint1:CGPointMake(7.73, 24.38) controlPoint2:CGPointMake(7.69, 24.36)];
                [bezier8Path addCurveToPoint:CGPointMake(7.56, 24.26) controlPoint1:CGPointMake(7.61, 24.32) controlPoint2:CGPointMake(7.58, 24.29)];
                [bezier8Path addCurveToPoint:CGPointMake(7.52, 24.15) controlPoint1:CGPointMake(7.54, 24.23) controlPoint2:CGPointMake(7.52, 24.19)];
                [bezier8Path addLineToPoint:CGPointMake(7.52, 24.14)];
                [bezier8Path addCurveToPoint:CGPointMake(7.57, 24.02) controlPoint1:CGPointMake(7.52, 24.09) controlPoint2:CGPointMake(7.54, 24.05)];
                [bezier8Path addCurveToPoint:CGPointMake(7.69, 23.98) controlPoint1:CGPointMake(7.61, 23.99) controlPoint2:CGPointMake(7.65, 23.98)];
                [bezier8Path addLineToPoint:CGPointMake(7.69, 23.98)];
                [bezier8Path addCurveToPoint:CGPointMake(7.75, 23.98) controlPoint1:CGPointMake(7.72, 23.98) controlPoint2:CGPointMake(7.74, 23.98)];
                [bezier8Path addCurveToPoint:CGPointMake(7.8, 24.01) controlPoint1:CGPointMake(7.78, 24) controlPoint2:CGPointMake(7.79, 24)];
                [bezier8Path addCurveToPoint:CGPointMake(7.83, 24.03) controlPoint1:CGPointMake(7.81, 24.02) controlPoint2:CGPointMake(7.82, 24.02)];
                [bezier8Path addCurveToPoint:CGPointMake(7.86, 24.05) controlPoint1:CGPointMake(7.84, 24.04) controlPoint2:CGPointMake(7.85, 24.04)];
                [bezier8Path addLineToPoint:CGPointMake(7.86, 24.05)];
                [bezier8Path addCurveToPoint:CGPointMake(7.9, 24.08) controlPoint1:CGPointMake(7.88, 24.06) controlPoint2:CGPointMake(7.89, 24.07)];
                [bezier8Path addCurveToPoint:CGPointMake(7.96, 24.1) controlPoint1:CGPointMake(7.91, 24.09) controlPoint2:CGPointMake(7.94, 24.09)];
                [bezier8Path addCurveToPoint:CGPointMake(8.06, 24.12) controlPoint1:CGPointMake(7.99, 24.11) controlPoint2:CGPointMake(8.02, 24.11)];
                [bezier8Path addCurveToPoint:CGPointMake(8.23, 24.12) controlPoint1:CGPointMake(8.1, 24.12) controlPoint2:CGPointMake(8.16, 24.12)];
                [bezier8Path addLineToPoint:CGPointMake(8.26, 24.12)];
                [bezier8Path addCurveToPoint:CGPointMake(8.45, 24.1) controlPoint1:CGPointMake(8.34, 24.12) controlPoint2:CGPointMake(8.4, 24.12)];
                [bezier8Path addCurveToPoint:CGPointMake(8.57, 24.05) controlPoint1:CGPointMake(8.5, 24.09) controlPoint2:CGPointMake(8.54, 24.07)];
                [bezier8Path addCurveToPoint:CGPointMake(8.63, 23.96) controlPoint1:CGPointMake(8.6, 24.03) controlPoint2:CGPointMake(8.62, 23.99)];
                [bezier8Path addCurveToPoint:CGPointMake(8.65, 23.83) controlPoint1:CGPointMake(8.64, 23.92) controlPoint2:CGPointMake(8.65, 23.88)];
                [bezier8Path addCurveToPoint:CGPointMake(8.61, 23.64) controlPoint1:CGPointMake(8.65, 23.74) controlPoint2:CGPointMake(8.64, 23.67)];
                [bezier8Path addCurveToPoint:CGPointMake(8.48, 23.58) controlPoint1:CGPointMake(8.59, 23.61) controlPoint2:CGPointMake(8.55, 23.58)];
                [bezier8Path addLineToPoint:CGPointMake(8.06, 23.58)];
                [bezier8Path addCurveToPoint:CGPointMake(7.99, 23.57) controlPoint1:CGPointMake(8.04, 23.58) controlPoint2:CGPointMake(8.01, 23.58)];
                [bezier8Path addCurveToPoint:CGPointMake(7.93, 23.55) controlPoint1:CGPointMake(7.97, 23.57) controlPoint2:CGPointMake(7.95, 23.56)];
                [bezier8Path addCurveToPoint:CGPointMake(7.89, 23.5) controlPoint1:CGPointMake(7.91, 23.54) controlPoint2:CGPointMake(7.9, 23.52)];
                [bezier8Path addCurveToPoint:CGPointMake(7.87, 23.42) controlPoint1:CGPointMake(7.88, 23.48) controlPoint2:CGPointMake(7.87, 23.45)];
                [bezier8Path addCurveToPoint:CGPointMake(7.93, 23.29) controlPoint1:CGPointMake(7.87, 23.36) controlPoint2:CGPointMake(7.89, 23.32)];
                [bezier8Path addCurveToPoint:CGPointMake(8.06, 23.25) controlPoint1:CGPointMake(7.97, 23.27) controlPoint2:CGPointMake(8.02, 23.25)];
                [bezier8Path addLineToPoint:CGPointMake(8.46, 23.25)];
                [bezier8Path addCurveToPoint:CGPointMake(8.54, 23.24) controlPoint1:CGPointMake(8.49, 23.25) controlPoint2:CGPointMake(8.52, 23.25)];
                [bezier8Path addCurveToPoint:CGPointMake(8.6, 23.2) controlPoint1:CGPointMake(8.56, 23.23) controlPoint2:CGPointMake(8.58, 23.22)];
                [bezier8Path addCurveToPoint:CGPointMake(8.63, 23.13) controlPoint1:CGPointMake(8.61, 23.18) controlPoint2:CGPointMake(8.63, 23.16)];
                [bezier8Path addCurveToPoint:CGPointMake(8.64, 23.01) controlPoint1:CGPointMake(8.64, 23.1) controlPoint2:CGPointMake(8.64, 23.06)];
                [bezier8Path addCurveToPoint:CGPointMake(8.63, 22.88) controlPoint1:CGPointMake(8.64, 22.96) controlPoint2:CGPointMake(8.64, 22.91)];
                [bezier8Path addCurveToPoint:CGPointMake(8.58, 22.79) controlPoint1:CGPointMake(8.63, 22.84) controlPoint2:CGPointMake(8.61, 22.81)];
                [bezier8Path addCurveToPoint:CGPointMake(8.47, 22.74) controlPoint1:CGPointMake(8.55, 22.77) controlPoint2:CGPointMake(8.52, 22.75)];
                [bezier8Path addCurveToPoint:CGPointMake(8.27, 22.73) controlPoint1:CGPointMake(8.42, 22.73) controlPoint2:CGPointMake(8.35, 22.73)];
                [bezier8Path addLineToPoint:CGPointMake(8.26, 22.73)];
                [bezier8Path addCurveToPoint:CGPointMake(8.09, 22.74) controlPoint1:CGPointMake(8.21, 22.73) controlPoint2:CGPointMake(8.15, 22.73)];
                [bezier8Path addCurveToPoint:CGPointMake(7.95, 22.78) controlPoint1:CGPointMake(8.03, 22.75) controlPoint2:CGPointMake(7.99, 22.76)];
                [bezier8Path addCurveToPoint:CGPointMake(7.9, 22.8) controlPoint1:CGPointMake(7.93, 22.79) controlPoint2:CGPointMake(7.92, 22.8)];
                [bezier8Path addCurveToPoint:CGPointMake(7.86, 22.82) controlPoint1:CGPointMake(7.89, 22.81) controlPoint2:CGPointMake(7.87, 22.82)];
                [bezier8Path addCurveToPoint:CGPointMake(7.81, 22.83) controlPoint1:CGPointMake(7.85, 22.83) controlPoint2:CGPointMake(7.83, 22.83)];
                [bezier8Path addCurveToPoint:CGPointMake(7.75, 22.83) controlPoint1:CGPointMake(7.79, 22.83) controlPoint2:CGPointMake(7.78, 22.83)];
                [bezier8Path addLineToPoint:CGPointMake(7.75, 22.83)];
                [bezier8Path addCurveToPoint:CGPointMake(7.63, 22.79) controlPoint1:CGPointMake(7.7, 22.83) controlPoint2:CGPointMake(7.66, 22.81)];
                [bezier8Path addCurveToPoint:CGPointMake(7.58, 22.68) controlPoint1:CGPointMake(7.59, 22.76) controlPoint2:CGPointMake(7.58, 22.72)];
                [bezier8Path addLineToPoint:CGPointMake(7.58, 22.68)];
                [bezier8Path addCurveToPoint:CGPointMake(7.62, 22.56) controlPoint1:CGPointMake(7.58, 22.63) controlPoint2:CGPointMake(7.6, 22.59)];
                [bezier8Path addCurveToPoint:CGPointMake(7.74, 22.47) controlPoint1:CGPointMake(7.65, 22.52) controlPoint2:CGPointMake(7.69, 22.5)];
                [bezier8Path addCurveToPoint:CGPointMake(7.94, 22.41) controlPoint1:CGPointMake(7.79, 22.45) controlPoint2:CGPointMake(7.86, 22.43)];
                [bezier8Path addCurveToPoint:CGPointMake(8.25, 22.39) controlPoint1:CGPointMake(8.02, 22.4) controlPoint2:CGPointMake(8.13, 22.39)];
                [bezier8Path addCurveToPoint:CGPointMake(8.62, 22.41) controlPoint1:CGPointMake(8.39, 22.39) controlPoint2:CGPointMake(8.52, 22.4)];
                [bezier8Path addCurveToPoint:CGPointMake(8.86, 22.49) controlPoint1:CGPointMake(8.72, 22.42) controlPoint2:CGPointMake(8.8, 22.45)];
                [bezier8Path addCurveToPoint:CGPointMake(8.99, 22.66) controlPoint1:CGPointMake(8.92, 22.53) controlPoint2:CGPointMake(8.97, 22.59)];
                [bezier8Path addCurveToPoint:CGPointMake(9.03, 22.94) controlPoint1:CGPointMake(9.02, 22.74) controlPoint2:CGPointMake(9.03, 22.83)];
                [bezier8Path addCurveToPoint:CGPointMake(9.02, 23.1) controlPoint1:CGPointMake(9.03, 23) controlPoint2:CGPointMake(9.03, 23.05)];
                [bezier8Path addCurveToPoint:CGPointMake(9, 23.22) controlPoint1:CGPointMake(9.01, 23.14) controlPoint2:CGPointMake(9.01, 23.18)];
                [bezier8Path addCurveToPoint:CGPointMake(8.97, 23.32) controlPoint1:CGPointMake(9, 23.27) controlPoint2:CGPointMake(8.98, 23.3)];
                [bezier8Path addCurveToPoint:CGPointMake(8.92, 23.39) controlPoint1:CGPointMake(8.96, 23.35) controlPoint2:CGPointMake(8.94, 23.37)];
                [bezier8Path addCurveToPoint:CGPointMake(8.96, 23.44) controlPoint1:CGPointMake(8.94, 23.4) controlPoint2:CGPointMake(8.95, 23.42)];
                [bezier8Path addCurveToPoint:CGPointMake(9, 23.52) controlPoint1:CGPointMake(8.97, 23.46) controlPoint2:CGPointMake(8.99, 23.49)];
                [bezier8Path addCurveToPoint:CGPointMake(9.03, 23.64) controlPoint1:CGPointMake(9.01, 23.55) controlPoint2:CGPointMake(9.02, 23.59)];
                [bezier8Path addCurveToPoint:CGPointMake(9.04, 23.82) controlPoint1:CGPointMake(9.04, 23.69) controlPoint2:CGPointMake(9.04, 23.75)];
                [bezier8Path closePath];
                bezier8Path.miterLimit = 4;

                [fillColor setFill];
                [bezier8Path fill];

                //// Bezier 9 Drawing
                UIBezierPath *bezier9Path = [UIBezierPath bezierPath];
                [bezier9Path moveToPoint:CGPointMake(11.23, 23.88)];
                [bezier9Path addLineToPoint:CGPointMake(11.23, 23.88)];
                [bezier9Path addCurveToPoint:CGPointMake(11.18, 24.14) controlPoint1:CGPointMake(11.23, 23.99) controlPoint2:CGPointMake(11.22, 24.07)];
                [bezier9Path addCurveToPoint:CGPointMake(11.02, 24.31) controlPoint1:CGPointMake(11.14, 24.21) controlPoint2:CGPointMake(11.09, 24.27)];
                [bezier9Path addCurveToPoint:CGPointMake(10.78, 24.4) controlPoint1:CGPointMake(10.95, 24.35) controlPoint2:CGPointMake(10.87, 24.38)];
                [bezier9Path addCurveToPoint:CGPointMake(10.47, 24.43) controlPoint1:CGPointMake(10.69, 24.42) controlPoint2:CGPointMake(10.58, 24.43)];
                [bezier9Path addCurveToPoint:CGPointMake(10.15, 24.4) controlPoint1:CGPointMake(10.35, 24.43) controlPoint2:CGPointMake(10.25, 24.42)];
                [bezier9Path addCurveToPoint:CGPointMake(9.92, 24.31) controlPoint1:CGPointMake(10.06, 24.38) controlPoint2:CGPointMake(9.98, 24.35)];
                [bezier9Path addCurveToPoint:CGPointMake(9.77, 24.14) controlPoint1:CGPointMake(9.86, 24.27) controlPoint2:CGPointMake(9.81, 24.21)];
                [bezier9Path addCurveToPoint:CGPointMake(9.72, 23.9) controlPoint1:CGPointMake(9.73, 24.07) controlPoint2:CGPointMake(9.72, 23.99)];
                [bezier9Path addLineToPoint:CGPointMake(9.72, 22.93)];
                [bezier9Path addCurveToPoint:CGPointMake(9.92, 22.54) controlPoint1:CGPointMake(9.72, 22.76) controlPoint2:CGPointMake(9.79, 22.63)];
                [bezier9Path addCurveToPoint:CGPointMake(10.48, 22.41) controlPoint1:CGPointMake(10.05, 22.46) controlPoint2:CGPointMake(10.24, 22.41)];
                [bezier9Path addCurveToPoint:CGPointMake(10.79, 22.44) controlPoint1:CGPointMake(10.59, 22.41) controlPoint2:CGPointMake(10.69, 22.42)];
                [bezier9Path addCurveToPoint:CGPointMake(11.02, 22.54) controlPoint1:CGPointMake(10.88, 22.46) controlPoint2:CGPointMake(10.96, 22.5)];
                [bezier9Path addCurveToPoint:CGPointMake(11.17, 22.71) controlPoint1:CGPointMake(11.08, 22.58) controlPoint2:CGPointMake(11.14, 22.64)];
                [bezier9Path addCurveToPoint:CGPointMake(11.22, 22.94) controlPoint1:CGPointMake(11.2, 22.78) controlPoint2:CGPointMake(11.22, 22.85)];
                [bezier9Path addLineToPoint:CGPointMake(11.22, 23.88)];
                [bezier9Path addLineToPoint:CGPointMake(11.23, 23.88)];
                [bezier9Path closePath];
                [bezier9Path moveToPoint:CGPointMake(10.84, 22.95)];
                [bezier9Path addCurveToPoint:CGPointMake(10.75, 22.78) controlPoint1:CGPointMake(10.84, 22.88) controlPoint2:CGPointMake(10.81, 22.82)];
                [bezier9Path addCurveToPoint:CGPointMake(10.48, 22.72) controlPoint1:CGPointMake(10.69, 22.74) controlPoint2:CGPointMake(10.6, 22.72)];
                [bezier9Path addCurveToPoint:CGPointMake(10.21, 22.78) controlPoint1:CGPointMake(10.36, 22.72) controlPoint2:CGPointMake(10.27, 22.74)];
                [bezier9Path addCurveToPoint:CGPointMake(10.13, 22.94) controlPoint1:CGPointMake(10.15, 22.82) controlPoint2:CGPointMake(10.13, 22.87)];
                [bezier9Path addLineToPoint:CGPointMake(10.13, 23.89)];
                [bezier9Path addCurveToPoint:CGPointMake(10.22, 24.06) controlPoint1:CGPointMake(10.13, 23.97) controlPoint2:CGPointMake(10.16, 24.02)];
                [bezier9Path addCurveToPoint:CGPointMake(10.49, 24.11) controlPoint1:CGPointMake(10.28, 24.09) controlPoint2:CGPointMake(10.37, 24.11)];
                [bezier9Path addCurveToPoint:CGPointMake(10.75, 24.06) controlPoint1:CGPointMake(10.6, 24.11) controlPoint2:CGPointMake(10.69, 24.09)];
                [bezier9Path addCurveToPoint:CGPointMake(10.85, 23.89) controlPoint1:CGPointMake(10.82, 24.03) controlPoint2:CGPointMake(10.85, 23.97)];
                [bezier9Path addLineToPoint:CGPointMake(10.85, 22.95)];
                [bezier9Path addLineToPoint:CGPointMake(10.84, 22.95)];
                [bezier9Path closePath];
                bezier9Path.miterLimit = 4;

                [fillColor setFill];
                [bezier9Path fill];

                //// Bezier 10 Drawing
                UIBezierPath *bezier10Path = [UIBezierPath bezierPath];
                [bezier10Path moveToPoint:CGPointMake(13.1, 23.28)];
                [bezier10Path addCurveToPoint:CGPointMake(13.28, 23.37) controlPoint1:CGPointMake(13.17, 23.3) controlPoint2:CGPointMake(13.23, 23.33)];
                [bezier10Path addCurveToPoint:CGPointMake(13.38, 23.55) controlPoint1:CGPointMake(13.33, 23.41) controlPoint2:CGPointMake(13.36, 23.47)];
                [bezier10Path addCurveToPoint:CGPointMake(13.41, 23.83) controlPoint1:CGPointMake(13.4, 23.62) controlPoint2:CGPointMake(13.41, 23.72)];
                [bezier10Path addCurveToPoint:CGPointMake(13.37, 24.12) controlPoint1:CGPointMake(13.41, 23.95) controlPoint2:CGPointMake(13.4, 24.04)];
                [bezier10Path addCurveToPoint:CGPointMake(13.24, 24.31) controlPoint1:CGPointMake(13.35, 24.2) controlPoint2:CGPointMake(13.3, 24.26)];
                [bezier10Path addCurveToPoint:CGPointMake(12.99, 24.41) controlPoint1:CGPointMake(13.18, 24.35) controlPoint2:CGPointMake(13.1, 24.39)];
                [bezier10Path addCurveToPoint:CGPointMake(12.59, 24.44) controlPoint1:CGPointMake(12.89, 24.43) controlPoint2:CGPointMake(12.75, 24.44)];
                [bezier10Path addLineToPoint:CGPointMake(12.51, 24.44)];
                [bezier10Path addCurveToPoint:CGPointMake(12.31, 24.43) controlPoint1:CGPointMake(12.45, 24.44) controlPoint2:CGPointMake(12.38, 24.44)];
                [bezier10Path addCurveToPoint:CGPointMake(12.11, 24.4) controlPoint1:CGPointMake(12.24, 24.43) controlPoint2:CGPointMake(12.17, 24.41)];
                [bezier10Path addCurveToPoint:CGPointMake(11.95, 24.32) controlPoint1:CGPointMake(12.05, 24.38) controlPoint2:CGPointMake(12, 24.35)];
                [bezier10Path addCurveToPoint:CGPointMake(11.88, 24.17) controlPoint1:CGPointMake(11.91, 24.28) controlPoint2:CGPointMake(11.88, 24.23)];
                [bezier10Path addLineToPoint:CGPointMake(11.88, 24.16)];
                [bezier10Path addCurveToPoint:CGPointMake(11.93, 24.05) controlPoint1:CGPointMake(11.88, 24.11) controlPoint2:CGPointMake(11.9, 24.08)];
                [bezier10Path addCurveToPoint:CGPointMake(12.05, 24) controlPoint1:CGPointMake(11.96, 24.02) controlPoint2:CGPointMake(12.01, 24)];
                [bezier10Path addLineToPoint:CGPointMake(12.06, 24)];
                [bezier10Path addCurveToPoint:CGPointMake(12.15, 24.01) controlPoint1:CGPointMake(12.1, 24) controlPoint2:CGPointMake(12.13, 24.01)];
                [bezier10Path addCurveToPoint:CGPointMake(12.21, 24.03) controlPoint1:CGPointMake(12.18, 24.02) controlPoint2:CGPointMake(12.19, 24.03)];
                [bezier10Path addCurveToPoint:CGPointMake(12.25, 24.06) controlPoint1:CGPointMake(12.22, 24.04) controlPoint2:CGPointMake(12.24, 24.05)];
                [bezier10Path addCurveToPoint:CGPointMake(12.32, 24.09) controlPoint1:CGPointMake(12.27, 24.07) controlPoint2:CGPointMake(12.29, 24.08)];
                [bezier10Path addCurveToPoint:CGPointMake(12.43, 24.11) controlPoint1:CGPointMake(12.35, 24.1) controlPoint2:CGPointMake(12.39, 24.1)];
                [bezier10Path addCurveToPoint:CGPointMake(12.62, 24.12) controlPoint1:CGPointMake(12.48, 24.12) controlPoint2:CGPointMake(12.54, 24.12)];
                [bezier10Path addCurveToPoint:CGPointMake(12.82, 24.1) controlPoint1:CGPointMake(12.7, 24.12) controlPoint2:CGPointMake(12.76, 24.12)];
                [bezier10Path addCurveToPoint:CGPointMake(12.94, 24.05) controlPoint1:CGPointMake(12.87, 24.09) controlPoint2:CGPointMake(12.91, 24.07)];
                [bezier10Path addCurveToPoint:CGPointMake(13, 23.96) controlPoint1:CGPointMake(12.97, 24.03) controlPoint2:CGPointMake(12.99, 23.99)];
                [bezier10Path addCurveToPoint:CGPointMake(13.02, 23.83) controlPoint1:CGPointMake(13.01, 23.92) controlPoint2:CGPointMake(13.02, 23.88)];
                [bezier10Path addCurveToPoint:CGPointMake(12.98, 23.64) controlPoint1:CGPointMake(13.02, 23.74) controlPoint2:CGPointMake(13.01, 23.68)];
                [bezier10Path addCurveToPoint:CGPointMake(12.85, 23.58) controlPoint1:CGPointMake(12.96, 23.6) controlPoint2:CGPointMake(12.92, 23.58)];
                [bezier10Path addLineToPoint:CGPointMake(12.18, 23.58)];
                [bezier10Path addCurveToPoint:CGPointMake(12.04, 23.57) controlPoint1:CGPointMake(12.12, 23.58) controlPoint2:CGPointMake(12.08, 23.58)];
                [bezier10Path addCurveToPoint:CGPointMake(11.96, 23.54) controlPoint1:CGPointMake(12.01, 23.57) controlPoint2:CGPointMake(11.98, 23.55)];
                [bezier10Path addCurveToPoint:CGPointMake(11.92, 23.47) controlPoint1:CGPointMake(11.94, 23.52) controlPoint2:CGPointMake(11.93, 23.5)];
                [bezier10Path addCurveToPoint:CGPointMake(11.91, 23.35) controlPoint1:CGPointMake(11.91, 23.44) controlPoint2:CGPointMake(11.91, 23.4)];
                [bezier10Path addLineToPoint:CGPointMake(11.91, 22.61)];
                [bezier10Path addCurveToPoint:CGPointMake(11.96, 22.48) controlPoint1:CGPointMake(11.91, 22.55) controlPoint2:CGPointMake(11.93, 22.51)];
                [bezier10Path addCurveToPoint:CGPointMake(12.13, 22.44) controlPoint1:CGPointMake(11.99, 22.45) controlPoint2:CGPointMake(12.05, 22.44)];
                [bezier10Path addCurveToPoint:CGPointMake(12.25, 22.44) controlPoint1:CGPointMake(12.15, 22.44) controlPoint2:CGPointMake(12.19, 22.44)];
                [bezier10Path addCurveToPoint:CGPointMake(12.43, 22.44) controlPoint1:CGPointMake(12.3, 22.44) controlPoint2:CGPointMake(12.37, 22.44)];
                [bezier10Path addCurveToPoint:CGPointMake(12.63, 22.44) controlPoint1:CGPointMake(12.49, 22.44) controlPoint2:CGPointMake(12.56, 22.44)];
                [bezier10Path addCurveToPoint:CGPointMake(12.83, 22.44) controlPoint1:CGPointMake(12.7, 22.44) controlPoint2:CGPointMake(12.77, 22.44)];
                [bezier10Path addCurveToPoint:CGPointMake(12.99, 22.44) controlPoint1:CGPointMake(12.89, 22.44) controlPoint2:CGPointMake(12.94, 22.44)];
                [bezier10Path addCurveToPoint:CGPointMake(13.08, 22.44) controlPoint1:CGPointMake(13.03, 22.44) controlPoint2:CGPointMake(13.06, 22.44)];
                [bezier10Path addCurveToPoint:CGPointMake(13.15, 22.45) controlPoint1:CGPointMake(13.1, 22.44) controlPoint2:CGPointMake(13.12, 22.44)];
                [bezier10Path addCurveToPoint:CGPointMake(13.22, 22.47) controlPoint1:CGPointMake(13.17, 22.45) controlPoint2:CGPointMake(13.2, 22.46)];
                [bezier10Path addCurveToPoint:CGPointMake(13.28, 22.52) controlPoint1:CGPointMake(13.24, 22.48) controlPoint2:CGPointMake(13.26, 22.5)];
                [bezier10Path addCurveToPoint:CGPointMake(13.3, 22.6) controlPoint1:CGPointMake(13.29, 22.54) controlPoint2:CGPointMake(13.3, 22.57)];
                [bezier10Path addLineToPoint:CGPointMake(13.3, 22.61)];
                [bezier10Path addCurveToPoint:CGPointMake(13.28, 22.7) controlPoint1:CGPointMake(13.3, 22.65) controlPoint2:CGPointMake(13.29, 22.68)];
                [bezier10Path addCurveToPoint:CGPointMake(13.23, 22.75) controlPoint1:CGPointMake(13.27, 22.72) controlPoint2:CGPointMake(13.25, 22.74)];
                [bezier10Path addCurveToPoint:CGPointMake(13.16, 22.77) controlPoint1:CGPointMake(13.21, 22.76) controlPoint2:CGPointMake(13.18, 22.77)];
                [bezier10Path addCurveToPoint:CGPointMake(13.08, 22.77) controlPoint1:CGPointMake(13.14, 22.77) controlPoint2:CGPointMake(13.11, 22.77)];
                [bezier10Path addLineToPoint:CGPointMake(12.3, 22.77)];
                [bezier10Path addLineToPoint:CGPointMake(12.3, 23.28)];
                [bezier10Path addLineToPoint:CGPointMake(12.82, 23.28)];
                [bezier10Path addCurveToPoint:CGPointMake(13.1, 23.28) controlPoint1:CGPointMake(12.94, 23.25) controlPoint2:CGPointMake(13.03, 23.25)];
                [bezier10Path closePath];
                bezier10Path.miterLimit = 4;

                [fillColor setFill];
                [bezier10Path fill];

                //// Bezier 11 Drawing
                UIBezierPath *bezier11Path = [UIBezierPath bezierPath];
                [bezier11Path moveToPoint:CGPointMake(16.26, 23.19)];
                [bezier11Path addCurveToPoint:CGPointMake(16.58, 23.23) controlPoint1:CGPointMake(16.39, 23.19) controlPoint2:CGPointMake(16.49, 23.2)];
                [bezier11Path addCurveToPoint:CGPointMake(16.79, 23.35) controlPoint1:CGPointMake(16.67, 23.26) controlPoint2:CGPointMake(16.74, 23.3)];
                [bezier11Path addCurveToPoint:CGPointMake(16.9, 23.55) controlPoint1:CGPointMake(16.85, 23.4) controlPoint2:CGPointMake(16.88, 23.47)];
                [bezier11Path addCurveToPoint:CGPointMake(16.94, 23.82) controlPoint1:CGPointMake(16.92, 23.63) controlPoint2:CGPointMake(16.94, 23.72)];
                [bezier11Path addCurveToPoint:CGPointMake(16.9, 24.08) controlPoint1:CGPointMake(16.94, 23.92) controlPoint2:CGPointMake(16.93, 24.01)];
                [bezier11Path addCurveToPoint:CGPointMake(16.77, 24.27) controlPoint1:CGPointMake(16.87, 24.16) controlPoint2:CGPointMake(16.83, 24.22)];
                [bezier11Path addCurveToPoint:CGPointMake(16.54, 24.39) controlPoint1:CGPointMake(16.71, 24.32) controlPoint2:CGPointMake(16.64, 24.36)];
                [bezier11Path addCurveToPoint:CGPointMake(16.18, 24.43) controlPoint1:CGPointMake(16.44, 24.42) controlPoint2:CGPointMake(16.32, 24.43)];
                [bezier11Path addCurveToPoint:CGPointMake(15.88, 24.4) controlPoint1:CGPointMake(16.07, 24.43) controlPoint2:CGPointMake(15.97, 24.42)];
                [bezier11Path addCurveToPoint:CGPointMake(15.65, 24.3) controlPoint1:CGPointMake(15.79, 24.38) controlPoint2:CGPointMake(15.71, 24.35)];
                [bezier11Path addCurveToPoint:CGPointMake(15.5, 24.13) controlPoint1:CGPointMake(15.58, 24.26) controlPoint2:CGPointMake(15.53, 24.2)];
                [bezier11Path addCurveToPoint:CGPointMake(15.44, 23.87) controlPoint1:CGPointMake(15.46, 24.06) controlPoint2:CGPointMake(15.44, 23.97)];
                [bezier11Path addLineToPoint:CGPointMake(15.44, 22.57)];
                [bezier11Path addCurveToPoint:CGPointMake(15.45, 22.51) controlPoint1:CGPointMake(15.44, 22.55) controlPoint2:CGPointMake(15.44, 22.53)];
                [bezier11Path addCurveToPoint:CGPointMake(15.48, 22.45) controlPoint1:CGPointMake(15.46, 22.49) controlPoint2:CGPointMake(15.47, 22.47)];
                [bezier11Path addCurveToPoint:CGPointMake(15.54, 22.41) controlPoint1:CGPointMake(15.49, 22.43) controlPoint2:CGPointMake(15.52, 22.42)];
                [bezier11Path addCurveToPoint:CGPointMake(15.63, 22.39) controlPoint1:CGPointMake(15.57, 22.4) controlPoint2:CGPointMake(15.6, 22.39)];
                [bezier11Path addCurveToPoint:CGPointMake(15.77, 22.44) controlPoint1:CGPointMake(15.69, 22.39) controlPoint2:CGPointMake(15.74, 22.41)];
                [bezier11Path addCurveToPoint:CGPointMake(15.82, 22.56) controlPoint1:CGPointMake(15.8, 22.47) controlPoint2:CGPointMake(15.82, 22.51)];
                [bezier11Path addLineToPoint:CGPointMake(15.82, 23.21)];
                [bezier11Path addCurveToPoint:CGPointMake(16.06, 23.19) controlPoint1:CGPointMake(15.91, 23.2) controlPoint2:CGPointMake(15.99, 23.19)];
                [bezier11Path addCurveToPoint:CGPointMake(16.26, 23.19) controlPoint1:CGPointMake(16.15, 23.19) controlPoint2:CGPointMake(16.21, 23.19)];
                [bezier11Path closePath];
                [bezier11Path moveToPoint:CGPointMake(16.55, 23.81)];
                [bezier11Path addCurveToPoint:CGPointMake(16.54, 23.66) controlPoint1:CGPointMake(16.55, 23.75) controlPoint2:CGPointMake(16.55, 23.7)];
                [bezier11Path addCurveToPoint:CGPointMake(16.48, 23.57) controlPoint1:CGPointMake(16.53, 23.62) controlPoint2:CGPointMake(16.51, 23.59)];
                [bezier11Path addCurveToPoint:CGPointMake(16.37, 23.53) controlPoint1:CGPointMake(16.45, 23.55) controlPoint2:CGPointMake(16.41, 23.53)];
                [bezier11Path addCurveToPoint:CGPointMake(16.19, 23.52) controlPoint1:CGPointMake(16.32, 23.52) controlPoint2:CGPointMake(16.27, 23.52)];
                [bezier11Path addCurveToPoint:CGPointMake(16.05, 23.52) controlPoint1:CGPointMake(16.14, 23.52) controlPoint2:CGPointMake(16.09, 23.52)];
                [bezier11Path addCurveToPoint:CGPointMake(15.96, 23.52) controlPoint1:CGPointMake(16.02, 23.52) controlPoint2:CGPointMake(15.99, 23.52)];
                [bezier11Path addCurveToPoint:CGPointMake(15.89, 23.53) controlPoint1:CGPointMake(15.94, 23.52) controlPoint2:CGPointMake(15.91, 23.52)];
                [bezier11Path addCurveToPoint:CGPointMake(15.83, 23.54) controlPoint1:CGPointMake(15.87, 23.53) controlPoint2:CGPointMake(15.85, 23.54)];
                [bezier11Path addLineToPoint:CGPointMake(15.83, 23.8)];
                [bezier11Path addCurveToPoint:CGPointMake(15.85, 23.94) controlPoint1:CGPointMake(15.83, 23.85) controlPoint2:CGPointMake(15.83, 23.9)];
                [bezier11Path addCurveToPoint:CGPointMake(15.91, 24.04) controlPoint1:CGPointMake(15.86, 23.98) controlPoint2:CGPointMake(15.88, 24.01)];
                [bezier11Path addCurveToPoint:CGPointMake(16.02, 24.1) controlPoint1:CGPointMake(15.93, 24.07) controlPoint2:CGPointMake(15.97, 24.09)];
                [bezier11Path addCurveToPoint:CGPointMake(16.19, 24.12) controlPoint1:CGPointMake(16.07, 24.11) controlPoint2:CGPointMake(16.13, 24.12)];
                [bezier11Path addCurveToPoint:CGPointMake(16.36, 24.11) controlPoint1:CGPointMake(16.25, 24.12) controlPoint2:CGPointMake(16.31, 24.12)];
                [bezier11Path addCurveToPoint:CGPointMake(16.47, 24.07) controlPoint1:CGPointMake(16.4, 24.1) controlPoint2:CGPointMake(16.44, 24.09)];
                [bezier11Path addCurveToPoint:CGPointMake(16.53, 23.98) controlPoint1:CGPointMake(16.5, 24.05) controlPoint2:CGPointMake(16.52, 24.02)];
                [bezier11Path addCurveToPoint:CGPointMake(16.55, 23.81) controlPoint1:CGPointMake(16.55, 23.92) controlPoint2:CGPointMake(16.55, 23.87)];
                [bezier11Path closePath];
                bezier11Path.miterLimit = 4;

                [fillColor setFill];
                [bezier11Path fill];

                //// Bezier 12 Drawing
                UIBezierPath *bezier12Path = [UIBezierPath bezierPath];
                [bezier12Path moveToPoint:CGPointMake(19.04, 23.88)];
                [bezier12Path addLineToPoint:CGPointMake(19.04, 23.88)];
                [bezier12Path addCurveToPoint:CGPointMake(18.99, 24.14) controlPoint1:CGPointMake(19.04, 23.99) controlPoint2:CGPointMake(19.03, 24.07)];
                [bezier12Path addCurveToPoint:CGPointMake(18.83, 24.31) controlPoint1:CGPointMake(18.95, 24.21) controlPoint2:CGPointMake(18.9, 24.27)];
                [bezier12Path addCurveToPoint:CGPointMake(18.59, 24.4) controlPoint1:CGPointMake(18.76, 24.35) controlPoint2:CGPointMake(18.68, 24.38)];
                [bezier12Path addCurveToPoint:CGPointMake(18.28, 24.43) controlPoint1:CGPointMake(18.5, 24.42) controlPoint2:CGPointMake(18.39, 24.43)];
                [bezier12Path addCurveToPoint:CGPointMake(17.97, 24.4) controlPoint1:CGPointMake(18.16, 24.43) controlPoint2:CGPointMake(18.06, 24.42)];
                [bezier12Path addCurveToPoint:CGPointMake(17.74, 24.31) controlPoint1:CGPointMake(17.88, 24.38) controlPoint2:CGPointMake(17.8, 24.35)];
                [bezier12Path addCurveToPoint:CGPointMake(17.59, 24.14) controlPoint1:CGPointMake(17.68, 24.27) controlPoint2:CGPointMake(17.62, 24.21)];
                [bezier12Path addCurveToPoint:CGPointMake(17.54, 23.9) controlPoint1:CGPointMake(17.55, 24.07) controlPoint2:CGPointMake(17.54, 23.99)];
                [bezier12Path addLineToPoint:CGPointMake(17.54, 22.93)];
                [bezier12Path addCurveToPoint:CGPointMake(17.74, 22.54) controlPoint1:CGPointMake(17.54, 22.76) controlPoint2:CGPointMake(17.61, 22.63)];
                [bezier12Path addCurveToPoint:CGPointMake(18.3, 22.41) controlPoint1:CGPointMake(17.87, 22.46) controlPoint2:CGPointMake(18.06, 22.41)];
                [bezier12Path addCurveToPoint:CGPointMake(18.61, 22.44) controlPoint1:CGPointMake(18.41, 22.41) controlPoint2:CGPointMake(18.52, 22.42)];
                [bezier12Path addCurveToPoint:CGPointMake(18.85, 22.54) controlPoint1:CGPointMake(18.7, 22.46) controlPoint2:CGPointMake(18.78, 22.5)];
                [bezier12Path addCurveToPoint:CGPointMake(19, 22.71) controlPoint1:CGPointMake(18.91, 22.58) controlPoint2:CGPointMake(18.96, 22.64)];
                [bezier12Path addCurveToPoint:CGPointMake(19.05, 22.94) controlPoint1:CGPointMake(19.03, 22.78) controlPoint2:CGPointMake(19.05, 22.85)];
                [bezier12Path addLineToPoint:CGPointMake(19.05, 23.88)];
                [bezier12Path addLineToPoint:CGPointMake(19.04, 23.88)];
                [bezier12Path closePath];
                [bezier12Path moveToPoint:CGPointMake(18.65, 22.95)];
                [bezier12Path addCurveToPoint:CGPointMake(18.56, 22.78) controlPoint1:CGPointMake(18.65, 22.88) controlPoint2:CGPointMake(18.62, 22.82)];
                [bezier12Path addCurveToPoint:CGPointMake(18.28, 22.72) controlPoint1:CGPointMake(18.5, 22.74) controlPoint2:CGPointMake(18.41, 22.72)];
                [bezier12Path addCurveToPoint:CGPointMake(18.01, 22.78) controlPoint1:CGPointMake(18.16, 22.72) controlPoint2:CGPointMake(18.07, 22.74)];
                [bezier12Path addCurveToPoint:CGPointMake(17.92, 22.94) controlPoint1:CGPointMake(17.95, 22.82) controlPoint2:CGPointMake(17.92, 22.87)];
                [bezier12Path addLineToPoint:CGPointMake(17.92, 23.89)];
                [bezier12Path addCurveToPoint:CGPointMake(18.01, 24.06) controlPoint1:CGPointMake(17.92, 23.97) controlPoint2:CGPointMake(17.95, 24.02)];
                [bezier12Path addCurveToPoint:CGPointMake(18.27, 24.11) controlPoint1:CGPointMake(18.07, 24.09) controlPoint2:CGPointMake(18.16, 24.11)];
                [bezier12Path addCurveToPoint:CGPointMake(18.54, 24.06) controlPoint1:CGPointMake(18.38, 24.11) controlPoint2:CGPointMake(18.47, 24.09)];
                [bezier12Path addCurveToPoint:CGPointMake(18.64, 23.89) controlPoint1:CGPointMake(18.6, 24.03) controlPoint2:CGPointMake(18.64, 23.97)];
                [bezier12Path addLineToPoint:CGPointMake(18.64, 22.95)];
                [bezier12Path addLineToPoint:CGPointMake(18.65, 22.95)];
                [bezier12Path closePath];
                bezier12Path.miterLimit = 4;

                [fillColor setFill];
                [bezier12Path fill];

                //// Bezier 13 Drawing
                UIBezierPath *bezier13Path = [UIBezierPath bezierPath];
                [bezier13Path moveToPoint:CGPointMake(20.91, 23.28)];
                [bezier13Path addCurveToPoint:CGPointMake(21.09, 23.37) controlPoint1:CGPointMake(20.98, 23.3) controlPoint2:CGPointMake(21.04, 23.33)];
                [bezier13Path addCurveToPoint:CGPointMake(21.18, 23.55) controlPoint1:CGPointMake(21.13, 23.41) controlPoint2:CGPointMake(21.17, 23.47)];
                [bezier13Path addCurveToPoint:CGPointMake(21.21, 23.83) controlPoint1:CGPointMake(21.2, 23.62) controlPoint2:CGPointMake(21.21, 23.72)];
                [bezier13Path addCurveToPoint:CGPointMake(21.17, 24.12) controlPoint1:CGPointMake(21.21, 23.95) controlPoint2:CGPointMake(21.19, 24.04)];
                [bezier13Path addCurveToPoint:CGPointMake(21.04, 24.31) controlPoint1:CGPointMake(21.15, 24.2) controlPoint2:CGPointMake(21.1, 24.26)];
                [bezier13Path addCurveToPoint:CGPointMake(20.79, 24.41) controlPoint1:CGPointMake(20.98, 24.35) controlPoint2:CGPointMake(20.9, 24.39)];
                [bezier13Path addCurveToPoint:CGPointMake(20.39, 24.44) controlPoint1:CGPointMake(20.68, 24.43) controlPoint2:CGPointMake(20.55, 24.44)];
                [bezier13Path addLineToPoint:CGPointMake(20.31, 24.44)];
                [bezier13Path addCurveToPoint:CGPointMake(20.11, 24.43) controlPoint1:CGPointMake(20.25, 24.44) controlPoint2:CGPointMake(20.18, 24.44)];
                [bezier13Path addCurveToPoint:CGPointMake(19.91, 24.4) controlPoint1:CGPointMake(20.04, 24.43) controlPoint2:CGPointMake(19.97, 24.41)];
                [bezier13Path addCurveToPoint:CGPointMake(19.75, 24.32) controlPoint1:CGPointMake(19.85, 24.38) controlPoint2:CGPointMake(19.8, 24.35)];
                [bezier13Path addCurveToPoint:CGPointMake(19.68, 24.17) controlPoint1:CGPointMake(19.71, 24.28) controlPoint2:CGPointMake(19.68, 24.23)];
                [bezier13Path addLineToPoint:CGPointMake(19.68, 24.16)];
                [bezier13Path addCurveToPoint:CGPointMake(19.73, 24.05) controlPoint1:CGPointMake(19.68, 24.11) controlPoint2:CGPointMake(19.7, 24.08)];
                [bezier13Path addCurveToPoint:CGPointMake(19.85, 24) controlPoint1:CGPointMake(19.76, 24.02) controlPoint2:CGPointMake(19.8, 24)];
                [bezier13Path addLineToPoint:CGPointMake(19.85, 24)];
                [bezier13Path addCurveToPoint:CGPointMake(19.94, 24.01) controlPoint1:CGPointMake(19.89, 24) controlPoint2:CGPointMake(19.92, 24.01)];
                [bezier13Path addCurveToPoint:CGPointMake(19.99, 24.03) controlPoint1:CGPointMake(19.96, 24.02) controlPoint2:CGPointMake(19.98, 24.03)];
                [bezier13Path addCurveToPoint:CGPointMake(20.04, 24.06) controlPoint1:CGPointMake(20.01, 24.04) controlPoint2:CGPointMake(20.02, 24.05)];
                [bezier13Path addCurveToPoint:CGPointMake(20.11, 24.09) controlPoint1:CGPointMake(20.05, 24.07) controlPoint2:CGPointMake(20.08, 24.08)];
                [bezier13Path addCurveToPoint:CGPointMake(20.22, 24.11) controlPoint1:CGPointMake(20.14, 24.1) controlPoint2:CGPointMake(20.18, 24.1)];
                [bezier13Path addCurveToPoint:CGPointMake(20.41, 24.12) controlPoint1:CGPointMake(20.27, 24.12) controlPoint2:CGPointMake(20.33, 24.12)];
                [bezier13Path addCurveToPoint:CGPointMake(20.6, 24.1) controlPoint1:CGPointMake(20.49, 24.12) controlPoint2:CGPointMake(20.55, 24.12)];
                [bezier13Path addCurveToPoint:CGPointMake(20.72, 24.05) controlPoint1:CGPointMake(20.65, 24.09) controlPoint2:CGPointMake(20.69, 24.07)];
                [bezier13Path addCurveToPoint:CGPointMake(20.78, 23.96) controlPoint1:CGPointMake(20.75, 24.03) controlPoint2:CGPointMake(20.77, 23.99)];
                [bezier13Path addCurveToPoint:CGPointMake(20.79, 23.83) controlPoint1:CGPointMake(20.79, 23.92) controlPoint2:CGPointMake(20.79, 23.88)];
                [bezier13Path addCurveToPoint:CGPointMake(20.76, 23.64) controlPoint1:CGPointMake(20.79, 23.74) controlPoint2:CGPointMake(20.78, 23.68)];
                [bezier13Path addCurveToPoint:CGPointMake(20.63, 23.58) controlPoint1:CGPointMake(20.74, 23.6) controlPoint2:CGPointMake(20.69, 23.58)];
                [bezier13Path addLineToPoint:CGPointMake(20, 23.58)];
                [bezier13Path addCurveToPoint:CGPointMake(19.86, 23.57) controlPoint1:CGPointMake(19.94, 23.58) controlPoint2:CGPointMake(19.89, 23.58)];
                [bezier13Path addCurveToPoint:CGPointMake(19.78, 23.54) controlPoint1:CGPointMake(19.83, 23.57) controlPoint2:CGPointMake(19.8, 23.55)];
                [bezier13Path addCurveToPoint:CGPointMake(19.74, 23.47) controlPoint1:CGPointMake(19.76, 23.52) controlPoint2:CGPointMake(19.75, 23.5)];
                [bezier13Path addCurveToPoint:CGPointMake(19.73, 23.35) controlPoint1:CGPointMake(19.73, 23.44) controlPoint2:CGPointMake(19.73, 23.4)];
                [bezier13Path addLineToPoint:CGPointMake(19.73, 22.61)];
                [bezier13Path addCurveToPoint:CGPointMake(19.78, 22.48) controlPoint1:CGPointMake(19.73, 22.55) controlPoint2:CGPointMake(19.75, 22.51)];
                [bezier13Path addCurveToPoint:CGPointMake(19.95, 22.44) controlPoint1:CGPointMake(19.81, 22.45) controlPoint2:CGPointMake(19.87, 22.44)];
                [bezier13Path addCurveToPoint:CGPointMake(20.07, 22.44) controlPoint1:CGPointMake(19.97, 22.44) controlPoint2:CGPointMake(20.01, 22.44)];
                [bezier13Path addCurveToPoint:CGPointMake(20.25, 22.44) controlPoint1:CGPointMake(20.12, 22.44) controlPoint2:CGPointMake(20.19, 22.44)];
                [bezier13Path addCurveToPoint:CGPointMake(20.46, 22.44) controlPoint1:CGPointMake(20.32, 22.44) controlPoint2:CGPointMake(20.39, 22.44)];
                [bezier13Path addCurveToPoint:CGPointMake(20.66, 22.44) controlPoint1:CGPointMake(20.53, 22.44) controlPoint2:CGPointMake(20.6, 22.44)];
                [bezier13Path addCurveToPoint:CGPointMake(20.82, 22.44) controlPoint1:CGPointMake(20.72, 22.44) controlPoint2:CGPointMake(20.78, 22.44)];
                [bezier13Path addCurveToPoint:CGPointMake(20.9, 22.44) controlPoint1:CGPointMake(20.86, 22.44) controlPoint2:CGPointMake(20.89, 22.44)];
                [bezier13Path addCurveToPoint:CGPointMake(20.97, 22.45) controlPoint1:CGPointMake(20.92, 22.44) controlPoint2:CGPointMake(20.94, 22.44)];
                [bezier13Path addCurveToPoint:CGPointMake(21.04, 22.47) controlPoint1:CGPointMake(21, 22.45) controlPoint2:CGPointMake(21.02, 22.46)];
                [bezier13Path addCurveToPoint:CGPointMake(21.1, 22.52) controlPoint1:CGPointMake(21.06, 22.48) controlPoint2:CGPointMake(21.08, 22.5)];
                [bezier13Path addCurveToPoint:CGPointMake(21.12, 22.6) controlPoint1:CGPointMake(21.11, 22.54) controlPoint2:CGPointMake(21.12, 22.57)];
                [bezier13Path addLineToPoint:CGPointMake(21.12, 22.61)];
                [bezier13Path addCurveToPoint:CGPointMake(21.1, 22.7) controlPoint1:CGPointMake(21.12, 22.65) controlPoint2:CGPointMake(21.11, 22.68)];
                [bezier13Path addCurveToPoint:CGPointMake(21.05, 22.75) controlPoint1:CGPointMake(21.09, 22.72) controlPoint2:CGPointMake(21.07, 22.74)];
                [bezier13Path addCurveToPoint:CGPointMake(20.98, 22.77) controlPoint1:CGPointMake(21.03, 22.76) controlPoint2:CGPointMake(21.01, 22.77)];
                [bezier13Path addCurveToPoint:CGPointMake(20.9, 22.77) controlPoint1:CGPointMake(20.95, 22.77) controlPoint2:CGPointMake(20.93, 22.77)];
                [bezier13Path addLineToPoint:CGPointMake(20.12, 22.77)];
                [bezier13Path addLineToPoint:CGPointMake(20.12, 23.28)];
                [bezier13Path addLineToPoint:CGPointMake(20.64, 23.28)];
                [bezier13Path addCurveToPoint:CGPointMake(20.91, 23.28) controlPoint1:CGPointMake(20.75, 23.25) controlPoint2:CGPointMake(20.84, 23.25)];
                [bezier13Path closePath];
                bezier13Path.miterLimit = 4;

                [fillColor setFill];
                [bezier13Path fill];

                //// Bezier 14 Drawing
                UIBezierPath *bezier14Path = [UIBezierPath bezierPath];
                [bezier14Path moveToPoint:CGPointMake(22.64, 22.4)];
                [bezier14Path addCurveToPoint:CGPointMake(23.01, 22.43) controlPoint1:CGPointMake(22.79, 22.4) controlPoint2:CGPointMake(22.91, 22.41)];
                [bezier14Path addCurveToPoint:CGPointMake(23.26, 22.53) controlPoint1:CGPointMake(23.11, 22.45) controlPoint2:CGPointMake(23.19, 22.48)];
                [bezier14Path addCurveToPoint:CGPointMake(23.4, 22.71) controlPoint1:CGPointMake(23.32, 22.58) controlPoint2:CGPointMake(23.37, 22.63)];
                [bezier14Path addCurveToPoint:CGPointMake(23.44, 22.98) controlPoint1:CGPointMake(23.43, 22.78) controlPoint2:CGPointMake(23.44, 22.87)];
                [bezier14Path addLineToPoint:CGPointMake(23.44, 22.99)];
                [bezier14Path addCurveToPoint:CGPointMake(23.4, 23.27) controlPoint1:CGPointMake(23.44, 23.1) controlPoint2:CGPointMake(23.43, 23.2)];
                [bezier14Path addCurveToPoint:CGPointMake(23.29, 23.46) controlPoint1:CGPointMake(23.38, 23.35) controlPoint2:CGPointMake(23.34, 23.41)];
                [bezier14Path addCurveToPoint:CGPointMake(23.09, 23.56) controlPoint1:CGPointMake(23.24, 23.51) controlPoint2:CGPointMake(23.17, 23.54)];
                [bezier14Path addCurveToPoint:CGPointMake(22.79, 23.59) controlPoint1:CGPointMake(23.01, 23.58) controlPoint2:CGPointMake(22.91, 23.59)];
                [bezier14Path addCurveToPoint:CGPointMake(22.53, 23.59) controlPoint1:CGPointMake(22.68, 23.59) controlPoint2:CGPointMake(22.6, 23.59)];
                [bezier14Path addCurveToPoint:CGPointMake(22.37, 23.62) controlPoint1:CGPointMake(22.46, 23.59) controlPoint2:CGPointMake(22.4, 23.61)];
                [bezier14Path addCurveToPoint:CGPointMake(22.28, 23.71) controlPoint1:CGPointMake(22.33, 23.64) controlPoint2:CGPointMake(22.3, 23.67)];
                [bezier14Path addCurveToPoint:CGPointMake(22.26, 23.9) controlPoint1:CGPointMake(22.26, 23.75) controlPoint2:CGPointMake(22.26, 23.82)];
                [bezier14Path addLineToPoint:CGPointMake(22.26, 24.08)];
                [bezier14Path addLineToPoint:CGPointMake(23.23, 24.08)];
                [bezier14Path addCurveToPoint:CGPointMake(23.3, 24.09) controlPoint1:CGPointMake(23.25, 24.08) controlPoint2:CGPointMake(23.28, 24.08)];
                [bezier14Path addCurveToPoint:CGPointMake(23.37, 24.12) controlPoint1:CGPointMake(23.32, 24.1) controlPoint2:CGPointMake(23.34, 24.11)];
                [bezier14Path addCurveToPoint:CGPointMake(23.42, 24.17) controlPoint1:CGPointMake(23.39, 24.13) controlPoint2:CGPointMake(23.41, 24.15)];
                [bezier14Path addCurveToPoint:CGPointMake(23.44, 24.24) controlPoint1:CGPointMake(23.43, 24.19) controlPoint2:CGPointMake(23.44, 24.21)];
                [bezier14Path addCurveToPoint:CGPointMake(23.42, 24.32) controlPoint1:CGPointMake(23.44, 24.27) controlPoint2:CGPointMake(23.43, 24.3)];
                [bezier14Path addCurveToPoint:CGPointMake(23.37, 24.37) controlPoint1:CGPointMake(23.41, 24.34) controlPoint2:CGPointMake(23.39, 24.36)];
                [bezier14Path addCurveToPoint:CGPointMake(23.3, 24.4) controlPoint1:CGPointMake(23.35, 24.38) controlPoint2:CGPointMake(23.33, 24.39)];
                [bezier14Path addCurveToPoint:CGPointMake(23.22, 24.41) controlPoint1:CGPointMake(23.28, 24.41) controlPoint2:CGPointMake(23.25, 24.41)];
                [bezier14Path addLineToPoint:CGPointMake(22.08, 24.41)];
                [bezier14Path addCurveToPoint:CGPointMake(21.91, 24.37) controlPoint1:CGPointMake(22, 24.41) controlPoint2:CGPointMake(21.94, 24.4)];
                [bezier14Path addCurveToPoint:CGPointMake(21.86, 24.24) controlPoint1:CGPointMake(21.88, 24.34) controlPoint2:CGPointMake(21.86, 24.3)];
                [bezier14Path addLineToPoint:CGPointMake(21.86, 23.84)];
                [bezier14Path addCurveToPoint:CGPointMake(21.9, 23.57) controlPoint1:CGPointMake(21.86, 23.73) controlPoint2:CGPointMake(21.87, 23.64)];
                [bezier14Path addCurveToPoint:CGPointMake(22.02, 23.39) controlPoint1:CGPointMake(21.93, 23.5) controlPoint2:CGPointMake(21.97, 23.44)];
                [bezier14Path addCurveToPoint:CGPointMake(22.22, 23.3) controlPoint1:CGPointMake(22.08, 23.34) controlPoint2:CGPointMake(22.14, 23.31)];
                [bezier14Path addCurveToPoint:CGPointMake(22.48, 23.27) controlPoint1:CGPointMake(22.3, 23.28) controlPoint2:CGPointMake(22.38, 23.27)];
                [bezier14Path addLineToPoint:CGPointMake(22.76, 23.26)];
                [bezier14Path addCurveToPoint:CGPointMake(22.89, 23.25) controlPoint1:CGPointMake(22.81, 23.26) controlPoint2:CGPointMake(22.86, 23.26)];
                [bezier14Path addCurveToPoint:CGPointMake(22.97, 23.21) controlPoint1:CGPointMake(22.92, 23.24) controlPoint2:CGPointMake(22.95, 23.23)];
                [bezier14Path addCurveToPoint:CGPointMake(23.02, 23.13) controlPoint1:CGPointMake(22.99, 23.19) controlPoint2:CGPointMake(23, 23.17)];
                [bezier14Path addCurveToPoint:CGPointMake(23.03, 23.01) controlPoint1:CGPointMake(23.03, 23.1) controlPoint2:CGPointMake(23.03, 23.06)];
                [bezier14Path addLineToPoint:CGPointMake(23.03, 23)];
                [bezier14Path addCurveToPoint:CGPointMake(23.01, 22.87) controlPoint1:CGPointMake(23.03, 22.95) controlPoint2:CGPointMake(23.02, 22.91)];
                [bezier14Path addCurveToPoint:CGPointMake(22.94, 22.79) controlPoint1:CGPointMake(23, 22.83) controlPoint2:CGPointMake(22.97, 22.81)];
                [bezier14Path addCurveToPoint:CGPointMake(22.81, 22.74) controlPoint1:CGPointMake(22.91, 22.77) controlPoint2:CGPointMake(22.87, 22.75)];
                [bezier14Path addCurveToPoint:CGPointMake(22.6, 22.73) controlPoint1:CGPointMake(22.75, 22.73) controlPoint2:CGPointMake(22.68, 22.73)];
                [bezier14Path addCurveToPoint:CGPointMake(22.41, 22.74) controlPoint1:CGPointMake(22.53, 22.73) controlPoint2:CGPointMake(22.47, 22.73)];
                [bezier14Path addCurveToPoint:CGPointMake(22.27, 22.77) controlPoint1:CGPointMake(22.35, 22.75) controlPoint2:CGPointMake(22.31, 22.76)];
                [bezier14Path addCurveToPoint:CGPointMake(22.17, 22.81) controlPoint1:CGPointMake(22.23, 22.78) controlPoint2:CGPointMake(22.2, 22.79)];
                [bezier14Path addCurveToPoint:CGPointMake(22.07, 22.83) controlPoint1:CGPointMake(22.14, 22.82) controlPoint2:CGPointMake(22.11, 22.83)];
                [bezier14Path addLineToPoint:CGPointMake(22.06, 22.83)];
                [bezier14Path addCurveToPoint:CGPointMake(21.94, 22.78) controlPoint1:CGPointMake(22.01, 22.83) controlPoint2:CGPointMake(21.97, 22.81)];
                [bezier14Path addCurveToPoint:CGPointMake(21.9, 22.66) controlPoint1:CGPointMake(21.91, 22.75) controlPoint2:CGPointMake(21.9, 22.71)];
                [bezier14Path addLineToPoint:CGPointMake(21.9, 22.65)];
                [bezier14Path addCurveToPoint:CGPointMake(21.96, 22.54) controlPoint1:CGPointMake(21.9, 22.61) controlPoint2:CGPointMake(21.92, 22.57)];
                [bezier14Path addCurveToPoint:CGPointMake(22.12, 22.47) controlPoint1:CGPointMake(22, 22.51) controlPoint2:CGPointMake(22.05, 22.48)];
                [bezier14Path addCurveToPoint:CGPointMake(22.35, 22.43) controlPoint1:CGPointMake(22.19, 22.45) controlPoint2:CGPointMake(22.26, 22.44)];
                [bezier14Path addCurveToPoint:CGPointMake(22.64, 22.4) controlPoint1:CGPointMake(22.46, 22.4) controlPoint2:CGPointMake(22.55, 22.4)];
                [bezier14Path closePath];
                bezier14Path.miterLimit = 4;

                [fillColor setFill];
                [bezier14Path fill];

                //// Bezier 15 Drawing
                UIBezierPath *bezier15Path = [UIBezierPath bezierPath];
                [bezier15Path moveToPoint:CGPointMake(25.52, 23.88)];
                [bezier15Path addCurveToPoint:CGPointMake(25.5, 24.11) controlPoint1:CGPointMake(25.52, 23.97) controlPoint2:CGPointMake(25.51, 24.04)];
                [bezier15Path addCurveToPoint:CGPointMake(25.39, 24.28) controlPoint1:CGPointMake(25.48, 24.18) controlPoint2:CGPointMake(25.44, 24.24)];
                [bezier15Path addCurveToPoint:CGPointMake(25.15, 24.39) controlPoint1:CGPointMake(25.34, 24.33) controlPoint2:CGPointMake(25.26, 24.36)];
                [bezier15Path addCurveToPoint:CGPointMake(24.74, 24.43) controlPoint1:CGPointMake(25.05, 24.41) controlPoint2:CGPointMake(24.91, 24.43)];
                [bezier15Path addCurveToPoint:CGPointMake(24.35, 24.39) controlPoint1:CGPointMake(24.58, 24.43) controlPoint2:CGPointMake(24.45, 24.42)];
                [bezier15Path addCurveToPoint:CGPointMake(24.13, 24.28) controlPoint1:CGPointMake(24.25, 24.36) controlPoint2:CGPointMake(24.18, 24.33)];
                [bezier15Path addCurveToPoint:CGPointMake(24.02, 24.11) controlPoint1:CGPointMake(24.08, 24.23) controlPoint2:CGPointMake(24.04, 24.17)];
                [bezier15Path addCurveToPoint:CGPointMake(23.99, 23.89) controlPoint1:CGPointMake(24, 24.04) controlPoint2:CGPointMake(23.99, 23.97)];
                [bezier15Path addCurveToPoint:CGPointMake(23.99, 23.73) controlPoint1:CGPointMake(23.99, 23.82) controlPoint2:CGPointMake(23.99, 23.77)];
                [bezier15Path addCurveToPoint:CGPointMake(24.02, 23.62) controlPoint1:CGPointMake(23.99, 23.69) controlPoint2:CGPointMake(24, 23.65)];
                [bezier15Path addCurveToPoint:CGPointMake(24.11, 23.54) controlPoint1:CGPointMake(24.04, 23.59) controlPoint2:CGPointMake(24.07, 23.56)];
                [bezier15Path addCurveToPoint:CGPointMake(24.28, 23.45) controlPoint1:CGPointMake(24.15, 23.51) controlPoint2:CGPointMake(24.21, 23.48)];
                [bezier15Path addCurveToPoint:CGPointMake(24.11, 23.38) controlPoint1:CGPointMake(24.21, 23.42) controlPoint2:CGPointMake(24.15, 23.4)];
                [bezier15Path addCurveToPoint:CGPointMake(24.03, 23.3) controlPoint1:CGPointMake(24.07, 23.36) controlPoint2:CGPointMake(24.04, 23.33)];
                [bezier15Path addCurveToPoint:CGPointMake(24, 23.16) controlPoint1:CGPointMake(24.01, 23.24) controlPoint2:CGPointMake(24, 23.2)];
                [bezier15Path addCurveToPoint:CGPointMake(23.99, 22.96) controlPoint1:CGPointMake(24, 23.11) controlPoint2:CGPointMake(23.99, 23.04)];
                [bezier15Path addCurveToPoint:CGPointMake(24.03, 22.69) controlPoint1:CGPointMake(23.99, 22.85) controlPoint2:CGPointMake(24, 22.76)];
                [bezier15Path addCurveToPoint:CGPointMake(24.16, 22.52) controlPoint1:CGPointMake(24.06, 22.62) controlPoint2:CGPointMake(24.1, 22.56)];
                [bezier15Path addCurveToPoint:CGPointMake(24.39, 22.43) controlPoint1:CGPointMake(24.22, 22.48) controlPoint2:CGPointMake(24.3, 22.45)];
                [bezier15Path addCurveToPoint:CGPointMake(24.74, 22.4) controlPoint1:CGPointMake(24.48, 22.41) controlPoint2:CGPointMake(24.6, 22.4)];
                [bezier15Path addCurveToPoint:CGPointMake(25.1, 22.43) controlPoint1:CGPointMake(24.88, 22.4) controlPoint2:CGPointMake(25, 22.41)];
                [bezier15Path addCurveToPoint:CGPointMake(25.34, 22.52) controlPoint1:CGPointMake(25.2, 22.45) controlPoint2:CGPointMake(25.28, 22.48)];
                [bezier15Path addCurveToPoint:CGPointMake(25.47, 22.69) controlPoint1:CGPointMake(25.4, 22.57) controlPoint2:CGPointMake(25.44, 22.62)];
                [bezier15Path addCurveToPoint:CGPointMake(25.51, 22.95) controlPoint1:CGPointMake(25.5, 22.76) controlPoint2:CGPointMake(25.51, 22.85)];
                [bezier15Path addCurveToPoint:CGPointMake(25.5, 23.15) controlPoint1:CGPointMake(25.51, 23.03) controlPoint2:CGPointMake(25.51, 23.1)];
                [bezier15Path addCurveToPoint:CGPointMake(25.47, 23.27) controlPoint1:CGPointMake(25.5, 23.2) controlPoint2:CGPointMake(25.49, 23.24)];
                [bezier15Path addCurveToPoint:CGPointMake(25.38, 23.35) controlPoint1:CGPointMake(25.45, 23.3) controlPoint2:CGPointMake(25.42, 23.33)];
                [bezier15Path addCurveToPoint:CGPointMake(25.22, 23.42) controlPoint1:CGPointMake(25.35, 23.37) controlPoint2:CGPointMake(25.29, 23.39)];
                [bezier15Path addCurveToPoint:CGPointMake(25.38, 23.5) controlPoint1:CGPointMake(25.29, 23.45) controlPoint2:CGPointMake(25.34, 23.48)];
                [bezier15Path addCurveToPoint:CGPointMake(25.46, 23.58) controlPoint1:CGPointMake(25.42, 23.52) controlPoint2:CGPointMake(25.44, 23.55)];
                [bezier15Path addCurveToPoint:CGPointMake(25.49, 23.69) controlPoint1:CGPointMake(25.48, 23.61) controlPoint2:CGPointMake(25.49, 23.65)];
                [bezier15Path addCurveToPoint:CGPointMake(25.52, 23.88) controlPoint1:CGPointMake(25.52, 23.74) controlPoint2:CGPointMake(25.52, 23.8)];
                [bezier15Path closePath];
                [bezier15Path moveToPoint:CGPointMake(25.13, 23.84)];
                [bezier15Path addCurveToPoint:CGPointMake(25.12, 23.81) controlPoint1:CGPointMake(25.13, 23.84) controlPoint2:CGPointMake(25.12, 23.83)];
                [bezier15Path addCurveToPoint:CGPointMake(25.07, 23.74) controlPoint1:CGPointMake(25.11, 23.79) controlPoint2:CGPointMake(25.09, 23.77)];
                [bezier15Path addCurveToPoint:CGPointMake(24.96, 23.65) controlPoint1:CGPointMake(25.05, 23.71) controlPoint2:CGPointMake(25.01, 23.68)];
                [bezier15Path addCurveToPoint:CGPointMake(24.76, 23.56) controlPoint1:CGPointMake(24.91, 23.62) controlPoint2:CGPointMake(24.84, 23.59)];
                [bezier15Path addCurveToPoint:CGPointMake(24.55, 23.66) controlPoint1:CGPointMake(24.67, 23.59) controlPoint2:CGPointMake(24.6, 23.63)];
                [bezier15Path addCurveToPoint:CGPointMake(24.44, 23.76) controlPoint1:CGPointMake(24.5, 23.69) controlPoint2:CGPointMake(24.47, 23.72)];
                [bezier15Path addCurveToPoint:CGPointMake(24.4, 23.84) controlPoint1:CGPointMake(24.42, 23.79) controlPoint2:CGPointMake(24.4, 23.82)];
                [bezier15Path addCurveToPoint:CGPointMake(24.39, 23.88) controlPoint1:CGPointMake(24.39, 23.86) controlPoint2:CGPointMake(24.39, 23.88)];
                [bezier15Path addLineToPoint:CGPointMake(24.39, 23.89)];
                [bezier15Path addCurveToPoint:CGPointMake(24.41, 23.99) controlPoint1:CGPointMake(24.39, 23.93) controlPoint2:CGPointMake(24.4, 23.97)];
                [bezier15Path addCurveToPoint:CGPointMake(24.47, 24.06) controlPoint1:CGPointMake(24.42, 24.02) controlPoint2:CGPointMake(24.44, 24.04)];
                [bezier15Path addCurveToPoint:CGPointMake(24.59, 24.1) controlPoint1:CGPointMake(24.5, 24.08) controlPoint2:CGPointMake(24.54, 24.09)];
                [bezier15Path addCurveToPoint:CGPointMake(24.78, 24.11) controlPoint1:CGPointMake(24.64, 24.11) controlPoint2:CGPointMake(24.7, 24.11)];
                [bezier15Path addCurveToPoint:CGPointMake(24.95, 24.1) controlPoint1:CGPointMake(24.85, 24.11) controlPoint2:CGPointMake(24.9, 24.11)];
                [bezier15Path addCurveToPoint:CGPointMake(25.06, 24.06) controlPoint1:CGPointMake(25, 24.09) controlPoint2:CGPointMake(25.03, 24.08)];
                [bezier15Path addCurveToPoint:CGPointMake(25.12, 23.99) controlPoint1:CGPointMake(25.08, 24.04) controlPoint2:CGPointMake(25.11, 24.02)];
                [bezier15Path addCurveToPoint:CGPointMake(25.14, 23.89) controlPoint1:CGPointMake(25.13, 23.96) controlPoint2:CGPointMake(25.14, 23.93)];
                [bezier15Path addLineToPoint:CGPointMake(25.14, 23.84)];
                [bezier15Path addLineToPoint:CGPointMake(25.13, 23.84)];
                [bezier15Path closePath];
                [bezier15Path moveToPoint:CGPointMake(24.76, 23.26)];
                [bezier15Path addCurveToPoint:CGPointMake(24.97, 23.21) controlPoint1:CGPointMake(24.85, 23.24) controlPoint2:CGPointMake(24.92, 23.22)];
                [bezier15Path addCurveToPoint:CGPointMake(25.08, 23.16) controlPoint1:CGPointMake(25.02, 23.19) controlPoint2:CGPointMake(25.05, 23.17)];
                [bezier15Path addCurveToPoint:CGPointMake(25.12, 23.07) controlPoint1:CGPointMake(25.1, 23.14) controlPoint2:CGPointMake(25.11, 23.11)];
                [bezier15Path addCurveToPoint:CGPointMake(25.13, 22.92) controlPoint1:CGPointMake(25.12, 23.04) controlPoint2:CGPointMake(25.13, 22.99)];
                [bezier15Path addCurveToPoint:CGPointMake(25.1, 22.81) controlPoint1:CGPointMake(25.13, 22.88) controlPoint2:CGPointMake(25.12, 22.84)];
                [bezier15Path addCurveToPoint:CGPointMake(25.03, 22.75) controlPoint1:CGPointMake(25.08, 22.79) controlPoint2:CGPointMake(25.06, 22.76)];
                [bezier15Path addCurveToPoint:CGPointMake(24.91, 22.73) controlPoint1:CGPointMake(25, 22.74) controlPoint2:CGPointMake(24.96, 22.73)];
                [bezier15Path addCurveToPoint:CGPointMake(24.76, 22.73) controlPoint1:CGPointMake(24.86, 22.73) controlPoint2:CGPointMake(24.81, 22.73)];
                [bezier15Path addCurveToPoint:CGPointMake(24.59, 22.74) controlPoint1:CGPointMake(24.69, 22.73) controlPoint2:CGPointMake(24.64, 22.73)];
                [bezier15Path addCurveToPoint:CGPointMake(24.48, 22.77) controlPoint1:CGPointMake(24.55, 22.74) controlPoint2:CGPointMake(24.51, 22.75)];
                [bezier15Path addCurveToPoint:CGPointMake(24.41, 22.84) controlPoint1:CGPointMake(24.45, 22.79) controlPoint2:CGPointMake(24.43, 22.81)];
                [bezier15Path addCurveToPoint:CGPointMake(24.39, 22.97) controlPoint1:CGPointMake(24.4, 22.87) controlPoint2:CGPointMake(24.39, 22.91)];
                [bezier15Path addCurveToPoint:CGPointMake(24.4, 23.09) controlPoint1:CGPointMake(24.39, 23.02) controlPoint2:CGPointMake(24.39, 23.06)];
                [bezier15Path addCurveToPoint:CGPointMake(24.44, 23.16) controlPoint1:CGPointMake(24.4, 23.12) controlPoint2:CGPointMake(24.42, 23.14)];
                [bezier15Path addCurveToPoint:CGPointMake(24.55, 23.21) controlPoint1:CGPointMake(24.46, 23.18) controlPoint2:CGPointMake(24.5, 23.19)];
                [bezier15Path addCurveToPoint:CGPointMake(24.76, 23.26) controlPoint1:CGPointMake(24.6, 23.22) controlPoint2:CGPointMake(24.67, 23.24)];
                [bezier15Path closePath];
                bezier15Path.miterLimit = 4;

                [fillColor setFill];
                [bezier15Path fill];

                //// Bezier 16 Drawing
                UIBezierPath *bezier16Path = [UIBezierPath bezierPath];
                [bezier16Path moveToPoint:CGPointMake(27.71, 23.88)];
                [bezier16Path addLineToPoint:CGPointMake(27.71, 23.88)];
                [bezier16Path addCurveToPoint:CGPointMake(27.66, 24.14) controlPoint1:CGPointMake(27.71, 23.99) controlPoint2:CGPointMake(27.69, 24.07)];
                [bezier16Path addCurveToPoint:CGPointMake(27.5, 24.31) controlPoint1:CGPointMake(27.62, 24.21) controlPoint2:CGPointMake(27.57, 24.27)];
                [bezier16Path addCurveToPoint:CGPointMake(27.26, 24.4) controlPoint1:CGPointMake(27.43, 24.35) controlPoint2:CGPointMake(27.35, 24.38)];
                [bezier16Path addCurveToPoint:CGPointMake(26.95, 24.43) controlPoint1:CGPointMake(27.17, 24.42) controlPoint2:CGPointMake(27.06, 24.43)];
                [bezier16Path addCurveToPoint:CGPointMake(26.64, 24.4) controlPoint1:CGPointMake(26.83, 24.43) controlPoint2:CGPointMake(26.73, 24.42)];
                [bezier16Path addCurveToPoint:CGPointMake(26.41, 24.31) controlPoint1:CGPointMake(26.55, 24.38) controlPoint2:CGPointMake(26.47, 24.35)];
                [bezier16Path addCurveToPoint:CGPointMake(26.26, 24.14) controlPoint1:CGPointMake(26.34, 24.27) controlPoint2:CGPointMake(26.3, 24.21)];
                [bezier16Path addCurveToPoint:CGPointMake(26.21, 23.9) controlPoint1:CGPointMake(26.23, 24.07) controlPoint2:CGPointMake(26.21, 23.99)];
                [bezier16Path addLineToPoint:CGPointMake(26.21, 22.93)];
                [bezier16Path addCurveToPoint:CGPointMake(26.41, 22.54) controlPoint1:CGPointMake(26.21, 22.76) controlPoint2:CGPointMake(26.28, 22.63)];
                [bezier16Path addCurveToPoint:CGPointMake(26.97, 22.41) controlPoint1:CGPointMake(26.54, 22.46) controlPoint2:CGPointMake(26.73, 22.41)];
                [bezier16Path addCurveToPoint:CGPointMake(27.28, 22.44) controlPoint1:CGPointMake(27.08, 22.41) controlPoint2:CGPointMake(27.18, 22.42)];
                [bezier16Path addCurveToPoint:CGPointMake(27.51, 22.54) controlPoint1:CGPointMake(27.37, 22.46) controlPoint2:CGPointMake(27.45, 22.5)];
                [bezier16Path addCurveToPoint:CGPointMake(27.66, 22.71) controlPoint1:CGPointMake(27.57, 22.58) controlPoint2:CGPointMake(27.62, 22.64)];
                [bezier16Path addCurveToPoint:CGPointMake(27.71, 22.94) controlPoint1:CGPointMake(27.7, 22.78) controlPoint2:CGPointMake(27.71, 22.85)];
                [bezier16Path addLineToPoint:CGPointMake(27.71, 23.88)];
                [bezier16Path closePath];
                [bezier16Path moveToPoint:CGPointMake(27.32, 22.95)];
                [bezier16Path addCurveToPoint:CGPointMake(27.23, 22.78) controlPoint1:CGPointMake(27.32, 22.88) controlPoint2:CGPointMake(27.29, 22.82)];
                [bezier16Path addCurveToPoint:CGPointMake(26.96, 22.72) controlPoint1:CGPointMake(27.18, 22.74) controlPoint2:CGPointMake(27.08, 22.72)];
                [bezier16Path addCurveToPoint:CGPointMake(26.69, 22.78) controlPoint1:CGPointMake(26.84, 22.72) controlPoint2:CGPointMake(26.75, 22.74)];
                [bezier16Path addCurveToPoint:CGPointMake(26.6, 22.94) controlPoint1:CGPointMake(26.63, 22.82) controlPoint2:CGPointMake(26.6, 22.87)];
                [bezier16Path addLineToPoint:CGPointMake(26.6, 23.89)];
                [bezier16Path addCurveToPoint:CGPointMake(26.69, 24.06) controlPoint1:CGPointMake(26.6, 23.97) controlPoint2:CGPointMake(26.63, 24.02)];
                [bezier16Path addCurveToPoint:CGPointMake(26.95, 24.11) controlPoint1:CGPointMake(26.75, 24.09) controlPoint2:CGPointMake(26.84, 24.11)];
                [bezier16Path addCurveToPoint:CGPointMake(27.22, 24.06) controlPoint1:CGPointMake(27.07, 24.11) controlPoint2:CGPointMake(27.15, 24.09)];
                [bezier16Path addCurveToPoint:CGPointMake(27.32, 23.89) controlPoint1:CGPointMake(27.28, 24.03) controlPoint2:CGPointMake(27.32, 23.97)];
                [bezier16Path addLineToPoint:CGPointMake(27.32, 22.95)];
                [bezier16Path closePath];
                bezier16Path.miterLimit = 4;

                [fillColor setFill];
                [bezier16Path fill];

                //// Bezier 17 Drawing
                UIBezierPath *bezier17Path = [UIBezierPath bezierPath];
                [bezier17Path moveToPoint:CGPointMake(31.23, 23.27)];
                [bezier17Path addCurveToPoint:CGPointMake(31.37, 23.31) controlPoint1:CGPointMake(31.28, 23.27) controlPoint2:CGPointMake(31.33, 23.28)];
                [bezier17Path addCurveToPoint:CGPointMake(31.43, 23.43) controlPoint1:CGPointMake(31.41, 23.33) controlPoint2:CGPointMake(31.43, 23.37)];
                [bezier17Path addCurveToPoint:CGPointMake(31.38, 23.56) controlPoint1:CGPointMake(31.43, 23.49) controlPoint2:CGPointMake(31.41, 23.53)];
                [bezier17Path addCurveToPoint:CGPointMake(31.24, 23.6) controlPoint1:CGPointMake(31.34, 23.59) controlPoint2:CGPointMake(31.3, 23.6)];
                [bezier17Path addLineToPoint:CGPointMake(31.18, 23.6)];
                [bezier17Path addLineToPoint:CGPointMake(31.18, 24.27)];
                [bezier17Path addCurveToPoint:CGPointMake(31.17, 24.32) controlPoint1:CGPointMake(31.18, 24.29) controlPoint2:CGPointMake(31.17, 24.31)];
                [bezier17Path addCurveToPoint:CGPointMake(31.13, 24.37) controlPoint1:CGPointMake(31.16, 24.34) controlPoint2:CGPointMake(31.15, 24.36)];
                [bezier17Path addCurveToPoint:CGPointMake(31.07, 24.41) controlPoint1:CGPointMake(31.11, 24.39) controlPoint2:CGPointMake(31.09, 24.4)];
                [bezier17Path addCurveToPoint:CGPointMake(30.98, 24.43) controlPoint1:CGPointMake(31.05, 24.42) controlPoint2:CGPointMake(31.02, 24.43)];
                [bezier17Path addCurveToPoint:CGPointMake(30.89, 24.41) controlPoint1:CGPointMake(30.94, 24.43) controlPoint2:CGPointMake(30.91, 24.43)];
                [bezier17Path addCurveToPoint:CGPointMake(30.83, 24.37) controlPoint1:CGPointMake(30.86, 24.4) controlPoint2:CGPointMake(30.84, 24.39)];
                [bezier17Path addCurveToPoint:CGPointMake(30.8, 24.32) controlPoint1:CGPointMake(30.81, 24.35) controlPoint2:CGPointMake(30.8, 24.34)];
                [bezier17Path addCurveToPoint:CGPointMake(30.79, 24.27) controlPoint1:CGPointMake(30.79, 24.3) controlPoint2:CGPointMake(30.79, 24.28)];
                [bezier17Path addLineToPoint:CGPointMake(30.79, 23.6)];
                [bezier17Path addLineToPoint:CGPointMake(30.03, 23.6)];
                [bezier17Path addCurveToPoint:CGPointMake(29.93, 23.58) controlPoint1:CGPointMake(29.98, 23.6) controlPoint2:CGPointMake(29.95, 23.59)];
                [bezier17Path addCurveToPoint:CGPointMake(29.91, 23.5) controlPoint1:CGPointMake(29.92, 23.56) controlPoint2:CGPointMake(29.91, 23.54)];
                [bezier17Path addLineToPoint:CGPointMake(29.91, 22.59)];
                [bezier17Path addCurveToPoint:CGPointMake(29.92, 22.53) controlPoint1:CGPointMake(29.91, 22.57) controlPoint2:CGPointMake(29.91, 22.55)];
                [bezier17Path addCurveToPoint:CGPointMake(29.95, 22.47) controlPoint1:CGPointMake(29.93, 22.51) controlPoint2:CGPointMake(29.94, 22.49)];
                [bezier17Path addCurveToPoint:CGPointMake(30.01, 22.43) controlPoint1:CGPointMake(29.96, 22.46) controlPoint2:CGPointMake(29.99, 22.44)];
                [bezier17Path addCurveToPoint:CGPointMake(30.1, 22.41) controlPoint1:CGPointMake(30.04, 22.42) controlPoint2:CGPointMake(30.07, 22.41)];
                [bezier17Path addCurveToPoint:CGPointMake(30.25, 22.46) controlPoint1:CGPointMake(30.17, 22.41) controlPoint2:CGPointMake(30.22, 22.43)];
                [bezier17Path addCurveToPoint:CGPointMake(30.3, 22.59) controlPoint1:CGPointMake(30.28, 22.49) controlPoint2:CGPointMake(30.3, 22.54)];
                [bezier17Path addLineToPoint:CGPointMake(30.3, 23.29)];
                [bezier17Path addLineToPoint:CGPointMake(30.79, 23.29)];
                [bezier17Path addLineToPoint:CGPointMake(30.79, 22.59)];
                [bezier17Path addCurveToPoint:CGPointMake(30.84, 22.47) controlPoint1:CGPointMake(30.79, 22.54) controlPoint2:CGPointMake(30.81, 22.5)];
                [bezier17Path addCurveToPoint:CGPointMake(30.99, 22.42) controlPoint1:CGPointMake(30.87, 22.44) controlPoint2:CGPointMake(30.92, 22.42)];
                [bezier17Path addCurveToPoint:CGPointMake(31.14, 22.47) controlPoint1:CGPointMake(31.05, 22.42) controlPoint2:CGPointMake(31.1, 22.44)];
                [bezier17Path addCurveToPoint:CGPointMake(31.19, 22.59) controlPoint1:CGPointMake(31.17, 22.5) controlPoint2:CGPointMake(31.19, 22.54)];
                [bezier17Path addLineToPoint:CGPointMake(31.19, 23.29)];
                [bezier17Path addLineToPoint:CGPointMake(31.24, 23.29)];
                [bezier17Path addLineToPoint:CGPointMake(31.23, 23.29)];
                [bezier17Path addLineToPoint:CGPointMake(31.23, 23.27)];
                [bezier17Path closePath];
                bezier17Path.miterLimit = 4;

                [fillColor setFill];
                [bezier17Path fill];

                //// Bezier 18 Drawing
                UIBezierPath *bezier18Path = [UIBezierPath bezierPath];
                [bezier18Path moveToPoint:CGPointMake(33.41, 23.27)];
                [bezier18Path addCurveToPoint:CGPointMake(33.54, 23.31) controlPoint1:CGPointMake(33.46, 23.27) controlPoint2:CGPointMake(33.51, 23.28)];
                [bezier18Path addCurveToPoint:CGPointMake(33.6, 23.43) controlPoint1:CGPointMake(33.58, 23.33) controlPoint2:CGPointMake(33.6, 23.37)];
                [bezier18Path addCurveToPoint:CGPointMake(33.54, 23.56) controlPoint1:CGPointMake(33.6, 23.49) controlPoint2:CGPointMake(33.58, 23.53)];
                [bezier18Path addCurveToPoint:CGPointMake(33.41, 23.6) controlPoint1:CGPointMake(33.5, 23.59) controlPoint2:CGPointMake(33.46, 23.6)];
                [bezier18Path addLineToPoint:CGPointMake(33.35, 23.6)];
                [bezier18Path addLineToPoint:CGPointMake(33.35, 24.27)];
                [bezier18Path addCurveToPoint:CGPointMake(33.33, 24.32) controlPoint1:CGPointMake(33.35, 24.29) controlPoint2:CGPointMake(33.34, 24.31)];
                [bezier18Path addCurveToPoint:CGPointMake(33.3, 24.37) controlPoint1:CGPointMake(33.33, 24.34) controlPoint2:CGPointMake(33.31, 24.36)];
                [bezier18Path addCurveToPoint:CGPointMake(33.24, 24.41) controlPoint1:CGPointMake(33.28, 24.39) controlPoint2:CGPointMake(33.26, 24.4)];
                [bezier18Path addCurveToPoint:CGPointMake(33.15, 24.43) controlPoint1:CGPointMake(33.21, 24.42) controlPoint2:CGPointMake(33.19, 24.43)];
                [bezier18Path addCurveToPoint:CGPointMake(33.06, 24.41) controlPoint1:CGPointMake(33.11, 24.43) controlPoint2:CGPointMake(33.08, 24.43)];
                [bezier18Path addCurveToPoint:CGPointMake(33, 24.37) controlPoint1:CGPointMake(33.04, 24.4) controlPoint2:CGPointMake(33.01, 24.39)];
                [bezier18Path addCurveToPoint:CGPointMake(32.97, 24.32) controlPoint1:CGPointMake(32.98, 24.35) controlPoint2:CGPointMake(32.97, 24.34)];
                [bezier18Path addCurveToPoint:CGPointMake(32.96, 24.27) controlPoint1:CGPointMake(32.96, 24.3) controlPoint2:CGPointMake(32.96, 24.28)];
                [bezier18Path addLineToPoint:CGPointMake(32.96, 23.6)];
                [bezier18Path addLineToPoint:CGPointMake(32.2, 23.6)];
                [bezier18Path addCurveToPoint:CGPointMake(32.11, 23.58) controlPoint1:CGPointMake(32.15, 23.6) controlPoint2:CGPointMake(32.12, 23.59)];
                [bezier18Path addCurveToPoint:CGPointMake(32.09, 23.5) controlPoint1:CGPointMake(32.09, 23.56) controlPoint2:CGPointMake(32.09, 23.54)];
                [bezier18Path addLineToPoint:CGPointMake(32.08, 22.59)];
                [bezier18Path addCurveToPoint:CGPointMake(32.09, 22.53) controlPoint1:CGPointMake(32.08, 22.57) controlPoint2:CGPointMake(32.09, 22.55)];
                [bezier18Path addCurveToPoint:CGPointMake(32.12, 22.47) controlPoint1:CGPointMake(32.1, 22.51) controlPoint2:CGPointMake(32.11, 22.49)];
                [bezier18Path addCurveToPoint:CGPointMake(32.18, 22.43) controlPoint1:CGPointMake(32.14, 22.46) controlPoint2:CGPointMake(32.16, 22.44)];
                [bezier18Path addCurveToPoint:CGPointMake(32.27, 22.41) controlPoint1:CGPointMake(32.21, 22.42) controlPoint2:CGPointMake(32.23, 22.41)];
                [bezier18Path addCurveToPoint:CGPointMake(32.42, 22.46) controlPoint1:CGPointMake(32.34, 22.41) controlPoint2:CGPointMake(32.39, 22.43)];
                [bezier18Path addCurveToPoint:CGPointMake(32.47, 22.59) controlPoint1:CGPointMake(32.45, 22.49) controlPoint2:CGPointMake(32.47, 22.54)];
                [bezier18Path addLineToPoint:CGPointMake(32.47, 23.29)];
                [bezier18Path addLineToPoint:CGPointMake(32.96, 23.29)];
                [bezier18Path addLineToPoint:CGPointMake(32.96, 22.59)];
                [bezier18Path addCurveToPoint:CGPointMake(33.01, 22.47) controlPoint1:CGPointMake(32.96, 22.54) controlPoint2:CGPointMake(32.97, 22.5)];
                [bezier18Path addCurveToPoint:CGPointMake(33.16, 22.42) controlPoint1:CGPointMake(33.04, 22.44) controlPoint2:CGPointMake(33.09, 22.42)];
                [bezier18Path addCurveToPoint:CGPointMake(33.31, 22.47) controlPoint1:CGPointMake(33.22, 22.42) controlPoint2:CGPointMake(33.28, 22.44)];
                [bezier18Path addCurveToPoint:CGPointMake(33.36, 22.59) controlPoint1:CGPointMake(33.34, 22.5) controlPoint2:CGPointMake(33.36, 22.54)];
                [bezier18Path addLineToPoint:CGPointMake(33.36, 23.29)];
                [bezier18Path addLineToPoint:CGPointMake(33.41, 23.27)];
                [bezier18Path addLineToPoint:CGPointMake(33.41, 23.27)];
                [bezier18Path closePath];
                bezier18Path.miterLimit = 4;

                [fillColor setFill];
                [bezier18Path fill];

                //// Bezier 19 Drawing
                UIBezierPath *bezier19Path = [UIBezierPath bezierPath];
                [bezier19Path moveToPoint:CGPointMake(35.27, 23.19)];
                [bezier19Path addCurveToPoint:CGPointMake(35.59, 23.23) controlPoint1:CGPointMake(35.4, 23.19) controlPoint2:CGPointMake(35.51, 23.2)];
                [bezier19Path addCurveToPoint:CGPointMake(35.8, 23.35) controlPoint1:CGPointMake(35.68, 23.26) controlPoint2:CGPointMake(35.75, 23.3)];
                [bezier19Path addCurveToPoint:CGPointMake(35.91, 23.55) controlPoint1:CGPointMake(35.86, 23.4) controlPoint2:CGPointMake(35.89, 23.47)];
                [bezier19Path addCurveToPoint:CGPointMake(35.95, 23.82) controlPoint1:CGPointMake(35.93, 23.63) controlPoint2:CGPointMake(35.95, 23.72)];
                [bezier19Path addCurveToPoint:CGPointMake(35.91, 24.08) controlPoint1:CGPointMake(35.95, 23.92) controlPoint2:CGPointMake(35.94, 24.01)];
                [bezier19Path addCurveToPoint:CGPointMake(35.78, 24.27) controlPoint1:CGPointMake(35.88, 24.16) controlPoint2:CGPointMake(35.84, 24.22)];
                [bezier19Path addCurveToPoint:CGPointMake(35.55, 24.39) controlPoint1:CGPointMake(35.72, 24.32) controlPoint2:CGPointMake(35.65, 24.36)];
                [bezier19Path addCurveToPoint:CGPointMake(35.19, 24.43) controlPoint1:CGPointMake(35.45, 24.42) controlPoint2:CGPointMake(35.33, 24.43)];
                [bezier19Path addCurveToPoint:CGPointMake(34.89, 24.4) controlPoint1:CGPointMake(35.08, 24.43) controlPoint2:CGPointMake(34.98, 24.42)];
                [bezier19Path addCurveToPoint:CGPointMake(34.65, 24.3) controlPoint1:CGPointMake(34.8, 24.38) controlPoint2:CGPointMake(34.72, 24.35)];
                [bezier19Path addCurveToPoint:CGPointMake(34.5, 24.13) controlPoint1:CGPointMake(34.59, 24.26) controlPoint2:CGPointMake(34.54, 24.2)];
                [bezier19Path addCurveToPoint:CGPointMake(34.45, 23.87) controlPoint1:CGPointMake(34.46, 24.06) controlPoint2:CGPointMake(34.45, 23.97)];
                [bezier19Path addLineToPoint:CGPointMake(34.45, 22.57)];
                [bezier19Path addCurveToPoint:CGPointMake(34.46, 22.51) controlPoint1:CGPointMake(34.45, 22.55) controlPoint2:CGPointMake(34.45, 22.53)];
                [bezier19Path addCurveToPoint:CGPointMake(34.5, 22.45) controlPoint1:CGPointMake(34.47, 22.49) controlPoint2:CGPointMake(34.48, 22.47)];
                [bezier19Path addCurveToPoint:CGPointMake(34.56, 22.41) controlPoint1:CGPointMake(34.52, 22.43) controlPoint2:CGPointMake(34.54, 22.42)];
                [bezier19Path addCurveToPoint:CGPointMake(34.66, 22.39) controlPoint1:CGPointMake(34.59, 22.4) controlPoint2:CGPointMake(34.62, 22.39)];
                [bezier19Path addCurveToPoint:CGPointMake(34.81, 22.44) controlPoint1:CGPointMake(34.72, 22.39) controlPoint2:CGPointMake(34.78, 22.41)];
                [bezier19Path addCurveToPoint:CGPointMake(34.86, 22.56) controlPoint1:CGPointMake(34.84, 22.47) controlPoint2:CGPointMake(34.86, 22.51)];
                [bezier19Path addLineToPoint:CGPointMake(34.86, 23.21)];
                [bezier19Path addCurveToPoint:CGPointMake(35.1, 23.19) controlPoint1:CGPointMake(34.95, 23.2) controlPoint2:CGPointMake(35.04, 23.19)];
                [bezier19Path addCurveToPoint:CGPointMake(35.27, 23.19) controlPoint1:CGPointMake(35.16, 23.19) controlPoint2:CGPointMake(35.22, 23.19)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(35.57, 23.81)];
                [bezier19Path addCurveToPoint:CGPointMake(35.55, 23.66) controlPoint1:CGPointMake(35.57, 23.75) controlPoint2:CGPointMake(35.56, 23.7)];
                [bezier19Path addCurveToPoint:CGPointMake(35.49, 23.57) controlPoint1:CGPointMake(35.54, 23.62) controlPoint2:CGPointMake(35.52, 23.59)];
                [bezier19Path addCurveToPoint:CGPointMake(35.38, 23.53) controlPoint1:CGPointMake(35.46, 23.55) controlPoint2:CGPointMake(35.42, 23.53)];
                [bezier19Path addCurveToPoint:CGPointMake(35.2, 23.52) controlPoint1:CGPointMake(35.33, 23.52) controlPoint2:CGPointMake(35.27, 23.52)];
                [bezier19Path addCurveToPoint:CGPointMake(35.06, 23.52) controlPoint1:CGPointMake(35.14, 23.52) controlPoint2:CGPointMake(35.1, 23.52)];
                [bezier19Path addCurveToPoint:CGPointMake(34.97, 23.52) controlPoint1:CGPointMake(35.02, 23.52) controlPoint2:CGPointMake(34.99, 23.52)];
                [bezier19Path addCurveToPoint:CGPointMake(34.9, 23.53) controlPoint1:CGPointMake(34.94, 23.52) controlPoint2:CGPointMake(34.92, 23.52)];
                [bezier19Path addCurveToPoint:CGPointMake(34.83, 23.54) controlPoint1:CGPointMake(34.88, 23.53) controlPoint2:CGPointMake(34.86, 23.54)];
                [bezier19Path addLineToPoint:CGPointMake(34.83, 23.8)];
                [bezier19Path addCurveToPoint:CGPointMake(34.85, 23.94) controlPoint1:CGPointMake(34.83, 23.85) controlPoint2:CGPointMake(34.84, 23.9)];
                [bezier19Path addCurveToPoint:CGPointMake(34.91, 24.04) controlPoint1:CGPointMake(34.86, 23.98) controlPoint2:CGPointMake(34.88, 24.01)];
                [bezier19Path addCurveToPoint:CGPointMake(35.02, 24.1) controlPoint1:CGPointMake(34.94, 24.07) controlPoint2:CGPointMake(34.97, 24.09)];
                [bezier19Path addCurveToPoint:CGPointMake(35.19, 24.12) controlPoint1:CGPointMake(35.07, 24.11) controlPoint2:CGPointMake(35.13, 24.12)];
                [bezier19Path addCurveToPoint:CGPointMake(35.35, 24.11) controlPoint1:CGPointMake(35.25, 24.12) controlPoint2:CGPointMake(35.31, 24.12)];
                [bezier19Path addCurveToPoint:CGPointMake(35.46, 24.07) controlPoint1:CGPointMake(35.4, 24.1) controlPoint2:CGPointMake(35.43, 24.09)];
                [bezier19Path addCurveToPoint:CGPointMake(35.53, 23.98) controlPoint1:CGPointMake(35.49, 24.05) controlPoint2:CGPointMake(35.51, 24.02)];
                [bezier19Path addCurveToPoint:CGPointMake(35.57, 23.81) controlPoint1:CGPointMake(35.56, 23.92) controlPoint2:CGPointMake(35.57, 23.87)];
                [bezier19Path closePath];
                bezier19Path.miterLimit = 4;

                [fillColor setFill];
                [bezier19Path fill];

                //// Bezier 20 Drawing
                UIBezierPath *bezier20Path = [UIBezierPath bezierPath];
                [bezier20Path moveToPoint:CGPointMake(37.89, 23.27)];
                [bezier20Path addCurveToPoint:CGPointMake(38.03, 23.31) controlPoint1:CGPointMake(37.94, 23.27) controlPoint2:CGPointMake(37.99, 23.28)];
                [bezier20Path addCurveToPoint:CGPointMake(38.09, 23.43) controlPoint1:CGPointMake(38.07, 23.33) controlPoint2:CGPointMake(38.09, 23.37)];
                [bezier20Path addCurveToPoint:CGPointMake(38.03, 23.56) controlPoint1:CGPointMake(38.09, 23.49) controlPoint2:CGPointMake(38.07, 23.53)];
                [bezier20Path addCurveToPoint:CGPointMake(37.9, 23.6) controlPoint1:CGPointMake(38, 23.59) controlPoint2:CGPointMake(37.95, 23.6)];
                [bezier20Path addLineToPoint:CGPointMake(37.83, 23.6)];
                [bezier20Path addLineToPoint:CGPointMake(37.83, 24.27)];
                [bezier20Path addCurveToPoint:CGPointMake(37.82, 24.32) controlPoint1:CGPointMake(37.83, 24.29) controlPoint2:CGPointMake(37.83, 24.31)];
                [bezier20Path addCurveToPoint:CGPointMake(37.78, 24.37) controlPoint1:CGPointMake(37.81, 24.34) controlPoint2:CGPointMake(37.8, 24.36)];
                [bezier20Path addCurveToPoint:CGPointMake(37.72, 24.41) controlPoint1:CGPointMake(37.76, 24.39) controlPoint2:CGPointMake(37.75, 24.4)];
                [bezier20Path addCurveToPoint:CGPointMake(37.63, 24.43) controlPoint1:CGPointMake(37.69, 24.42) controlPoint2:CGPointMake(37.66, 24.43)];
                [bezier20Path addCurveToPoint:CGPointMake(37.54, 24.41) controlPoint1:CGPointMake(37.59, 24.43) controlPoint2:CGPointMake(37.56, 24.43)];
                [bezier20Path addCurveToPoint:CGPointMake(37.48, 24.37) controlPoint1:CGPointMake(37.52, 24.4) controlPoint2:CGPointMake(37.5, 24.39)];
                [bezier20Path addCurveToPoint:CGPointMake(37.45, 24.32) controlPoint1:CGPointMake(37.46, 24.35) controlPoint2:CGPointMake(37.45, 24.34)];
                [bezier20Path addCurveToPoint:CGPointMake(37.44, 24.27) controlPoint1:CGPointMake(37.44, 24.3) controlPoint2:CGPointMake(37.44, 24.28)];
                [bezier20Path addLineToPoint:CGPointMake(37.44, 23.6)];
                [bezier20Path addLineToPoint:CGPointMake(36.68, 23.6)];
                [bezier20Path addCurveToPoint:CGPointMake(36.59, 23.58) controlPoint1:CGPointMake(36.63, 23.6) controlPoint2:CGPointMake(36.6, 23.59)];
                [bezier20Path addCurveToPoint:CGPointMake(36.57, 23.5) controlPoint1:CGPointMake(36.57, 23.56) controlPoint2:CGPointMake(36.57, 23.54)];
                [bezier20Path addLineToPoint:CGPointMake(36.57, 22.59)];
                [bezier20Path addCurveToPoint:CGPointMake(36.58, 22.53) controlPoint1:CGPointMake(36.57, 22.57) controlPoint2:CGPointMake(36.58, 22.55)];
                [bezier20Path addCurveToPoint:CGPointMake(36.61, 22.47) controlPoint1:CGPointMake(36.59, 22.51) controlPoint2:CGPointMake(36.6, 22.49)];
                [bezier20Path addCurveToPoint:CGPointMake(36.67, 22.43) controlPoint1:CGPointMake(36.63, 22.46) controlPoint2:CGPointMake(36.64, 22.44)];
                [bezier20Path addCurveToPoint:CGPointMake(36.76, 22.41) controlPoint1:CGPointMake(36.7, 22.42) controlPoint2:CGPointMake(36.73, 22.41)];
                [bezier20Path addCurveToPoint:CGPointMake(36.91, 22.46) controlPoint1:CGPointMake(36.83, 22.41) controlPoint2:CGPointMake(36.88, 22.43)];
                [bezier20Path addCurveToPoint:CGPointMake(36.96, 22.59) controlPoint1:CGPointMake(36.94, 22.49) controlPoint2:CGPointMake(36.96, 22.54)];
                [bezier20Path addLineToPoint:CGPointMake(36.96, 23.29)];
                [bezier20Path addLineToPoint:CGPointMake(37.45, 23.29)];
                [bezier20Path addLineToPoint:CGPointMake(37.45, 22.59)];
                [bezier20Path addCurveToPoint:CGPointMake(37.5, 22.47) controlPoint1:CGPointMake(37.45, 22.54) controlPoint2:CGPointMake(37.47, 22.5)];
                [bezier20Path addCurveToPoint:CGPointMake(37.65, 22.42) controlPoint1:CGPointMake(37.53, 22.44) controlPoint2:CGPointMake(37.58, 22.42)];
                [bezier20Path addCurveToPoint:CGPointMake(37.79, 22.47) controlPoint1:CGPointMake(37.71, 22.42) controlPoint2:CGPointMake(37.76, 22.44)];
                [bezier20Path addCurveToPoint:CGPointMake(37.84, 22.59) controlPoint1:CGPointMake(37.82, 22.5) controlPoint2:CGPointMake(37.84, 22.54)];
                [bezier20Path addLineToPoint:CGPointMake(37.84, 23.29)];
                [bezier20Path addLineToPoint:CGPointMake(37.89, 23.27)];
                [bezier20Path addLineToPoint:CGPointMake(37.89, 23.27)];
                [bezier20Path closePath];
                bezier20Path.miterLimit = 4;

                [fillColor setFill];
                [bezier20Path fill];

                //// Bezier 21 Drawing
                UIBezierPath *bezier21Path = [UIBezierPath bezierPath];
                [bezier21Path moveToPoint:CGPointMake(40.25, 23.88)];
                [bezier21Path addLineToPoint:CGPointMake(40.25, 23.88)];
                [bezier21Path addCurveToPoint:CGPointMake(40.2, 24.14) controlPoint1:CGPointMake(40.25, 23.99) controlPoint2:CGPointMake(40.24, 24.07)];
                [bezier21Path addCurveToPoint:CGPointMake(40.04, 24.31) controlPoint1:CGPointMake(40.16, 24.21) controlPoint2:CGPointMake(40.11, 24.27)];
                [bezier21Path addCurveToPoint:CGPointMake(39.8, 24.4) controlPoint1:CGPointMake(39.97, 24.35) controlPoint2:CGPointMake(39.89, 24.38)];
                [bezier21Path addCurveToPoint:CGPointMake(39.49, 24.43) controlPoint1:CGPointMake(39.71, 24.42) controlPoint2:CGPointMake(39.6, 24.43)];
                [bezier21Path addCurveToPoint:CGPointMake(39.18, 24.4) controlPoint1:CGPointMake(39.38, 24.43) controlPoint2:CGPointMake(39.27, 24.42)];
                [bezier21Path addCurveToPoint:CGPointMake(38.95, 24.31) controlPoint1:CGPointMake(39.09, 24.38) controlPoint2:CGPointMake(39.01, 24.35)];
                [bezier21Path addCurveToPoint:CGPointMake(38.8, 24.14) controlPoint1:CGPointMake(38.89, 24.27) controlPoint2:CGPointMake(38.84, 24.21)];
                [bezier21Path addCurveToPoint:CGPointMake(38.75, 23.9) controlPoint1:CGPointMake(38.77, 24.07) controlPoint2:CGPointMake(38.75, 23.99)];
                [bezier21Path addLineToPoint:CGPointMake(38.75, 22.93)];
                [bezier21Path addCurveToPoint:CGPointMake(38.95, 22.54) controlPoint1:CGPointMake(38.75, 22.76) controlPoint2:CGPointMake(38.82, 22.63)];
                [bezier21Path addCurveToPoint:CGPointMake(39.51, 22.41) controlPoint1:CGPointMake(39.08, 22.46) controlPoint2:CGPointMake(39.27, 22.41)];
                [bezier21Path addCurveToPoint:CGPointMake(39.82, 22.44) controlPoint1:CGPointMake(39.62, 22.41) controlPoint2:CGPointMake(39.72, 22.42)];
                [bezier21Path addCurveToPoint:CGPointMake(40.05, 22.54) controlPoint1:CGPointMake(39.91, 22.46) controlPoint2:CGPointMake(39.99, 22.5)];
                [bezier21Path addCurveToPoint:CGPointMake(40.2, 22.71) controlPoint1:CGPointMake(40.11, 22.58) controlPoint2:CGPointMake(40.17, 22.64)];
                [bezier21Path addCurveToPoint:CGPointMake(40.25, 22.94) controlPoint1:CGPointMake(40.24, 22.78) controlPoint2:CGPointMake(40.25, 22.85)];
                [bezier21Path addLineToPoint:CGPointMake(40.25, 23.88)];
                [bezier21Path closePath];
                [bezier21Path moveToPoint:CGPointMake(39.85, 22.95)];
                [bezier21Path addCurveToPoint:CGPointMake(39.76, 22.78) controlPoint1:CGPointMake(39.85, 22.88) controlPoint2:CGPointMake(39.82, 22.82)];
                [bezier21Path addCurveToPoint:CGPointMake(39.49, 22.72) controlPoint1:CGPointMake(39.7, 22.74) controlPoint2:CGPointMake(39.61, 22.72)];
                [bezier21Path addCurveToPoint:CGPointMake(39.22, 22.78) controlPoint1:CGPointMake(39.37, 22.72) controlPoint2:CGPointMake(39.28, 22.74)];
                [bezier21Path addCurveToPoint:CGPointMake(39.14, 22.94) controlPoint1:CGPointMake(39.16, 22.82) controlPoint2:CGPointMake(39.14, 22.87)];
                [bezier21Path addLineToPoint:CGPointMake(39.14, 23.89)];
                [bezier21Path addCurveToPoint:CGPointMake(39.23, 24.06) controlPoint1:CGPointMake(39.14, 23.97) controlPoint2:CGPointMake(39.17, 24.02)];
                [bezier21Path addCurveToPoint:CGPointMake(39.49, 24.11) controlPoint1:CGPointMake(39.29, 24.09) controlPoint2:CGPointMake(39.38, 24.11)];
                [bezier21Path addCurveToPoint:CGPointMake(39.76, 24.06) controlPoint1:CGPointMake(39.6, 24.11) controlPoint2:CGPointMake(39.7, 24.09)];
                [bezier21Path addCurveToPoint:CGPointMake(39.86, 23.89) controlPoint1:CGPointMake(39.82, 24.03) controlPoint2:CGPointMake(39.86, 23.97)];
                [bezier21Path addLineToPoint:CGPointMake(39.86, 22.95)];
                [bezier21Path addLineToPoint:CGPointMake(39.85, 22.95)];
                [bezier21Path closePath];
                bezier21Path.miterLimit = 4;

                [fillColor setFill];
                [bezier21Path fill];
            }
        }

        //// Bezier 22 Drawing
        UIBezierPath *bezier22Path = [UIBezierPath bezierPath];
        [bezier22Path moveToPoint:CGPointMake(6.92, 23.82)];
        [bezier22Path addCurveToPoint:CGPointMake(6.88, 24.11) controlPoint1:CGPointMake(6.92, 23.94) controlPoint2:CGPointMake(6.91, 24.03)];
        [bezier22Path addCurveToPoint:CGPointMake(6.75, 24.3) controlPoint1:CGPointMake(6.86, 24.19) controlPoint2:CGPointMake(6.81, 24.25)];
        [bezier22Path addCurveToPoint:CGPointMake(6.5, 24.4) controlPoint1:CGPointMake(6.69, 24.35) controlPoint2:CGPointMake(6.61, 24.38)];
        [bezier22Path addCurveToPoint:CGPointMake(6.1, 24.43) controlPoint1:CGPointMake(6.39, 24.42) controlPoint2:CGPointMake(6.26, 24.43)];
        [bezier22Path addLineToPoint:CGPointMake(6.08, 24.43)];
        [bezier22Path addCurveToPoint:CGPointMake(5.95, 24.43) controlPoint1:CGPointMake(6.04, 24.43) controlPoint2:CGPointMake(6, 24.43)];
        [bezier22Path addCurveToPoint:CGPointMake(5.8, 24.42) controlPoint1:CGPointMake(5.9, 24.43) controlPoint2:CGPointMake(5.85, 24.43)];
        [bezier22Path addCurveToPoint:CGPointMake(5.66, 24.39) controlPoint1:CGPointMake(5.75, 24.41) controlPoint2:CGPointMake(5.7, 24.41)];
        [bezier22Path addCurveToPoint:CGPointMake(5.53, 24.34) controlPoint1:CGPointMake(5.61, 24.38) controlPoint2:CGPointMake(5.57, 24.36)];
        [bezier22Path addCurveToPoint:CGPointMake(5.44, 24.26) controlPoint1:CGPointMake(5.49, 24.32) controlPoint2:CGPointMake(5.46, 24.29)];
        [bezier22Path addCurveToPoint:CGPointMake(5.4, 24.15) controlPoint1:CGPointMake(5.42, 24.23) controlPoint2:CGPointMake(5.41, 24.19)];
        [bezier22Path addLineToPoint:CGPointMake(5.4, 24.14)];
        [bezier22Path addCurveToPoint:CGPointMake(5.46, 24.02) controlPoint1:CGPointMake(5.4, 24.09) controlPoint2:CGPointMake(5.42, 24.05)];
        [bezier22Path addCurveToPoint:CGPointMake(5.58, 23.98) controlPoint1:CGPointMake(5.5, 23.99) controlPoint2:CGPointMake(5.54, 23.98)];
        [bezier22Path addLineToPoint:CGPointMake(5.58, 23.98)];
        [bezier22Path addCurveToPoint:CGPointMake(5.64, 23.98) controlPoint1:CGPointMake(5.61, 23.98) controlPoint2:CGPointMake(5.63, 23.98)];
        [bezier22Path addCurveToPoint:CGPointMake(5.68, 24.01) controlPoint1:CGPointMake(5.66, 24) controlPoint2:CGPointMake(5.67, 24)];
        [bezier22Path addCurveToPoint:CGPointMake(5.71, 24.03) controlPoint1:CGPointMake(5.69, 24.02) controlPoint2:CGPointMake(5.7, 24.02)];
        [bezier22Path addCurveToPoint:CGPointMake(5.73, 24.05) controlPoint1:CGPointMake(5.71, 24.04) controlPoint2:CGPointMake(5.73, 24.04)];
        [bezier22Path addLineToPoint:CGPointMake(5.73, 24.05)];
        [bezier22Path addCurveToPoint:CGPointMake(5.77, 24.08) controlPoint1:CGPointMake(5.74, 24.06) controlPoint2:CGPointMake(5.76, 24.07)];
        [bezier22Path addCurveToPoint:CGPointMake(5.84, 24.1) controlPoint1:CGPointMake(5.78, 24.09) controlPoint2:CGPointMake(5.81, 24.09)];
        [bezier22Path addCurveToPoint:CGPointMake(5.94, 24.12) controlPoint1:CGPointMake(5.87, 24.11) controlPoint2:CGPointMake(5.9, 24.11)];
        [bezier22Path addCurveToPoint:CGPointMake(6.11, 24.12) controlPoint1:CGPointMake(5.98, 24.12) controlPoint2:CGPointMake(6.04, 24.12)];
        [bezier22Path addLineToPoint:CGPointMake(6.14, 24.12)];
        [bezier22Path addCurveToPoint:CGPointMake(6.33, 24.1) controlPoint1:CGPointMake(6.22, 24.12) controlPoint2:CGPointMake(6.28, 24.12)];
        [bezier22Path addCurveToPoint:CGPointMake(6.45, 24.05) controlPoint1:CGPointMake(6.38, 24.09) controlPoint2:CGPointMake(6.42, 24.07)];
        [bezier22Path addCurveToPoint:CGPointMake(6.51, 23.96) controlPoint1:CGPointMake(6.47, 24.03) controlPoint2:CGPointMake(6.5, 23.99)];
        [bezier22Path addCurveToPoint:CGPointMake(6.53, 23.83) controlPoint1:CGPointMake(6.52, 23.92) controlPoint2:CGPointMake(6.53, 23.88)];
        [bezier22Path addCurveToPoint:CGPointMake(6.49, 23.64) controlPoint1:CGPointMake(6.53, 23.74) controlPoint2:CGPointMake(6.52, 23.67)];
        [bezier22Path addCurveToPoint:CGPointMake(6.36, 23.58) controlPoint1:CGPointMake(6.47, 23.61) controlPoint2:CGPointMake(6.43, 23.58)];
        [bezier22Path addLineToPoint:CGPointMake(5.94, 23.58)];
        [bezier22Path addCurveToPoint:CGPointMake(5.87, 23.57) controlPoint1:CGPointMake(5.92, 23.58) controlPoint2:CGPointMake(5.89, 23.58)];
        [bezier22Path addCurveToPoint:CGPointMake(5.81, 23.55) controlPoint1:CGPointMake(5.85, 23.57) controlPoint2:CGPointMake(5.83, 23.56)];
        [bezier22Path addCurveToPoint:CGPointMake(5.77, 23.5) controlPoint1:CGPointMake(5.79, 23.54) controlPoint2:CGPointMake(5.78, 23.52)];
        [bezier22Path addCurveToPoint:CGPointMake(5.75, 23.42) controlPoint1:CGPointMake(5.76, 23.48) controlPoint2:CGPointMake(5.75, 23.45)];
        [bezier22Path addCurveToPoint:CGPointMake(5.81, 23.29) controlPoint1:CGPointMake(5.75, 23.36) controlPoint2:CGPointMake(5.77, 23.32)];
        [bezier22Path addCurveToPoint:CGPointMake(5.94, 23.25) controlPoint1:CGPointMake(5.85, 23.27) controlPoint2:CGPointMake(5.9, 23.25)];
        [bezier22Path addLineToPoint:CGPointMake(6.34, 23.25)];
        [bezier22Path addCurveToPoint:CGPointMake(6.42, 23.24) controlPoint1:CGPointMake(6.37, 23.25) controlPoint2:CGPointMake(6.4, 23.25)];
        [bezier22Path addCurveToPoint:CGPointMake(6.48, 23.2) controlPoint1:CGPointMake(6.44, 23.23) controlPoint2:CGPointMake(6.46, 23.22)];
        [bezier22Path addCurveToPoint:CGPointMake(6.52, 23.13) controlPoint1:CGPointMake(6.49, 23.18) controlPoint2:CGPointMake(6.51, 23.16)];
        [bezier22Path addCurveToPoint:CGPointMake(6.53, 23.01) controlPoint1:CGPointMake(6.53, 23.1) controlPoint2:CGPointMake(6.53, 23.06)];
        [bezier22Path addCurveToPoint:CGPointMake(6.52, 22.88) controlPoint1:CGPointMake(6.53, 22.96) controlPoint2:CGPointMake(6.53, 22.91)];
        [bezier22Path addCurveToPoint:CGPointMake(6.47, 22.79) controlPoint1:CGPointMake(6.51, 22.84) controlPoint2:CGPointMake(6.5, 22.81)];
        [bezier22Path addCurveToPoint:CGPointMake(6.36, 22.74) controlPoint1:CGPointMake(6.45, 22.77) controlPoint2:CGPointMake(6.41, 22.75)];
        [bezier22Path addCurveToPoint:CGPointMake(6.16, 22.73) controlPoint1:CGPointMake(6.31, 22.73) controlPoint2:CGPointMake(6.24, 22.73)];
        [bezier22Path addLineToPoint:CGPointMake(6.14, 22.73)];
        [bezier22Path addCurveToPoint:CGPointMake(5.97, 22.74) controlPoint1:CGPointMake(6.09, 22.73) controlPoint2:CGPointMake(6.03, 22.73)];
        [bezier22Path addCurveToPoint:CGPointMake(5.83, 22.78) controlPoint1:CGPointMake(5.91, 22.75) controlPoint2:CGPointMake(5.87, 22.76)];
        [bezier22Path addCurveToPoint:CGPointMake(5.78, 22.8) controlPoint1:CGPointMake(5.81, 22.79) controlPoint2:CGPointMake(5.8, 22.8)];
        [bezier22Path addCurveToPoint:CGPointMake(5.74, 22.82) controlPoint1:CGPointMake(5.77, 22.81) controlPoint2:CGPointMake(5.75, 22.82)];
        [bezier22Path addCurveToPoint:CGPointMake(5.69, 22.83) controlPoint1:CGPointMake(5.73, 22.83) controlPoint2:CGPointMake(5.71, 22.83)];
        [bezier22Path addCurveToPoint:CGPointMake(5.63, 22.83) controlPoint1:CGPointMake(5.67, 22.83) controlPoint2:CGPointMake(5.66, 22.83)];
        [bezier22Path addLineToPoint:CGPointMake(5.63, 22.83)];
        [bezier22Path addCurveToPoint:CGPointMake(5.51, 22.79) controlPoint1:CGPointMake(5.58, 22.83) controlPoint2:CGPointMake(5.54, 22.81)];
        [bezier22Path addCurveToPoint:CGPointMake(5.46, 22.68) controlPoint1:CGPointMake(5.47, 22.76) controlPoint2:CGPointMake(5.46, 22.72)];
        [bezier22Path addLineToPoint:CGPointMake(5.46, 22.68)];
        [bezier22Path addCurveToPoint:CGPointMake(5.51, 22.56) controlPoint1:CGPointMake(5.46, 22.63) controlPoint2:CGPointMake(5.48, 22.59)];
        [bezier22Path addCurveToPoint:CGPointMake(5.63, 22.47) controlPoint1:CGPointMake(5.54, 22.52) controlPoint2:CGPointMake(5.58, 22.5)];
        [bezier22Path addCurveToPoint:CGPointMake(5.84, 22.41) controlPoint1:CGPointMake(5.68, 22.45) controlPoint2:CGPointMake(5.75, 22.43)];
        [bezier22Path addCurveToPoint:CGPointMake(6.15, 22.39) controlPoint1:CGPointMake(5.92, 22.4) controlPoint2:CGPointMake(6.02, 22.39)];
        [bezier22Path addCurveToPoint:CGPointMake(6.52, 22.41) controlPoint1:CGPointMake(6.29, 22.39) controlPoint2:CGPointMake(6.42, 22.4)];
        [bezier22Path addCurveToPoint:CGPointMake(6.76, 22.49) controlPoint1:CGPointMake(6.62, 22.42) controlPoint2:CGPointMake(6.7, 22.45)];
        [bezier22Path addCurveToPoint:CGPointMake(6.89, 22.66) controlPoint1:CGPointMake(6.82, 22.53) controlPoint2:CGPointMake(6.87, 22.59)];
        [bezier22Path addCurveToPoint:CGPointMake(6.93, 22.94) controlPoint1:CGPointMake(6.92, 22.74) controlPoint2:CGPointMake(6.93, 22.83)];
        [bezier22Path addCurveToPoint:CGPointMake(6.92, 23.1) controlPoint1:CGPointMake(6.93, 23) controlPoint2:CGPointMake(6.93, 23.05)];
        [bezier22Path addCurveToPoint:CGPointMake(6.9, 23.22) controlPoint1:CGPointMake(6.91, 23.14) controlPoint2:CGPointMake(6.91, 23.18)];
        [bezier22Path addCurveToPoint:CGPointMake(6.86, 23.31) controlPoint1:CGPointMake(6.89, 23.25) controlPoint2:CGPointMake(6.88, 23.28)];
        [bezier22Path addCurveToPoint:CGPointMake(6.81, 23.38) controlPoint1:CGPointMake(6.85, 23.34) controlPoint2:CGPointMake(6.83, 23.36)];
        [bezier22Path addCurveToPoint:CGPointMake(6.86, 23.43) controlPoint1:CGPointMake(6.83, 23.39) controlPoint2:CGPointMake(6.84, 23.41)];
        [bezier22Path addCurveToPoint:CGPointMake(6.9, 23.51) controlPoint1:CGPointMake(6.87, 23.45) controlPoint2:CGPointMake(6.89, 23.48)];
        [bezier22Path addCurveToPoint:CGPointMake(6.93, 23.63) controlPoint1:CGPointMake(6.91, 23.54) controlPoint2:CGPointMake(6.92, 23.58)];
        [bezier22Path addCurveToPoint:CGPointMake(6.92, 23.82) controlPoint1:CGPointMake(6.92, 23.69) controlPoint2:CGPointMake(6.92, 23.75)];
        [bezier22Path closePath];
        bezier22Path.miterLimit = 4;

        [fillColor setFill];
        [bezier22Path fill];
    }

    //// Group 15
    {
        //// Bezier 23 Drawing
        UIBezierPath *bezier23Path = [UIBezierPath bezierPath];
        [bezier23Path moveToPoint:CGPointMake(34.66, 20.7)];
        [bezier23Path addLineToPoint:CGPointMake(34.66, 20.54)];
        [bezier23Path addCurveToPoint:CGPointMake(35.54, 19.55) controlPoint1:CGPointMake(35.23, 20.09) controlPoint2:CGPointMake(35.54, 19.82)];
        [bezier23Path addCurveToPoint:CGPointMake(35.21, 19.26) controlPoint1:CGPointMake(35.54, 19.35) controlPoint2:CGPointMake(35.37, 19.26)];
        [bezier23Path addCurveToPoint:CGPointMake(34.78, 19.46) controlPoint1:CGPointMake(35.02, 19.26) controlPoint2:CGPointMake(34.87, 19.34)];
        [bezier23Path addLineToPoint:CGPointMake(34.66, 19.33)];
        [bezier23Path addCurveToPoint:CGPointMake(35.21, 19.08) controlPoint1:CGPointMake(34.78, 19.17) controlPoint2:CGPointMake(34.99, 19.08)];
        [bezier23Path addCurveToPoint:CGPointMake(35.74, 19.55) controlPoint1:CGPointMake(35.47, 19.08) controlPoint2:CGPointMake(35.74, 19.23)];
        [bezier23Path addCurveToPoint:CGPointMake(34.97, 20.52) controlPoint1:CGPointMake(35.74, 19.87) controlPoint2:CGPointMake(35.41, 20.17)];
        [bezier23Path addLineToPoint:CGPointMake(35.75, 20.52)];
        [bezier23Path addLineToPoint:CGPointMake(35.75, 20.7)];
        [bezier23Path addLineToPoint:CGPointMake(34.66, 20.7)];
        [bezier23Path closePath];
        bezier23Path.miterLimit = 4;

        [fillColor setFill];
        [bezier23Path fill];

        //// Bezier 24 Drawing
        UIBezierPath *bezier24Path = [UIBezierPath bezierPath];
        [bezier24Path moveToPoint:CGPointMake(36.14, 20.47)];
        [bezier24Path addLineToPoint:CGPointMake(36.26, 20.35)];
        [bezier24Path addCurveToPoint:CGPointMake(36.7, 20.56) controlPoint1:CGPointMake(36.35, 20.47) controlPoint2:CGPointMake(36.52, 20.56)];
        [bezier24Path addCurveToPoint:CGPointMake(37.07, 20.26) controlPoint1:CGPointMake(36.93, 20.56) controlPoint2:CGPointMake(37.07, 20.45)];
        [bezier24Path addCurveToPoint:CGPointMake(36.67, 19.98) controlPoint1:CGPointMake(37.07, 20.06) controlPoint2:CGPointMake(36.91, 19.98)];
        [bezier24Path addCurveToPoint:CGPointMake(36.51, 19.98) controlPoint1:CGPointMake(36.6, 19.98) controlPoint2:CGPointMake(36.53, 19.98)];
        [bezier24Path addLineToPoint:CGPointMake(36.51, 19.8)];
        [bezier24Path addCurveToPoint:CGPointMake(36.67, 19.8) controlPoint1:CGPointMake(36.54, 19.8) controlPoint2:CGPointMake(36.61, 19.8)];
        [bezier24Path addCurveToPoint:CGPointMake(37.04, 19.54) controlPoint1:CGPointMake(36.87, 19.8) controlPoint2:CGPointMake(37.04, 19.72)];
        [bezier24Path addCurveToPoint:CGPointMake(36.68, 19.27) controlPoint1:CGPointMake(37.04, 19.36) controlPoint2:CGPointMake(36.88, 19.27)];
        [bezier24Path addCurveToPoint:CGPointMake(36.26, 19.46) controlPoint1:CGPointMake(36.51, 19.27) controlPoint2:CGPointMake(36.38, 19.34)];
        [bezier24Path addLineToPoint:CGPointMake(36.15, 19.34)];
        [bezier24Path addCurveToPoint:CGPointMake(36.69, 19.09) controlPoint1:CGPointMake(36.26, 19.2) controlPoint2:CGPointMake(36.45, 19.09)];
        [bezier24Path addCurveToPoint:CGPointMake(37.23, 19.51) controlPoint1:CGPointMake(37, 19.09) controlPoint2:CGPointMake(37.23, 19.25)];
        [bezier24Path addCurveToPoint:CGPointMake(36.89, 19.88) controlPoint1:CGPointMake(37.23, 19.74) controlPoint2:CGPointMake(37.04, 19.85)];
        [bezier24Path addCurveToPoint:CGPointMake(37.26, 20.27) controlPoint1:CGPointMake(37.04, 19.89) controlPoint2:CGPointMake(37.26, 20.02)];
        [bezier24Path addCurveToPoint:CGPointMake(36.7, 20.73) controlPoint1:CGPointMake(37.26, 20.53) controlPoint2:CGPointMake(37.05, 20.73)];
        [bezier24Path addCurveToPoint:CGPointMake(36.14, 20.47) controlPoint1:CGPointMake(36.44, 20.73) controlPoint2:CGPointMake(36.24, 20.61)];
        [bezier24Path closePath];
        bezier24Path.miterLimit = 4;

        [fillColor setFill];
        [bezier24Path fill];

        //// Bezier 25 Drawing
        UIBezierPath *bezier25Path = [UIBezierPath bezierPath];
        [bezier25Path moveToPoint:CGPointMake(38.07, 20.7)];
        [bezier25Path addLineToPoint:CGPointMake(38.07, 19.37)];
        [bezier25Path addLineToPoint:CGPointMake(37.81, 19.64)];
        [bezier25Path addLineToPoint:CGPointMake(37.69, 19.52)];
        [bezier25Path addLineToPoint:CGPointMake(38.09, 19.11)];
        [bezier25Path addLineToPoint:CGPointMake(38.26, 19.11)];
        [bezier25Path addLineToPoint:CGPointMake(38.26, 20.7)];
        [bezier25Path addLineToPoint:CGPointMake(38.07, 20.7)];
        [bezier25Path closePath];
        bezier25Path.miterLimit = 4;

        [fillColor setFill];
        [bezier25Path fill];

        //// Bezier 26 Drawing
        UIBezierPath *bezier26Path = [UIBezierPath bezierPath];
        [bezier26Path moveToPoint:CGPointMake(38.78, 20.7)];
        [bezier26Path addLineToPoint:CGPointMake(38.78, 20.54)];
        [bezier26Path addCurveToPoint:CGPointMake(39.66, 19.55) controlPoint1:CGPointMake(39.35, 20.09) controlPoint2:CGPointMake(39.66, 19.82)];
        [bezier26Path addCurveToPoint:CGPointMake(39.33, 19.26) controlPoint1:CGPointMake(39.66, 19.35) controlPoint2:CGPointMake(39.49, 19.26)];
        [bezier26Path addCurveToPoint:CGPointMake(38.9, 19.46) controlPoint1:CGPointMake(39.14, 19.26) controlPoint2:CGPointMake(38.99, 19.34)];
        [bezier26Path addLineToPoint:CGPointMake(38.78, 19.33)];
        [bezier26Path addCurveToPoint:CGPointMake(39.33, 19.08) controlPoint1:CGPointMake(38.9, 19.17) controlPoint2:CGPointMake(39.11, 19.08)];
        [bezier26Path addCurveToPoint:CGPointMake(39.86, 19.55) controlPoint1:CGPointMake(39.59, 19.08) controlPoint2:CGPointMake(39.86, 19.23)];
        [bezier26Path addCurveToPoint:CGPointMake(39.09, 20.52) controlPoint1:CGPointMake(39.86, 19.87) controlPoint2:CGPointMake(39.53, 20.17)];
        [bezier26Path addLineToPoint:CGPointMake(39.87, 20.52)];
        [bezier26Path addLineToPoint:CGPointMake(39.87, 20.7)];
        [bezier26Path addLineToPoint:CGPointMake(38.78, 20.7)];
        [bezier26Path closePath];
        bezier26Path.miterLimit = 4;

        [fillColor setFill];
        [bezier26Path fill];
    }
}
}

//// Cleanup
CGGradientRelease(sVGID_5_);
CGColorSpaceRelease(colorSpace);
}

- (void)drawIc_card_cidvCanvas {
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor *gradientColor = [UIColor colorWithRed:0.402 green:0.75 blue:0.935 alpha:1];
    UIColor *gradientColor2 = [UIColor colorWithRed:0.144 green:0.465 blue:0.732 alpha:1];
    UIColor *gradientColor3 = [UIColor colorWithRed:0.037 green:0.312 blue:0.619 alpha:1];
    UIColor *fillColor = [UIColor colorWithRed:0.647 green:0.647 blue:0.647 alpha:1];
    UIColor *fillColor2 = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1];
    UIColor *fillColor3 = [UIColor colorWithRed:0.037 green:0.312 blue:0.619 alpha:1];
    UIColor *fillColor4 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    UIColor *fillColor5 = [UIColor colorWithRed:0.229 green:0.229 blue:0.229 alpha:1];
    UIColor *fillColor6 = [UIColor colorWithRed:0.89 green:0.122 blue:0.136 alpha:1];

    //// Gradient Declarations
    CGFloat sVGID_5_2Locations[] = {0, 0.61, 1};
    CGGradientRef sVGID_5_2 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) @[ (id)gradientColor.CGColor, (id)gradientColor2.CGColor, (id)gradientColor3.CGColor ], sVGID_5_2Locations);

    //// Group
    {
        //// Group 2
        {
            //// Bezier Drawing
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(43.77, 0)];
            [bezierPath addLineToPoint:CGPointMake(2.23, 0)];
            [bezierPath addCurveToPoint:CGPointMake(0, 2.22) controlPoint1:CGPointMake(1, 0) controlPoint2:CGPointMake(0, 0.99)];
            [bezierPath addLineToPoint:CGPointMake(0, 3.33)];
            [bezierPath addLineToPoint:CGPointMake(0, 26.67)];
            [bezierPath addLineToPoint:CGPointMake(0, 27.79)];
            [bezierPath addCurveToPoint:CGPointMake(2.23, 30) controlPoint1:CGPointMake(0, 29.01) controlPoint2:CGPointMake(1, 30)];
            [bezierPath addLineToPoint:CGPointMake(43.77, 30)];
            [bezierPath addCurveToPoint:CGPointMake(46, 27.79) controlPoint1:CGPointMake(45, 30) controlPoint2:CGPointMake(46, 29.01)];
            [bezierPath addLineToPoint:CGPointMake(46, 2.22)];
            [bezierPath addCurveToPoint:CGPointMake(43.77, 0) controlPoint1:CGPointMake(46, 0.99) controlPoint2:CGPointMake(45, 0)];
            [bezierPath closePath];
            bezierPath.miterLimit = 4;

            [fillColor setFill];
            [bezierPath fill];

            //// Rectangle Drawing
            UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.55, 0.57, 44.9, 28.35) cornerRadius:1.6];
            [fillColor2 setFill];
            [rectanglePath fill];
        }

        //// Group 3
        {
            //// Group 4
            {
                //// SVGID_1_ Drawing
                UIBezierPath *sVGID_1_Path = [UIBezierPath bezierPath];
                [sVGID_1_Path moveToPoint:CGPointMake(41.83, 3.69)];
                [sVGID_1_Path addLineToPoint:CGPointMake(29.36, 3.69)];
                [sVGID_1_Path addLineToPoint:CGPointMake(29.36, 16.2)];
                [sVGID_1_Path addLineToPoint:CGPointMake(41.82, 16.2)];
                [sVGID_1_Path addLineToPoint:CGPointMake(41.82, 12.07)];
                [sVGID_1_Path addCurveToPoint:CGPointMake(41.9, 11.79) controlPoint1:CGPointMake(41.87, 12) controlPoint2:CGPointMake(41.9, 11.91)];
                [sVGID_1_Path addCurveToPoint:CGPointMake(41.82, 11.52) controlPoint1:CGPointMake(41.9, 11.66) controlPoint2:CGPointMake(41.87, 11.58)];
                [sVGID_1_Path addLineToPoint:CGPointMake(41.82, 3.69)];
                [sVGID_1_Path addLineToPoint:CGPointMake(41.83, 3.69)];
                [sVGID_1_Path closePath];
                sVGID_1_Path.miterLimit = 4;

                [fillColor3 setFill];
                [sVGID_1_Path fill];
            }

            //// Group 5
            {
                //// Group 6
                {
                    //// Group 7
                    {
                        //// Bezier 3 Drawing
                        UIBezierPath *bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint:CGPointMake(28.56, 15.94)];
            [bezier3Path addLineToPoint:CGPointMake(28.45, 15.94)];
            [bezier3Path addCurveToPoint:CGPointMake(28.44, 15.79) controlPoint1:CGPointMake(28.44, 15.9) controlPoint2:CGPointMake(28.44, 15.82)];
            [bezier3Path addCurveToPoint:CGPointMake(28.36, 15.71) controlPoint1:CGPointMake(28.44, 15.75) controlPoint2:CGPointMake(28.43, 15.71)];
            [bezier3Path addLineToPoint:CGPointMake(28.2, 15.71)];
            [bezier3Path addLineToPoint:CGPointMake(28.2, 15.94)];
            [bezier3Path addLineToPoint:CGPointMake(28.1, 15.94)];
            [bezier3Path addLineToPoint:CGPointMake(28.1, 15.39)];
            [bezier3Path addLineToPoint:CGPointMake(28.36, 15.39)];
            [bezier3Path addCurveToPoint:CGPointMake(28.55, 15.54) controlPoint1:CGPointMake(28.45, 15.39) controlPoint2:CGPointMake(28.55, 15.42)];
            [bezier3Path addCurveToPoint:CGPointMake(28.49, 15.66) controlPoint1:CGPointMake(28.55, 15.61) controlPoint2:CGPointMake(28.52, 15.64)];
            [bezier3Path addCurveToPoint:CGPointMake(28.54, 15.76) controlPoint1:CGPointMake(28.52, 15.67) controlPoint2:CGPointMake(28.54, 15.7)];
            [bezier3Path addLineToPoint:CGPointMake(28.54, 15.86)];
            [bezier3Path addCurveToPoint:CGPointMake(28.56, 15.91) controlPoint1:CGPointMake(28.54, 15.89) controlPoint2:CGPointMake(28.54, 15.89)];
            [bezier3Path addLineToPoint:CGPointMake(28.56, 15.94)];
            [bezier3Path closePath];
            [bezier3Path moveToPoint:CGPointMake(28.45, 15.55)];
            [bezier3Path addCurveToPoint:CGPointMake(28.37, 15.47) controlPoint1:CGPointMake(28.45, 15.48) controlPoint2:CGPointMake(28.4, 15.47)];
            [bezier3Path addLineToPoint:CGPointMake(28.2, 15.47)];
            [bezier3Path addLineToPoint:CGPointMake(28.2, 15.63)];
            [bezier3Path addLineToPoint:CGPointMake(28.35, 15.63)];
            [bezier3Path addCurveToPoint:CGPointMake(28.45, 15.55) controlPoint1:CGPointMake(28.4, 15.63) controlPoint2:CGPointMake(28.45, 15.62)];
            [bezier3Path closePath];
            [bezier3Path moveToPoint:CGPointMake(28.9, 15.67)];
            [bezier3Path addCurveToPoint:CGPointMake(28.31, 15.08) controlPoint1:CGPointMake(28.9, 15.34) controlPoint2:CGPointMake(28.64, 15.08)];
            [bezier3Path addCurveToPoint:CGPointMake(27.72, 15.67) controlPoint1:CGPointMake(27.98, 15.08) controlPoint2:CGPointMake(27.72, 15.34)];
            [bezier3Path addCurveToPoint:CGPointMake(28.31, 16.26) controlPoint1:CGPointMake(27.72, 16) controlPoint2:CGPointMake(27.98, 16.26)];
            [bezier3Path addCurveToPoint:CGPointMake(28.9, 15.67) controlPoint1:CGPointMake(28.64, 16.26) controlPoint2:CGPointMake(28.9, 16)];
            [bezier3Path closePath];
            [bezier3Path moveToPoint:CGPointMake(28.81, 15.67)];
            [bezier3Path addCurveToPoint:CGPointMake(28.31, 16.17) controlPoint1:CGPointMake(28.81, 15.95) controlPoint2:CGPointMake(28.6, 16.17)];
            [bezier3Path addCurveToPoint:CGPointMake(27.81, 15.67) controlPoint1:CGPointMake(28.02, 16.17) controlPoint2:CGPointMake(27.81, 15.94)];
            [bezier3Path addCurveToPoint:CGPointMake(28.31, 15.16) controlPoint1:CGPointMake(27.81, 15.39) controlPoint2:CGPointMake(28.02, 15.16)];
            [bezier3Path addCurveToPoint:CGPointMake(28.81, 15.67) controlPoint1:CGPointMake(28.6, 15.16) controlPoint2:CGPointMake(28.81, 15.39)];
            [bezier3Path closePath];
            bezier3Path.miterLimit = 4;

            [fillColor3 setFill];
            [bezier3Path fill];
        }
    }
}

//// Group 8
{
    //// SVGID_4_
    {
        CGContextSaveGState(context);
        CGContextBeginTransparencyLayer(context, NULL);

        //// Clip Bezier 4
        UIBezierPath *bezier4Path = [UIBezierPath bezierPath];
        [bezier4Path moveToPoint:CGPointMake(41.83, 3.69)];
        [bezier4Path addLineToPoint:CGPointMake(29.36, 3.69)];
        [bezier4Path addLineToPoint:CGPointMake(29.36, 16.2)];
        [bezier4Path addLineToPoint:CGPointMake(41.82, 16.2)];
        [bezier4Path addLineToPoint:CGPointMake(41.82, 12.07)];
        [bezier4Path addCurveToPoint:CGPointMake(41.9, 11.79) controlPoint1:CGPointMake(41.87, 12) controlPoint2:CGPointMake(41.9, 11.91)];
        [bezier4Path addCurveToPoint:CGPointMake(41.82, 11.52) controlPoint1:CGPointMake(41.9, 11.66) controlPoint2:CGPointMake(41.87, 11.58)];
        [bezier4Path addLineToPoint:CGPointMake(41.82, 3.69)];
        [bezier4Path addLineToPoint:CGPointMake(41.83, 3.69)];
        [bezier4Path closePath];
        bezier4Path.miterLimit = 0;

        [bezier4Path addClip];

        //// Rectangle 2 Drawing
        UIBezierPath *rectangle2Path = [UIBezierPath bezierPathWithRect:CGRectMake(25.36, 0.92, 13.39, 13.39)];
        CGContextSaveGState(context);
        [rectangle2Path addClip];
        CGContextDrawRadialGradient(context, sVGID_5_2,
                                    CGPointMake(32.05, 7.61), 0,
                                    CGPointMake(32.05, 7.61), 6.69,
                                    kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
        CGContextRestoreGState(context);

        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }
}

//// Group 10
{
    //// Bezier 5 Drawing
    UIBezierPath *bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint:CGPointMake(29.36, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(29.96, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(30.1, 9.7)];
    [bezier5Path addLineToPoint:CGPointMake(30.4, 9.7)];
    [bezier5Path addLineToPoint:CGPointMake(30.53, 10.03)];
    [bezier5Path addLineToPoint:CGPointMake(31.71, 10.03)];
    [bezier5Path addLineToPoint:CGPointMake(31.71, 9.77)];
    [bezier5Path addLineToPoint:CGPointMake(31.81, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(32.43, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(32.53, 9.77)];
    [bezier5Path addLineToPoint:CGPointMake(32.53, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(35.46, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(35.46, 9.49)];
    [bezier5Path addLineToPoint:CGPointMake(35.52, 9.49)];
    [bezier5Path addCurveToPoint:CGPointMake(35.57, 9.56) controlPoint1:CGPointMake(35.56, 9.49) controlPoint2:CGPointMake(35.57, 9.49)];
    [bezier5Path addLineToPoint:CGPointMake(35.57, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(37.08, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(37.08, 9.9)];
    [bezier5Path addCurveToPoint:CGPointMake(37.64, 10.02) controlPoint1:CGPointMake(37.21, 9.97) controlPoint2:CGPointMake(37.39, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(38.28, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(38.42, 9.69)];
    [bezier5Path addLineToPoint:CGPointMake(38.72, 9.69)];
    [bezier5Path addLineToPoint:CGPointMake(38.85, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(40.08, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(40.08, 9.71)];
    [bezier5Path addLineToPoint:CGPointMake(40.26, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(41.25, 10.02)];
    [bezier5Path addLineToPoint:CGPointMake(41.25, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(40.27, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(40.27, 8.22)];
    [bezier5Path addLineToPoint:CGPointMake(40.13, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(39.13, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(39.13, 8.22)];
    [bezier5Path addLineToPoint:CGPointMake(39, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(37.65, 7.98)];
    [bezier5Path addCurveToPoint:CGPointMake(37.06, 8.1) controlPoint1:CGPointMake(37.43, 7.98) controlPoint2:CGPointMake(37.22, 8.01)];
    [bezier5Path addLineToPoint:CGPointMake(37.06, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(36.13, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(36.13, 8.1)];
    [bezier5Path addCurveToPoint:CGPointMake(35.74, 7.98) controlPoint1:CGPointMake(36.03, 8.01) controlPoint2:CGPointMake(35.89, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(32.34, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(32.11, 8.51)];
    [bezier5Path addLineToPoint:CGPointMake(31.88, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(30.81, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(30.81, 8.22)];
    [bezier5Path addLineToPoint:CGPointMake(30.7, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(29.79, 7.98)];
    [bezier5Path addLineToPoint:CGPointMake(29.36, 8.95)];
    [bezier5Path addLineToPoint:CGPointMake(29.36, 10.02)];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(40.93, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(40.44, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(39.78, 8.63)];
    [bezier5Path addLineToPoint:CGPointMake(39.78, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(39.07, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(38.93, 9.4)];
    [bezier5Path addLineToPoint:CGPointMake(38.2, 9.4)];
    [bezier5Path addLineToPoint:CGPointMake(38.07, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(37.66, 9.73)];
    [bezier5Path addCurveToPoint:CGPointMake(37.15, 9.57) controlPoint1:CGPointMake(37.49, 9.73) controlPoint2:CGPointMake(37.28, 9.69)];
    [bezier5Path addCurveToPoint:CGPointMake(36.96, 9.01) controlPoint1:CGPointMake(37.03, 9.45) controlPoint2:CGPointMake(36.96, 9.28)];
    [bezier5Path addCurveToPoint:CGPointMake(37.15, 8.44) controlPoint1:CGPointMake(36.96, 8.79) controlPoint2:CGPointMake(37, 8.59)];
    [bezier5Path addCurveToPoint:CGPointMake(37.68, 8.27) controlPoint1:CGPointMake(37.26, 8.32) controlPoint2:CGPointMake(37.44, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(38.02, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(38.02, 8.58)];
    [bezier5Path addLineToPoint:CGPointMake(37.69, 8.58)];
    [bezier5Path addCurveToPoint:CGPointMake(37.42, 8.67) controlPoint1:CGPointMake(37.56, 8.58) controlPoint2:CGPointMake(37.49, 8.6)];
    [bezier5Path addCurveToPoint:CGPointMake(37.32, 9) controlPoint1:CGPointMake(37.36, 8.73) controlPoint2:CGPointMake(37.32, 8.85)];
    [bezier5Path addCurveToPoint:CGPointMake(37.42, 9.34) controlPoint1:CGPointMake(37.32, 9.16) controlPoint2:CGPointMake(37.35, 9.27)];
    [bezier5Path addCurveToPoint:CGPointMake(37.66, 9.42) controlPoint1:CGPointMake(37.47, 9.4) controlPoint2:CGPointMake(37.57, 9.42)];
    [bezier5Path addLineToPoint:CGPointMake(37.82, 9.42)];
    [bezier5Path addLineToPoint:CGPointMake(38.31, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(38.84, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(39.43, 9.66)];
    [bezier5Path addLineToPoint:CGPointMake(39.43, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(39.96, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(40.57, 9.29)];
    [bezier5Path addLineToPoint:CGPointMake(40.57, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(40.93, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(40.93, 9.73)];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(36.79, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(36.43, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(36.43, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(36.79, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(36.79, 9.73)];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(36.23, 8.66)];
    [bezier5Path addCurveToPoint:CGPointMake(35.98, 9.05) controlPoint1:CGPointMake(36.23, 8.89) controlPoint2:CGPointMake(36.07, 9.01)];
    [bezier5Path addCurveToPoint:CGPointMake(36.15, 9.17) controlPoint1:CGPointMake(36.06, 9.08) controlPoint2:CGPointMake(36.12, 9.13)];
    [bezier5Path addCurveToPoint:CGPointMake(36.21, 9.44) controlPoint1:CGPointMake(36.2, 9.24) controlPoint2:CGPointMake(36.21, 9.31)];
    [bezier5Path addLineToPoint:CGPointMake(36.21, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(35.86, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(35.86, 9.55)];
    [bezier5Path addCurveToPoint:CGPointMake(35.8, 9.27) controlPoint1:CGPointMake(35.86, 9.46) controlPoint2:CGPointMake(35.87, 9.34)];
    [bezier5Path addCurveToPoint:CGPointMake(35.55, 9.21) controlPoint1:CGPointMake(35.75, 9.22) controlPoint2:CGPointMake(35.67, 9.21)];
    [bezier5Path addLineToPoint:CGPointMake(35.18, 9.21)];
    [bezier5Path addLineToPoint:CGPointMake(35.18, 9.74)];
    [bezier5Path addLineToPoint:CGPointMake(34.83, 9.74)];
    [bezier5Path addLineToPoint:CGPointMake(34.83, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(35.63, 8.27)];
    [bezier5Path addCurveToPoint:CGPointMake(36.06, 8.34) controlPoint1:CGPointMake(35.81, 8.27) controlPoint2:CGPointMake(35.94, 8.28)];
    [bezier5Path addCurveToPoint:CGPointMake(36.23, 8.66) controlPoint1:CGPointMake(36.16, 8.4) controlPoint2:CGPointMake(36.23, 8.5)];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(34.58, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(33.41, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(33.41, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(34.58, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(34.58, 8.58)];
    [bezier5Path addLineToPoint:CGPointMake(33.76, 8.58)];
    [bezier5Path addLineToPoint:CGPointMake(33.76, 8.84)];
    [bezier5Path addLineToPoint:CGPointMake(34.56, 8.84)];
    [bezier5Path addLineToPoint:CGPointMake(34.56, 9.14)];
    [bezier5Path addLineToPoint:CGPointMake(33.76, 9.14)];
    [bezier5Path addLineToPoint:CGPointMake(33.76, 9.43)];
    [bezier5Path addLineToPoint:CGPointMake(34.58, 9.43)];
    [bezier5Path addLineToPoint:CGPointMake(34.58, 9.73)];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(33.14, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(32.78, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(32.78, 8.58)];
    [bezier5Path addLineToPoint:CGPointMake(32.27, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(31.96, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(31.45, 8.58)];
    [bezier5Path addLineToPoint:CGPointMake(31.45, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(30.74, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(30.61, 9.4)];
    [bezier5Path addLineToPoint:CGPointMake(29.88, 9.4)];
    [bezier5Path addLineToPoint:CGPointMake(29.75, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(29.37, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(30, 8.26)];
    [bezier5Path addLineToPoint:CGPointMake(30.52, 8.26)];
    [bezier5Path addLineToPoint:CGPointMake(31.12, 9.65)];
    [bezier5Path addLineToPoint:CGPointMake(31.12, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(31.69, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(32.15, 9.27)];
    [bezier5Path addLineToPoint:CGPointMake(32.57, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(33.15, 8.27)];
    [bezier5Path addLineToPoint:CGPointMake(33.15, 9.73)];
    [bezier5Path addLineToPoint:CGPointMake(33.14, 9.73)];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(38.8, 9.1)];
    [bezier5Path addLineToPoint:CGPointMake(38.56, 8.52)];
    [bezier5Path addLineToPoint:CGPointMake(38.32, 9.1)];
    [bezier5Path addLineToPoint:CGPointMake(38.8, 9.1)];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(35.77, 8.87)];
    [bezier5Path addCurveToPoint:CGPointMake(35.59, 8.9) controlPoint1:CGPointMake(35.72, 8.9) controlPoint2:CGPointMake(35.66, 8.9)];
    [bezier5Path addLineToPoint:CGPointMake(35.17, 8.9)];
    [bezier5Path addLineToPoint:CGPointMake(35.17, 8.57)];
    [bezier5Path addLineToPoint:CGPointMake(35.6, 8.57)];
    [bezier5Path addCurveToPoint:CGPointMake(35.77, 8.6) controlPoint1:CGPointMake(35.66, 8.57) controlPoint2:CGPointMake(35.72, 8.57)];
    [bezier5Path addCurveToPoint:CGPointMake(35.84, 8.73) controlPoint1:CGPointMake(35.81, 8.62) controlPoint2:CGPointMake(35.84, 8.67)];
    [bezier5Path addCurveToPoint:CGPointMake(35.77, 8.87) controlPoint1:CGPointMake(35.84, 8.79) controlPoint2:CGPointMake(35.81, 8.84)];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(30.49, 9.1)];
    [bezier5Path addLineToPoint:CGPointMake(30.25, 8.52)];
    [bezier5Path addLineToPoint:CGPointMake(30.01, 9.1)];
    [bezier5Path addLineToPoint:CGPointMake(30.49, 9.1)];
    [bezier5Path closePath];
    bezier5Path.miterLimit = 4;

    [fillColor4 setFill];
    [bezier5Path fill];

    //// Bezier 6 Drawing
    UIBezierPath *bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path moveToPoint:CGPointMake(36.15, 11.27)];
    [bezier6Path addCurveToPoint:CGPointMake(35.54, 11.76) controlPoint1:CGPointMake(36.15, 11.68) controlPoint2:CGPointMake(35.85, 11.76)];
    [bezier6Path addLineToPoint:CGPointMake(35.1, 11.76)];
    [bezier6Path addLineToPoint:CGPointMake(35.1, 12.25)];
    [bezier6Path addLineToPoint:CGPointMake(34.42, 12.25)];
    [bezier6Path addLineToPoint:CGPointMake(33.99, 11.77)];
    [bezier6Path addLineToPoint:CGPointMake(33.54, 12.25)];
    [bezier6Path addLineToPoint:CGPointMake(32.15, 12.25)];
    [bezier6Path addLineToPoint:CGPointMake(32.15, 10.78)];
    [bezier6Path addLineToPoint:CGPointMake(33.56, 10.78)];
    [bezier6Path addLineToPoint:CGPointMake(34, 11.27)];
    [bezier6Path addLineToPoint:CGPointMake(34.44, 10.79)];
    [bezier6Path addLineToPoint:CGPointMake(35.56, 10.79)];
    [bezier6Path addCurveToPoint:CGPointMake(36.15, 11.27) controlPoint1:CGPointMake(35.84, 10.79) controlPoint2:CGPointMake(36.15, 10.87)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(33.37, 11.95)];
    [bezier6Path addLineToPoint:CGPointMake(32.51, 11.95)];
    [bezier6Path addLineToPoint:CGPointMake(32.51, 11.66)];
    [bezier6Path addLineToPoint:CGPointMake(33.28, 11.66)];
    [bezier6Path addLineToPoint:CGPointMake(33.28, 11.36)];
    [bezier6Path addLineToPoint:CGPointMake(32.51, 11.36)];
    [bezier6Path addLineToPoint:CGPointMake(32.51, 11.09)];
    [bezier6Path addLineToPoint:CGPointMake(33.39, 11.09)];
    [bezier6Path addLineToPoint:CGPointMake(33.77, 11.52)];
    [bezier6Path addLineToPoint:CGPointMake(33.37, 11.95)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(34.76, 12.12)];
    [bezier6Path addLineToPoint:CGPointMake(34.22, 11.52)];
    [bezier6Path addLineToPoint:CGPointMake(34.76, 10.94)];
    [bezier6Path addLineToPoint:CGPointMake(34.76, 12.12)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(35.56, 11.47)];
    [bezier6Path addLineToPoint:CGPointMake(35.1, 11.47)];
    [bezier6Path addLineToPoint:CGPointMake(35.1, 11.1)];
    [bezier6Path addLineToPoint:CGPointMake(35.56, 11.1)];
    [bezier6Path addCurveToPoint:CGPointMake(35.77, 11.28) controlPoint1:CGPointMake(35.69, 11.1) controlPoint2:CGPointMake(35.77, 11.15)];
    [bezier6Path addCurveToPoint:CGPointMake(35.56, 11.47) controlPoint1:CGPointMake(35.78, 11.4) controlPoint2:CGPointMake(35.69, 11.47)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(37.92, 10.79)];
    [bezier6Path addLineToPoint:CGPointMake(39.09, 10.79)];
    [bezier6Path addLineToPoint:CGPointMake(39.09, 11.09)];
    [bezier6Path addLineToPoint:CGPointMake(38.27, 11.09)];
    [bezier6Path addLineToPoint:CGPointMake(38.27, 11.36)];
    [bezier6Path addLineToPoint:CGPointMake(39.07, 11.36)];
    [bezier6Path addLineToPoint:CGPointMake(39.07, 11.66)];
    [bezier6Path addLineToPoint:CGPointMake(38.27, 11.66)];
    [bezier6Path addLineToPoint:CGPointMake(38.27, 11.95)];
    [bezier6Path addLineToPoint:CGPointMake(39.09, 11.95)];
    [bezier6Path addLineToPoint:CGPointMake(39.09, 12.25)];
    [bezier6Path addLineToPoint:CGPointMake(37.92, 12.25)];
    [bezier6Path addLineToPoint:CGPointMake(37.92, 10.79)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(37.48, 11.58)];
    [bezier6Path addCurveToPoint:CGPointMake(37.65, 11.7) controlPoint1:CGPointMake(37.56, 11.61) controlPoint2:CGPointMake(37.62, 11.66)];
    [bezier6Path addCurveToPoint:CGPointMake(37.71, 11.97) controlPoint1:CGPointMake(37.7, 11.77) controlPoint2:CGPointMake(37.71, 11.84)];
    [bezier6Path addLineToPoint:CGPointMake(37.71, 12.26)];
    [bezier6Path addLineToPoint:CGPointMake(37.36, 12.26)];
    [bezier6Path addLineToPoint:CGPointMake(37.36, 12.08)];
    [bezier6Path addCurveToPoint:CGPointMake(37.3, 11.79) controlPoint1:CGPointMake(37.36, 11.99) controlPoint2:CGPointMake(37.37, 11.86)];
    [bezier6Path addCurveToPoint:CGPointMake(37.05, 11.72) controlPoint1:CGPointMake(37.25, 11.74) controlPoint2:CGPointMake(37.17, 11.72)];
    [bezier6Path addLineToPoint:CGPointMake(36.67, 11.72)];
    [bezier6Path addLineToPoint:CGPointMake(36.67, 12.26)];
    [bezier6Path addLineToPoint:CGPointMake(36.32, 12.26)];
    [bezier6Path addLineToPoint:CGPointMake(36.32, 10.79)];
    [bezier6Path addLineToPoint:CGPointMake(37.13, 10.79)];
    [bezier6Path addCurveToPoint:CGPointMake(37.56, 10.86) controlPoint1:CGPointMake(37.31, 10.79) controlPoint2:CGPointMake(37.44, 10.8)];
    [bezier6Path addCurveToPoint:CGPointMake(37.74, 11.19) controlPoint1:CGPointMake(37.67, 10.93) controlPoint2:CGPointMake(37.74, 11.02)];
    [bezier6Path addCurveToPoint:CGPointMake(37.48, 11.58) controlPoint1:CGPointMake(37.73, 11.42) controlPoint2:CGPointMake(37.57, 11.54)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(37.27, 11.39)];
    [bezier6Path addCurveToPoint:CGPointMake(37.1, 11.42) controlPoint1:CGPointMake(37.22, 11.42) controlPoint2:CGPointMake(37.16, 11.42)];
    [bezier6Path addLineToPoint:CGPointMake(36.67, 11.42)];
    [bezier6Path addLineToPoint:CGPointMake(36.67, 11.09)];
    [bezier6Path addLineToPoint:CGPointMake(37.1, 11.09)];
    [bezier6Path addCurveToPoint:CGPointMake(37.27, 11.12) controlPoint1:CGPointMake(37.16, 11.09) controlPoint2:CGPointMake(37.22, 11.09)];
    [bezier6Path addCurveToPoint:CGPointMake(37.34, 11.25) controlPoint1:CGPointMake(37.31, 11.14) controlPoint2:CGPointMake(37.34, 11.19)];
    [bezier6Path addCurveToPoint:CGPointMake(37.27, 11.39) controlPoint1:CGPointMake(37.34, 11.31) controlPoint2:CGPointMake(37.31, 11.37)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(40.43, 11.48)];
    [bezier6Path addCurveToPoint:CGPointMake(40.54, 11.79) controlPoint1:CGPointMake(40.5, 11.55) controlPoint2:CGPointMake(40.54, 11.64)];
    [bezier6Path addCurveToPoint:CGPointMake(39.99, 12.25) controlPoint1:CGPointMake(40.54, 12.11) controlPoint2:CGPointMake(40.34, 12.25)];
    [bezier6Path addLineToPoint:CGPointMake(39.3, 12.25)];
    [bezier6Path addLineToPoint:CGPointMake(39.3, 11.93)];
    [bezier6Path addLineToPoint:CGPointMake(39.98, 11.93)];
    [bezier6Path addCurveToPoint:CGPointMake(40.12, 11.89) controlPoint1:CGPointMake(40.04, 11.93) controlPoint2:CGPointMake(40.09, 11.92)];
    [bezier6Path addCurveToPoint:CGPointMake(40.16, 11.8) controlPoint1:CGPointMake(40.14, 11.87) controlPoint2:CGPointMake(40.16, 11.84)];
    [bezier6Path addCurveToPoint:CGPointMake(40.12, 11.7) controlPoint1:CGPointMake(40.16, 11.76) controlPoint2:CGPointMake(40.14, 11.72)];
    [bezier6Path addCurveToPoint:CGPointMake(39.99, 11.66) controlPoint1:CGPointMake(40.09, 11.68) controlPoint2:CGPointMake(40.06, 11.67)];
    [bezier6Path addCurveToPoint:CGPointMake(39.25, 11.21) controlPoint1:CGPointMake(39.66, 11.65) controlPoint2:CGPointMake(39.25, 11.67)];
    [bezier6Path addCurveToPoint:CGPointMake(39.75, 10.77) controlPoint1:CGPointMake(39.25, 11) controlPoint2:CGPointMake(39.38, 10.77)];
    [bezier6Path addLineToPoint:CGPointMake(40.45, 10.77)];
    [bezier6Path addLineToPoint:CGPointMake(40.45, 11.08)];
    [bezier6Path addLineToPoint:CGPointMake(39.8, 11.08)];
    [bezier6Path addCurveToPoint:CGPointMake(39.66, 11.11) controlPoint1:CGPointMake(39.74, 11.08) controlPoint2:CGPointMake(39.69, 11.08)];
    [bezier6Path addCurveToPoint:CGPointMake(39.61, 11.22) controlPoint1:CGPointMake(39.62, 11.13) controlPoint2:CGPointMake(39.61, 11.17)];
    [bezier6Path addCurveToPoint:CGPointMake(39.68, 11.33) controlPoint1:CGPointMake(39.61, 11.27) controlPoint2:CGPointMake(39.64, 11.31)];
    [bezier6Path addCurveToPoint:CGPointMake(39.82, 11.35) controlPoint1:CGPointMake(39.72, 11.34) controlPoint2:CGPointMake(39.76, 11.35)];
    [bezier6Path addLineToPoint:CGPointMake(40.01, 11.35)];
    [bezier6Path addCurveToPoint:CGPointMake(40.43, 11.48) controlPoint1:CGPointMake(40.22, 11.37) controlPoint2:CGPointMake(40.35, 11.4)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(41.83, 12.07)];
    [bezier6Path addCurveToPoint:CGPointMake(41.36, 12.26) controlPoint1:CGPointMake(41.74, 12.19) controlPoint2:CGPointMake(41.58, 12.26)];
    [bezier6Path addLineToPoint:CGPointMake(40.68, 12.26)];
    [bezier6Path addLineToPoint:CGPointMake(40.68, 11.94)];
    [bezier6Path addLineToPoint:CGPointMake(41.35, 11.94)];
    [bezier6Path addCurveToPoint:CGPointMake(41.5, 11.9) controlPoint1:CGPointMake(41.42, 11.94) controlPoint2:CGPointMake(41.47, 11.93)];
    [bezier6Path addCurveToPoint:CGPointMake(41.54, 11.81) controlPoint1:CGPointMake(41.52, 11.88) controlPoint2:CGPointMake(41.54, 11.85)];
    [bezier6Path addCurveToPoint:CGPointMake(41.5, 11.71) controlPoint1:CGPointMake(41.54, 11.77) controlPoint2:CGPointMake(41.52, 11.73)];
    [bezier6Path addCurveToPoint:CGPointMake(41.38, 11.67) controlPoint1:CGPointMake(41.47, 11.69) controlPoint2:CGPointMake(41.44, 11.68)];
    [bezier6Path addCurveToPoint:CGPointMake(40.64, 11.22) controlPoint1:CGPointMake(41.05, 11.66) controlPoint2:CGPointMake(40.64, 11.68)];
    [bezier6Path addCurveToPoint:CGPointMake(41.14, 10.78) controlPoint1:CGPointMake(40.64, 11.01) controlPoint2:CGPointMake(40.77, 10.78)];
    [bezier6Path addLineToPoint:CGPointMake(41.84, 10.78)];
    [bezier6Path addLineToPoint:CGPointMake(41.84, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(41.19, 10.5)];
    [bezier6Path addCurveToPoint:CGPointMake(40.75, 10.62) controlPoint1:CGPointMake(40.99, 10.5) controlPoint2:CGPointMake(40.85, 10.55)];
    [bezier6Path addLineToPoint:CGPointMake(40.75, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(39.79, 10.5)];
    [bezier6Path addCurveToPoint:CGPointMake(39.37, 10.62) controlPoint1:CGPointMake(39.64, 10.5) controlPoint2:CGPointMake(39.46, 10.54)];
    [bezier6Path addLineToPoint:CGPointMake(39.37, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(37.66, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(37.66, 10.62)];
    [bezier6Path addCurveToPoint:CGPointMake(37.19, 10.5) controlPoint1:CGPointMake(37.52, 10.52) controlPoint2:CGPointMake(37.3, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(36.06, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(36.06, 10.62)];
    [bezier6Path addCurveToPoint:CGPointMake(35.56, 10.5) controlPoint1:CGPointMake(35.95, 10.52) controlPoint2:CGPointMake(35.71, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(34.3, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(34, 10.81)];
    [bezier6Path addLineToPoint:CGPointMake(33.73, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(31.84, 10.5)];
    [bezier6Path addLineToPoint:CGPointMake(31.84, 12.55)];
    [bezier6Path addLineToPoint:CGPointMake(33.69, 12.55)];
    [bezier6Path addLineToPoint:CGPointMake(33.99, 12.23)];
    [bezier6Path addLineToPoint:CGPointMake(34.27, 12.55)];
    [bezier6Path addLineToPoint:CGPointMake(35.41, 12.55)];
    [bezier6Path addLineToPoint:CGPointMake(35.41, 12.07)];
    [bezier6Path addLineToPoint:CGPointMake(35.52, 12.07)];
    [bezier6Path addCurveToPoint:CGPointMake(36.01, 12) controlPoint1:CGPointMake(35.67, 12.07) controlPoint2:CGPointMake(35.85, 12.07)];
    [bezier6Path addLineToPoint:CGPointMake(36.01, 12.55)];
    [bezier6Path addLineToPoint:CGPointMake(36.95, 12.55)];
    [bezier6Path addLineToPoint:CGPointMake(36.95, 12.02)];
    [bezier6Path addLineToPoint:CGPointMake(37, 12.02)];
    [bezier6Path addCurveToPoint:CGPointMake(37.06, 12.08) controlPoint1:CGPointMake(37.06, 12.02) controlPoint2:CGPointMake(37.06, 12.02)];
    [bezier6Path addLineToPoint:CGPointMake(37.06, 12.55)];
    [bezier6Path addLineToPoint:CGPointMake(39.92, 12.55)];
    [bezier6Path addCurveToPoint:CGPointMake(40.4, 12.42) controlPoint1:CGPointMake(40.1, 12.55) controlPoint2:CGPointMake(40.29, 12.5)];
    [bezier6Path addLineToPoint:CGPointMake(40.4, 12.55)];
    [bezier6Path addLineToPoint:CGPointMake(41.31, 12.55)];
    [bezier6Path addCurveToPoint:CGPointMake(41.83, 12.45) controlPoint1:CGPointMake(41.5, 12.55) controlPoint2:CGPointMake(41.69, 12.52)];
    [bezier6Path addLineToPoint:CGPointMake(41.83, 12.07)];
    [bezier6Path closePath];
    [bezier6Path moveToPoint:CGPointMake(41.83, 11.1)];
    [bezier6Path addLineToPoint:CGPointMake(41.19, 11.1)];
    [bezier6Path addCurveToPoint:CGPointMake(41.05, 11.13) controlPoint1:CGPointMake(41.12, 11.1) controlPoint2:CGPointMake(41.08, 11.1)];
    [bezier6Path addCurveToPoint:CGPointMake(41, 11.24) controlPoint1:CGPointMake(41.01, 11.15) controlPoint2:CGPointMake(41, 11.19)];
    [bezier6Path addCurveToPoint:CGPointMake(41.08, 11.35) controlPoint1:CGPointMake(41, 11.29) controlPoint2:CGPointMake(41.03, 11.33)];
    [bezier6Path addCurveToPoint:CGPointMake(41.21, 11.37) controlPoint1:CGPointMake(41.11, 11.36) controlPoint2:CGPointMake(41.15, 11.37)];
    [bezier6Path addLineToPoint:CGPointMake(41.4, 11.37)];
    [bezier6Path addCurveToPoint:CGPointMake(41.8, 11.49) controlPoint1:CGPointMake(41.6, 11.38) controlPoint2:CGPointMake(41.72, 11.41)];
    [bezier6Path addCurveToPoint:CGPointMake(41.83, 11.53) controlPoint1:CGPointMake(41.81, 11.5) controlPoint2:CGPointMake(41.82, 11.51)];
    [bezier6Path addLineToPoint:CGPointMake(41.83, 11.1)];
    [bezier6Path closePath];
    bezier6Path.miterLimit = 4;

    [fillColor4 setFill];
    [bezier6Path fill];
}
}

//// Bezier 7 Drawing
UIBezierPath *bezier7Path = [UIBezierPath bezierPath];
[bezier7Path moveToPoint:CGPointMake(4.71, 16.18)];
[bezier7Path addCurveToPoint:CGPointMake(4.04, 15.51) controlPoint1:CGPointMake(4.34, 16.18) controlPoint2:CGPointMake(4.04, 15.88)];
[bezier7Path addLineToPoint:CGPointMake(4.04, 12.21)];
[bezier7Path addCurveToPoint:CGPointMake(4.71, 11.54) controlPoint1:CGPointMake(4.04, 11.84) controlPoint2:CGPointMake(4.34, 11.54)];
[bezier7Path addLineToPoint:CGPointMake(10.29, 11.54)];
[bezier7Path addCurveToPoint:CGPointMake(10.96, 12.21) controlPoint1:CGPointMake(10.66, 11.54) controlPoint2:CGPointMake(10.96, 11.84)];
[bezier7Path addLineToPoint:CGPointMake(10.96, 15.51)];
[bezier7Path addCurveToPoint:CGPointMake(10.29, 16.18) controlPoint1:CGPointMake(10.96, 15.88) controlPoint2:CGPointMake(10.66, 16.18)];
[bezier7Path addLineToPoint:CGPointMake(4.71, 16.18)];
[bezier7Path closePath];
[bezier7Path moveToPoint:CGPointMake(4.71, 11.89)];
[bezier7Path addCurveToPoint:CGPointMake(4.39, 12.21) controlPoint1:CGPointMake(4.53, 11.89) controlPoint2:CGPointMake(4.39, 12.04)];
[bezier7Path addLineToPoint:CGPointMake(4.39, 15.51)];
[bezier7Path addCurveToPoint:CGPointMake(4.71, 15.83) controlPoint1:CGPointMake(4.39, 15.69) controlPoint2:CGPointMake(4.54, 15.83)];
[bezier7Path addLineToPoint:CGPointMake(10.29, 15.83)];
[bezier7Path addCurveToPoint:CGPointMake(10.61, 15.51) controlPoint1:CGPointMake(10.47, 15.83) controlPoint2:CGPointMake(10.61, 15.68)];
[bezier7Path addLineToPoint:CGPointMake(10.61, 12.21)];
[bezier7Path addCurveToPoint:CGPointMake(10.29, 11.89) controlPoint1:CGPointMake(10.61, 12.03) controlPoint2:CGPointMake(10.47, 11.89)];
[bezier7Path addLineToPoint:CGPointMake(4.71, 11.89)];
[bezier7Path closePath];
bezier7Path.miterLimit = 4;

[fillColor setFill];
[bezier7Path fill];

//// Group 11
{
    //// Group 12
    {
        //// Group 13
        {
            //// Bezier 8 Drawing
            UIBezierPath *bezier8Path = [UIBezierPath bezierPath];
            [bezier8Path moveToPoint:CGPointMake(9.04, 23.82)];
            [bezier8Path addCurveToPoint:CGPointMake(9, 24.11) controlPoint1:CGPointMake(9.04, 23.94) controlPoint2:CGPointMake(9.03, 24.03)];
            [bezier8Path addCurveToPoint:CGPointMake(8.87, 24.3) controlPoint1:CGPointMake(8.98, 24.19) controlPoint2:CGPointMake(8.93, 24.25)];
            [bezier8Path addCurveToPoint:CGPointMake(8.62, 24.4) controlPoint1:CGPointMake(8.81, 24.35) controlPoint2:CGPointMake(8.73, 24.38)];
            [bezier8Path addCurveToPoint:CGPointMake(8.22, 24.43) controlPoint1:CGPointMake(8.51, 24.42) controlPoint2:CGPointMake(8.38, 24.43)];
            [bezier8Path addLineToPoint:CGPointMake(8.2, 24.43)];
            [bezier8Path addCurveToPoint:CGPointMake(8.07, 24.43) controlPoint1:CGPointMake(8.16, 24.43) controlPoint2:CGPointMake(8.11, 24.43)];
            [bezier8Path addCurveToPoint:CGPointMake(7.92, 24.42) controlPoint1:CGPointMake(8.02, 24.43) controlPoint2:CGPointMake(7.97, 24.43)];
            [bezier8Path addCurveToPoint:CGPointMake(7.78, 24.39) controlPoint1:CGPointMake(7.87, 24.41) controlPoint2:CGPointMake(7.82, 24.41)];
            [bezier8Path addCurveToPoint:CGPointMake(7.65, 24.34) controlPoint1:CGPointMake(7.73, 24.38) controlPoint2:CGPointMake(7.69, 24.36)];
            [bezier8Path addCurveToPoint:CGPointMake(7.56, 24.26) controlPoint1:CGPointMake(7.61, 24.32) controlPoint2:CGPointMake(7.58, 24.29)];
            [bezier8Path addCurveToPoint:CGPointMake(7.52, 24.15) controlPoint1:CGPointMake(7.54, 24.23) controlPoint2:CGPointMake(7.52, 24.19)];
            [bezier8Path addLineToPoint:CGPointMake(7.52, 24.14)];
            [bezier8Path addCurveToPoint:CGPointMake(7.57, 24.02) controlPoint1:CGPointMake(7.52, 24.09) controlPoint2:CGPointMake(7.54, 24.05)];
            [bezier8Path addCurveToPoint:CGPointMake(7.69, 23.98) controlPoint1:CGPointMake(7.61, 23.99) controlPoint2:CGPointMake(7.65, 23.98)];
            [bezier8Path addLineToPoint:CGPointMake(7.69, 23.98)];
            [bezier8Path addCurveToPoint:CGPointMake(7.75, 23.98) controlPoint1:CGPointMake(7.72, 23.98) controlPoint2:CGPointMake(7.74, 23.98)];
            [bezier8Path addCurveToPoint:CGPointMake(7.8, 24.01) controlPoint1:CGPointMake(7.78, 24) controlPoint2:CGPointMake(7.79, 24)];
            [bezier8Path addCurveToPoint:CGPointMake(7.83, 24.03) controlPoint1:CGPointMake(7.81, 24.02) controlPoint2:CGPointMake(7.82, 24.02)];
            [bezier8Path addCurveToPoint:CGPointMake(7.86, 24.05) controlPoint1:CGPointMake(7.84, 24.04) controlPoint2:CGPointMake(7.85, 24.04)];
            [bezier8Path addLineToPoint:CGPointMake(7.86, 24.05)];
            [bezier8Path addCurveToPoint:CGPointMake(7.9, 24.08) controlPoint1:CGPointMake(7.88, 24.06) controlPoint2:CGPointMake(7.89, 24.07)];
            [bezier8Path addCurveToPoint:CGPointMake(7.96, 24.1) controlPoint1:CGPointMake(7.91, 24.09) controlPoint2:CGPointMake(7.94, 24.09)];
            [bezier8Path addCurveToPoint:CGPointMake(8.06, 24.12) controlPoint1:CGPointMake(7.99, 24.11) controlPoint2:CGPointMake(8.02, 24.11)];
            [bezier8Path addCurveToPoint:CGPointMake(8.23, 24.12) controlPoint1:CGPointMake(8.1, 24.12) controlPoint2:CGPointMake(8.16, 24.12)];
            [bezier8Path addLineToPoint:CGPointMake(8.26, 24.12)];
            [bezier8Path addCurveToPoint:CGPointMake(8.45, 24.1) controlPoint1:CGPointMake(8.34, 24.12) controlPoint2:CGPointMake(8.4, 24.12)];
            [bezier8Path addCurveToPoint:CGPointMake(8.57, 24.05) controlPoint1:CGPointMake(8.5, 24.09) controlPoint2:CGPointMake(8.54, 24.07)];
            [bezier8Path addCurveToPoint:CGPointMake(8.63, 23.96) controlPoint1:CGPointMake(8.6, 24.03) controlPoint2:CGPointMake(8.62, 23.99)];
            [bezier8Path addCurveToPoint:CGPointMake(8.65, 23.83) controlPoint1:CGPointMake(8.64, 23.92) controlPoint2:CGPointMake(8.65, 23.88)];
            [bezier8Path addCurveToPoint:CGPointMake(8.61, 23.64) controlPoint1:CGPointMake(8.65, 23.74) controlPoint2:CGPointMake(8.64, 23.67)];
            [bezier8Path addCurveToPoint:CGPointMake(8.48, 23.58) controlPoint1:CGPointMake(8.59, 23.61) controlPoint2:CGPointMake(8.55, 23.58)];
            [bezier8Path addLineToPoint:CGPointMake(8.06, 23.58)];
            [bezier8Path addCurveToPoint:CGPointMake(7.99, 23.57) controlPoint1:CGPointMake(8.04, 23.58) controlPoint2:CGPointMake(8.01, 23.58)];
            [bezier8Path addCurveToPoint:CGPointMake(7.93, 23.55) controlPoint1:CGPointMake(7.97, 23.57) controlPoint2:CGPointMake(7.95, 23.56)];
            [bezier8Path addCurveToPoint:CGPointMake(7.89, 23.5) controlPoint1:CGPointMake(7.91, 23.54) controlPoint2:CGPointMake(7.9, 23.52)];
            [bezier8Path addCurveToPoint:CGPointMake(7.87, 23.42) controlPoint1:CGPointMake(7.88, 23.48) controlPoint2:CGPointMake(7.87, 23.45)];
            [bezier8Path addCurveToPoint:CGPointMake(7.93, 23.29) controlPoint1:CGPointMake(7.87, 23.36) controlPoint2:CGPointMake(7.89, 23.32)];
            [bezier8Path addCurveToPoint:CGPointMake(8.06, 23.25) controlPoint1:CGPointMake(7.97, 23.27) controlPoint2:CGPointMake(8.02, 23.25)];
            [bezier8Path addLineToPoint:CGPointMake(8.46, 23.25)];
            [bezier8Path addCurveToPoint:CGPointMake(8.54, 23.24) controlPoint1:CGPointMake(8.49, 23.25) controlPoint2:CGPointMake(8.52, 23.25)];
            [bezier8Path addCurveToPoint:CGPointMake(8.6, 23.2) controlPoint1:CGPointMake(8.56, 23.23) controlPoint2:CGPointMake(8.58, 23.22)];
            [bezier8Path addCurveToPoint:CGPointMake(8.63, 23.13) controlPoint1:CGPointMake(8.61, 23.18) controlPoint2:CGPointMake(8.63, 23.16)];
            [bezier8Path addCurveToPoint:CGPointMake(8.64, 23.01) controlPoint1:CGPointMake(8.64, 23.1) controlPoint2:CGPointMake(8.64, 23.06)];
            [bezier8Path addCurveToPoint:CGPointMake(8.63, 22.88) controlPoint1:CGPointMake(8.64, 22.96) controlPoint2:CGPointMake(8.64, 22.91)];
            [bezier8Path addCurveToPoint:CGPointMake(8.58, 22.79) controlPoint1:CGPointMake(8.63, 22.84) controlPoint2:CGPointMake(8.61, 22.81)];
            [bezier8Path addCurveToPoint:CGPointMake(8.47, 22.74) controlPoint1:CGPointMake(8.55, 22.77) controlPoint2:CGPointMake(8.52, 22.75)];
            [bezier8Path addCurveToPoint:CGPointMake(8.27, 22.73) controlPoint1:CGPointMake(8.42, 22.73) controlPoint2:CGPointMake(8.35, 22.73)];
            [bezier8Path addLineToPoint:CGPointMake(8.26, 22.73)];
            [bezier8Path addCurveToPoint:CGPointMake(8.09, 22.74) controlPoint1:CGPointMake(8.21, 22.73) controlPoint2:CGPointMake(8.15, 22.73)];
            [bezier8Path addCurveToPoint:CGPointMake(7.95, 22.78) controlPoint1:CGPointMake(8.03, 22.75) controlPoint2:CGPointMake(7.99, 22.76)];
            [bezier8Path addCurveToPoint:CGPointMake(7.9, 22.8) controlPoint1:CGPointMake(7.93, 22.79) controlPoint2:CGPointMake(7.92, 22.8)];
            [bezier8Path addCurveToPoint:CGPointMake(7.86, 22.82) controlPoint1:CGPointMake(7.89, 22.81) controlPoint2:CGPointMake(7.87, 22.82)];
            [bezier8Path addCurveToPoint:CGPointMake(7.81, 22.83) controlPoint1:CGPointMake(7.85, 22.83) controlPoint2:CGPointMake(7.83, 22.83)];
            [bezier8Path addCurveToPoint:CGPointMake(7.75, 22.83) controlPoint1:CGPointMake(7.79, 22.83) controlPoint2:CGPointMake(7.78, 22.83)];
            [bezier8Path addLineToPoint:CGPointMake(7.75, 22.83)];
            [bezier8Path addCurveToPoint:CGPointMake(7.63, 22.79) controlPoint1:CGPointMake(7.7, 22.83) controlPoint2:CGPointMake(7.66, 22.81)];
            [bezier8Path addCurveToPoint:CGPointMake(7.58, 22.68) controlPoint1:CGPointMake(7.59, 22.76) controlPoint2:CGPointMake(7.58, 22.72)];
            [bezier8Path addLineToPoint:CGPointMake(7.58, 22.68)];
            [bezier8Path addCurveToPoint:CGPointMake(7.62, 22.56) controlPoint1:CGPointMake(7.58, 22.63) controlPoint2:CGPointMake(7.6, 22.59)];
            [bezier8Path addCurveToPoint:CGPointMake(7.74, 22.47) controlPoint1:CGPointMake(7.65, 22.52) controlPoint2:CGPointMake(7.69, 22.5)];
            [bezier8Path addCurveToPoint:CGPointMake(7.94, 22.41) controlPoint1:CGPointMake(7.79, 22.45) controlPoint2:CGPointMake(7.86, 22.43)];
            [bezier8Path addCurveToPoint:CGPointMake(8.25, 22.39) controlPoint1:CGPointMake(8.02, 22.4) controlPoint2:CGPointMake(8.13, 22.39)];
            [bezier8Path addCurveToPoint:CGPointMake(8.62, 22.41) controlPoint1:CGPointMake(8.39, 22.39) controlPoint2:CGPointMake(8.52, 22.4)];
            [bezier8Path addCurveToPoint:CGPointMake(8.86, 22.49) controlPoint1:CGPointMake(8.72, 22.42) controlPoint2:CGPointMake(8.8, 22.45)];
            [bezier8Path addCurveToPoint:CGPointMake(8.99, 22.66) controlPoint1:CGPointMake(8.92, 22.53) controlPoint2:CGPointMake(8.97, 22.59)];
            [bezier8Path addCurveToPoint:CGPointMake(9.03, 22.94) controlPoint1:CGPointMake(9.02, 22.74) controlPoint2:CGPointMake(9.03, 22.83)];
            [bezier8Path addCurveToPoint:CGPointMake(9.02, 23.1) controlPoint1:CGPointMake(9.03, 23) controlPoint2:CGPointMake(9.03, 23.05)];
            [bezier8Path addCurveToPoint:CGPointMake(9, 23.22) controlPoint1:CGPointMake(9.01, 23.14) controlPoint2:CGPointMake(9.01, 23.18)];
            [bezier8Path addCurveToPoint:CGPointMake(8.97, 23.32) controlPoint1:CGPointMake(9, 23.27) controlPoint2:CGPointMake(8.98, 23.3)];
            [bezier8Path addCurveToPoint:CGPointMake(8.92, 23.39) controlPoint1:CGPointMake(8.96, 23.35) controlPoint2:CGPointMake(8.94, 23.37)];
            [bezier8Path addCurveToPoint:CGPointMake(8.96, 23.44) controlPoint1:CGPointMake(8.94, 23.4) controlPoint2:CGPointMake(8.95, 23.42)];
            [bezier8Path addCurveToPoint:CGPointMake(9, 23.52) controlPoint1:CGPointMake(8.97, 23.46) controlPoint2:CGPointMake(8.99, 23.49)];
            [bezier8Path addCurveToPoint:CGPointMake(9.03, 23.64) controlPoint1:CGPointMake(9.01, 23.55) controlPoint2:CGPointMake(9.02, 23.59)];
            [bezier8Path addCurveToPoint:CGPointMake(9.04, 23.82) controlPoint1:CGPointMake(9.04, 23.69) controlPoint2:CGPointMake(9.04, 23.75)];
            [bezier8Path closePath];
            bezier8Path.miterLimit = 4;

            [fillColor setFill];
            [bezier8Path fill];

            //// Bezier 9 Drawing
            UIBezierPath *bezier9Path = [UIBezierPath bezierPath];
            [bezier9Path moveToPoint:CGPointMake(11.23, 23.88)];
            [bezier9Path addLineToPoint:CGPointMake(11.23, 23.88)];
            [bezier9Path addCurveToPoint:CGPointMake(11.18, 24.14) controlPoint1:CGPointMake(11.23, 23.99) controlPoint2:CGPointMake(11.22, 24.07)];
            [bezier9Path addCurveToPoint:CGPointMake(11.02, 24.31) controlPoint1:CGPointMake(11.14, 24.21) controlPoint2:CGPointMake(11.09, 24.27)];
            [bezier9Path addCurveToPoint:CGPointMake(10.78, 24.4) controlPoint1:CGPointMake(10.95, 24.35) controlPoint2:CGPointMake(10.87, 24.38)];
            [bezier9Path addCurveToPoint:CGPointMake(10.47, 24.43) controlPoint1:CGPointMake(10.69, 24.42) controlPoint2:CGPointMake(10.58, 24.43)];
            [bezier9Path addCurveToPoint:CGPointMake(10.15, 24.4) controlPoint1:CGPointMake(10.35, 24.43) controlPoint2:CGPointMake(10.25, 24.42)];
            [bezier9Path addCurveToPoint:CGPointMake(9.92, 24.31) controlPoint1:CGPointMake(10.06, 24.38) controlPoint2:CGPointMake(9.98, 24.35)];
            [bezier9Path addCurveToPoint:CGPointMake(9.77, 24.14) controlPoint1:CGPointMake(9.86, 24.27) controlPoint2:CGPointMake(9.81, 24.21)];
            [bezier9Path addCurveToPoint:CGPointMake(9.72, 23.9) controlPoint1:CGPointMake(9.73, 24.07) controlPoint2:CGPointMake(9.72, 23.99)];
            [bezier9Path addLineToPoint:CGPointMake(9.72, 22.93)];
            [bezier9Path addCurveToPoint:CGPointMake(9.92, 22.54) controlPoint1:CGPointMake(9.72, 22.76) controlPoint2:CGPointMake(9.79, 22.63)];
            [bezier9Path addCurveToPoint:CGPointMake(10.48, 22.41) controlPoint1:CGPointMake(10.05, 22.46) controlPoint2:CGPointMake(10.24, 22.41)];
            [bezier9Path addCurveToPoint:CGPointMake(10.79, 22.44) controlPoint1:CGPointMake(10.59, 22.41) controlPoint2:CGPointMake(10.69, 22.42)];
            [bezier9Path addCurveToPoint:CGPointMake(11.02, 22.54) controlPoint1:CGPointMake(10.88, 22.46) controlPoint2:CGPointMake(10.96, 22.5)];
            [bezier9Path addCurveToPoint:CGPointMake(11.17, 22.71) controlPoint1:CGPointMake(11.08, 22.58) controlPoint2:CGPointMake(11.14, 22.64)];
            [bezier9Path addCurveToPoint:CGPointMake(11.22, 22.94) controlPoint1:CGPointMake(11.2, 22.78) controlPoint2:CGPointMake(11.22, 22.85)];
            [bezier9Path addLineToPoint:CGPointMake(11.22, 23.88)];
            [bezier9Path addLineToPoint:CGPointMake(11.23, 23.88)];
            [bezier9Path closePath];
            [bezier9Path moveToPoint:CGPointMake(10.84, 22.95)];
            [bezier9Path addCurveToPoint:CGPointMake(10.75, 22.78) controlPoint1:CGPointMake(10.84, 22.88) controlPoint2:CGPointMake(10.81, 22.82)];
            [bezier9Path addCurveToPoint:CGPointMake(10.48, 22.72) controlPoint1:CGPointMake(10.69, 22.74) controlPoint2:CGPointMake(10.6, 22.72)];
            [bezier9Path addCurveToPoint:CGPointMake(10.21, 22.78) controlPoint1:CGPointMake(10.36, 22.72) controlPoint2:CGPointMake(10.27, 22.74)];
            [bezier9Path addCurveToPoint:CGPointMake(10.13, 22.94) controlPoint1:CGPointMake(10.15, 22.82) controlPoint2:CGPointMake(10.13, 22.87)];
            [bezier9Path addLineToPoint:CGPointMake(10.13, 23.89)];
            [bezier9Path addCurveToPoint:CGPointMake(10.22, 24.06) controlPoint1:CGPointMake(10.13, 23.97) controlPoint2:CGPointMake(10.16, 24.02)];
            [bezier9Path addCurveToPoint:CGPointMake(10.49, 24.11) controlPoint1:CGPointMake(10.28, 24.09) controlPoint2:CGPointMake(10.37, 24.11)];
            [bezier9Path addCurveToPoint:CGPointMake(10.75, 24.06) controlPoint1:CGPointMake(10.6, 24.11) controlPoint2:CGPointMake(10.69, 24.09)];
            [bezier9Path addCurveToPoint:CGPointMake(10.85, 23.89) controlPoint1:CGPointMake(10.82, 24.03) controlPoint2:CGPointMake(10.85, 23.97)];
            [bezier9Path addLineToPoint:CGPointMake(10.85, 22.95)];
            [bezier9Path addLineToPoint:CGPointMake(10.84, 22.95)];
            [bezier9Path closePath];
            bezier9Path.miterLimit = 4;

            [fillColor setFill];
            [bezier9Path fill];

            //// Bezier 10 Drawing
            UIBezierPath *bezier10Path = [UIBezierPath bezierPath];
            [bezier10Path moveToPoint:CGPointMake(13.1, 23.28)];
            [bezier10Path addCurveToPoint:CGPointMake(13.28, 23.37) controlPoint1:CGPointMake(13.17, 23.3) controlPoint2:CGPointMake(13.23, 23.33)];
            [bezier10Path addCurveToPoint:CGPointMake(13.38, 23.55) controlPoint1:CGPointMake(13.33, 23.41) controlPoint2:CGPointMake(13.36, 23.47)];
            [bezier10Path addCurveToPoint:CGPointMake(13.41, 23.83) controlPoint1:CGPointMake(13.4, 23.62) controlPoint2:CGPointMake(13.41, 23.72)];
            [bezier10Path addCurveToPoint:CGPointMake(13.37, 24.12) controlPoint1:CGPointMake(13.41, 23.95) controlPoint2:CGPointMake(13.4, 24.04)];
            [bezier10Path addCurveToPoint:CGPointMake(13.24, 24.31) controlPoint1:CGPointMake(13.35, 24.2) controlPoint2:CGPointMake(13.3, 24.26)];
            [bezier10Path addCurveToPoint:CGPointMake(12.99, 24.41) controlPoint1:CGPointMake(13.18, 24.35) controlPoint2:CGPointMake(13.1, 24.39)];
            [bezier10Path addCurveToPoint:CGPointMake(12.59, 24.44) controlPoint1:CGPointMake(12.89, 24.43) controlPoint2:CGPointMake(12.75, 24.44)];
            [bezier10Path addLineToPoint:CGPointMake(12.51, 24.44)];
            [bezier10Path addCurveToPoint:CGPointMake(12.31, 24.43) controlPoint1:CGPointMake(12.45, 24.44) controlPoint2:CGPointMake(12.38, 24.44)];
            [bezier10Path addCurveToPoint:CGPointMake(12.11, 24.4) controlPoint1:CGPointMake(12.24, 24.43) controlPoint2:CGPointMake(12.17, 24.41)];
            [bezier10Path addCurveToPoint:CGPointMake(11.95, 24.32) controlPoint1:CGPointMake(12.05, 24.38) controlPoint2:CGPointMake(12, 24.35)];
            [bezier10Path addCurveToPoint:CGPointMake(11.88, 24.17) controlPoint1:CGPointMake(11.91, 24.28) controlPoint2:CGPointMake(11.88, 24.23)];
            [bezier10Path addLineToPoint:CGPointMake(11.88, 24.16)];
            [bezier10Path addCurveToPoint:CGPointMake(11.93, 24.05) controlPoint1:CGPointMake(11.88, 24.11) controlPoint2:CGPointMake(11.9, 24.08)];
            [bezier10Path addCurveToPoint:CGPointMake(12.05, 24) controlPoint1:CGPointMake(11.96, 24.02) controlPoint2:CGPointMake(12.01, 24)];
            [bezier10Path addLineToPoint:CGPointMake(12.06, 24)];
            [bezier10Path addCurveToPoint:CGPointMake(12.15, 24.01) controlPoint1:CGPointMake(12.1, 24) controlPoint2:CGPointMake(12.13, 24.01)];
            [bezier10Path addCurveToPoint:CGPointMake(12.21, 24.03) controlPoint1:CGPointMake(12.18, 24.02) controlPoint2:CGPointMake(12.19, 24.03)];
            [bezier10Path addCurveToPoint:CGPointMake(12.25, 24.06) controlPoint1:CGPointMake(12.22, 24.04) controlPoint2:CGPointMake(12.24, 24.05)];
            [bezier10Path addCurveToPoint:CGPointMake(12.32, 24.09) controlPoint1:CGPointMake(12.27, 24.07) controlPoint2:CGPointMake(12.29, 24.08)];
            [bezier10Path addCurveToPoint:CGPointMake(12.43, 24.11) controlPoint1:CGPointMake(12.35, 24.1) controlPoint2:CGPointMake(12.39, 24.1)];
            [bezier10Path addCurveToPoint:CGPointMake(12.62, 24.12) controlPoint1:CGPointMake(12.48, 24.12) controlPoint2:CGPointMake(12.54, 24.12)];
            [bezier10Path addCurveToPoint:CGPointMake(12.82, 24.1) controlPoint1:CGPointMake(12.7, 24.12) controlPoint2:CGPointMake(12.76, 24.12)];
            [bezier10Path addCurveToPoint:CGPointMake(12.94, 24.05) controlPoint1:CGPointMake(12.87, 24.09) controlPoint2:CGPointMake(12.91, 24.07)];
            [bezier10Path addCurveToPoint:CGPointMake(13, 23.96) controlPoint1:CGPointMake(12.97, 24.03) controlPoint2:CGPointMake(12.99, 23.99)];
            [bezier10Path addCurveToPoint:CGPointMake(13.02, 23.83) controlPoint1:CGPointMake(13.01, 23.92) controlPoint2:CGPointMake(13.02, 23.88)];
            [bezier10Path addCurveToPoint:CGPointMake(12.98, 23.64) controlPoint1:CGPointMake(13.02, 23.74) controlPoint2:CGPointMake(13.01, 23.68)];
            [bezier10Path addCurveToPoint:CGPointMake(12.85, 23.58) controlPoint1:CGPointMake(12.96, 23.6) controlPoint2:CGPointMake(12.92, 23.58)];
            [bezier10Path addLineToPoint:CGPointMake(12.18, 23.58)];
            [bezier10Path addCurveToPoint:CGPointMake(12.04, 23.57) controlPoint1:CGPointMake(12.12, 23.58) controlPoint2:CGPointMake(12.08, 23.58)];
            [bezier10Path addCurveToPoint:CGPointMake(11.96, 23.54) controlPoint1:CGPointMake(12.01, 23.57) controlPoint2:CGPointMake(11.98, 23.55)];
            [bezier10Path addCurveToPoint:CGPointMake(11.92, 23.47) controlPoint1:CGPointMake(11.94, 23.52) controlPoint2:CGPointMake(11.93, 23.5)];
            [bezier10Path addCurveToPoint:CGPointMake(11.91, 23.35) controlPoint1:CGPointMake(11.91, 23.44) controlPoint2:CGPointMake(11.91, 23.4)];
            [bezier10Path addLineToPoint:CGPointMake(11.91, 22.61)];
            [bezier10Path addCurveToPoint:CGPointMake(11.96, 22.48) controlPoint1:CGPointMake(11.91, 22.55) controlPoint2:CGPointMake(11.93, 22.51)];
            [bezier10Path addCurveToPoint:CGPointMake(12.13, 22.44) controlPoint1:CGPointMake(11.99, 22.45) controlPoint2:CGPointMake(12.05, 22.44)];
            [bezier10Path addCurveToPoint:CGPointMake(12.25, 22.44) controlPoint1:CGPointMake(12.15, 22.44) controlPoint2:CGPointMake(12.19, 22.44)];
            [bezier10Path addCurveToPoint:CGPointMake(12.43, 22.44) controlPoint1:CGPointMake(12.3, 22.44) controlPoint2:CGPointMake(12.37, 22.44)];
            [bezier10Path addCurveToPoint:CGPointMake(12.63, 22.44) controlPoint1:CGPointMake(12.49, 22.44) controlPoint2:CGPointMake(12.56, 22.44)];
            [bezier10Path addCurveToPoint:CGPointMake(12.83, 22.44) controlPoint1:CGPointMake(12.7, 22.44) controlPoint2:CGPointMake(12.77, 22.44)];
            [bezier10Path addCurveToPoint:CGPointMake(12.99, 22.44) controlPoint1:CGPointMake(12.89, 22.44) controlPoint2:CGPointMake(12.94, 22.44)];
            [bezier10Path addCurveToPoint:CGPointMake(13.08, 22.44) controlPoint1:CGPointMake(13.03, 22.44) controlPoint2:CGPointMake(13.06, 22.44)];
            [bezier10Path addCurveToPoint:CGPointMake(13.15, 22.45) controlPoint1:CGPointMake(13.1, 22.44) controlPoint2:CGPointMake(13.12, 22.44)];
            [bezier10Path addCurveToPoint:CGPointMake(13.22, 22.47) controlPoint1:CGPointMake(13.17, 22.45) controlPoint2:CGPointMake(13.2, 22.46)];
            [bezier10Path addCurveToPoint:CGPointMake(13.28, 22.52) controlPoint1:CGPointMake(13.24, 22.48) controlPoint2:CGPointMake(13.26, 22.5)];
            [bezier10Path addCurveToPoint:CGPointMake(13.3, 22.6) controlPoint1:CGPointMake(13.29, 22.54) controlPoint2:CGPointMake(13.3, 22.57)];
            [bezier10Path addLineToPoint:CGPointMake(13.3, 22.61)];
            [bezier10Path addCurveToPoint:CGPointMake(13.28, 22.7) controlPoint1:CGPointMake(13.3, 22.65) controlPoint2:CGPointMake(13.29, 22.68)];
            [bezier10Path addCurveToPoint:CGPointMake(13.23, 22.75) controlPoint1:CGPointMake(13.27, 22.72) controlPoint2:CGPointMake(13.25, 22.74)];
            [bezier10Path addCurveToPoint:CGPointMake(13.16, 22.77) controlPoint1:CGPointMake(13.21, 22.76) controlPoint2:CGPointMake(13.18, 22.77)];
            [bezier10Path addCurveToPoint:CGPointMake(13.08, 22.77) controlPoint1:CGPointMake(13.14, 22.77) controlPoint2:CGPointMake(13.11, 22.77)];
            [bezier10Path addLineToPoint:CGPointMake(12.3, 22.77)];
            [bezier10Path addLineToPoint:CGPointMake(12.3, 23.28)];
            [bezier10Path addLineToPoint:CGPointMake(12.82, 23.28)];
            [bezier10Path addCurveToPoint:CGPointMake(13.1, 23.28) controlPoint1:CGPointMake(12.94, 23.25) controlPoint2:CGPointMake(13.03, 23.25)];
            [bezier10Path closePath];
            bezier10Path.miterLimit = 4;

            [fillColor setFill];
            [bezier10Path fill];

            //// Bezier 11 Drawing
            UIBezierPath *bezier11Path = [UIBezierPath bezierPath];
            [bezier11Path moveToPoint:CGPointMake(16.26, 23.19)];
            [bezier11Path addCurveToPoint:CGPointMake(16.58, 23.23) controlPoint1:CGPointMake(16.39, 23.19) controlPoint2:CGPointMake(16.49, 23.2)];
            [bezier11Path addCurveToPoint:CGPointMake(16.79, 23.35) controlPoint1:CGPointMake(16.67, 23.26) controlPoint2:CGPointMake(16.74, 23.3)];
            [bezier11Path addCurveToPoint:CGPointMake(16.9, 23.55) controlPoint1:CGPointMake(16.85, 23.4) controlPoint2:CGPointMake(16.88, 23.47)];
            [bezier11Path addCurveToPoint:CGPointMake(16.94, 23.82) controlPoint1:CGPointMake(16.92, 23.63) controlPoint2:CGPointMake(16.94, 23.72)];
            [bezier11Path addCurveToPoint:CGPointMake(16.9, 24.08) controlPoint1:CGPointMake(16.94, 23.92) controlPoint2:CGPointMake(16.93, 24.01)];
            [bezier11Path addCurveToPoint:CGPointMake(16.77, 24.27) controlPoint1:CGPointMake(16.87, 24.16) controlPoint2:CGPointMake(16.83, 24.22)];
            [bezier11Path addCurveToPoint:CGPointMake(16.54, 24.39) controlPoint1:CGPointMake(16.71, 24.32) controlPoint2:CGPointMake(16.64, 24.36)];
            [bezier11Path addCurveToPoint:CGPointMake(16.18, 24.43) controlPoint1:CGPointMake(16.44, 24.42) controlPoint2:CGPointMake(16.32, 24.43)];
            [bezier11Path addCurveToPoint:CGPointMake(15.88, 24.4) controlPoint1:CGPointMake(16.07, 24.43) controlPoint2:CGPointMake(15.97, 24.42)];
            [bezier11Path addCurveToPoint:CGPointMake(15.65, 24.3) controlPoint1:CGPointMake(15.79, 24.38) controlPoint2:CGPointMake(15.71, 24.35)];
            [bezier11Path addCurveToPoint:CGPointMake(15.5, 24.13) controlPoint1:CGPointMake(15.58, 24.26) controlPoint2:CGPointMake(15.53, 24.2)];
            [bezier11Path addCurveToPoint:CGPointMake(15.44, 23.87) controlPoint1:CGPointMake(15.46, 24.06) controlPoint2:CGPointMake(15.44, 23.97)];
            [bezier11Path addLineToPoint:CGPointMake(15.44, 22.57)];
            [bezier11Path addCurveToPoint:CGPointMake(15.45, 22.51) controlPoint1:CGPointMake(15.44, 22.55) controlPoint2:CGPointMake(15.44, 22.53)];
            [bezier11Path addCurveToPoint:CGPointMake(15.48, 22.45) controlPoint1:CGPointMake(15.46, 22.49) controlPoint2:CGPointMake(15.47, 22.47)];
            [bezier11Path addCurveToPoint:CGPointMake(15.54, 22.41) controlPoint1:CGPointMake(15.49, 22.43) controlPoint2:CGPointMake(15.52, 22.42)];
            [bezier11Path addCurveToPoint:CGPointMake(15.63, 22.39) controlPoint1:CGPointMake(15.57, 22.4) controlPoint2:CGPointMake(15.6, 22.39)];
            [bezier11Path addCurveToPoint:CGPointMake(15.77, 22.44) controlPoint1:CGPointMake(15.69, 22.39) controlPoint2:CGPointMake(15.74, 22.41)];
            [bezier11Path addCurveToPoint:CGPointMake(15.82, 22.56) controlPoint1:CGPointMake(15.8, 22.47) controlPoint2:CGPointMake(15.82, 22.51)];
            [bezier11Path addLineToPoint:CGPointMake(15.82, 23.21)];
            [bezier11Path addCurveToPoint:CGPointMake(16.06, 23.19) controlPoint1:CGPointMake(15.91, 23.2) controlPoint2:CGPointMake(15.99, 23.19)];
            [bezier11Path addCurveToPoint:CGPointMake(16.26, 23.19) controlPoint1:CGPointMake(16.15, 23.19) controlPoint2:CGPointMake(16.21, 23.19)];
            [bezier11Path closePath];
            [bezier11Path moveToPoint:CGPointMake(16.55, 23.81)];
            [bezier11Path addCurveToPoint:CGPointMake(16.54, 23.66) controlPoint1:CGPointMake(16.55, 23.75) controlPoint2:CGPointMake(16.55, 23.7)];
            [bezier11Path addCurveToPoint:CGPointMake(16.48, 23.57) controlPoint1:CGPointMake(16.53, 23.62) controlPoint2:CGPointMake(16.51, 23.59)];
            [bezier11Path addCurveToPoint:CGPointMake(16.37, 23.53) controlPoint1:CGPointMake(16.45, 23.55) controlPoint2:CGPointMake(16.41, 23.53)];
            [bezier11Path addCurveToPoint:CGPointMake(16.19, 23.52) controlPoint1:CGPointMake(16.32, 23.52) controlPoint2:CGPointMake(16.27, 23.52)];
            [bezier11Path addCurveToPoint:CGPointMake(16.05, 23.52) controlPoint1:CGPointMake(16.14, 23.52) controlPoint2:CGPointMake(16.09, 23.52)];
            [bezier11Path addCurveToPoint:CGPointMake(15.96, 23.52) controlPoint1:CGPointMake(16.02, 23.52) controlPoint2:CGPointMake(15.99, 23.52)];
            [bezier11Path addCurveToPoint:CGPointMake(15.89, 23.53) controlPoint1:CGPointMake(15.94, 23.52) controlPoint2:CGPointMake(15.91, 23.52)];
            [bezier11Path addCurveToPoint:CGPointMake(15.83, 23.54) controlPoint1:CGPointMake(15.87, 23.53) controlPoint2:CGPointMake(15.85, 23.54)];
            [bezier11Path addLineToPoint:CGPointMake(15.83, 23.8)];
            [bezier11Path addCurveToPoint:CGPointMake(15.85, 23.94) controlPoint1:CGPointMake(15.83, 23.85) controlPoint2:CGPointMake(15.83, 23.9)];
            [bezier11Path addCurveToPoint:CGPointMake(15.91, 24.04) controlPoint1:CGPointMake(15.86, 23.98) controlPoint2:CGPointMake(15.88, 24.01)];
            [bezier11Path addCurveToPoint:CGPointMake(16.02, 24.1) controlPoint1:CGPointMake(15.93, 24.07) controlPoint2:CGPointMake(15.97, 24.09)];
            [bezier11Path addCurveToPoint:CGPointMake(16.19, 24.12) controlPoint1:CGPointMake(16.07, 24.11) controlPoint2:CGPointMake(16.13, 24.12)];
            [bezier11Path addCurveToPoint:CGPointMake(16.36, 24.11) controlPoint1:CGPointMake(16.25, 24.12) controlPoint2:CGPointMake(16.31, 24.12)];
            [bezier11Path addCurveToPoint:CGPointMake(16.47, 24.07) controlPoint1:CGPointMake(16.4, 24.1) controlPoint2:CGPointMake(16.44, 24.09)];
            [bezier11Path addCurveToPoint:CGPointMake(16.53, 23.98) controlPoint1:CGPointMake(16.5, 24.05) controlPoint2:CGPointMake(16.52, 24.02)];
            [bezier11Path addCurveToPoint:CGPointMake(16.55, 23.81) controlPoint1:CGPointMake(16.55, 23.92) controlPoint2:CGPointMake(16.55, 23.87)];
            [bezier11Path closePath];
            bezier11Path.miterLimit = 4;

            [fillColor setFill];
            [bezier11Path fill];

            //// Bezier 12 Drawing
            UIBezierPath *bezier12Path = [UIBezierPath bezierPath];
            [bezier12Path moveToPoint:CGPointMake(19.04, 23.88)];
            [bezier12Path addLineToPoint:CGPointMake(19.04, 23.88)];
            [bezier12Path addCurveToPoint:CGPointMake(18.99, 24.14) controlPoint1:CGPointMake(19.04, 23.99) controlPoint2:CGPointMake(19.03, 24.07)];
            [bezier12Path addCurveToPoint:CGPointMake(18.83, 24.31) controlPoint1:CGPointMake(18.95, 24.21) controlPoint2:CGPointMake(18.9, 24.27)];
            [bezier12Path addCurveToPoint:CGPointMake(18.59, 24.4) controlPoint1:CGPointMake(18.76, 24.35) controlPoint2:CGPointMake(18.68, 24.38)];
            [bezier12Path addCurveToPoint:CGPointMake(18.28, 24.43) controlPoint1:CGPointMake(18.5, 24.42) controlPoint2:CGPointMake(18.39, 24.43)];
            [bezier12Path addCurveToPoint:CGPointMake(17.97, 24.4) controlPoint1:CGPointMake(18.16, 24.43) controlPoint2:CGPointMake(18.06, 24.42)];
            [bezier12Path addCurveToPoint:CGPointMake(17.74, 24.31) controlPoint1:CGPointMake(17.88, 24.38) controlPoint2:CGPointMake(17.8, 24.35)];
            [bezier12Path addCurveToPoint:CGPointMake(17.59, 24.14) controlPoint1:CGPointMake(17.68, 24.27) controlPoint2:CGPointMake(17.62, 24.21)];
            [bezier12Path addCurveToPoint:CGPointMake(17.54, 23.9) controlPoint1:CGPointMake(17.55, 24.07) controlPoint2:CGPointMake(17.54, 23.99)];
            [bezier12Path addLineToPoint:CGPointMake(17.54, 22.93)];
            [bezier12Path addCurveToPoint:CGPointMake(17.74, 22.54) controlPoint1:CGPointMake(17.54, 22.76) controlPoint2:CGPointMake(17.61, 22.63)];
            [bezier12Path addCurveToPoint:CGPointMake(18.3, 22.41) controlPoint1:CGPointMake(17.87, 22.46) controlPoint2:CGPointMake(18.06, 22.41)];
            [bezier12Path addCurveToPoint:CGPointMake(18.61, 22.44) controlPoint1:CGPointMake(18.41, 22.41) controlPoint2:CGPointMake(18.52, 22.42)];
            [bezier12Path addCurveToPoint:CGPointMake(18.85, 22.54) controlPoint1:CGPointMake(18.7, 22.46) controlPoint2:CGPointMake(18.78, 22.5)];
            [bezier12Path addCurveToPoint:CGPointMake(19, 22.71) controlPoint1:CGPointMake(18.91, 22.58) controlPoint2:CGPointMake(18.96, 22.64)];
            [bezier12Path addCurveToPoint:CGPointMake(19.05, 22.94) controlPoint1:CGPointMake(19.03, 22.78) controlPoint2:CGPointMake(19.05, 22.85)];
            [bezier12Path addLineToPoint:CGPointMake(19.05, 23.88)];
            [bezier12Path addLineToPoint:CGPointMake(19.04, 23.88)];
            [bezier12Path closePath];
            [bezier12Path moveToPoint:CGPointMake(18.65, 22.95)];
            [bezier12Path addCurveToPoint:CGPointMake(18.56, 22.78) controlPoint1:CGPointMake(18.65, 22.88) controlPoint2:CGPointMake(18.62, 22.82)];
            [bezier12Path addCurveToPoint:CGPointMake(18.28, 22.72) controlPoint1:CGPointMake(18.5, 22.74) controlPoint2:CGPointMake(18.41, 22.72)];
            [bezier12Path addCurveToPoint:CGPointMake(18.01, 22.78) controlPoint1:CGPointMake(18.16, 22.72) controlPoint2:CGPointMake(18.07, 22.74)];
            [bezier12Path addCurveToPoint:CGPointMake(17.92, 22.94) controlPoint1:CGPointMake(17.95, 22.82) controlPoint2:CGPointMake(17.92, 22.87)];
            [bezier12Path addLineToPoint:CGPointMake(17.92, 23.89)];
            [bezier12Path addCurveToPoint:CGPointMake(18.01, 24.06) controlPoint1:CGPointMake(17.92, 23.97) controlPoint2:CGPointMake(17.95, 24.02)];
            [bezier12Path addCurveToPoint:CGPointMake(18.27, 24.11) controlPoint1:CGPointMake(18.07, 24.09) controlPoint2:CGPointMake(18.16, 24.11)];
            [bezier12Path addCurveToPoint:CGPointMake(18.54, 24.06) controlPoint1:CGPointMake(18.38, 24.11) controlPoint2:CGPointMake(18.47, 24.09)];
            [bezier12Path addCurveToPoint:CGPointMake(18.64, 23.89) controlPoint1:CGPointMake(18.6, 24.03) controlPoint2:CGPointMake(18.64, 23.97)];
            [bezier12Path addLineToPoint:CGPointMake(18.64, 22.95)];
            [bezier12Path addLineToPoint:CGPointMake(18.65, 22.95)];
            [bezier12Path closePath];
            bezier12Path.miterLimit = 4;

            [fillColor setFill];
            [bezier12Path fill];

            //// Bezier 13 Drawing
            UIBezierPath *bezier13Path = [UIBezierPath bezierPath];
            [bezier13Path moveToPoint:CGPointMake(20.91, 23.28)];
            [bezier13Path addCurveToPoint:CGPointMake(21.09, 23.37) controlPoint1:CGPointMake(20.98, 23.3) controlPoint2:CGPointMake(21.04, 23.33)];
            [bezier13Path addCurveToPoint:CGPointMake(21.18, 23.55) controlPoint1:CGPointMake(21.13, 23.41) controlPoint2:CGPointMake(21.17, 23.47)];
            [bezier13Path addCurveToPoint:CGPointMake(21.21, 23.83) controlPoint1:CGPointMake(21.2, 23.62) controlPoint2:CGPointMake(21.21, 23.72)];
            [bezier13Path addCurveToPoint:CGPointMake(21.17, 24.12) controlPoint1:CGPointMake(21.21, 23.95) controlPoint2:CGPointMake(21.19, 24.04)];
            [bezier13Path addCurveToPoint:CGPointMake(21.04, 24.31) controlPoint1:CGPointMake(21.15, 24.2) controlPoint2:CGPointMake(21.1, 24.26)];
            [bezier13Path addCurveToPoint:CGPointMake(20.79, 24.41) controlPoint1:CGPointMake(20.98, 24.35) controlPoint2:CGPointMake(20.9, 24.39)];
            [bezier13Path addCurveToPoint:CGPointMake(20.39, 24.44) controlPoint1:CGPointMake(20.68, 24.43) controlPoint2:CGPointMake(20.55, 24.44)];
            [bezier13Path addLineToPoint:CGPointMake(20.31, 24.44)];
            [bezier13Path addCurveToPoint:CGPointMake(20.11, 24.43) controlPoint1:CGPointMake(20.25, 24.44) controlPoint2:CGPointMake(20.18, 24.44)];
            [bezier13Path addCurveToPoint:CGPointMake(19.91, 24.4) controlPoint1:CGPointMake(20.04, 24.43) controlPoint2:CGPointMake(19.97, 24.41)];
            [bezier13Path addCurveToPoint:CGPointMake(19.75, 24.32) controlPoint1:CGPointMake(19.85, 24.38) controlPoint2:CGPointMake(19.8, 24.35)];
            [bezier13Path addCurveToPoint:CGPointMake(19.68, 24.17) controlPoint1:CGPointMake(19.71, 24.28) controlPoint2:CGPointMake(19.68, 24.23)];
            [bezier13Path addLineToPoint:CGPointMake(19.68, 24.16)];
            [bezier13Path addCurveToPoint:CGPointMake(19.73, 24.05) controlPoint1:CGPointMake(19.68, 24.11) controlPoint2:CGPointMake(19.7, 24.08)];
            [bezier13Path addCurveToPoint:CGPointMake(19.85, 24) controlPoint1:CGPointMake(19.76, 24.02) controlPoint2:CGPointMake(19.8, 24)];
            [bezier13Path addLineToPoint:CGPointMake(19.85, 24)];
            [bezier13Path addCurveToPoint:CGPointMake(19.94, 24.01) controlPoint1:CGPointMake(19.89, 24) controlPoint2:CGPointMake(19.92, 24.01)];
            [bezier13Path addCurveToPoint:CGPointMake(19.99, 24.03) controlPoint1:CGPointMake(19.96, 24.02) controlPoint2:CGPointMake(19.98, 24.03)];
            [bezier13Path addCurveToPoint:CGPointMake(20.04, 24.06) controlPoint1:CGPointMake(20.01, 24.04) controlPoint2:CGPointMake(20.02, 24.05)];
            [bezier13Path addCurveToPoint:CGPointMake(20.11, 24.09) controlPoint1:CGPointMake(20.05, 24.07) controlPoint2:CGPointMake(20.08, 24.08)];
            [bezier13Path addCurveToPoint:CGPointMake(20.22, 24.11) controlPoint1:CGPointMake(20.14, 24.1) controlPoint2:CGPointMake(20.18, 24.1)];
            [bezier13Path addCurveToPoint:CGPointMake(20.41, 24.12) controlPoint1:CGPointMake(20.27, 24.12) controlPoint2:CGPointMake(20.33, 24.12)];
            [bezier13Path addCurveToPoint:CGPointMake(20.6, 24.1) controlPoint1:CGPointMake(20.49, 24.12) controlPoint2:CGPointMake(20.55, 24.12)];
            [bezier13Path addCurveToPoint:CGPointMake(20.72, 24.05) controlPoint1:CGPointMake(20.65, 24.09) controlPoint2:CGPointMake(20.69, 24.07)];
            [bezier13Path addCurveToPoint:CGPointMake(20.78, 23.96) controlPoint1:CGPointMake(20.75, 24.03) controlPoint2:CGPointMake(20.77, 23.99)];
            [bezier13Path addCurveToPoint:CGPointMake(20.79, 23.83) controlPoint1:CGPointMake(20.79, 23.92) controlPoint2:CGPointMake(20.79, 23.88)];
            [bezier13Path addCurveToPoint:CGPointMake(20.76, 23.64) controlPoint1:CGPointMake(20.79, 23.74) controlPoint2:CGPointMake(20.78, 23.68)];
            [bezier13Path addCurveToPoint:CGPointMake(20.63, 23.58) controlPoint1:CGPointMake(20.74, 23.6) controlPoint2:CGPointMake(20.69, 23.58)];
            [bezier13Path addLineToPoint:CGPointMake(20, 23.58)];
            [bezier13Path addCurveToPoint:CGPointMake(19.86, 23.57) controlPoint1:CGPointMake(19.94, 23.58) controlPoint2:CGPointMake(19.89, 23.58)];
            [bezier13Path addCurveToPoint:CGPointMake(19.78, 23.54) controlPoint1:CGPointMake(19.83, 23.57) controlPoint2:CGPointMake(19.8, 23.55)];
            [bezier13Path addCurveToPoint:CGPointMake(19.74, 23.47) controlPoint1:CGPointMake(19.76, 23.52) controlPoint2:CGPointMake(19.75, 23.5)];
            [bezier13Path addCurveToPoint:CGPointMake(19.73, 23.35) controlPoint1:CGPointMake(19.73, 23.44) controlPoint2:CGPointMake(19.73, 23.4)];
            [bezier13Path addLineToPoint:CGPointMake(19.73, 22.61)];
            [bezier13Path addCurveToPoint:CGPointMake(19.78, 22.48) controlPoint1:CGPointMake(19.73, 22.55) controlPoint2:CGPointMake(19.75, 22.51)];
            [bezier13Path addCurveToPoint:CGPointMake(19.95, 22.44) controlPoint1:CGPointMake(19.81, 22.45) controlPoint2:CGPointMake(19.87, 22.44)];
            [bezier13Path addCurveToPoint:CGPointMake(20.07, 22.44) controlPoint1:CGPointMake(19.97, 22.44) controlPoint2:CGPointMake(20.01, 22.44)];
            [bezier13Path addCurveToPoint:CGPointMake(20.25, 22.44) controlPoint1:CGPointMake(20.12, 22.44) controlPoint2:CGPointMake(20.19, 22.44)];
            [bezier13Path addCurveToPoint:CGPointMake(20.46, 22.44) controlPoint1:CGPointMake(20.32, 22.44) controlPoint2:CGPointMake(20.39, 22.44)];
            [bezier13Path addCurveToPoint:CGPointMake(20.66, 22.44) controlPoint1:CGPointMake(20.53, 22.44) controlPoint2:CGPointMake(20.6, 22.44)];
            [bezier13Path addCurveToPoint:CGPointMake(20.82, 22.44) controlPoint1:CGPointMake(20.72, 22.44) controlPoint2:CGPointMake(20.78, 22.44)];
            [bezier13Path addCurveToPoint:CGPointMake(20.9, 22.44) controlPoint1:CGPointMake(20.86, 22.44) controlPoint2:CGPointMake(20.89, 22.44)];
            [bezier13Path addCurveToPoint:CGPointMake(20.97, 22.45) controlPoint1:CGPointMake(20.92, 22.44) controlPoint2:CGPointMake(20.94, 22.44)];
            [bezier13Path addCurveToPoint:CGPointMake(21.04, 22.47) controlPoint1:CGPointMake(21, 22.45) controlPoint2:CGPointMake(21.02, 22.46)];
            [bezier13Path addCurveToPoint:CGPointMake(21.1, 22.52) controlPoint1:CGPointMake(21.06, 22.48) controlPoint2:CGPointMake(21.08, 22.5)];
            [bezier13Path addCurveToPoint:CGPointMake(21.12, 22.6) controlPoint1:CGPointMake(21.11, 22.54) controlPoint2:CGPointMake(21.12, 22.57)];
            [bezier13Path addLineToPoint:CGPointMake(21.12, 22.61)];
            [bezier13Path addCurveToPoint:CGPointMake(21.1, 22.7) controlPoint1:CGPointMake(21.12, 22.65) controlPoint2:CGPointMake(21.11, 22.68)];
            [bezier13Path addCurveToPoint:CGPointMake(21.05, 22.75) controlPoint1:CGPointMake(21.09, 22.72) controlPoint2:CGPointMake(21.07, 22.74)];
            [bezier13Path addCurveToPoint:CGPointMake(20.98, 22.77) controlPoint1:CGPointMake(21.03, 22.76) controlPoint2:CGPointMake(21.01, 22.77)];
            [bezier13Path addCurveToPoint:CGPointMake(20.9, 22.77) controlPoint1:CGPointMake(20.95, 22.77) controlPoint2:CGPointMake(20.93, 22.77)];
            [bezier13Path addLineToPoint:CGPointMake(20.12, 22.77)];
            [bezier13Path addLineToPoint:CGPointMake(20.12, 23.28)];
            [bezier13Path addLineToPoint:CGPointMake(20.64, 23.28)];
            [bezier13Path addCurveToPoint:CGPointMake(20.91, 23.28) controlPoint1:CGPointMake(20.75, 23.25) controlPoint2:CGPointMake(20.84, 23.25)];
            [bezier13Path closePath];
            bezier13Path.miterLimit = 4;

            [fillColor setFill];
            [bezier13Path fill];

            //// Bezier 14 Drawing
            UIBezierPath *bezier14Path = [UIBezierPath bezierPath];
            [bezier14Path moveToPoint:CGPointMake(22.64, 22.4)];
            [bezier14Path addCurveToPoint:CGPointMake(23.01, 22.43) controlPoint1:CGPointMake(22.79, 22.4) controlPoint2:CGPointMake(22.91, 22.41)];
            [bezier14Path addCurveToPoint:CGPointMake(23.26, 22.53) controlPoint1:CGPointMake(23.11, 22.45) controlPoint2:CGPointMake(23.19, 22.48)];
            [bezier14Path addCurveToPoint:CGPointMake(23.4, 22.71) controlPoint1:CGPointMake(23.32, 22.58) controlPoint2:CGPointMake(23.37, 22.63)];
            [bezier14Path addCurveToPoint:CGPointMake(23.44, 22.98) controlPoint1:CGPointMake(23.43, 22.78) controlPoint2:CGPointMake(23.44, 22.87)];
            [bezier14Path addLineToPoint:CGPointMake(23.44, 22.99)];
            [bezier14Path addCurveToPoint:CGPointMake(23.4, 23.27) controlPoint1:CGPointMake(23.44, 23.1) controlPoint2:CGPointMake(23.43, 23.2)];
            [bezier14Path addCurveToPoint:CGPointMake(23.29, 23.46) controlPoint1:CGPointMake(23.38, 23.35) controlPoint2:CGPointMake(23.34, 23.41)];
            [bezier14Path addCurveToPoint:CGPointMake(23.09, 23.56) controlPoint1:CGPointMake(23.24, 23.51) controlPoint2:CGPointMake(23.17, 23.54)];
            [bezier14Path addCurveToPoint:CGPointMake(22.79, 23.59) controlPoint1:CGPointMake(23.01, 23.58) controlPoint2:CGPointMake(22.91, 23.59)];
            [bezier14Path addCurveToPoint:CGPointMake(22.53, 23.59) controlPoint1:CGPointMake(22.68, 23.59) controlPoint2:CGPointMake(22.6, 23.59)];
            [bezier14Path addCurveToPoint:CGPointMake(22.37, 23.62) controlPoint1:CGPointMake(22.46, 23.59) controlPoint2:CGPointMake(22.4, 23.61)];
            [bezier14Path addCurveToPoint:CGPointMake(22.28, 23.71) controlPoint1:CGPointMake(22.33, 23.64) controlPoint2:CGPointMake(22.3, 23.67)];
            [bezier14Path addCurveToPoint:CGPointMake(22.26, 23.9) controlPoint1:CGPointMake(22.26, 23.75) controlPoint2:CGPointMake(22.26, 23.82)];
            [bezier14Path addLineToPoint:CGPointMake(22.26, 24.08)];
            [bezier14Path addLineToPoint:CGPointMake(23.23, 24.08)];
            [bezier14Path addCurveToPoint:CGPointMake(23.3, 24.09) controlPoint1:CGPointMake(23.25, 24.08) controlPoint2:CGPointMake(23.28, 24.08)];
            [bezier14Path addCurveToPoint:CGPointMake(23.37, 24.12) controlPoint1:CGPointMake(23.32, 24.1) controlPoint2:CGPointMake(23.34, 24.11)];
            [bezier14Path addCurveToPoint:CGPointMake(23.42, 24.17) controlPoint1:CGPointMake(23.39, 24.13) controlPoint2:CGPointMake(23.41, 24.15)];
            [bezier14Path addCurveToPoint:CGPointMake(23.44, 24.24) controlPoint1:CGPointMake(23.43, 24.19) controlPoint2:CGPointMake(23.44, 24.21)];
            [bezier14Path addCurveToPoint:CGPointMake(23.42, 24.32) controlPoint1:CGPointMake(23.44, 24.27) controlPoint2:CGPointMake(23.43, 24.3)];
            [bezier14Path addCurveToPoint:CGPointMake(23.37, 24.37) controlPoint1:CGPointMake(23.41, 24.34) controlPoint2:CGPointMake(23.39, 24.36)];
            [bezier14Path addCurveToPoint:CGPointMake(23.3, 24.4) controlPoint1:CGPointMake(23.35, 24.38) controlPoint2:CGPointMake(23.33, 24.39)];
            [bezier14Path addCurveToPoint:CGPointMake(23.22, 24.41) controlPoint1:CGPointMake(23.28, 24.41) controlPoint2:CGPointMake(23.25, 24.41)];
            [bezier14Path addLineToPoint:CGPointMake(22.08, 24.41)];
            [bezier14Path addCurveToPoint:CGPointMake(21.91, 24.37) controlPoint1:CGPointMake(22, 24.41) controlPoint2:CGPointMake(21.94, 24.4)];
            [bezier14Path addCurveToPoint:CGPointMake(21.86, 24.24) controlPoint1:CGPointMake(21.88, 24.34) controlPoint2:CGPointMake(21.86, 24.3)];
            [bezier14Path addLineToPoint:CGPointMake(21.86, 23.84)];
            [bezier14Path addCurveToPoint:CGPointMake(21.9, 23.57) controlPoint1:CGPointMake(21.86, 23.73) controlPoint2:CGPointMake(21.87, 23.64)];
            [bezier14Path addCurveToPoint:CGPointMake(22.02, 23.39) controlPoint1:CGPointMake(21.93, 23.5) controlPoint2:CGPointMake(21.97, 23.44)];
            [bezier14Path addCurveToPoint:CGPointMake(22.22, 23.3) controlPoint1:CGPointMake(22.08, 23.34) controlPoint2:CGPointMake(22.14, 23.31)];
            [bezier14Path addCurveToPoint:CGPointMake(22.48, 23.27) controlPoint1:CGPointMake(22.3, 23.28) controlPoint2:CGPointMake(22.38, 23.27)];
            [bezier14Path addLineToPoint:CGPointMake(22.76, 23.26)];
            [bezier14Path addCurveToPoint:CGPointMake(22.89, 23.25) controlPoint1:CGPointMake(22.81, 23.26) controlPoint2:CGPointMake(22.86, 23.26)];
            [bezier14Path addCurveToPoint:CGPointMake(22.97, 23.21) controlPoint1:CGPointMake(22.92, 23.24) controlPoint2:CGPointMake(22.95, 23.23)];
            [bezier14Path addCurveToPoint:CGPointMake(23.02, 23.13) controlPoint1:CGPointMake(22.99, 23.19) controlPoint2:CGPointMake(23, 23.17)];
            [bezier14Path addCurveToPoint:CGPointMake(23.03, 23.01) controlPoint1:CGPointMake(23.03, 23.1) controlPoint2:CGPointMake(23.03, 23.06)];
            [bezier14Path addLineToPoint:CGPointMake(23.03, 23)];
            [bezier14Path addCurveToPoint:CGPointMake(23.01, 22.87) controlPoint1:CGPointMake(23.03, 22.95) controlPoint2:CGPointMake(23.02, 22.91)];
            [bezier14Path addCurveToPoint:CGPointMake(22.94, 22.79) controlPoint1:CGPointMake(23, 22.83) controlPoint2:CGPointMake(22.97, 22.81)];
            [bezier14Path addCurveToPoint:CGPointMake(22.81, 22.74) controlPoint1:CGPointMake(22.91, 22.77) controlPoint2:CGPointMake(22.87, 22.75)];
            [bezier14Path addCurveToPoint:CGPointMake(22.6, 22.73) controlPoint1:CGPointMake(22.75, 22.73) controlPoint2:CGPointMake(22.68, 22.73)];
            [bezier14Path addCurveToPoint:CGPointMake(22.41, 22.74) controlPoint1:CGPointMake(22.53, 22.73) controlPoint2:CGPointMake(22.47, 22.73)];
            [bezier14Path addCurveToPoint:CGPointMake(22.27, 22.77) controlPoint1:CGPointMake(22.35, 22.75) controlPoint2:CGPointMake(22.31, 22.76)];
            [bezier14Path addCurveToPoint:CGPointMake(22.17, 22.81) controlPoint1:CGPointMake(22.23, 22.78) controlPoint2:CGPointMake(22.2, 22.79)];
            [bezier14Path addCurveToPoint:CGPointMake(22.07, 22.83) controlPoint1:CGPointMake(22.14, 22.82) controlPoint2:CGPointMake(22.11, 22.83)];
            [bezier14Path addLineToPoint:CGPointMake(22.06, 22.83)];
            [bezier14Path addCurveToPoint:CGPointMake(21.94, 22.78) controlPoint1:CGPointMake(22.01, 22.83) controlPoint2:CGPointMake(21.97, 22.81)];
            [bezier14Path addCurveToPoint:CGPointMake(21.9, 22.66) controlPoint1:CGPointMake(21.91, 22.75) controlPoint2:CGPointMake(21.9, 22.71)];
            [bezier14Path addLineToPoint:CGPointMake(21.9, 22.65)];
            [bezier14Path addCurveToPoint:CGPointMake(21.96, 22.54) controlPoint1:CGPointMake(21.9, 22.61) controlPoint2:CGPointMake(21.92, 22.57)];
            [bezier14Path addCurveToPoint:CGPointMake(22.12, 22.47) controlPoint1:CGPointMake(22, 22.51) controlPoint2:CGPointMake(22.05, 22.48)];
            [bezier14Path addCurveToPoint:CGPointMake(22.35, 22.43) controlPoint1:CGPointMake(22.19, 22.45) controlPoint2:CGPointMake(22.26, 22.44)];
            [bezier14Path addCurveToPoint:CGPointMake(22.64, 22.4) controlPoint1:CGPointMake(22.46, 22.4) controlPoint2:CGPointMake(22.55, 22.4)];
            [bezier14Path closePath];
            bezier14Path.miterLimit = 4;

            [fillColor setFill];
            [bezier14Path fill];

            //// Bezier 15 Drawing
            UIBezierPath *bezier15Path = [UIBezierPath bezierPath];
            [bezier15Path moveToPoint:CGPointMake(25.52, 23.88)];
            [bezier15Path addCurveToPoint:CGPointMake(25.5, 24.11) controlPoint1:CGPointMake(25.52, 23.97) controlPoint2:CGPointMake(25.51, 24.04)];
            [bezier15Path addCurveToPoint:CGPointMake(25.39, 24.28) controlPoint1:CGPointMake(25.48, 24.18) controlPoint2:CGPointMake(25.44, 24.24)];
            [bezier15Path addCurveToPoint:CGPointMake(25.15, 24.39) controlPoint1:CGPointMake(25.34, 24.33) controlPoint2:CGPointMake(25.26, 24.36)];
            [bezier15Path addCurveToPoint:CGPointMake(24.74, 24.43) controlPoint1:CGPointMake(25.05, 24.41) controlPoint2:CGPointMake(24.91, 24.43)];
            [bezier15Path addCurveToPoint:CGPointMake(24.35, 24.39) controlPoint1:CGPointMake(24.58, 24.43) controlPoint2:CGPointMake(24.45, 24.42)];
            [bezier15Path addCurveToPoint:CGPointMake(24.13, 24.28) controlPoint1:CGPointMake(24.25, 24.36) controlPoint2:CGPointMake(24.18, 24.33)];
            [bezier15Path addCurveToPoint:CGPointMake(24.02, 24.11) controlPoint1:CGPointMake(24.08, 24.23) controlPoint2:CGPointMake(24.04, 24.17)];
            [bezier15Path addCurveToPoint:CGPointMake(23.99, 23.89) controlPoint1:CGPointMake(24, 24.04) controlPoint2:CGPointMake(23.99, 23.97)];
            [bezier15Path addCurveToPoint:CGPointMake(23.99, 23.73) controlPoint1:CGPointMake(23.99, 23.82) controlPoint2:CGPointMake(23.99, 23.77)];
            [bezier15Path addCurveToPoint:CGPointMake(24.02, 23.62) controlPoint1:CGPointMake(23.99, 23.69) controlPoint2:CGPointMake(24, 23.65)];
            [bezier15Path addCurveToPoint:CGPointMake(24.11, 23.54) controlPoint1:CGPointMake(24.04, 23.59) controlPoint2:CGPointMake(24.07, 23.56)];
            [bezier15Path addCurveToPoint:CGPointMake(24.28, 23.45) controlPoint1:CGPointMake(24.15, 23.51) controlPoint2:CGPointMake(24.21, 23.48)];
            [bezier15Path addCurveToPoint:CGPointMake(24.11, 23.38) controlPoint1:CGPointMake(24.21, 23.42) controlPoint2:CGPointMake(24.15, 23.4)];
            [bezier15Path addCurveToPoint:CGPointMake(24.03, 23.3) controlPoint1:CGPointMake(24.07, 23.36) controlPoint2:CGPointMake(24.04, 23.33)];
            [bezier15Path addCurveToPoint:CGPointMake(24, 23.16) controlPoint1:CGPointMake(24.01, 23.24) controlPoint2:CGPointMake(24, 23.2)];
            [bezier15Path addCurveToPoint:CGPointMake(23.99, 22.96) controlPoint1:CGPointMake(24, 23.11) controlPoint2:CGPointMake(23.99, 23.04)];
            [bezier15Path addCurveToPoint:CGPointMake(24.03, 22.69) controlPoint1:CGPointMake(23.99, 22.85) controlPoint2:CGPointMake(24, 22.76)];
            [bezier15Path addCurveToPoint:CGPointMake(24.16, 22.52) controlPoint1:CGPointMake(24.06, 22.62) controlPoint2:CGPointMake(24.1, 22.56)];
            [bezier15Path addCurveToPoint:CGPointMake(24.39, 22.43) controlPoint1:CGPointMake(24.22, 22.48) controlPoint2:CGPointMake(24.3, 22.45)];
            [bezier15Path addCurveToPoint:CGPointMake(24.74, 22.4) controlPoint1:CGPointMake(24.48, 22.41) controlPoint2:CGPointMake(24.6, 22.4)];
            [bezier15Path addCurveToPoint:CGPointMake(25.1, 22.43) controlPoint1:CGPointMake(24.88, 22.4) controlPoint2:CGPointMake(25, 22.41)];
            [bezier15Path addCurveToPoint:CGPointMake(25.34, 22.52) controlPoint1:CGPointMake(25.2, 22.45) controlPoint2:CGPointMake(25.28, 22.48)];
            [bezier15Path addCurveToPoint:CGPointMake(25.47, 22.69) controlPoint1:CGPointMake(25.4, 22.57) controlPoint2:CGPointMake(25.44, 22.62)];
            [bezier15Path addCurveToPoint:CGPointMake(25.51, 22.95) controlPoint1:CGPointMake(25.5, 22.76) controlPoint2:CGPointMake(25.51, 22.85)];
            [bezier15Path addCurveToPoint:CGPointMake(25.5, 23.15) controlPoint1:CGPointMake(25.51, 23.03) controlPoint2:CGPointMake(25.51, 23.1)];
            [bezier15Path addCurveToPoint:CGPointMake(25.47, 23.27) controlPoint1:CGPointMake(25.5, 23.2) controlPoint2:CGPointMake(25.49, 23.24)];
            [bezier15Path addCurveToPoint:CGPointMake(25.38, 23.35) controlPoint1:CGPointMake(25.45, 23.3) controlPoint2:CGPointMake(25.42, 23.33)];
            [bezier15Path addCurveToPoint:CGPointMake(25.22, 23.42) controlPoint1:CGPointMake(25.35, 23.37) controlPoint2:CGPointMake(25.29, 23.39)];
            [bezier15Path addCurveToPoint:CGPointMake(25.38, 23.5) controlPoint1:CGPointMake(25.29, 23.45) controlPoint2:CGPointMake(25.34, 23.48)];
            [bezier15Path addCurveToPoint:CGPointMake(25.46, 23.58) controlPoint1:CGPointMake(25.42, 23.52) controlPoint2:CGPointMake(25.44, 23.55)];
            [bezier15Path addCurveToPoint:CGPointMake(25.49, 23.69) controlPoint1:CGPointMake(25.48, 23.61) controlPoint2:CGPointMake(25.49, 23.65)];
            [bezier15Path addCurveToPoint:CGPointMake(25.52, 23.88) controlPoint1:CGPointMake(25.52, 23.74) controlPoint2:CGPointMake(25.52, 23.8)];
            [bezier15Path closePath];
            [bezier15Path moveToPoint:CGPointMake(25.13, 23.84)];
            [bezier15Path addCurveToPoint:CGPointMake(25.12, 23.81) controlPoint1:CGPointMake(25.13, 23.84) controlPoint2:CGPointMake(25.12, 23.83)];
            [bezier15Path addCurveToPoint:CGPointMake(25.07, 23.74) controlPoint1:CGPointMake(25.11, 23.79) controlPoint2:CGPointMake(25.09, 23.77)];
            [bezier15Path addCurveToPoint:CGPointMake(24.96, 23.65) controlPoint1:CGPointMake(25.05, 23.71) controlPoint2:CGPointMake(25.01, 23.68)];
            [bezier15Path addCurveToPoint:CGPointMake(24.76, 23.56) controlPoint1:CGPointMake(24.91, 23.62) controlPoint2:CGPointMake(24.84, 23.59)];
            [bezier15Path addCurveToPoint:CGPointMake(24.55, 23.66) controlPoint1:CGPointMake(24.67, 23.59) controlPoint2:CGPointMake(24.6, 23.63)];
            [bezier15Path addCurveToPoint:CGPointMake(24.44, 23.76) controlPoint1:CGPointMake(24.5, 23.69) controlPoint2:CGPointMake(24.47, 23.72)];
            [bezier15Path addCurveToPoint:CGPointMake(24.4, 23.84) controlPoint1:CGPointMake(24.42, 23.79) controlPoint2:CGPointMake(24.4, 23.82)];
            [bezier15Path addCurveToPoint:CGPointMake(24.39, 23.88) controlPoint1:CGPointMake(24.39, 23.86) controlPoint2:CGPointMake(24.39, 23.88)];
            [bezier15Path addLineToPoint:CGPointMake(24.39, 23.89)];
            [bezier15Path addCurveToPoint:CGPointMake(24.41, 23.99) controlPoint1:CGPointMake(24.39, 23.93) controlPoint2:CGPointMake(24.4, 23.97)];
            [bezier15Path addCurveToPoint:CGPointMake(24.47, 24.06) controlPoint1:CGPointMake(24.42, 24.02) controlPoint2:CGPointMake(24.44, 24.04)];
            [bezier15Path addCurveToPoint:CGPointMake(24.59, 24.1) controlPoint1:CGPointMake(24.5, 24.08) controlPoint2:CGPointMake(24.54, 24.09)];
            [bezier15Path addCurveToPoint:CGPointMake(24.78, 24.11) controlPoint1:CGPointMake(24.64, 24.11) controlPoint2:CGPointMake(24.7, 24.11)];
            [bezier15Path addCurveToPoint:CGPointMake(24.95, 24.1) controlPoint1:CGPointMake(24.85, 24.11) controlPoint2:CGPointMake(24.9, 24.11)];
            [bezier15Path addCurveToPoint:CGPointMake(25.06, 24.06) controlPoint1:CGPointMake(25, 24.09) controlPoint2:CGPointMake(25.03, 24.08)];
            [bezier15Path addCurveToPoint:CGPointMake(25.12, 23.99) controlPoint1:CGPointMake(25.08, 24.04) controlPoint2:CGPointMake(25.11, 24.02)];
            [bezier15Path addCurveToPoint:CGPointMake(25.14, 23.89) controlPoint1:CGPointMake(25.13, 23.96) controlPoint2:CGPointMake(25.14, 23.93)];
            [bezier15Path addLineToPoint:CGPointMake(25.14, 23.84)];
            [bezier15Path addLineToPoint:CGPointMake(25.13, 23.84)];
            [bezier15Path closePath];
            [bezier15Path moveToPoint:CGPointMake(24.76, 23.26)];
            [bezier15Path addCurveToPoint:CGPointMake(24.97, 23.21) controlPoint1:CGPointMake(24.85, 23.24) controlPoint2:CGPointMake(24.92, 23.22)];
            [bezier15Path addCurveToPoint:CGPointMake(25.08, 23.16) controlPoint1:CGPointMake(25.02, 23.19) controlPoint2:CGPointMake(25.05, 23.17)];
            [bezier15Path addCurveToPoint:CGPointMake(25.12, 23.07) controlPoint1:CGPointMake(25.1, 23.14) controlPoint2:CGPointMake(25.11, 23.11)];
            [bezier15Path addCurveToPoint:CGPointMake(25.13, 22.92) controlPoint1:CGPointMake(25.12, 23.04) controlPoint2:CGPointMake(25.13, 22.99)];
            [bezier15Path addCurveToPoint:CGPointMake(25.1, 22.81) controlPoint1:CGPointMake(25.13, 22.88) controlPoint2:CGPointMake(25.12, 22.84)];
            [bezier15Path addCurveToPoint:CGPointMake(25.03, 22.75) controlPoint1:CGPointMake(25.08, 22.79) controlPoint2:CGPointMake(25.06, 22.76)];
            [bezier15Path addCurveToPoint:CGPointMake(24.91, 22.73) controlPoint1:CGPointMake(25, 22.74) controlPoint2:CGPointMake(24.96, 22.73)];
            [bezier15Path addCurveToPoint:CGPointMake(24.76, 22.73) controlPoint1:CGPointMake(24.86, 22.73) controlPoint2:CGPointMake(24.81, 22.73)];
            [bezier15Path addCurveToPoint:CGPointMake(24.59, 22.74) controlPoint1:CGPointMake(24.69, 22.73) controlPoint2:CGPointMake(24.64, 22.73)];
            [bezier15Path addCurveToPoint:CGPointMake(24.48, 22.77) controlPoint1:CGPointMake(24.55, 22.74) controlPoint2:CGPointMake(24.51, 22.75)];
            [bezier15Path addCurveToPoint:CGPointMake(24.41, 22.84) controlPoint1:CGPointMake(24.45, 22.79) controlPoint2:CGPointMake(24.43, 22.81)];
            [bezier15Path addCurveToPoint:CGPointMake(24.39, 22.97) controlPoint1:CGPointMake(24.4, 22.87) controlPoint2:CGPointMake(24.39, 22.91)];
            [bezier15Path addCurveToPoint:CGPointMake(24.4, 23.09) controlPoint1:CGPointMake(24.39, 23.02) controlPoint2:CGPointMake(24.39, 23.06)];
            [bezier15Path addCurveToPoint:CGPointMake(24.44, 23.16) controlPoint1:CGPointMake(24.4, 23.12) controlPoint2:CGPointMake(24.42, 23.14)];
            [bezier15Path addCurveToPoint:CGPointMake(24.55, 23.21) controlPoint1:CGPointMake(24.46, 23.18) controlPoint2:CGPointMake(24.5, 23.19)];
            [bezier15Path addCurveToPoint:CGPointMake(24.76, 23.26) controlPoint1:CGPointMake(24.6, 23.22) controlPoint2:CGPointMake(24.67, 23.24)];
            [bezier15Path closePath];
            bezier15Path.miterLimit = 4;

            [fillColor setFill];
            [bezier15Path fill];

            //// Bezier 16 Drawing
            UIBezierPath *bezier16Path = [UIBezierPath bezierPath];
            [bezier16Path moveToPoint:CGPointMake(27.71, 23.88)];
            [bezier16Path addLineToPoint:CGPointMake(27.71, 23.88)];
            [bezier16Path addCurveToPoint:CGPointMake(27.66, 24.14) controlPoint1:CGPointMake(27.71, 23.99) controlPoint2:CGPointMake(27.69, 24.07)];
            [bezier16Path addCurveToPoint:CGPointMake(27.5, 24.31) controlPoint1:CGPointMake(27.62, 24.21) controlPoint2:CGPointMake(27.57, 24.27)];
            [bezier16Path addCurveToPoint:CGPointMake(27.26, 24.4) controlPoint1:CGPointMake(27.43, 24.35) controlPoint2:CGPointMake(27.35, 24.38)];
            [bezier16Path addCurveToPoint:CGPointMake(26.95, 24.43) controlPoint1:CGPointMake(27.17, 24.42) controlPoint2:CGPointMake(27.06, 24.43)];
            [bezier16Path addCurveToPoint:CGPointMake(26.64, 24.4) controlPoint1:CGPointMake(26.83, 24.43) controlPoint2:CGPointMake(26.73, 24.42)];
            [bezier16Path addCurveToPoint:CGPointMake(26.41, 24.31) controlPoint1:CGPointMake(26.55, 24.38) controlPoint2:CGPointMake(26.47, 24.35)];
            [bezier16Path addCurveToPoint:CGPointMake(26.26, 24.14) controlPoint1:CGPointMake(26.34, 24.27) controlPoint2:CGPointMake(26.3, 24.21)];
            [bezier16Path addCurveToPoint:CGPointMake(26.21, 23.9) controlPoint1:CGPointMake(26.23, 24.07) controlPoint2:CGPointMake(26.21, 23.99)];
            [bezier16Path addLineToPoint:CGPointMake(26.21, 22.93)];
            [bezier16Path addCurveToPoint:CGPointMake(26.41, 22.54) controlPoint1:CGPointMake(26.21, 22.76) controlPoint2:CGPointMake(26.28, 22.63)];
            [bezier16Path addCurveToPoint:CGPointMake(26.97, 22.41) controlPoint1:CGPointMake(26.54, 22.46) controlPoint2:CGPointMake(26.73, 22.41)];
            [bezier16Path addCurveToPoint:CGPointMake(27.28, 22.44) controlPoint1:CGPointMake(27.08, 22.41) controlPoint2:CGPointMake(27.18, 22.42)];
            [bezier16Path addCurveToPoint:CGPointMake(27.51, 22.54) controlPoint1:CGPointMake(27.37, 22.46) controlPoint2:CGPointMake(27.45, 22.5)];
            [bezier16Path addCurveToPoint:CGPointMake(27.66, 22.71) controlPoint1:CGPointMake(27.57, 22.58) controlPoint2:CGPointMake(27.62, 22.64)];
            [bezier16Path addCurveToPoint:CGPointMake(27.71, 22.94) controlPoint1:CGPointMake(27.7, 22.78) controlPoint2:CGPointMake(27.71, 22.85)];
            [bezier16Path addLineToPoint:CGPointMake(27.71, 23.88)];
            [bezier16Path closePath];
            [bezier16Path moveToPoint:CGPointMake(27.32, 22.95)];
            [bezier16Path addCurveToPoint:CGPointMake(27.23, 22.78) controlPoint1:CGPointMake(27.32, 22.88) controlPoint2:CGPointMake(27.29, 22.82)];
            [bezier16Path addCurveToPoint:CGPointMake(26.96, 22.72) controlPoint1:CGPointMake(27.18, 22.74) controlPoint2:CGPointMake(27.08, 22.72)];
            [bezier16Path addCurveToPoint:CGPointMake(26.69, 22.78) controlPoint1:CGPointMake(26.84, 22.72) controlPoint2:CGPointMake(26.75, 22.74)];
            [bezier16Path addCurveToPoint:CGPointMake(26.6, 22.94) controlPoint1:CGPointMake(26.63, 22.82) controlPoint2:CGPointMake(26.6, 22.87)];
            [bezier16Path addLineToPoint:CGPointMake(26.6, 23.89)];
            [bezier16Path addCurveToPoint:CGPointMake(26.69, 24.06) controlPoint1:CGPointMake(26.6, 23.97) controlPoint2:CGPointMake(26.63, 24.02)];
            [bezier16Path addCurveToPoint:CGPointMake(26.95, 24.11) controlPoint1:CGPointMake(26.75, 24.09) controlPoint2:CGPointMake(26.84, 24.11)];
            [bezier16Path addCurveToPoint:CGPointMake(27.22, 24.06) controlPoint1:CGPointMake(27.07, 24.11) controlPoint2:CGPointMake(27.15, 24.09)];
            [bezier16Path addCurveToPoint:CGPointMake(27.32, 23.89) controlPoint1:CGPointMake(27.28, 24.03) controlPoint2:CGPointMake(27.32, 23.97)];
            [bezier16Path addLineToPoint:CGPointMake(27.32, 22.95)];
            [bezier16Path closePath];
            bezier16Path.miterLimit = 4;

            [fillColor setFill];
            [bezier16Path fill];

            //// Bezier 17 Drawing
            UIBezierPath *bezier17Path = [UIBezierPath bezierPath];
            [bezier17Path moveToPoint:CGPointMake(31.23, 23.27)];
            [bezier17Path addCurveToPoint:CGPointMake(31.37, 23.31) controlPoint1:CGPointMake(31.28, 23.27) controlPoint2:CGPointMake(31.33, 23.28)];
            [bezier17Path addCurveToPoint:CGPointMake(31.43, 23.43) controlPoint1:CGPointMake(31.41, 23.33) controlPoint2:CGPointMake(31.43, 23.37)];
            [bezier17Path addCurveToPoint:CGPointMake(31.38, 23.56) controlPoint1:CGPointMake(31.43, 23.49) controlPoint2:CGPointMake(31.41, 23.53)];
            [bezier17Path addCurveToPoint:CGPointMake(31.24, 23.6) controlPoint1:CGPointMake(31.34, 23.59) controlPoint2:CGPointMake(31.3, 23.6)];
            [bezier17Path addLineToPoint:CGPointMake(31.18, 23.6)];
            [bezier17Path addLineToPoint:CGPointMake(31.18, 24.27)];
            [bezier17Path addCurveToPoint:CGPointMake(31.17, 24.32) controlPoint1:CGPointMake(31.18, 24.29) controlPoint2:CGPointMake(31.17, 24.31)];
            [bezier17Path addCurveToPoint:CGPointMake(31.13, 24.37) controlPoint1:CGPointMake(31.16, 24.34) controlPoint2:CGPointMake(31.15, 24.36)];
            [bezier17Path addCurveToPoint:CGPointMake(31.07, 24.41) controlPoint1:CGPointMake(31.11, 24.39) controlPoint2:CGPointMake(31.09, 24.4)];
            [bezier17Path addCurveToPoint:CGPointMake(30.98, 24.43) controlPoint1:CGPointMake(31.05, 24.42) controlPoint2:CGPointMake(31.02, 24.43)];
            [bezier17Path addCurveToPoint:CGPointMake(30.89, 24.41) controlPoint1:CGPointMake(30.94, 24.43) controlPoint2:CGPointMake(30.91, 24.43)];
            [bezier17Path addCurveToPoint:CGPointMake(30.83, 24.37) controlPoint1:CGPointMake(30.86, 24.4) controlPoint2:CGPointMake(30.84, 24.39)];
            [bezier17Path addCurveToPoint:CGPointMake(30.8, 24.32) controlPoint1:CGPointMake(30.81, 24.35) controlPoint2:CGPointMake(30.8, 24.34)];
            [bezier17Path addCurveToPoint:CGPointMake(30.79, 24.27) controlPoint1:CGPointMake(30.79, 24.3) controlPoint2:CGPointMake(30.79, 24.28)];
            [bezier17Path addLineToPoint:CGPointMake(30.79, 23.6)];
            [bezier17Path addLineToPoint:CGPointMake(30.03, 23.6)];
            [bezier17Path addCurveToPoint:CGPointMake(29.93, 23.58) controlPoint1:CGPointMake(29.98, 23.6) controlPoint2:CGPointMake(29.95, 23.59)];
            [bezier17Path addCurveToPoint:CGPointMake(29.91, 23.5) controlPoint1:CGPointMake(29.92, 23.56) controlPoint2:CGPointMake(29.91, 23.54)];
            [bezier17Path addLineToPoint:CGPointMake(29.91, 22.59)];
            [bezier17Path addCurveToPoint:CGPointMake(29.92, 22.53) controlPoint1:CGPointMake(29.91, 22.57) controlPoint2:CGPointMake(29.91, 22.55)];
            [bezier17Path addCurveToPoint:CGPointMake(29.95, 22.47) controlPoint1:CGPointMake(29.93, 22.51) controlPoint2:CGPointMake(29.94, 22.49)];
            [bezier17Path addCurveToPoint:CGPointMake(30.01, 22.43) controlPoint1:CGPointMake(29.96, 22.46) controlPoint2:CGPointMake(29.99, 22.44)];
            [bezier17Path addCurveToPoint:CGPointMake(30.1, 22.41) controlPoint1:CGPointMake(30.04, 22.42) controlPoint2:CGPointMake(30.07, 22.41)];
            [bezier17Path addCurveToPoint:CGPointMake(30.25, 22.46) controlPoint1:CGPointMake(30.17, 22.41) controlPoint2:CGPointMake(30.22, 22.43)];
            [bezier17Path addCurveToPoint:CGPointMake(30.3, 22.59) controlPoint1:CGPointMake(30.28, 22.49) controlPoint2:CGPointMake(30.3, 22.54)];
            [bezier17Path addLineToPoint:CGPointMake(30.3, 23.29)];
            [bezier17Path addLineToPoint:CGPointMake(30.79, 23.29)];
            [bezier17Path addLineToPoint:CGPointMake(30.79, 22.59)];
            [bezier17Path addCurveToPoint:CGPointMake(30.84, 22.47) controlPoint1:CGPointMake(30.79, 22.54) controlPoint2:CGPointMake(30.81, 22.5)];
            [bezier17Path addCurveToPoint:CGPointMake(30.99, 22.42) controlPoint1:CGPointMake(30.87, 22.44) controlPoint2:CGPointMake(30.92, 22.42)];
            [bezier17Path addCurveToPoint:CGPointMake(31.14, 22.47) controlPoint1:CGPointMake(31.05, 22.42) controlPoint2:CGPointMake(31.1, 22.44)];
            [bezier17Path addCurveToPoint:CGPointMake(31.19, 22.59) controlPoint1:CGPointMake(31.17, 22.5) controlPoint2:CGPointMake(31.19, 22.54)];
            [bezier17Path addLineToPoint:CGPointMake(31.19, 23.29)];
            [bezier17Path addLineToPoint:CGPointMake(31.24, 23.29)];
            [bezier17Path addLineToPoint:CGPointMake(31.23, 23.29)];
            [bezier17Path addLineToPoint:CGPointMake(31.23, 23.27)];
            [bezier17Path closePath];
            bezier17Path.miterLimit = 4;

            [fillColor setFill];
            [bezier17Path fill];

            //// Bezier 18 Drawing
            UIBezierPath *bezier18Path = [UIBezierPath bezierPath];
            [bezier18Path moveToPoint:CGPointMake(33.41, 23.27)];
            [bezier18Path addCurveToPoint:CGPointMake(33.54, 23.31) controlPoint1:CGPointMake(33.46, 23.27) controlPoint2:CGPointMake(33.51, 23.28)];
            [bezier18Path addCurveToPoint:CGPointMake(33.6, 23.43) controlPoint1:CGPointMake(33.58, 23.33) controlPoint2:CGPointMake(33.6, 23.37)];
            [bezier18Path addCurveToPoint:CGPointMake(33.54, 23.56) controlPoint1:CGPointMake(33.6, 23.49) controlPoint2:CGPointMake(33.58, 23.53)];
            [bezier18Path addCurveToPoint:CGPointMake(33.41, 23.6) controlPoint1:CGPointMake(33.5, 23.59) controlPoint2:CGPointMake(33.46, 23.6)];
            [bezier18Path addLineToPoint:CGPointMake(33.35, 23.6)];
            [bezier18Path addLineToPoint:CGPointMake(33.35, 24.27)];
            [bezier18Path addCurveToPoint:CGPointMake(33.33, 24.32) controlPoint1:CGPointMake(33.35, 24.29) controlPoint2:CGPointMake(33.34, 24.31)];
            [bezier18Path addCurveToPoint:CGPointMake(33.3, 24.37) controlPoint1:CGPointMake(33.33, 24.34) controlPoint2:CGPointMake(33.31, 24.36)];
            [bezier18Path addCurveToPoint:CGPointMake(33.24, 24.41) controlPoint1:CGPointMake(33.28, 24.39) controlPoint2:CGPointMake(33.26, 24.4)];
            [bezier18Path addCurveToPoint:CGPointMake(33.15, 24.43) controlPoint1:CGPointMake(33.21, 24.42) controlPoint2:CGPointMake(33.19, 24.43)];
            [bezier18Path addCurveToPoint:CGPointMake(33.06, 24.41) controlPoint1:CGPointMake(33.11, 24.43) controlPoint2:CGPointMake(33.08, 24.43)];
            [bezier18Path addCurveToPoint:CGPointMake(33, 24.37) controlPoint1:CGPointMake(33.04, 24.4) controlPoint2:CGPointMake(33.01, 24.39)];
            [bezier18Path addCurveToPoint:CGPointMake(32.97, 24.32) controlPoint1:CGPointMake(32.98, 24.35) controlPoint2:CGPointMake(32.97, 24.34)];
            [bezier18Path addCurveToPoint:CGPointMake(32.96, 24.27) controlPoint1:CGPointMake(32.96, 24.3) controlPoint2:CGPointMake(32.96, 24.28)];
            [bezier18Path addLineToPoint:CGPointMake(32.96, 23.6)];
            [bezier18Path addLineToPoint:CGPointMake(32.2, 23.6)];
            [bezier18Path addCurveToPoint:CGPointMake(32.11, 23.58) controlPoint1:CGPointMake(32.15, 23.6) controlPoint2:CGPointMake(32.12, 23.59)];
            [bezier18Path addCurveToPoint:CGPointMake(32.09, 23.5) controlPoint1:CGPointMake(32.09, 23.56) controlPoint2:CGPointMake(32.09, 23.54)];
            [bezier18Path addLineToPoint:CGPointMake(32.08, 22.59)];
            [bezier18Path addCurveToPoint:CGPointMake(32.09, 22.53) controlPoint1:CGPointMake(32.08, 22.57) controlPoint2:CGPointMake(32.09, 22.55)];
            [bezier18Path addCurveToPoint:CGPointMake(32.12, 22.47) controlPoint1:CGPointMake(32.1, 22.51) controlPoint2:CGPointMake(32.11, 22.49)];
            [bezier18Path addCurveToPoint:CGPointMake(32.18, 22.43) controlPoint1:CGPointMake(32.14, 22.46) controlPoint2:CGPointMake(32.16, 22.44)];
            [bezier18Path addCurveToPoint:CGPointMake(32.27, 22.41) controlPoint1:CGPointMake(32.21, 22.42) controlPoint2:CGPointMake(32.23, 22.41)];
            [bezier18Path addCurveToPoint:CGPointMake(32.42, 22.46) controlPoint1:CGPointMake(32.34, 22.41) controlPoint2:CGPointMake(32.39, 22.43)];
            [bezier18Path addCurveToPoint:CGPointMake(32.47, 22.59) controlPoint1:CGPointMake(32.45, 22.49) controlPoint2:CGPointMake(32.47, 22.54)];
            [bezier18Path addLineToPoint:CGPointMake(32.47, 23.29)];
            [bezier18Path addLineToPoint:CGPointMake(32.96, 23.29)];
            [bezier18Path addLineToPoint:CGPointMake(32.96, 22.59)];
            [bezier18Path addCurveToPoint:CGPointMake(33.01, 22.47) controlPoint1:CGPointMake(32.96, 22.54) controlPoint2:CGPointMake(32.97, 22.5)];
            [bezier18Path addCurveToPoint:CGPointMake(33.16, 22.42) controlPoint1:CGPointMake(33.04, 22.44) controlPoint2:CGPointMake(33.09, 22.42)];
            [bezier18Path addCurveToPoint:CGPointMake(33.31, 22.47) controlPoint1:CGPointMake(33.22, 22.42) controlPoint2:CGPointMake(33.28, 22.44)];
            [bezier18Path addCurveToPoint:CGPointMake(33.36, 22.59) controlPoint1:CGPointMake(33.34, 22.5) controlPoint2:CGPointMake(33.36, 22.54)];
            [bezier18Path addLineToPoint:CGPointMake(33.36, 23.29)];
            [bezier18Path addLineToPoint:CGPointMake(33.41, 23.27)];
            [bezier18Path addLineToPoint:CGPointMake(33.41, 23.27)];
            [bezier18Path closePath];
            bezier18Path.miterLimit = 4;

            [fillColor setFill];
            [bezier18Path fill];

            //// Bezier 19 Drawing
            UIBezierPath *bezier19Path = [UIBezierPath bezierPath];
            [bezier19Path moveToPoint:CGPointMake(35.27, 23.19)];
            [bezier19Path addCurveToPoint:CGPointMake(35.59, 23.23) controlPoint1:CGPointMake(35.4, 23.19) controlPoint2:CGPointMake(35.51, 23.2)];
            [bezier19Path addCurveToPoint:CGPointMake(35.8, 23.35) controlPoint1:CGPointMake(35.68, 23.26) controlPoint2:CGPointMake(35.75, 23.3)];
            [bezier19Path addCurveToPoint:CGPointMake(35.91, 23.55) controlPoint1:CGPointMake(35.86, 23.4) controlPoint2:CGPointMake(35.89, 23.47)];
            [bezier19Path addCurveToPoint:CGPointMake(35.95, 23.82) controlPoint1:CGPointMake(35.93, 23.63) controlPoint2:CGPointMake(35.95, 23.72)];
            [bezier19Path addCurveToPoint:CGPointMake(35.91, 24.08) controlPoint1:CGPointMake(35.95, 23.92) controlPoint2:CGPointMake(35.94, 24.01)];
            [bezier19Path addCurveToPoint:CGPointMake(35.78, 24.27) controlPoint1:CGPointMake(35.88, 24.16) controlPoint2:CGPointMake(35.84, 24.22)];
            [bezier19Path addCurveToPoint:CGPointMake(35.55, 24.39) controlPoint1:CGPointMake(35.72, 24.32) controlPoint2:CGPointMake(35.65, 24.36)];
            [bezier19Path addCurveToPoint:CGPointMake(35.19, 24.43) controlPoint1:CGPointMake(35.45, 24.42) controlPoint2:CGPointMake(35.33, 24.43)];
            [bezier19Path addCurveToPoint:CGPointMake(34.89, 24.4) controlPoint1:CGPointMake(35.08, 24.43) controlPoint2:CGPointMake(34.98, 24.42)];
            [bezier19Path addCurveToPoint:CGPointMake(34.65, 24.3) controlPoint1:CGPointMake(34.8, 24.38) controlPoint2:CGPointMake(34.72, 24.35)];
            [bezier19Path addCurveToPoint:CGPointMake(34.5, 24.13) controlPoint1:CGPointMake(34.59, 24.26) controlPoint2:CGPointMake(34.54, 24.2)];
            [bezier19Path addCurveToPoint:CGPointMake(34.45, 23.87) controlPoint1:CGPointMake(34.46, 24.06) controlPoint2:CGPointMake(34.45, 23.97)];
            [bezier19Path addLineToPoint:CGPointMake(34.45, 22.57)];
            [bezier19Path addCurveToPoint:CGPointMake(34.46, 22.51) controlPoint1:CGPointMake(34.45, 22.55) controlPoint2:CGPointMake(34.45, 22.53)];
            [bezier19Path addCurveToPoint:CGPointMake(34.5, 22.45) controlPoint1:CGPointMake(34.47, 22.49) controlPoint2:CGPointMake(34.48, 22.47)];
            [bezier19Path addCurveToPoint:CGPointMake(34.56, 22.41) controlPoint1:CGPointMake(34.52, 22.43) controlPoint2:CGPointMake(34.54, 22.42)];
            [bezier19Path addCurveToPoint:CGPointMake(34.66, 22.39) controlPoint1:CGPointMake(34.59, 22.4) controlPoint2:CGPointMake(34.62, 22.39)];
            [bezier19Path addCurveToPoint:CGPointMake(34.81, 22.44) controlPoint1:CGPointMake(34.72, 22.39) controlPoint2:CGPointMake(34.78, 22.41)];
            [bezier19Path addCurveToPoint:CGPointMake(34.86, 22.56) controlPoint1:CGPointMake(34.84, 22.47) controlPoint2:CGPointMake(34.86, 22.51)];
            [bezier19Path addLineToPoint:CGPointMake(34.86, 23.21)];
            [bezier19Path addCurveToPoint:CGPointMake(35.1, 23.19) controlPoint1:CGPointMake(34.95, 23.2) controlPoint2:CGPointMake(35.04, 23.19)];
            [bezier19Path addCurveToPoint:CGPointMake(35.27, 23.19) controlPoint1:CGPointMake(35.16, 23.19) controlPoint2:CGPointMake(35.22, 23.19)];
            [bezier19Path closePath];
            [bezier19Path moveToPoint:CGPointMake(35.57, 23.81)];
            [bezier19Path addCurveToPoint:CGPointMake(35.55, 23.66) controlPoint1:CGPointMake(35.57, 23.75) controlPoint2:CGPointMake(35.56, 23.7)];
            [bezier19Path addCurveToPoint:CGPointMake(35.49, 23.57) controlPoint1:CGPointMake(35.54, 23.62) controlPoint2:CGPointMake(35.52, 23.59)];
            [bezier19Path addCurveToPoint:CGPointMake(35.38, 23.53) controlPoint1:CGPointMake(35.46, 23.55) controlPoint2:CGPointMake(35.42, 23.53)];
            [bezier19Path addCurveToPoint:CGPointMake(35.2, 23.52) controlPoint1:CGPointMake(35.33, 23.52) controlPoint2:CGPointMake(35.27, 23.52)];
            [bezier19Path addCurveToPoint:CGPointMake(35.06, 23.52) controlPoint1:CGPointMake(35.14, 23.52) controlPoint2:CGPointMake(35.1, 23.52)];
            [bezier19Path addCurveToPoint:CGPointMake(34.97, 23.52) controlPoint1:CGPointMake(35.02, 23.52) controlPoint2:CGPointMake(34.99, 23.52)];
            [bezier19Path addCurveToPoint:CGPointMake(34.9, 23.53) controlPoint1:CGPointMake(34.94, 23.52) controlPoint2:CGPointMake(34.92, 23.52)];
            [bezier19Path addCurveToPoint:CGPointMake(34.83, 23.54) controlPoint1:CGPointMake(34.88, 23.53) controlPoint2:CGPointMake(34.86, 23.54)];
            [bezier19Path addLineToPoint:CGPointMake(34.83, 23.8)];
            [bezier19Path addCurveToPoint:CGPointMake(34.85, 23.94) controlPoint1:CGPointMake(34.83, 23.85) controlPoint2:CGPointMake(34.84, 23.9)];
            [bezier19Path addCurveToPoint:CGPointMake(34.91, 24.04) controlPoint1:CGPointMake(34.86, 23.98) controlPoint2:CGPointMake(34.88, 24.01)];
            [bezier19Path addCurveToPoint:CGPointMake(35.02, 24.1) controlPoint1:CGPointMake(34.94, 24.07) controlPoint2:CGPointMake(34.97, 24.09)];
            [bezier19Path addCurveToPoint:CGPointMake(35.19, 24.12) controlPoint1:CGPointMake(35.07, 24.11) controlPoint2:CGPointMake(35.13, 24.12)];
            [bezier19Path addCurveToPoint:CGPointMake(35.35, 24.11) controlPoint1:CGPointMake(35.25, 24.12) controlPoint2:CGPointMake(35.31, 24.12)];
            [bezier19Path addCurveToPoint:CGPointMake(35.46, 24.07) controlPoint1:CGPointMake(35.4, 24.1) controlPoint2:CGPointMake(35.43, 24.09)];
            [bezier19Path addCurveToPoint:CGPointMake(35.53, 23.98) controlPoint1:CGPointMake(35.49, 24.05) controlPoint2:CGPointMake(35.51, 24.02)];
            [bezier19Path addCurveToPoint:CGPointMake(35.57, 23.81) controlPoint1:CGPointMake(35.56, 23.92) controlPoint2:CGPointMake(35.57, 23.87)];
            [bezier19Path closePath];
            bezier19Path.miterLimit = 4;

            [fillColor setFill];
            [bezier19Path fill];

            //// Bezier 20 Drawing
            UIBezierPath *bezier20Path = [UIBezierPath bezierPath];
            [bezier20Path moveToPoint:CGPointMake(37.89, 23.27)];
            [bezier20Path addCurveToPoint:CGPointMake(38.03, 23.31) controlPoint1:CGPointMake(37.94, 23.27) controlPoint2:CGPointMake(37.99, 23.28)];
            [bezier20Path addCurveToPoint:CGPointMake(38.09, 23.43) controlPoint1:CGPointMake(38.07, 23.33) controlPoint2:CGPointMake(38.09, 23.37)];
            [bezier20Path addCurveToPoint:CGPointMake(38.03, 23.56) controlPoint1:CGPointMake(38.09, 23.49) controlPoint2:CGPointMake(38.07, 23.53)];
            [bezier20Path addCurveToPoint:CGPointMake(37.9, 23.6) controlPoint1:CGPointMake(38, 23.59) controlPoint2:CGPointMake(37.95, 23.6)];
            [bezier20Path addLineToPoint:CGPointMake(37.83, 23.6)];
            [bezier20Path addLineToPoint:CGPointMake(37.83, 24.27)];
            [bezier20Path addCurveToPoint:CGPointMake(37.82, 24.32) controlPoint1:CGPointMake(37.83, 24.29) controlPoint2:CGPointMake(37.83, 24.31)];
            [bezier20Path addCurveToPoint:CGPointMake(37.78, 24.37) controlPoint1:CGPointMake(37.81, 24.34) controlPoint2:CGPointMake(37.8, 24.36)];
            [bezier20Path addCurveToPoint:CGPointMake(37.72, 24.41) controlPoint1:CGPointMake(37.76, 24.39) controlPoint2:CGPointMake(37.75, 24.4)];
            [bezier20Path addCurveToPoint:CGPointMake(37.63, 24.43) controlPoint1:CGPointMake(37.69, 24.42) controlPoint2:CGPointMake(37.66, 24.43)];
            [bezier20Path addCurveToPoint:CGPointMake(37.54, 24.41) controlPoint1:CGPointMake(37.59, 24.43) controlPoint2:CGPointMake(37.56, 24.43)];
            [bezier20Path addCurveToPoint:CGPointMake(37.48, 24.37) controlPoint1:CGPointMake(37.52, 24.4) controlPoint2:CGPointMake(37.5, 24.39)];
            [bezier20Path addCurveToPoint:CGPointMake(37.45, 24.32) controlPoint1:CGPointMake(37.46, 24.35) controlPoint2:CGPointMake(37.45, 24.34)];
            [bezier20Path addCurveToPoint:CGPointMake(37.44, 24.27) controlPoint1:CGPointMake(37.44, 24.3) controlPoint2:CGPointMake(37.44, 24.28)];
            [bezier20Path addLineToPoint:CGPointMake(37.44, 23.6)];
            [bezier20Path addLineToPoint:CGPointMake(36.68, 23.6)];
            [bezier20Path addCurveToPoint:CGPointMake(36.59, 23.58) controlPoint1:CGPointMake(36.63, 23.6) controlPoint2:CGPointMake(36.6, 23.59)];
            [bezier20Path addCurveToPoint:CGPointMake(36.57, 23.5) controlPoint1:CGPointMake(36.57, 23.56) controlPoint2:CGPointMake(36.57, 23.54)];
            [bezier20Path addLineToPoint:CGPointMake(36.57, 22.59)];
            [bezier20Path addCurveToPoint:CGPointMake(36.58, 22.53) controlPoint1:CGPointMake(36.57, 22.57) controlPoint2:CGPointMake(36.58, 22.55)];
            [bezier20Path addCurveToPoint:CGPointMake(36.61, 22.47) controlPoint1:CGPointMake(36.59, 22.51) controlPoint2:CGPointMake(36.6, 22.49)];
            [bezier20Path addCurveToPoint:CGPointMake(36.67, 22.43) controlPoint1:CGPointMake(36.63, 22.46) controlPoint2:CGPointMake(36.64, 22.44)];
            [bezier20Path addCurveToPoint:CGPointMake(36.76, 22.41) controlPoint1:CGPointMake(36.7, 22.42) controlPoint2:CGPointMake(36.73, 22.41)];
            [bezier20Path addCurveToPoint:CGPointMake(36.91, 22.46) controlPoint1:CGPointMake(36.83, 22.41) controlPoint2:CGPointMake(36.88, 22.43)];
            [bezier20Path addCurveToPoint:CGPointMake(36.96, 22.59) controlPoint1:CGPointMake(36.94, 22.49) controlPoint2:CGPointMake(36.96, 22.54)];
            [bezier20Path addLineToPoint:CGPointMake(36.96, 23.29)];
            [bezier20Path addLineToPoint:CGPointMake(37.45, 23.29)];
            [bezier20Path addLineToPoint:CGPointMake(37.45, 22.59)];
            [bezier20Path addCurveToPoint:CGPointMake(37.5, 22.47) controlPoint1:CGPointMake(37.45, 22.54) controlPoint2:CGPointMake(37.47, 22.5)];
            [bezier20Path addCurveToPoint:CGPointMake(37.65, 22.42) controlPoint1:CGPointMake(37.53, 22.44) controlPoint2:CGPointMake(37.58, 22.42)];
            [bezier20Path addCurveToPoint:CGPointMake(37.79, 22.47) controlPoint1:CGPointMake(37.71, 22.42) controlPoint2:CGPointMake(37.76, 22.44)];
            [bezier20Path addCurveToPoint:CGPointMake(37.84, 22.59) controlPoint1:CGPointMake(37.82, 22.5) controlPoint2:CGPointMake(37.84, 22.54)];
            [bezier20Path addLineToPoint:CGPointMake(37.84, 23.29)];
            [bezier20Path addLineToPoint:CGPointMake(37.89, 23.27)];
            [bezier20Path addLineToPoint:CGPointMake(37.89, 23.27)];
            [bezier20Path closePath];
            bezier20Path.miterLimit = 4;

            [fillColor setFill];
            [bezier20Path fill];

            //// Bezier 21 Drawing
            UIBezierPath *bezier21Path = [UIBezierPath bezierPath];
            [bezier21Path moveToPoint:CGPointMake(40.25, 23.88)];
            [bezier21Path addLineToPoint:CGPointMake(40.25, 23.88)];
            [bezier21Path addCurveToPoint:CGPointMake(40.2, 24.14) controlPoint1:CGPointMake(40.25, 23.99) controlPoint2:CGPointMake(40.24, 24.07)];
            [bezier21Path addCurveToPoint:CGPointMake(40.04, 24.31) controlPoint1:CGPointMake(40.16, 24.21) controlPoint2:CGPointMake(40.11, 24.27)];
            [bezier21Path addCurveToPoint:CGPointMake(39.8, 24.4) controlPoint1:CGPointMake(39.97, 24.35) controlPoint2:CGPointMake(39.89, 24.38)];
            [bezier21Path addCurveToPoint:CGPointMake(39.49, 24.43) controlPoint1:CGPointMake(39.71, 24.42) controlPoint2:CGPointMake(39.6, 24.43)];
            [bezier21Path addCurveToPoint:CGPointMake(39.18, 24.4) controlPoint1:CGPointMake(39.38, 24.43) controlPoint2:CGPointMake(39.27, 24.42)];
            [bezier21Path addCurveToPoint:CGPointMake(38.95, 24.31) controlPoint1:CGPointMake(39.09, 24.38) controlPoint2:CGPointMake(39.01, 24.35)];
            [bezier21Path addCurveToPoint:CGPointMake(38.8, 24.14) controlPoint1:CGPointMake(38.89, 24.27) controlPoint2:CGPointMake(38.84, 24.21)];
            [bezier21Path addCurveToPoint:CGPointMake(38.75, 23.9) controlPoint1:CGPointMake(38.77, 24.07) controlPoint2:CGPointMake(38.75, 23.99)];
            [bezier21Path addLineToPoint:CGPointMake(38.75, 22.93)];
            [bezier21Path addCurveToPoint:CGPointMake(38.95, 22.54) controlPoint1:CGPointMake(38.75, 22.76) controlPoint2:CGPointMake(38.82, 22.63)];
            [bezier21Path addCurveToPoint:CGPointMake(39.51, 22.41) controlPoint1:CGPointMake(39.08, 22.46) controlPoint2:CGPointMake(39.27, 22.41)];
            [bezier21Path addCurveToPoint:CGPointMake(39.82, 22.44) controlPoint1:CGPointMake(39.62, 22.41) controlPoint2:CGPointMake(39.72, 22.42)];
            [bezier21Path addCurveToPoint:CGPointMake(40.05, 22.54) controlPoint1:CGPointMake(39.91, 22.46) controlPoint2:CGPointMake(39.99, 22.5)];
            [bezier21Path addCurveToPoint:CGPointMake(40.2, 22.71) controlPoint1:CGPointMake(40.11, 22.58) controlPoint2:CGPointMake(40.17, 22.64)];
            [bezier21Path addCurveToPoint:CGPointMake(40.25, 22.94) controlPoint1:CGPointMake(40.24, 22.78) controlPoint2:CGPointMake(40.25, 22.85)];
            [bezier21Path addLineToPoint:CGPointMake(40.25, 23.88)];
            [bezier21Path closePath];
            [bezier21Path moveToPoint:CGPointMake(39.85, 22.95)];
            [bezier21Path addCurveToPoint:CGPointMake(39.76, 22.78) controlPoint1:CGPointMake(39.85, 22.88) controlPoint2:CGPointMake(39.82, 22.82)];
            [bezier21Path addCurveToPoint:CGPointMake(39.49, 22.72) controlPoint1:CGPointMake(39.7, 22.74) controlPoint2:CGPointMake(39.61, 22.72)];
            [bezier21Path addCurveToPoint:CGPointMake(39.22, 22.78) controlPoint1:CGPointMake(39.37, 22.72) controlPoint2:CGPointMake(39.28, 22.74)];
            [bezier21Path addCurveToPoint:CGPointMake(39.14, 22.94) controlPoint1:CGPointMake(39.16, 22.82) controlPoint2:CGPointMake(39.14, 22.87)];
            [bezier21Path addLineToPoint:CGPointMake(39.14, 23.89)];
            [bezier21Path addCurveToPoint:CGPointMake(39.23, 24.06) controlPoint1:CGPointMake(39.14, 23.97) controlPoint2:CGPointMake(39.17, 24.02)];
            [bezier21Path addCurveToPoint:CGPointMake(39.49, 24.11) controlPoint1:CGPointMake(39.29, 24.09) controlPoint2:CGPointMake(39.38, 24.11)];
            [bezier21Path addCurveToPoint:CGPointMake(39.76, 24.06) controlPoint1:CGPointMake(39.6, 24.11) controlPoint2:CGPointMake(39.7, 24.09)];
            [bezier21Path addCurveToPoint:CGPointMake(39.86, 23.89) controlPoint1:CGPointMake(39.82, 24.03) controlPoint2:CGPointMake(39.86, 23.97)];
            [bezier21Path addLineToPoint:CGPointMake(39.86, 22.95)];
            [bezier21Path addLineToPoint:CGPointMake(39.85, 22.95)];
            [bezier21Path closePath];
            bezier21Path.miterLimit = 4;

            [fillColor setFill];
            [bezier21Path fill];
        }
    }

    //// Bezier 22 Drawing
    UIBezierPath *bezier22Path = [UIBezierPath bezierPath];
    [bezier22Path moveToPoint:CGPointMake(6.92, 23.82)];
    [bezier22Path addCurveToPoint:CGPointMake(6.88, 24.11) controlPoint1:CGPointMake(6.92, 23.94) controlPoint2:CGPointMake(6.91, 24.03)];
    [bezier22Path addCurveToPoint:CGPointMake(6.75, 24.3) controlPoint1:CGPointMake(6.86, 24.19) controlPoint2:CGPointMake(6.81, 24.25)];
    [bezier22Path addCurveToPoint:CGPointMake(6.5, 24.4) controlPoint1:CGPointMake(6.69, 24.35) controlPoint2:CGPointMake(6.61, 24.38)];
    [bezier22Path addCurveToPoint:CGPointMake(6.1, 24.43) controlPoint1:CGPointMake(6.39, 24.42) controlPoint2:CGPointMake(6.26, 24.43)];
    [bezier22Path addLineToPoint:CGPointMake(6.08, 24.43)];
    [bezier22Path addCurveToPoint:CGPointMake(5.95, 24.43) controlPoint1:CGPointMake(6.04, 24.43) controlPoint2:CGPointMake(6, 24.43)];
    [bezier22Path addCurveToPoint:CGPointMake(5.8, 24.42) controlPoint1:CGPointMake(5.9, 24.43) controlPoint2:CGPointMake(5.85, 24.43)];
    [bezier22Path addCurveToPoint:CGPointMake(5.66, 24.39) controlPoint1:CGPointMake(5.75, 24.41) controlPoint2:CGPointMake(5.7, 24.41)];
    [bezier22Path addCurveToPoint:CGPointMake(5.53, 24.34) controlPoint1:CGPointMake(5.61, 24.38) controlPoint2:CGPointMake(5.57, 24.36)];
    [bezier22Path addCurveToPoint:CGPointMake(5.44, 24.26) controlPoint1:CGPointMake(5.49, 24.32) controlPoint2:CGPointMake(5.46, 24.29)];
    [bezier22Path addCurveToPoint:CGPointMake(5.4, 24.15) controlPoint1:CGPointMake(5.42, 24.23) controlPoint2:CGPointMake(5.41, 24.19)];
    [bezier22Path addLineToPoint:CGPointMake(5.4, 24.14)];
    [bezier22Path addCurveToPoint:CGPointMake(5.46, 24.02) controlPoint1:CGPointMake(5.4, 24.09) controlPoint2:CGPointMake(5.42, 24.05)];
    [bezier22Path addCurveToPoint:CGPointMake(5.58, 23.98) controlPoint1:CGPointMake(5.5, 23.99) controlPoint2:CGPointMake(5.54, 23.98)];
    [bezier22Path addLineToPoint:CGPointMake(5.58, 23.98)];
    [bezier22Path addCurveToPoint:CGPointMake(5.64, 23.98) controlPoint1:CGPointMake(5.61, 23.98) controlPoint2:CGPointMake(5.63, 23.98)];
    [bezier22Path addCurveToPoint:CGPointMake(5.68, 24.01) controlPoint1:CGPointMake(5.66, 24) controlPoint2:CGPointMake(5.67, 24)];
    [bezier22Path addCurveToPoint:CGPointMake(5.71, 24.03) controlPoint1:CGPointMake(5.69, 24.02) controlPoint2:CGPointMake(5.7, 24.02)];
    [bezier22Path addCurveToPoint:CGPointMake(5.73, 24.05) controlPoint1:CGPointMake(5.71, 24.04) controlPoint2:CGPointMake(5.73, 24.04)];
    [bezier22Path addLineToPoint:CGPointMake(5.73, 24.05)];
    [bezier22Path addCurveToPoint:CGPointMake(5.77, 24.08) controlPoint1:CGPointMake(5.74, 24.06) controlPoint2:CGPointMake(5.76, 24.07)];
    [bezier22Path addCurveToPoint:CGPointMake(5.84, 24.1) controlPoint1:CGPointMake(5.78, 24.09) controlPoint2:CGPointMake(5.81, 24.09)];
    [bezier22Path addCurveToPoint:CGPointMake(5.94, 24.12) controlPoint1:CGPointMake(5.87, 24.11) controlPoint2:CGPointMake(5.9, 24.11)];
    [bezier22Path addCurveToPoint:CGPointMake(6.11, 24.12) controlPoint1:CGPointMake(5.98, 24.12) controlPoint2:CGPointMake(6.04, 24.12)];
    [bezier22Path addLineToPoint:CGPointMake(6.14, 24.12)];
    [bezier22Path addCurveToPoint:CGPointMake(6.33, 24.1) controlPoint1:CGPointMake(6.22, 24.12) controlPoint2:CGPointMake(6.28, 24.12)];
    [bezier22Path addCurveToPoint:CGPointMake(6.45, 24.05) controlPoint1:CGPointMake(6.38, 24.09) controlPoint2:CGPointMake(6.42, 24.07)];
    [bezier22Path addCurveToPoint:CGPointMake(6.51, 23.96) controlPoint1:CGPointMake(6.47, 24.03) controlPoint2:CGPointMake(6.5, 23.99)];
    [bezier22Path addCurveToPoint:CGPointMake(6.53, 23.83) controlPoint1:CGPointMake(6.52, 23.92) controlPoint2:CGPointMake(6.53, 23.88)];
    [bezier22Path addCurveToPoint:CGPointMake(6.49, 23.64) controlPoint1:CGPointMake(6.53, 23.74) controlPoint2:CGPointMake(6.52, 23.67)];
    [bezier22Path addCurveToPoint:CGPointMake(6.36, 23.58) controlPoint1:CGPointMake(6.47, 23.61) controlPoint2:CGPointMake(6.43, 23.58)];
    [bezier22Path addLineToPoint:CGPointMake(5.94, 23.58)];
    [bezier22Path addCurveToPoint:CGPointMake(5.87, 23.57) controlPoint1:CGPointMake(5.92, 23.58) controlPoint2:CGPointMake(5.89, 23.58)];
    [bezier22Path addCurveToPoint:CGPointMake(5.81, 23.55) controlPoint1:CGPointMake(5.85, 23.57) controlPoint2:CGPointMake(5.83, 23.56)];
    [bezier22Path addCurveToPoint:CGPointMake(5.77, 23.5) controlPoint1:CGPointMake(5.79, 23.54) controlPoint2:CGPointMake(5.78, 23.52)];
    [bezier22Path addCurveToPoint:CGPointMake(5.75, 23.42) controlPoint1:CGPointMake(5.76, 23.48) controlPoint2:CGPointMake(5.75, 23.45)];
    [bezier22Path addCurveToPoint:CGPointMake(5.81, 23.29) controlPoint1:CGPointMake(5.75, 23.36) controlPoint2:CGPointMake(5.77, 23.32)];
    [bezier22Path addCurveToPoint:CGPointMake(5.94, 23.25) controlPoint1:CGPointMake(5.85, 23.27) controlPoint2:CGPointMake(5.9, 23.25)];
    [bezier22Path addLineToPoint:CGPointMake(6.34, 23.25)];
    [bezier22Path addCurveToPoint:CGPointMake(6.42, 23.24) controlPoint1:CGPointMake(6.37, 23.25) controlPoint2:CGPointMake(6.4, 23.25)];
    [bezier22Path addCurveToPoint:CGPointMake(6.48, 23.2) controlPoint1:CGPointMake(6.44, 23.23) controlPoint2:CGPointMake(6.46, 23.22)];
    [bezier22Path addCurveToPoint:CGPointMake(6.52, 23.13) controlPoint1:CGPointMake(6.49, 23.18) controlPoint2:CGPointMake(6.51, 23.16)];
    [bezier22Path addCurveToPoint:CGPointMake(6.53, 23.01) controlPoint1:CGPointMake(6.53, 23.1) controlPoint2:CGPointMake(6.53, 23.06)];
    [bezier22Path addCurveToPoint:CGPointMake(6.52, 22.88) controlPoint1:CGPointMake(6.53, 22.96) controlPoint2:CGPointMake(6.53, 22.91)];
    [bezier22Path addCurveToPoint:CGPointMake(6.47, 22.79) controlPoint1:CGPointMake(6.51, 22.84) controlPoint2:CGPointMake(6.5, 22.81)];
    [bezier22Path addCurveToPoint:CGPointMake(6.36, 22.74) controlPoint1:CGPointMake(6.45, 22.77) controlPoint2:CGPointMake(6.41, 22.75)];
    [bezier22Path addCurveToPoint:CGPointMake(6.16, 22.73) controlPoint1:CGPointMake(6.31, 22.73) controlPoint2:CGPointMake(6.24, 22.73)];
    [bezier22Path addLineToPoint:CGPointMake(6.14, 22.73)];
    [bezier22Path addCurveToPoint:CGPointMake(5.97, 22.74) controlPoint1:CGPointMake(6.09, 22.73) controlPoint2:CGPointMake(6.03, 22.73)];
    [bezier22Path addCurveToPoint:CGPointMake(5.83, 22.78) controlPoint1:CGPointMake(5.91, 22.75) controlPoint2:CGPointMake(5.87, 22.76)];
    [bezier22Path addCurveToPoint:CGPointMake(5.78, 22.8) controlPoint1:CGPointMake(5.81, 22.79) controlPoint2:CGPointMake(5.8, 22.8)];
    [bezier22Path addCurveToPoint:CGPointMake(5.74, 22.82) controlPoint1:CGPointMake(5.77, 22.81) controlPoint2:CGPointMake(5.75, 22.82)];
    [bezier22Path addCurveToPoint:CGPointMake(5.69, 22.83) controlPoint1:CGPointMake(5.73, 22.83) controlPoint2:CGPointMake(5.71, 22.83)];
    [bezier22Path addCurveToPoint:CGPointMake(5.63, 22.83) controlPoint1:CGPointMake(5.67, 22.83) controlPoint2:CGPointMake(5.66, 22.83)];
    [bezier22Path addLineToPoint:CGPointMake(5.63, 22.83)];
    [bezier22Path addCurveToPoint:CGPointMake(5.51, 22.79) controlPoint1:CGPointMake(5.58, 22.83) controlPoint2:CGPointMake(5.54, 22.81)];
    [bezier22Path addCurveToPoint:CGPointMake(5.46, 22.68) controlPoint1:CGPointMake(5.47, 22.76) controlPoint2:CGPointMake(5.46, 22.72)];
    [bezier22Path addLineToPoint:CGPointMake(5.46, 22.68)];
    [bezier22Path addCurveToPoint:CGPointMake(5.51, 22.56) controlPoint1:CGPointMake(5.46, 22.63) controlPoint2:CGPointMake(5.48, 22.59)];
    [bezier22Path addCurveToPoint:CGPointMake(5.63, 22.47) controlPoint1:CGPointMake(5.54, 22.52) controlPoint2:CGPointMake(5.58, 22.5)];
    [bezier22Path addCurveToPoint:CGPointMake(5.84, 22.41) controlPoint1:CGPointMake(5.68, 22.45) controlPoint2:CGPointMake(5.75, 22.43)];
    [bezier22Path addCurveToPoint:CGPointMake(6.15, 22.39) controlPoint1:CGPointMake(5.92, 22.4) controlPoint2:CGPointMake(6.02, 22.39)];
    [bezier22Path addCurveToPoint:CGPointMake(6.52, 22.41) controlPoint1:CGPointMake(6.29, 22.39) controlPoint2:CGPointMake(6.42, 22.4)];
    [bezier22Path addCurveToPoint:CGPointMake(6.76, 22.49) controlPoint1:CGPointMake(6.62, 22.42) controlPoint2:CGPointMake(6.7, 22.45)];
    [bezier22Path addCurveToPoint:CGPointMake(6.89, 22.66) controlPoint1:CGPointMake(6.82, 22.53) controlPoint2:CGPointMake(6.87, 22.59)];
    [bezier22Path addCurveToPoint:CGPointMake(6.93, 22.94) controlPoint1:CGPointMake(6.92, 22.74) controlPoint2:CGPointMake(6.93, 22.83)];
    [bezier22Path addCurveToPoint:CGPointMake(6.92, 23.1) controlPoint1:CGPointMake(6.93, 23) controlPoint2:CGPointMake(6.93, 23.05)];
    [bezier22Path addCurveToPoint:CGPointMake(6.9, 23.22) controlPoint1:CGPointMake(6.91, 23.14) controlPoint2:CGPointMake(6.91, 23.18)];
    [bezier22Path addCurveToPoint:CGPointMake(6.86, 23.31) controlPoint1:CGPointMake(6.89, 23.25) controlPoint2:CGPointMake(6.88, 23.28)];
    [bezier22Path addCurveToPoint:CGPointMake(6.81, 23.38) controlPoint1:CGPointMake(6.85, 23.34) controlPoint2:CGPointMake(6.83, 23.36)];
    [bezier22Path addCurveToPoint:CGPointMake(6.86, 23.43) controlPoint1:CGPointMake(6.83, 23.39) controlPoint2:CGPointMake(6.84, 23.41)];
    [bezier22Path addCurveToPoint:CGPointMake(6.9, 23.51) controlPoint1:CGPointMake(6.87, 23.45) controlPoint2:CGPointMake(6.89, 23.48)];
    [bezier22Path addCurveToPoint:CGPointMake(6.93, 23.63) controlPoint1:CGPointMake(6.91, 23.54) controlPoint2:CGPointMake(6.92, 23.58)];
    [bezier22Path addCurveToPoint:CGPointMake(6.92, 23.82) controlPoint1:CGPointMake(6.92, 23.69) controlPoint2:CGPointMake(6.92, 23.75)];
    [bezier22Path closePath];
    bezier22Path.miterLimit = 4;

    [fillColor setFill];
    [bezier22Path fill];
}

//// Group 14
{
    //// Bezier 23 Drawing
    UIBezierPath *bezier23Path = [UIBezierPath bezierPath];
    [bezier23Path moveToPoint:CGPointMake(34.46, 20.77)];
    [bezier23Path addLineToPoint:CGPointMake(34.46, 20.6)];
    [bezier23Path addCurveToPoint:CGPointMake(35.41, 19.53) controlPoint1:CGPointMake(35.08, 20.11) controlPoint2:CGPointMake(35.41, 19.83)];
    [bezier23Path addCurveToPoint:CGPointMake(35.05, 19.22) controlPoint1:CGPointMake(35.41, 19.31) controlPoint2:CGPointMake(35.23, 19.22)];
    [bezier23Path addCurveToPoint:CGPointMake(34.58, 19.44) controlPoint1:CGPointMake(34.84, 19.22) controlPoint2:CGPointMake(34.68, 19.31)];
    [bezier23Path addLineToPoint:CGPointMake(34.45, 19.3)];
    [bezier23Path addCurveToPoint:CGPointMake(35.05, 19.03) controlPoint1:CGPointMake(34.58, 19.13) controlPoint2:CGPointMake(34.81, 19.03)];
    [bezier23Path addCurveToPoint:CGPointMake(35.63, 19.54) controlPoint1:CGPointMake(35.34, 19.03) controlPoint2:CGPointMake(35.63, 19.19)];
    [bezier23Path addCurveToPoint:CGPointMake(34.79, 20.59) controlPoint1:CGPointMake(35.63, 19.89) controlPoint2:CGPointMake(35.27, 20.21)];
    [bezier23Path addLineToPoint:CGPointMake(35.63, 20.59)];
    [bezier23Path addLineToPoint:CGPointMake(35.63, 20.78)];
    [bezier23Path addLineToPoint:CGPointMake(34.46, 20.78)];
    [bezier23Path addLineToPoint:CGPointMake(34.46, 20.77)];
    [bezier23Path closePath];
    bezier23Path.miterLimit = 4;

    [fillColor5 setFill];
    [bezier23Path fill];

    //// Bezier 24 Drawing
    UIBezierPath *bezier24Path = [UIBezierPath bezierPath];
    [bezier24Path moveToPoint:CGPointMake(36.06, 20.51)];
    [bezier24Path addLineToPoint:CGPointMake(36.19, 20.38)];
    [bezier24Path addCurveToPoint:CGPointMake(36.67, 20.61) controlPoint1:CGPointMake(36.29, 20.51) controlPoint2:CGPointMake(36.47, 20.61)];
    [bezier24Path addCurveToPoint:CGPointMake(37.07, 20.29) controlPoint1:CGPointMake(36.92, 20.61) controlPoint2:CGPointMake(37.07, 20.49)];
    [bezier24Path addCurveToPoint:CGPointMake(36.64, 19.99) controlPoint1:CGPointMake(37.07, 20.08) controlPoint2:CGPointMake(36.89, 19.99)];
    [bezier24Path addCurveToPoint:CGPointMake(36.46, 19.99) controlPoint1:CGPointMake(36.57, 19.99) controlPoint2:CGPointMake(36.49, 19.99)];
    [bezier24Path addLineToPoint:CGPointMake(36.46, 19.79)];
    [bezier24Path addCurveToPoint:CGPointMake(36.64, 19.79) controlPoint1:CGPointMake(36.49, 19.79) controlPoint2:CGPointMake(36.57, 19.79)];
    [bezier24Path addCurveToPoint:CGPointMake(37.04, 19.51) controlPoint1:CGPointMake(36.86, 19.79) controlPoint2:CGPointMake(37.04, 19.7)];
    [bezier24Path addCurveToPoint:CGPointMake(36.66, 19.22) controlPoint1:CGPointMake(37.04, 19.32) controlPoint2:CGPointMake(36.86, 19.22)];
    [bezier24Path addCurveToPoint:CGPointMake(36.21, 19.43) controlPoint1:CGPointMake(36.47, 19.22) controlPoint2:CGPointMake(36.33, 19.29)];
    [bezier24Path addLineToPoint:CGPointMake(36.09, 19.3)];
    [bezier24Path addCurveToPoint:CGPointMake(36.68, 19.03) controlPoint1:CGPointMake(36.21, 19.15) controlPoint2:CGPointMake(36.41, 19.03)];
    [bezier24Path addCurveToPoint:CGPointMake(37.26, 19.49) controlPoint1:CGPointMake(37.01, 19.03) controlPoint2:CGPointMake(37.26, 19.2)];
    [bezier24Path addCurveToPoint:CGPointMake(36.89, 19.89) controlPoint1:CGPointMake(37.26, 19.74) controlPoint2:CGPointMake(37.05, 19.86)];
    [bezier24Path addCurveToPoint:CGPointMake(37.29, 20.31) controlPoint1:CGPointMake(37.05, 19.9) controlPoint2:CGPointMake(37.29, 20.04)];
    [bezier24Path addCurveToPoint:CGPointMake(36.68, 20.81) controlPoint1:CGPointMake(37.29, 20.6) controlPoint2:CGPointMake(37.06, 20.81)];
    [bezier24Path addCurveToPoint:CGPointMake(36.06, 20.51) controlPoint1:CGPointMake(36.37, 20.8) controlPoint2:CGPointMake(36.16, 20.67)];
    [bezier24Path closePath];
    bezier24Path.miterLimit = 4;

    [fillColor5 setFill];
    [bezier24Path fill];

    //// Bezier 25 Drawing
    UIBezierPath *bezier25Path = [UIBezierPath bezierPath];
    [bezier25Path moveToPoint:CGPointMake(38.14, 20.77)];
    [bezier25Path addLineToPoint:CGPointMake(38.14, 19.33)];
    [bezier25Path addLineToPoint:CGPointMake(37.86, 19.62)];
    [bezier25Path addLineToPoint:CGPointMake(37.73, 19.49)];
    [bezier25Path addLineToPoint:CGPointMake(38.16, 19.05)];
    [bezier25Path addLineToPoint:CGPointMake(38.35, 19.05)];
    [bezier25Path addLineToPoint:CGPointMake(38.35, 20.77)];
    [bezier25Path addLineToPoint:CGPointMake(38.14, 20.77)];
    [bezier25Path closePath];
    bezier25Path.miterLimit = 4;

    [fillColor5 setFill];
    [bezier25Path fill];

    //// Bezier 26 Drawing
    UIBezierPath *bezier26Path = [UIBezierPath bezierPath];
    [bezier26Path moveToPoint:CGPointMake(38.9, 20.77)];
    [bezier26Path addLineToPoint:CGPointMake(38.9, 20.6)];
    [bezier26Path addCurveToPoint:CGPointMake(39.85, 19.53) controlPoint1:CGPointMake(39.52, 20.11) controlPoint2:CGPointMake(39.85, 19.83)];
    [bezier26Path addCurveToPoint:CGPointMake(39.49, 19.22) controlPoint1:CGPointMake(39.85, 19.31) controlPoint2:CGPointMake(39.67, 19.22)];
    [bezier26Path addCurveToPoint:CGPointMake(39.02, 19.44) controlPoint1:CGPointMake(39.28, 19.22) controlPoint2:CGPointMake(39.12, 19.31)];
    [bezier26Path addLineToPoint:CGPointMake(38.89, 19.3)];
    [bezier26Path addCurveToPoint:CGPointMake(39.49, 19.03) controlPoint1:CGPointMake(39.02, 19.13) controlPoint2:CGPointMake(39.25, 19.03)];
    [bezier26Path addCurveToPoint:CGPointMake(40.07, 19.54) controlPoint1:CGPointMake(39.78, 19.03) controlPoint2:CGPointMake(40.07, 19.19)];
    [bezier26Path addCurveToPoint:CGPointMake(39.23, 20.59) controlPoint1:CGPointMake(40.07, 19.89) controlPoint2:CGPointMake(39.72, 20.21)];
    [bezier26Path addLineToPoint:CGPointMake(40.07, 20.59)];
    [bezier26Path addLineToPoint:CGPointMake(40.07, 20.78)];
    [bezier26Path addLineToPoint:CGPointMake(38.9, 20.78)];
    [bezier26Path addLineToPoint:CGPointMake(38.9, 20.77)];
    [bezier26Path closePath];
    bezier26Path.miterLimit = 4;

    [fillColor5 setFill];
    [bezier26Path fill];
}
}

//// Bezier 27 Drawing
UIBezierPath *bezier27Path = [UIBezierPath bezierPath];
[bezier27Path moveToPoint:CGPointMake(40.79, 17)];
[bezier27Path addLineToPoint:CGPointMake(33.67, 17)];
[bezier27Path addCurveToPoint:CGPointMake(32.17, 18.5) controlPoint1:CGPointMake(32.84, 17) controlPoint2:CGPointMake(32.17, 17.67)];
[bezier27Path addLineToPoint:CGPointMake(32.17, 21.31)];
[bezier27Path addCurveToPoint:CGPointMake(33.67, 22.81) controlPoint1:CGPointMake(32.17, 22.14) controlPoint2:CGPointMake(32.84, 22.81)];
[bezier27Path addLineToPoint:CGPointMake(40.79, 22.81)];
[bezier27Path addCurveToPoint:CGPointMake(42.29, 21.31) controlPoint1:CGPointMake(41.62, 22.81) controlPoint2:CGPointMake(42.29, 22.14)];
[bezier27Path addLineToPoint:CGPointMake(42.29, 18.5)];
[bezier27Path addCurveToPoint:CGPointMake(40.79, 17) controlPoint1:CGPointMake(42.29, 17.68) controlPoint2:CGPointMake(41.61, 17)];
[bezier27Path closePath];
[bezier27Path moveToPoint:CGPointMake(41.29, 21.31)];
[bezier27Path addCurveToPoint:CGPointMake(40.79, 21.81) controlPoint1:CGPointMake(41.29, 21.59) controlPoint2:CGPointMake(41.07, 21.81)];
[bezier27Path addLineToPoint:CGPointMake(33.67, 21.81)];
[bezier27Path addCurveToPoint:CGPointMake(33.17, 21.31) controlPoint1:CGPointMake(33.39, 21.81) controlPoint2:CGPointMake(33.17, 21.59)];
[bezier27Path addLineToPoint:CGPointMake(33.17, 18.5)];
[bezier27Path addCurveToPoint:CGPointMake(33.67, 18) controlPoint1:CGPointMake(33.17, 18.22) controlPoint2:CGPointMake(33.39, 18)];
[bezier27Path addLineToPoint:CGPointMake(40.79, 18)];
[bezier27Path addCurveToPoint:CGPointMake(41.29, 18.5) controlPoint1:CGPointMake(41.07, 18) controlPoint2:CGPointMake(41.29, 18.22)];
[bezier27Path addLineToPoint:CGPointMake(41.29, 21.31)];
[bezier27Path closePath];
bezier27Path.miterLimit = 4;

[fillColor6 setFill];
[bezier27Path fill];

//// Cleanup
CGGradientRelease(sVGID_5_2);
CGColorSpaceRelease(colorSpace);
}

- (void)drawIc_card_cvcCanvas {
    //// Color Declarations
    UIColor *fillColor = [UIColor colorWithRed:0.647 green:0.647 blue:0.647 alpha:1];
    UIColor *fillColor2 = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1];
    UIColor *fillColor4 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    UIColor *fillColor5 = [UIColor colorWithRed:0.229 green:0.229 blue:0.229 alpha:1];
    UIColor *fillColor6 = [UIColor colorWithRed:0.89 green:0.122 blue:0.136 alpha:1];
    UIColor *fillColor7 = [UIColor colorWithRed:0.065 green:0.319 blue:0.487 alpha:1];

    //// Group
    {
        //// Group 2
        {
            //// Group 3
            {
                //// Bezier Drawing
                UIBezierPath *bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint:CGPointMake(43.77, 0)];
                [bezierPath addLineToPoint:CGPointMake(2.23, 0)];
                [bezierPath addCurveToPoint:CGPointMake(0, 2.22) controlPoint1:CGPointMake(1, 0) controlPoint2:CGPointMake(0, 0.99)];
                [bezierPath addLineToPoint:CGPointMake(0, 3.33)];
                [bezierPath addLineToPoint:CGPointMake(0, 26.67)];
                [bezierPath addLineToPoint:CGPointMake(0, 27.79)];
                [bezierPath addCurveToPoint:CGPointMake(2.23, 30) controlPoint1:CGPointMake(0, 29.01) controlPoint2:CGPointMake(1, 30)];
                [bezierPath addLineToPoint:CGPointMake(43.77, 30)];
                [bezierPath addCurveToPoint:CGPointMake(46, 27.79) controlPoint1:CGPointMake(45, 30) controlPoint2:CGPointMake(46, 29.01)];
                [bezierPath addLineToPoint:CGPointMake(46, 2.22)];
                [bezierPath addCurveToPoint:CGPointMake(43.77, 0) controlPoint1:CGPointMake(46, 0.99) controlPoint2:CGPointMake(45, 0)];
                [bezierPath closePath];
                bezierPath.miterLimit = 4;

                [fillColor setFill];
                [bezierPath fill];

                //// Rectangle Drawing
                UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.55, 0.57, 44.9, 28.35) cornerRadius:1.6];
                [fillColor2 setFill];
                [rectanglePath fill];
            }

            //// Rectangle 2 Drawing
            UIBezierPath *rectangle2Path = [UIBezierPath bezierPathWithRect:CGRectMake(0.55, 3.97, 44.9, 5.25)];
            [fillColor5 setFill];
            [rectangle2Path fill];

            //// Group 4
            {
                //// Bezier 2 Drawing
                UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
                [bezier2Path moveToPoint:CGPointMake(4.34, 13.23)];
                [bezier2Path addCurveToPoint:CGPointMake(3.68, 13.89) controlPoint1:CGPointMake(4.34, 13.23) controlPoint2:CGPointMake(3.68, 13.23)];
                [bezier2Path addLineToPoint:CGPointMake(3.68, 19.13)];
                [bezier2Path addCurveToPoint:CGPointMake(4.34, 19.79) controlPoint1:CGPointMake(3.68, 19.13) controlPoint2:CGPointMake(3.68, 19.79)];
                [bezier2Path addLineToPoint:CGPointMake(42.79, 19.79)];
                [bezier2Path addCurveToPoint:CGPointMake(43.45, 19.13) controlPoint1:CGPointMake(42.79, 19.79) controlPoint2:CGPointMake(43.45, 19.79)];
                [bezier2Path addLineToPoint:CGPointMake(43.45, 13.89)];
                [bezier2Path addCurveToPoint:CGPointMake(42.79, 13.23) controlPoint1:CGPointMake(43.45, 13.89) controlPoint2:CGPointMake(43.45, 13.23)];
                [bezier2Path addLineToPoint:CGPointMake(4.34, 13.23)];
                [bezier2Path closePath];
                bezier2Path.miterLimit = 4;

                [fillColor4 setFill];
                [bezier2Path fill];

                //// Bezier 3 Drawing
                UIBezierPath *bezier3Path = [UIBezierPath bezierPath];
                [bezier3Path moveToPoint:CGPointMake(27.13, 17.86)];
                [bezier3Path addCurveToPoint:CGPointMake(20.86, 17.36) controlPoint1:CGPointMake(25.14, 17.37) controlPoint2:CGPointMake(22.9, 17.42)];
                [bezier3Path addCurveToPoint:CGPointMake(18.32, 17.52) controlPoint1:CGPointMake(20, 17.34) controlPoint2:CGPointMake(19.17, 17.36)];
                [bezier3Path addCurveToPoint:CGPointMake(16.85, 17.77) controlPoint1:CGPointMake(17.83, 17.61) controlPoint2:CGPointMake(17.34, 17.71)];
                [bezier3Path addCurveToPoint:CGPointMake(15.79, 17.22) controlPoint1:CGPointMake(16.34, 17.83) controlPoint2:CGPointMake(15.55, 17.9)];
                [bezier3Path addCurveToPoint:CGPointMake(16.61, 15.36) controlPoint1:CGPointMake(16.01, 16.58) controlPoint2:CGPointMake(16.36, 15.99)];
                [bezier3Path addCurveToPoint:CGPointMake(16.44, 15.27) controlPoint1:CGPointMake(16.65, 15.25) controlPoint2:CGPointMake(16.5, 15.25)];
                [bezier3Path addCurveToPoint:CGPointMake(13.49, 16.88) controlPoint1:CGPointMake(15.39, 15.67) controlPoint2:CGPointMake(14.48, 16.36)];
                [bezier3Path addCurveToPoint:CGPointMake(11.89, 17.06) controlPoint1:CGPointMake(13.09, 17.09) controlPoint2:CGPointMake(12.04, 17.71)];
                [bezier3Path addCurveToPoint:CGPointMake(11.49, 16.63) controlPoint1:CGPointMake(11.84, 16.85) controlPoint2:CGPointMake(11.68, 16.72)];
                [bezier3Path addCurveToPoint:CGPointMake(9.5, 16.96) controlPoint1:CGPointMake(10.95, 16.37) controlPoint2:CGPointMake(10.02, 16.84)];
                [bezier3Path addCurveToPoint:CGPointMake(8.83, 16.93) controlPoint1:CGPointMake(9.68, 16.92) controlPoint2:CGPointMake(8.65, 17.12)];
                [bezier3Path addCurveToPoint:CGPointMake(9.49, 16.15) controlPoint1:CGPointMake(9.06, 16.68) controlPoint2:CGPointMake(9.27, 16.41)];
                [bezier3Path addCurveToPoint:CGPointMake(10.99, 14.58) controlPoint1:CGPointMake(9.95, 15.58) controlPoint2:CGPointMake(10.43, 15.05)];
                [bezier3Path addCurveToPoint:CGPointMake(10.85, 14.45) controlPoint1:CGPointMake(11.11, 14.48) controlPoint2:CGPointMake(10.95, 14.41)];
                [bezier3Path addCurveToPoint:CGPointMake(5.19, 17.89) controlPoint1:CGPointMake(8.7, 15.3) controlPoint2:CGPointMake(7, 16.46)];
                [bezier3Path addCurveToPoint:CGPointMake(5.36, 18.01) controlPoint1:CGPointMake(5.06, 18) controlPoint2:CGPointMake(5.26, 18.08)];
                [bezier3Path addCurveToPoint:CGPointMake(10.44, 14.84) controlPoint1:CGPointMake(6.99, 16.72) controlPoint2:CGPointMake(8.56, 15.66)];
                [bezier3Path addCurveToPoint:CGPointMake(8.41, 17.09) controlPoint1:CGPointMake(9.71, 15.54) controlPoint2:CGPointMake(9.11, 16.34)];
                [bezier3Path addCurveToPoint:CGPointMake(8.47, 17.22) controlPoint1:CGPointMake(8.36, 17.15) controlPoint2:CGPointMake(8.41, 17.21)];
                [bezier3Path addCurveToPoint:CGPointMake(9.94, 17.04) controlPoint1:CGPointMake(8.98, 17.26) controlPoint2:CGPointMake(9.45, 17.17)];
                [bezier3Path addCurveToPoint:CGPointMake(11.69, 17.51) controlPoint1:CGPointMake(10.65, 16.85) controlPoint2:CGPointMake(11.59, 16.46)];
                [bezier3Path addCurveToPoint:CGPointMake(11.81, 17.57) controlPoint1:CGPointMake(11.69, 17.56) controlPoint2:CGPointMake(11.77, 17.57)];
                [bezier3Path addCurveToPoint:CGPointMake(16.27, 15.54) controlPoint1:CGPointMake(13.49, 17.49) controlPoint2:CGPointMake(14.79, 16.2)];
                [bezier3Path addCurveToPoint:CGPointMake(15.4, 17.69) controlPoint1:CGPointMake(15.96, 16.24) controlPoint2:CGPointMake(15.55, 16.93)];
                [bezier3Path addCurveToPoint:CGPointMake(15.46, 17.76) controlPoint1:CGPointMake(15.39, 17.73) controlPoint2:CGPointMake(15.43, 17.75)];
                [bezier3Path addCurveToPoint:CGPointMake(18.61, 17.65) controlPoint1:CGPointMake(16.44, 18.22) controlPoint2:CGPointMake(17.6, 17.84)];
                [bezier3Path addCurveToPoint:CGPointMake(21.3, 17.56) controlPoint1:CGPointMake(19.49, 17.48) controlPoint2:CGPointMake(20.41, 17.53)];
                [bezier3Path addCurveToPoint:CGPointMake(26.98, 18.03) controlPoint1:CGPointMake(23.15, 17.62) controlPoint2:CGPointMake(25.18, 17.59)];
                [bezier3Path addCurveToPoint:CGPointMake(27.13, 17.86) controlPoint1:CGPointMake(27.09, 18.06) controlPoint2:CGPointMake(27.28, 17.9)];
                [bezier3Path closePath];
                bezier3Path.miterLimit = 4;

                [fillColor7 setFill];
                [bezier3Path fill];
            }

            //// Group 5
            {
                //// Bezier 4 Drawing
                UIBezierPath *bezier4Path = [UIBezierPath bezierPath];
                [bezier4Path moveToPoint:CGPointMake(35.1, 16.59)];
                [bezier4Path addLineToPoint:CGPointMake(35.28, 16.4)];
                [bezier4Path addCurveToPoint:CGPointMake(35.96, 16.72) controlPoint1:CGPointMake(35.42, 16.59) controlPoint2:CGPointMake(35.67, 16.72)];
                [bezier4Path addCurveToPoint:CGPointMake(36.53, 16.26) controlPoint1:CGPointMake(36.31, 16.72) controlPoint2:CGPointMake(36.53, 16.55)];
                [bezier4Path addCurveToPoint:CGPointMake(35.93, 15.83) controlPoint1:CGPointMake(36.53, 15.96) controlPoint2:CGPointMake(36.28, 15.83)];
                [bezier4Path addCurveToPoint:CGPointMake(35.68, 15.83) controlPoint1:CGPointMake(35.83, 15.83) controlPoint2:CGPointMake(35.71, 15.83)];
                [bezier4Path addLineToPoint:CGPointMake(35.68, 15.55)];
                [bezier4Path addCurveToPoint:CGPointMake(35.93, 15.55) controlPoint1:CGPointMake(35.72, 15.55) controlPoint2:CGPointMake(35.83, 15.55)];
                [bezier4Path addCurveToPoint:CGPointMake(36.5, 15.15) controlPoint1:CGPointMake(36.24, 15.55) controlPoint2:CGPointMake(36.5, 15.43)];
                [bezier4Path addCurveToPoint:CGPointMake(35.96, 14.73) controlPoint1:CGPointMake(36.5, 14.88) controlPoint2:CGPointMake(36.25, 14.73)];
                [bezier4Path addCurveToPoint:CGPointMake(35.32, 15.03) controlPoint1:CGPointMake(35.69, 14.73) controlPoint2:CGPointMake(35.5, 14.83)];
                [bezier4Path addLineToPoint:CGPointMake(35.15, 14.84)];
                [bezier4Path addCurveToPoint:CGPointMake(35.98, 14.46) controlPoint1:CGPointMake(35.32, 14.63) controlPoint2:CGPointMake(35.61, 14.46)];
                [bezier4Path addCurveToPoint:CGPointMake(36.8, 15.11) controlPoint1:CGPointMake(36.45, 14.46) controlPoint2:CGPointMake(36.8, 14.7)];
                [bezier4Path addCurveToPoint:CGPointMake(36.28, 15.67) controlPoint1:CGPointMake(36.8, 15.46) controlPoint2:CGPointMake(36.51, 15.64)];
                [bezier4Path addCurveToPoint:CGPointMake(36.84, 16.27) controlPoint1:CGPointMake(36.5, 15.69) controlPoint2:CGPointMake(36.84, 15.88)];
                [bezier4Path addCurveToPoint:CGPointMake(35.98, 16.97) controlPoint1:CGPointMake(36.84, 16.67) controlPoint2:CGPointMake(36.52, 16.97)];
                [bezier4Path addCurveToPoint:CGPointMake(35.1, 16.59) controlPoint1:CGPointMake(35.55, 16.99) controlPoint2:CGPointMake(35.25, 16.81)];
                [bezier4Path closePath];
                bezier4Path.miterLimit = 4;

                [fillColor5 setFill];
                [bezier4Path fill];

                //// Bezier 5 Drawing
                UIBezierPath *bezier5Path = [UIBezierPath bezierPath];
                [bezier5Path moveToPoint:CGPointMake(38.04, 16.95)];
                [bezier5Path addLineToPoint:CGPointMake(38.04, 14.92)];
                [bezier5Path addLineToPoint:CGPointMake(37.65, 15.33)];
                [bezier5Path addLineToPoint:CGPointMake(37.47, 15.14)];
                [bezier5Path addLineToPoint:CGPointMake(38.08, 14.51)];
                [bezier5Path addLineToPoint:CGPointMake(38.35, 14.51)];
                [bezier5Path addLineToPoint:CGPointMake(38.35, 16.94)];
                [bezier5Path addLineToPoint:CGPointMake(38.04, 16.94)];
                [bezier5Path addLineToPoint:CGPointMake(38.04, 16.95)];
                [bezier5Path closePath];
                bezier5Path.miterLimit = 4;

                [fillColor5 setFill];
                [bezier5Path fill];

                //// Bezier 6 Drawing
                UIBezierPath *bezier6Path = [UIBezierPath bezierPath];
                [bezier6Path moveToPoint:CGPointMake(39.27, 16.95)];
                [bezier6Path addLineToPoint:CGPointMake(39.27, 16.7)];
                [bezier6Path addCurveToPoint:CGPointMake(40.62, 15.19) controlPoint1:CGPointMake(40.15, 16.01) controlPoint2:CGPointMake(40.62, 15.61)];
                [bezier6Path addCurveToPoint:CGPointMake(40.11, 14.74) controlPoint1:CGPointMake(40.62, 14.88) controlPoint2:CGPointMake(40.37, 14.74)];
                [bezier6Path addCurveToPoint:CGPointMake(39.45, 15.05) controlPoint1:CGPointMake(39.82, 14.74) controlPoint2:CGPointMake(39.59, 14.86)];
                [bezier6Path addLineToPoint:CGPointMake(39.26, 14.86)];
                [bezier6Path addCurveToPoint:CGPointMake(40.11, 14.48) controlPoint1:CGPointMake(39.45, 14.62) controlPoint2:CGPointMake(39.76, 14.48)];
                [bezier6Path addCurveToPoint:CGPointMake(40.93, 15.19) controlPoint1:CGPointMake(40.51, 14.48) controlPoint2:CGPointMake(40.93, 14.71)];
                [bezier6Path addCurveToPoint:CGPointMake(39.75, 16.67) controlPoint1:CGPointMake(40.93, 15.69) controlPoint2:CGPointMake(40.43, 16.14)];
                [bezier6Path addLineToPoint:CGPointMake(40.94, 16.67)];
                [bezier6Path addLineToPoint:CGPointMake(40.94, 16.94)];
                [bezier6Path addLineToPoint:CGPointMake(39.27, 16.94)];
                [bezier6Path addLineToPoint:CGPointMake(39.27, 16.95)];
                [bezier6Path closePath];
                bezier6Path.miterLimit = 4;

                [fillColor5 setFill];
                [bezier6Path fill];
            }
        }

        //// Bezier 7 Drawing
        UIBezierPath *bezier7Path = [UIBezierPath bezierPath];
        [bezier7Path moveToPoint:CGPointMake(42.29, 12.23)];
        [bezier7Path addLineToPoint:CGPointMake(33.74, 12.23)];
        [bezier7Path addCurveToPoint:CGPointMake(32.24, 13.73) controlPoint1:CGPointMake(32.91, 12.23) controlPoint2:CGPointMake(32.24, 12.9)];
        [bezier7Path addLineToPoint:CGPointMake(32.24, 17.73)];
        [bezier7Path addCurveToPoint:CGPointMake(33.74, 19.23) controlPoint1:CGPointMake(32.24, 18.56) controlPoint2:CGPointMake(32.91, 19.23)];
        [bezier7Path addLineToPoint:CGPointMake(42.29, 19.23)];
        [bezier7Path addCurveToPoint:CGPointMake(43.79, 17.73) controlPoint1:CGPointMake(43.12, 19.23) controlPoint2:CGPointMake(43.79, 18.56)];
        [bezier7Path addLineToPoint:CGPointMake(43.79, 13.73)];
        [bezier7Path addCurveToPoint:CGPointMake(42.29, 12.23) controlPoint1:CGPointMake(43.79, 12.9) controlPoint2:CGPointMake(43.12, 12.23)];
        [bezier7Path closePath];
        [bezier7Path moveToPoint:CGPointMake(42.79, 17.73)];
        [bezier7Path addCurveToPoint:CGPointMake(42.29, 18.23) controlPoint1:CGPointMake(42.79, 18.01) controlPoint2:CGPointMake(42.57, 18.23)];
        [bezier7Path addLineToPoint:CGPointMake(33.74, 18.23)];
        [bezier7Path addCurveToPoint:CGPointMake(33.24, 17.73) controlPoint1:CGPointMake(33.46, 18.23) controlPoint2:CGPointMake(33.24, 18.01)];
        [bezier7Path addLineToPoint:CGPointMake(33.24, 13.73)];
        [bezier7Path addCurveToPoint:CGPointMake(33.74, 13.23) controlPoint1:CGPointMake(33.24, 13.45) controlPoint2:CGPointMake(33.46, 13.23)];
        [bezier7Path addLineToPoint:CGPointMake(42.29, 13.23)];
        [bezier7Path addCurveToPoint:CGPointMake(42.79, 13.73) controlPoint1:CGPointMake(42.57, 13.23) controlPoint2:CGPointMake(42.79, 13.45)];
        [bezier7Path addLineToPoint:CGPointMake(42.79, 17.73)];
        [bezier7Path closePath];
        bezier7Path.miterLimit = 4;

        [fillColor6 setFill];
        [bezier7Path fill];
    }
}

- (void)drawIc_card_maestroCanvas {
    //// Color Declarations
    UIColor *fillColor = [UIColor colorWithRed:0.647 green:0.647 blue:0.647 alpha:1];
    UIColor *fillColor2 = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1];
    UIColor *fillColor8 = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    UIColor *fillColor9 = [UIColor colorWithRed:0.386 green:0.36 blue:0.7 alpha:1];
    UIColor *fillColor10 = [UIColor colorWithRed:0.889 green:0 blue:0.087 alpha:1];
    UIColor *fillColor11 = [UIColor colorWithRed:0.069 green:0.558 blue:0.843 alpha:1];

    //// Group
    {
        //// Group 2
        {
            //// Bezier Drawing
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(43.77, 0)];
            [bezierPath addLineToPoint:CGPointMake(2.23, 0)];
            [bezierPath addCurveToPoint:CGPointMake(0, 2.22) controlPoint1:CGPointMake(1, 0) controlPoint2:CGPointMake(0, 0.99)];
            [bezierPath addLineToPoint:CGPointMake(0, 3.33)];
            [bezierPath addLineToPoint:CGPointMake(0, 26.67)];
            [bezierPath addLineToPoint:CGPointMake(0, 27.79)];
            [bezierPath addCurveToPoint:CGPointMake(2.23, 30) controlPoint1:CGPointMake(0, 29.01) controlPoint2:CGPointMake(1, 30)];
            [bezierPath addLineToPoint:CGPointMake(43.77, 30)];
            [bezierPath addCurveToPoint:CGPointMake(46, 27.79) controlPoint1:CGPointMake(45, 30) controlPoint2:CGPointMake(46, 29.01)];
            [bezierPath addLineToPoint:CGPointMake(46, 2.22)];
            [bezierPath addCurveToPoint:CGPointMake(43.77, 0) controlPoint1:CGPointMake(46, 0.99) controlPoint2:CGPointMake(45, 0)];
            [bezierPath closePath];
            bezierPath.miterLimit = 4;

            [fillColor setFill];
            [bezierPath fill];

            //// Rectangle Drawing
            UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.55, 0.57, 44.9, 28.35) cornerRadius:1.6];
            [fillColor2 setFill];
            [rectanglePath fill];
        }

        //// Group 3
        {
            //// Group 4
            {
                //// Bezier 2 Drawing
                UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
                [bezier2Path moveToPoint:CGPointMake(9.43, 22.93)];
                [bezier2Path addCurveToPoint:CGPointMake(9.75, 22.97) controlPoint1:CGPointMake(9.56, 22.93) controlPoint2:CGPointMake(9.66, 22.94)];
                [bezier2Path addCurveToPoint:CGPointMake(9.96, 23.09) controlPoint1:CGPointMake(9.84, 23) controlPoint2:CGPointMake(9.91, 23.04)];
                [bezier2Path addCurveToPoint:CGPointMake(10.07, 23.29) controlPoint1:CGPointMake(10.01, 23.14) controlPoint2:CGPointMake(10.05, 23.21)];
                [bezier2Path addCurveToPoint:CGPointMake(10.11, 23.56) controlPoint1:CGPointMake(10.09, 23.37) controlPoint2:CGPointMake(10.11, 23.46)];
                [bezier2Path addCurveToPoint:CGPointMake(10.07, 23.82) controlPoint1:CGPointMake(10.11, 23.66) controlPoint2:CGPointMake(10.09, 23.75)];
                [bezier2Path addCurveToPoint:CGPointMake(9.94, 24.01) controlPoint1:CGPointMake(10.04, 23.9) controlPoint2:CGPointMake(10, 23.96)];
                [bezier2Path addCurveToPoint:CGPointMake(9.7, 24.13) controlPoint1:CGPointMake(9.88, 24.06) controlPoint2:CGPointMake(9.8, 24.1)];
                [bezier2Path addCurveToPoint:CGPointMake(9.34, 24.17) controlPoint1:CGPointMake(9.6, 24.16) controlPoint2:CGPointMake(9.48, 24.17)];
                [bezier2Path addCurveToPoint:CGPointMake(9.05, 24.14) controlPoint1:CGPointMake(9.23, 24.17) controlPoint2:CGPointMake(9.14, 24.16)];
                [bezier2Path addCurveToPoint:CGPointMake(8.82, 24.04) controlPoint1:CGPointMake(8.96, 24.12) controlPoint2:CGPointMake(8.88, 24.09)];
                [bezier2Path addCurveToPoint:CGPointMake(8.67, 23.87) controlPoint1:CGPointMake(8.75, 24) controlPoint2:CGPointMake(8.7, 23.94)];
                [bezier2Path addCurveToPoint:CGPointMake(8.62, 23.61) controlPoint1:CGPointMake(8.64, 23.8) controlPoint2:CGPointMake(8.62, 23.71)];
                [bezier2Path addLineToPoint:CGPointMake(8.62, 22.31)];
                [bezier2Path addCurveToPoint:CGPointMake(8.63, 22.25) controlPoint1:CGPointMake(8.62, 22.29) controlPoint2:CGPointMake(8.62, 22.27)];
                [bezier2Path addCurveToPoint:CGPointMake(8.67, 22.2) controlPoint1:CGPointMake(8.64, 22.23) controlPoint2:CGPointMake(8.65, 22.21)];
                [bezier2Path addCurveToPoint:CGPointMake(8.73, 22.16) controlPoint1:CGPointMake(8.69, 22.18) controlPoint2:CGPointMake(8.7, 22.17)];
                [bezier2Path addCurveToPoint:CGPointMake(8.82, 22.15) controlPoint1:CGPointMake(8.76, 22.15) controlPoint2:CGPointMake(8.79, 22.15)];
                [bezier2Path addCurveToPoint:CGPointMake(8.97, 22.2) controlPoint1:CGPointMake(8.89, 22.15) controlPoint2:CGPointMake(8.93, 22.17)];
                [bezier2Path addCurveToPoint:CGPointMake(9.02, 22.32) controlPoint1:CGPointMake(9, 22.23) controlPoint2:CGPointMake(9.02, 22.27)];
                [bezier2Path addLineToPoint:CGPointMake(9.02, 22.97)];
                [bezier2Path addCurveToPoint:CGPointMake(9.27, 22.95) controlPoint1:CGPointMake(9.11, 22.96) controlPoint2:CGPointMake(9.2, 22.95)];
                [bezier2Path addCurveToPoint:CGPointMake(9.43, 22.93) controlPoint1:CGPointMake(9.32, 22.93) controlPoint2:CGPointMake(9.38, 22.93)];
                [bezier2Path closePath];
                [bezier2Path moveToPoint:CGPointMake(9.72, 23.54)];
                [bezier2Path addCurveToPoint:CGPointMake(9.7, 23.39) controlPoint1:CGPointMake(9.72, 23.48) controlPoint2:CGPointMake(9.72, 23.43)];
                [bezier2Path addCurveToPoint:CGPointMake(9.64, 23.3) controlPoint1:CGPointMake(9.69, 23.35) controlPoint2:CGPointMake(9.67, 23.32)];
                [bezier2Path addCurveToPoint:CGPointMake(9.53, 23.26) controlPoint1:CGPointMake(9.61, 23.28) controlPoint2:CGPointMake(9.58, 23.26)];
                [bezier2Path addCurveToPoint:CGPointMake(9.35, 23.25) controlPoint1:CGPointMake(9.48, 23.25) controlPoint2:CGPointMake(9.42, 23.25)];
                [bezier2Path addCurveToPoint:CGPointMake(9.21, 23.25) controlPoint1:CGPointMake(9.3, 23.25) controlPoint2:CGPointMake(9.25, 23.25)];
                [bezier2Path addCurveToPoint:CGPointMake(9.12, 23.25) controlPoint1:CGPointMake(9.17, 23.25) controlPoint2:CGPointMake(9.15, 23.25)];
                [bezier2Path addCurveToPoint:CGPointMake(9.06, 23.26) controlPoint1:CGPointMake(9.1, 23.25) controlPoint2:CGPointMake(9.07, 23.25)];
                [bezier2Path addCurveToPoint:CGPointMake(8.99, 23.27) controlPoint1:CGPointMake(9.04, 23.26) controlPoint2:CGPointMake(9.02, 23.27)];
                [bezier2Path addLineToPoint:CGPointMake(8.99, 23.52)];
                [bezier2Path addCurveToPoint:CGPointMake(9.01, 23.66) controlPoint1:CGPointMake(8.99, 23.58) controlPoint2:CGPointMake(9, 23.63)];
                [bezier2Path addCurveToPoint:CGPointMake(9.07, 23.76) controlPoint1:CGPointMake(9.02, 23.7) controlPoint2:CGPointMake(9.04, 23.73)];
                [bezier2Path addCurveToPoint:CGPointMake(9.18, 23.82) controlPoint1:CGPointMake(9.1, 23.79) controlPoint2:CGPointMake(9.13, 23.81)];
                [bezier2Path addCurveToPoint:CGPointMake(9.35, 23.84) controlPoint1:CGPointMake(9.23, 23.83) controlPoint2:CGPointMake(9.28, 23.84)];
                [bezier2Path addCurveToPoint:CGPointMake(9.52, 23.83) controlPoint1:CGPointMake(9.41, 23.84) controlPoint2:CGPointMake(9.47, 23.84)];
                [bezier2Path addCurveToPoint:CGPointMake(9.63, 23.79) controlPoint1:CGPointMake(9.56, 23.82) controlPoint2:CGPointMake(9.6, 23.81)];
                [bezier2Path addCurveToPoint:CGPointMake(9.7, 23.7) controlPoint1:CGPointMake(9.66, 23.77) controlPoint2:CGPointMake(9.69, 23.74)];
                [bezier2Path addCurveToPoint:CGPointMake(9.72, 23.54) controlPoint1:CGPointMake(9.72, 23.66) controlPoint2:CGPointMake(9.72, 23.61)];
                [bezier2Path closePath];
                bezier2Path.miterLimit = 4;

                [fillColor setFill];
                [bezier2Path fill];

                //// Bezier 3 Drawing
                UIBezierPath *bezier3Path = [UIBezierPath bezierPath];
                [bezier3Path moveToPoint:CGPointMake(11.46, 22.14)];
                [bezier3Path addCurveToPoint:CGPointMake(11.83, 22.17) controlPoint1:CGPointMake(11.61, 22.14) controlPoint2:CGPointMake(11.73, 22.15)];
                [bezier3Path addCurveToPoint:CGPointMake(12.07, 22.27) controlPoint1:CGPointMake(11.93, 22.19) controlPoint2:CGPointMake(12.01, 22.22)];
                [bezier3Path addCurveToPoint:CGPointMake(12.21, 22.45) controlPoint1:CGPointMake(12.14, 22.31) controlPoint2:CGPointMake(12.18, 22.37)];
                [bezier3Path addCurveToPoint:CGPointMake(12.25, 22.72) controlPoint1:CGPointMake(12.24, 22.52) controlPoint2:CGPointMake(12.25, 22.61)];
                [bezier3Path addLineToPoint:CGPointMake(12.25, 22.73)];
                [bezier3Path addCurveToPoint:CGPointMake(12.22, 23.02) controlPoint1:CGPointMake(12.25, 22.84) controlPoint2:CGPointMake(12.24, 22.94)];
                [bezier3Path addCurveToPoint:CGPointMake(12.11, 23.2) controlPoint1:CGPointMake(12.2, 23.1) controlPoint2:CGPointMake(12.16, 23.15)];
                [bezier3Path addCurveToPoint:CGPointMake(11.91, 23.3) controlPoint1:CGPointMake(12.06, 23.25) controlPoint2:CGPointMake(11.99, 23.28)];
                [bezier3Path addCurveToPoint:CGPointMake(11.6, 23.33) controlPoint1:CGPointMake(11.83, 23.32) controlPoint2:CGPointMake(11.73, 23.33)];
                [bezier3Path addCurveToPoint:CGPointMake(11.34, 23.33) controlPoint1:CGPointMake(11.5, 23.33) controlPoint2:CGPointMake(11.41, 23.33)];
                [bezier3Path addCurveToPoint:CGPointMake(11.18, 23.37) controlPoint1:CGPointMake(11.27, 23.33) controlPoint2:CGPointMake(11.22, 23.35)];
                [bezier3Path addCurveToPoint:CGPointMake(11.1, 23.46) controlPoint1:CGPointMake(11.14, 23.39) controlPoint2:CGPointMake(11.11, 23.42)];
                [bezier3Path addCurveToPoint:CGPointMake(11.07, 23.65) controlPoint1:CGPointMake(11.08, 23.5) controlPoint2:CGPointMake(11.07, 23.57)];
                [bezier3Path addLineToPoint:CGPointMake(11.07, 23.83)];
                [bezier3Path addLineToPoint:CGPointMake(12.04, 23.83)];
                [bezier3Path addCurveToPoint:CGPointMake(12.11, 23.84) controlPoint1:CGPointMake(12.06, 23.83) controlPoint2:CGPointMake(12.09, 23.83)];
                [bezier3Path addCurveToPoint:CGPointMake(12.18, 23.87) controlPoint1:CGPointMake(12.13, 23.85) controlPoint2:CGPointMake(12.16, 23.86)];
                [bezier3Path addCurveToPoint:CGPointMake(12.23, 23.92) controlPoint1:CGPointMake(12.2, 23.88) controlPoint2:CGPointMake(12.21, 23.9)];
                [bezier3Path addCurveToPoint:CGPointMake(12.26, 23.99) controlPoint1:CGPointMake(12.24, 23.94) controlPoint2:CGPointMake(12.25, 23.96)];
                [bezier3Path addCurveToPoint:CGPointMake(12.24, 24.07) controlPoint1:CGPointMake(12.26, 24.02) controlPoint2:CGPointMake(12.26, 24.05)];
                [bezier3Path addCurveToPoint:CGPointMake(12.19, 24.12) controlPoint1:CGPointMake(12.23, 24.09) controlPoint2:CGPointMake(12.21, 24.11)];
                [bezier3Path addCurveToPoint:CGPointMake(12.13, 24.15) controlPoint1:CGPointMake(12.17, 24.13) controlPoint2:CGPointMake(12.15, 24.14)];
                [bezier3Path addCurveToPoint:CGPointMake(12.05, 24.16) controlPoint1:CGPointMake(12.1, 24.16) controlPoint2:CGPointMake(12.08, 24.16)];
                [bezier3Path addLineToPoint:CGPointMake(10.91, 24.16)];
                [bezier3Path addCurveToPoint:CGPointMake(10.74, 24.12) controlPoint1:CGPointMake(10.83, 24.16) controlPoint2:CGPointMake(10.77, 24.15)];
                [bezier3Path addCurveToPoint:CGPointMake(10.69, 23.99) controlPoint1:CGPointMake(10.71, 24.09) controlPoint2:CGPointMake(10.69, 24.05)];
                [bezier3Path addLineToPoint:CGPointMake(10.69, 23.59)];
                [bezier3Path addCurveToPoint:CGPointMake(10.73, 23.32) controlPoint1:CGPointMake(10.69, 23.48) controlPoint2:CGPointMake(10.7, 23.39)];
                [bezier3Path addCurveToPoint:CGPointMake(10.85, 23.14) controlPoint1:CGPointMake(10.76, 23.25) controlPoint2:CGPointMake(10.8, 23.19)];
                [bezier3Path addCurveToPoint:CGPointMake(11.05, 23.05) controlPoint1:CGPointMake(10.9, 23.1) controlPoint2:CGPointMake(10.97, 23.07)];
                [bezier3Path addCurveToPoint:CGPointMake(11.31, 23.02) controlPoint1:CGPointMake(11.13, 23.03) controlPoint2:CGPointMake(11.21, 23.02)];
                [bezier3Path addLineToPoint:CGPointMake(11.6, 23.01)];
                [bezier3Path addCurveToPoint:CGPointMake(11.73, 23) controlPoint1:CGPointMake(11.65, 23.01) controlPoint2:CGPointMake(11.7, 23.01)];
                [bezier3Path addCurveToPoint:CGPointMake(11.81, 22.96) controlPoint1:CGPointMake(11.76, 22.99) controlPoint2:CGPointMake(11.79, 22.98)];
                [bezier3Path addCurveToPoint:CGPointMake(11.86, 22.88) controlPoint1:CGPointMake(11.83, 22.94) controlPoint2:CGPointMake(11.85, 22.92)];
                [bezier3Path addCurveToPoint:CGPointMake(11.87, 22.76) controlPoint1:CGPointMake(11.87, 22.85) controlPoint2:CGPointMake(11.87, 22.81)];
                [bezier3Path addLineToPoint:CGPointMake(11.87, 22.75)];
                [bezier3Path addCurveToPoint:CGPointMake(11.85, 22.62) controlPoint1:CGPointMake(11.87, 22.7) controlPoint2:CGPointMake(11.87, 22.66)];
                [bezier3Path addCurveToPoint:CGPointMake(11.79, 22.54) controlPoint1:CGPointMake(11.84, 22.59) controlPoint2:CGPointMake(11.82, 22.56)];
                [bezier3Path addCurveToPoint:CGPointMake(11.66, 22.49) controlPoint1:CGPointMake(11.76, 22.52) controlPoint2:CGPointMake(11.72, 22.5)];
                [bezier3Path addCurveToPoint:CGPointMake(11.45, 22.48) controlPoint1:CGPointMake(11.6, 22.48) controlPoint2:CGPointMake(11.53, 22.48)];
                [bezier3Path addCurveToPoint:CGPointMake(11.26, 22.49) controlPoint1:CGPointMake(11.38, 22.48) controlPoint2:CGPointMake(11.32, 22.48)];
                [bezier3Path addCurveToPoint:CGPointMake(11.12, 22.52) controlPoint1:CGPointMake(11.2, 22.5) controlPoint2:CGPointMake(11.16, 22.51)];
                [bezier3Path addCurveToPoint:CGPointMake(11.02, 22.56) controlPoint1:CGPointMake(11.08, 22.53) controlPoint2:CGPointMake(11.05, 22.54)];
                [bezier3Path addCurveToPoint:CGPointMake(10.92, 22.58) controlPoint1:CGPointMake(10.99, 22.57) controlPoint2:CGPointMake(10.96, 22.58)];
                [bezier3Path addLineToPoint:CGPointMake(10.91, 22.58)];
                [bezier3Path addCurveToPoint:CGPointMake(10.79, 22.53) controlPoint1:CGPointMake(10.86, 22.58) controlPoint2:CGPointMake(10.83, 22.56)];
                [bezier3Path addCurveToPoint:CGPointMake(10.75, 22.41) controlPoint1:CGPointMake(10.76, 22.5) controlPoint2:CGPointMake(10.75, 22.46)];
                [bezier3Path addLineToPoint:CGPointMake(10.75, 22.4)];
                [bezier3Path addCurveToPoint:CGPointMake(10.81, 22.29) controlPoint1:CGPointMake(10.75, 22.35) controlPoint2:CGPointMake(10.77, 22.32)];
                [bezier3Path addCurveToPoint:CGPointMake(10.97, 22.22) controlPoint1:CGPointMake(10.85, 22.26) controlPoint2:CGPointMake(10.9, 22.23)];
                [bezier3Path addCurveToPoint:CGPointMake(11.2, 22.18) controlPoint1:CGPointMake(11.04, 22.2) controlPoint2:CGPointMake(11.11, 22.19)];
                [bezier3Path addCurveToPoint:CGPointMake(11.46, 22.14) controlPoint1:CGPointMake(11.27, 22.14) controlPoint2:CGPointMake(11.36, 22.14)];
                [bezier3Path closePath];
                bezier3Path.miterLimit = 4;

                [fillColor setFill];
                [bezier3Path fill];

                //// Bezier 4 Drawing
                UIBezierPath *bezier4Path = [UIBezierPath bezierPath];
                [bezier4Path moveToPoint:CGPointMake(15.03, 22.14)];
                [bezier4Path addCurveToPoint:CGPointMake(15.4, 22.17) controlPoint1:CGPointMake(15.18, 22.14) controlPoint2:CGPointMake(15.3, 22.15)];
                [bezier4Path addCurveToPoint:CGPointMake(15.65, 22.27) controlPoint1:CGPointMake(15.5, 22.19) controlPoint2:CGPointMake(15.58, 22.22)];
                [bezier4Path addCurveToPoint:CGPointMake(15.78, 22.45) controlPoint1:CGPointMake(15.71, 22.31) controlPoint2:CGPointMake(15.75, 22.37)];
                [bezier4Path addCurveToPoint:CGPointMake(15.82, 22.72) controlPoint1:CGPointMake(15.81, 22.52) controlPoint2:CGPointMake(15.82, 22.61)];
                [bezier4Path addLineToPoint:CGPointMake(15.82, 22.73)];
                [bezier4Path addCurveToPoint:CGPointMake(15.79, 23.02) controlPoint1:CGPointMake(15.82, 22.84) controlPoint2:CGPointMake(15.81, 22.94)];
                [bezier4Path addCurveToPoint:CGPointMake(15.68, 23.2) controlPoint1:CGPointMake(15.77, 23.1) controlPoint2:CGPointMake(15.73, 23.15)];
                [bezier4Path addCurveToPoint:CGPointMake(15.48, 23.3) controlPoint1:CGPointMake(15.63, 23.25) controlPoint2:CGPointMake(15.56, 23.28)];
                [bezier4Path addCurveToPoint:CGPointMake(15.18, 23.33) controlPoint1:CGPointMake(15.4, 23.32) controlPoint2:CGPointMake(15.3, 23.33)];
                [bezier4Path addCurveToPoint:CGPointMake(14.92, 23.33) controlPoint1:CGPointMake(15.08, 23.33) controlPoint2:CGPointMake(14.99, 23.33)];
                [bezier4Path addCurveToPoint:CGPointMake(14.75, 23.37) controlPoint1:CGPointMake(14.85, 23.33) controlPoint2:CGPointMake(14.8, 23.35)];
                [bezier4Path addCurveToPoint:CGPointMake(14.66, 23.46) controlPoint1:CGPointMake(14.71, 23.39) controlPoint2:CGPointMake(14.68, 23.42)];
                [bezier4Path addCurveToPoint:CGPointMake(14.64, 23.65) controlPoint1:CGPointMake(14.65, 23.5) controlPoint2:CGPointMake(14.64, 23.57)];
                [bezier4Path addLineToPoint:CGPointMake(14.64, 23.83)];
                [bezier4Path addLineToPoint:CGPointMake(15.61, 23.83)];
                [bezier4Path addCurveToPoint:CGPointMake(15.68, 23.84) controlPoint1:CGPointMake(15.63, 23.83) controlPoint2:CGPointMake(15.66, 23.83)];
                [bezier4Path addCurveToPoint:CGPointMake(15.74, 23.87) controlPoint1:CGPointMake(15.7, 23.85) controlPoint2:CGPointMake(15.73, 23.86)];
                [bezier4Path addCurveToPoint:CGPointMake(15.79, 23.92) controlPoint1:CGPointMake(15.76, 23.88) controlPoint2:CGPointMake(15.78, 23.9)];
                [bezier4Path addCurveToPoint:CGPointMake(15.82, 23.99) controlPoint1:CGPointMake(15.8, 23.94) controlPoint2:CGPointMake(15.81, 23.96)];
                [bezier4Path addCurveToPoint:CGPointMake(15.8, 24.07) controlPoint1:CGPointMake(15.82, 24.02) controlPoint2:CGPointMake(15.82, 24.05)];
                [bezier4Path addCurveToPoint:CGPointMake(15.75, 24.12) controlPoint1:CGPointMake(15.78, 24.09) controlPoint2:CGPointMake(15.77, 24.11)];
                [bezier4Path addCurveToPoint:CGPointMake(15.68, 24.15) controlPoint1:CGPointMake(15.73, 24.13) controlPoint2:CGPointMake(15.71, 24.14)];
                [bezier4Path addCurveToPoint:CGPointMake(15.6, 24.16) controlPoint1:CGPointMake(15.65, 24.16) controlPoint2:CGPointMake(15.63, 24.16)];
                [bezier4Path addLineToPoint:CGPointMake(14.46, 24.16)];
                [bezier4Path addCurveToPoint:CGPointMake(14.29, 24.12) controlPoint1:CGPointMake(14.38, 24.16) controlPoint2:CGPointMake(14.32, 24.15)];
                [bezier4Path addCurveToPoint:CGPointMake(14.24, 23.99) controlPoint1:CGPointMake(14.25, 24.09) controlPoint2:CGPointMake(14.24, 24.05)];
                [bezier4Path addLineToPoint:CGPointMake(14.24, 23.59)];
                [bezier4Path addCurveToPoint:CGPointMake(14.28, 23.32) controlPoint1:CGPointMake(14.24, 23.48) controlPoint2:CGPointMake(14.25, 23.39)];
                [bezier4Path addCurveToPoint:CGPointMake(14.4, 23.14) controlPoint1:CGPointMake(14.31, 23.25) controlPoint2:CGPointMake(14.35, 23.19)];
                [bezier4Path addCurveToPoint:CGPointMake(14.59, 23.05) controlPoint1:CGPointMake(14.45, 23.1) controlPoint2:CGPointMake(14.52, 23.07)];
                [bezier4Path addCurveToPoint:CGPointMake(14.88, 23) controlPoint1:CGPointMake(14.7, 23.01) controlPoint2:CGPointMake(14.79, 23)];
                [bezier4Path addLineToPoint:CGPointMake(15.17, 22.99)];
                [bezier4Path addCurveToPoint:CGPointMake(15.3, 22.98) controlPoint1:CGPointMake(15.22, 22.99) controlPoint2:CGPointMake(15.27, 22.99)];
                [bezier4Path addCurveToPoint:CGPointMake(15.38, 22.94) controlPoint1:CGPointMake(15.33, 22.97) controlPoint2:CGPointMake(15.36, 22.96)];
                [bezier4Path addCurveToPoint:CGPointMake(15.43, 22.86) controlPoint1:CGPointMake(15.4, 22.92) controlPoint2:CGPointMake(15.42, 22.9)];
                [bezier4Path addCurveToPoint:CGPointMake(15.44, 22.74) controlPoint1:CGPointMake(15.44, 22.83) controlPoint2:CGPointMake(15.44, 22.79)];
                [bezier4Path addLineToPoint:CGPointMake(15.44, 22.73)];
                [bezier4Path addCurveToPoint:CGPointMake(15.42, 22.6) controlPoint1:CGPointMake(15.44, 22.68) controlPoint2:CGPointMake(15.44, 22.64)];
                [bezier4Path addCurveToPoint:CGPointMake(15.36, 22.52) controlPoint1:CGPointMake(15.41, 22.57) controlPoint2:CGPointMake(15.39, 22.54)];
                [bezier4Path addCurveToPoint:CGPointMake(15.23, 22.47) controlPoint1:CGPointMake(15.33, 22.5) controlPoint2:CGPointMake(15.29, 22.48)];
                [bezier4Path addCurveToPoint:CGPointMake(15.02, 22.46) controlPoint1:CGPointMake(15.17, 22.46) controlPoint2:CGPointMake(15.1, 22.46)];
                [bezier4Path addCurveToPoint:CGPointMake(14.83, 22.47) controlPoint1:CGPointMake(14.95, 22.46) controlPoint2:CGPointMake(14.89, 22.46)];
                [bezier4Path addCurveToPoint:CGPointMake(14.69, 22.5) controlPoint1:CGPointMake(14.77, 22.48) controlPoint2:CGPointMake(14.73, 22.49)];
                [bezier4Path addCurveToPoint:CGPointMake(14.59, 22.54) controlPoint1:CGPointMake(14.65, 22.51) controlPoint2:CGPointMake(14.62, 22.52)];
                [bezier4Path addCurveToPoint:CGPointMake(14.49, 22.56) controlPoint1:CGPointMake(14.56, 22.55) controlPoint2:CGPointMake(14.53, 22.56)];
                [bezier4Path addLineToPoint:CGPointMake(14.48, 22.56)];
                [bezier4Path addCurveToPoint:CGPointMake(14.36, 22.51) controlPoint1:CGPointMake(14.43, 22.56) controlPoint2:CGPointMake(14.39, 22.54)];
                [bezier4Path addCurveToPoint:CGPointMake(14.32, 22.39) controlPoint1:CGPointMake(14.33, 22.48) controlPoint2:CGPointMake(14.32, 22.44)];
                [bezier4Path addLineToPoint:CGPointMake(14.32, 22.38)];
                [bezier4Path addCurveToPoint:CGPointMake(14.38, 22.27) controlPoint1:CGPointMake(14.32, 22.33) controlPoint2:CGPointMake(14.34, 22.3)];
                [bezier4Path addCurveToPoint:CGPointMake(14.54, 22.2) controlPoint1:CGPointMake(14.42, 22.24) controlPoint2:CGPointMake(14.47, 22.21)];
                [bezier4Path addCurveToPoint:CGPointMake(14.77, 22.16) controlPoint1:CGPointMake(14.61, 22.18) controlPoint2:CGPointMake(14.68, 22.17)];
                [bezier4Path addCurveToPoint:CGPointMake(15.03, 22.14) controlPoint1:CGPointMake(14.84, 22.14) controlPoint2:CGPointMake(14.93, 22.14)];
                [bezier4Path closePath];
                bezier4Path.miterLimit = 4;

                [fillColor setFill];
                [bezier4Path fill];

                //// Bezier 5 Drawing
                UIBezierPath *bezier5Path = [UIBezierPath bezierPath];
                [bezier5Path moveToPoint:CGPointMake(18.01, 23.62)];
                [bezier5Path addCurveToPoint:CGPointMake(17.98, 23.85) controlPoint1:CGPointMake(18.01, 23.71) controlPoint2:CGPointMake(18, 23.78)];
                [bezier5Path addCurveToPoint:CGPointMake(17.87, 24.02) controlPoint1:CGPointMake(17.96, 23.92) controlPoint2:CGPointMake(17.92, 23.98)];
                [bezier5Path addCurveToPoint:CGPointMake(17.63, 24.13) controlPoint1:CGPointMake(17.81, 24.07) controlPoint2:CGPointMake(17.74, 24.1)];
                [bezier5Path addCurveToPoint:CGPointMake(17.23, 24.17) controlPoint1:CGPointMake(17.53, 24.15) controlPoint2:CGPointMake(17.39, 24.17)];
                [bezier5Path addCurveToPoint:CGPointMake(16.84, 24.13) controlPoint1:CGPointMake(17.07, 24.17) controlPoint2:CGPointMake(16.94, 24.16)];
                [bezier5Path addCurveToPoint:CGPointMake(16.62, 24.02) controlPoint1:CGPointMake(16.74, 24.1) controlPoint2:CGPointMake(16.67, 24.07)];
                [bezier5Path addCurveToPoint:CGPointMake(16.51, 23.85) controlPoint1:CGPointMake(16.57, 23.97) controlPoint2:CGPointMake(16.53, 23.91)];
                [bezier5Path addCurveToPoint:CGPointMake(16.48, 23.63) controlPoint1:CGPointMake(16.49, 23.78) controlPoint2:CGPointMake(16.48, 23.71)];
                [bezier5Path addCurveToPoint:CGPointMake(16.49, 23.46) controlPoint1:CGPointMake(16.48, 23.56) controlPoint2:CGPointMake(16.48, 23.51)];
                [bezier5Path addCurveToPoint:CGPointMake(16.52, 23.35) controlPoint1:CGPointMake(16.49, 23.42) controlPoint2:CGPointMake(16.5, 23.38)];
                [bezier5Path addCurveToPoint:CGPointMake(16.6, 23.27) controlPoint1:CGPointMake(16.54, 23.32) controlPoint2:CGPointMake(16.56, 23.29)];
                [bezier5Path addCurveToPoint:CGPointMake(16.77, 23.18) controlPoint1:CGPointMake(16.64, 23.24) controlPoint2:CGPointMake(16.7, 23.21)];
                [bezier5Path addCurveToPoint:CGPointMake(16.6, 23.11) controlPoint1:CGPointMake(16.7, 23.15) controlPoint2:CGPointMake(16.64, 23.13)];
                [bezier5Path addCurveToPoint:CGPointMake(16.51, 23.03) controlPoint1:CGPointMake(16.56, 23.09) controlPoint2:CGPointMake(16.53, 23.06)];
                [bezier5Path addCurveToPoint:CGPointMake(16.48, 22.91) controlPoint1:CGPointMake(16.49, 23) controlPoint2:CGPointMake(16.48, 22.96)];
                [bezier5Path addCurveToPoint:CGPointMake(16.47, 22.71) controlPoint1:CGPointMake(16.47, 22.86) controlPoint2:CGPointMake(16.47, 22.79)];
                [bezier5Path addCurveToPoint:CGPointMake(16.51, 22.44) controlPoint1:CGPointMake(16.47, 22.6) controlPoint2:CGPointMake(16.48, 22.51)];
                [bezier5Path addCurveToPoint:CGPointMake(16.64, 22.27) controlPoint1:CGPointMake(16.54, 22.37) controlPoint2:CGPointMake(16.58, 22.31)];
                [bezier5Path addCurveToPoint:CGPointMake(16.87, 22.18) controlPoint1:CGPointMake(16.7, 22.23) controlPoint2:CGPointMake(16.78, 22.2)];
                [bezier5Path addCurveToPoint:CGPointMake(17.22, 22.15) controlPoint1:CGPointMake(16.96, 22.16) controlPoint2:CGPointMake(17.08, 22.15)];
                [bezier5Path addCurveToPoint:CGPointMake(17.58, 22.18) controlPoint1:CGPointMake(17.36, 22.15) controlPoint2:CGPointMake(17.48, 22.16)];
                [bezier5Path addCurveToPoint:CGPointMake(17.82, 22.27) controlPoint1:CGPointMake(17.68, 22.2) controlPoint2:CGPointMake(17.76, 22.23)];
                [bezier5Path addCurveToPoint:CGPointMake(17.95, 22.44) controlPoint1:CGPointMake(17.88, 22.31) controlPoint2:CGPointMake(17.93, 22.37)];
                [bezier5Path addCurveToPoint:CGPointMake(17.99, 22.7) controlPoint1:CGPointMake(17.98, 22.51) controlPoint2:CGPointMake(17.99, 22.6)];
                [bezier5Path addCurveToPoint:CGPointMake(17.98, 22.9) controlPoint1:CGPointMake(17.99, 22.78) controlPoint2:CGPointMake(17.99, 22.85)];
                [bezier5Path addCurveToPoint:CGPointMake(17.95, 23.02) controlPoint1:CGPointMake(17.98, 22.95) controlPoint2:CGPointMake(17.97, 22.99)];
                [bezier5Path addCurveToPoint:CGPointMake(17.87, 23.1) controlPoint1:CGPointMake(17.93, 23.05) controlPoint2:CGPointMake(17.9, 23.08)];
                [bezier5Path addCurveToPoint:CGPointMake(17.72, 23.17) controlPoint1:CGPointMake(17.83, 23.12) controlPoint2:CGPointMake(17.78, 23.14)];
                [bezier5Path addCurveToPoint:CGPointMake(17.88, 23.25) controlPoint1:CGPointMake(17.79, 23.2) controlPoint2:CGPointMake(17.84, 23.23)];
                [bezier5Path addCurveToPoint:CGPointMake(17.96, 23.33) controlPoint1:CGPointMake(17.92, 23.27) controlPoint2:CGPointMake(17.95, 23.3)];
                [bezier5Path addCurveToPoint:CGPointMake(17.99, 23.45) controlPoint1:CGPointMake(17.98, 23.36) controlPoint2:CGPointMake(17.99, 23.4)];
                [bezier5Path addCurveToPoint:CGPointMake(18.01, 23.62) controlPoint1:CGPointMake(18.01, 23.48) controlPoint2:CGPointMake(18.01, 23.54)];
                [bezier5Path closePath];
                [bezier5Path moveToPoint:CGPointMake(17.62, 23.58)];
                [bezier5Path addCurveToPoint:CGPointMake(17.61, 23.55) controlPoint1:CGPointMake(17.62, 23.58) controlPoint2:CGPointMake(17.61, 23.57)];
                [bezier5Path addCurveToPoint:CGPointMake(17.56, 23.48) controlPoint1:CGPointMake(17.6, 23.53) controlPoint2:CGPointMake(17.59, 23.51)];
                [bezier5Path addCurveToPoint:CGPointMake(17.45, 23.39) controlPoint1:CGPointMake(17.54, 23.45) controlPoint2:CGPointMake(17.5, 23.42)];
                [bezier5Path addCurveToPoint:CGPointMake(17.24, 23.3) controlPoint1:CGPointMake(17.4, 23.35) controlPoint2:CGPointMake(17.33, 23.33)];
                [bezier5Path addCurveToPoint:CGPointMake(17.04, 23.4) controlPoint1:CGPointMake(17.15, 23.33) controlPoint2:CGPointMake(17.08, 23.36)];
                [bezier5Path addCurveToPoint:CGPointMake(16.93, 23.49) controlPoint1:CGPointMake(16.99, 23.43) controlPoint2:CGPointMake(16.96, 23.47)];
                [bezier5Path addCurveToPoint:CGPointMake(16.88, 23.57) controlPoint1:CGPointMake(16.9, 23.52) controlPoint2:CGPointMake(16.89, 23.55)];
                [bezier5Path addCurveToPoint:CGPointMake(16.87, 23.61) controlPoint1:CGPointMake(16.87, 23.59) controlPoint2:CGPointMake(16.87, 23.61)];
                [bezier5Path addLineToPoint:CGPointMake(16.87, 23.61)];
                [bezier5Path addCurveToPoint:CGPointMake(16.89, 23.71) controlPoint1:CGPointMake(16.87, 23.65) controlPoint2:CGPointMake(16.87, 23.69)];
                [bezier5Path addCurveToPoint:CGPointMake(16.95, 23.78) controlPoint1:CGPointMake(16.9, 23.74) controlPoint2:CGPointMake(16.92, 23.76)];
                [bezier5Path addCurveToPoint:CGPointMake(17.07, 23.82) controlPoint1:CGPointMake(16.98, 23.8) controlPoint2:CGPointMake(17.02, 23.81)];
                [bezier5Path addCurveToPoint:CGPointMake(17.26, 23.83) controlPoint1:CGPointMake(17.12, 23.83) controlPoint2:CGPointMake(17.19, 23.83)];
                [bezier5Path addCurveToPoint:CGPointMake(17.43, 23.82) controlPoint1:CGPointMake(17.33, 23.83) controlPoint2:CGPointMake(17.39, 23.83)];
                [bezier5Path addCurveToPoint:CGPointMake(17.54, 23.78) controlPoint1:CGPointMake(17.48, 23.81) controlPoint2:CGPointMake(17.51, 23.8)];
                [bezier5Path addCurveToPoint:CGPointMake(17.6, 23.71) controlPoint1:CGPointMake(17.57, 23.76) controlPoint2:CGPointMake(17.59, 23.74)];
                [bezier5Path addCurveToPoint:CGPointMake(17.62, 23.61) controlPoint1:CGPointMake(17.61, 23.68) controlPoint2:CGPointMake(17.62, 23.65)];
                [bezier5Path addLineToPoint:CGPointMake(17.62, 23.58)];
                [bezier5Path closePath];
                [bezier5Path moveToPoint:CGPointMake(17.25, 23)];
                [bezier5Path addCurveToPoint:CGPointMake(17.46, 22.95) controlPoint1:CGPointMake(17.34, 22.98) controlPoint2:CGPointMake(17.41, 22.96)];
                [bezier5Path addCurveToPoint:CGPointMake(17.57, 22.9) controlPoint1:CGPointMake(17.51, 22.93) controlPoint2:CGPointMake(17.54, 22.92)];
                [bezier5Path addCurveToPoint:CGPointMake(17.61, 22.81) controlPoint1:CGPointMake(17.59, 22.88) controlPoint2:CGPointMake(17.61, 22.85)];
                [bezier5Path addCurveToPoint:CGPointMake(17.62, 22.66) controlPoint1:CGPointMake(17.61, 22.78) controlPoint2:CGPointMake(17.62, 22.73)];
                [bezier5Path addCurveToPoint:CGPointMake(17.6, 22.56) controlPoint1:CGPointMake(17.62, 22.62) controlPoint2:CGPointMake(17.61, 22.58)];
                [bezier5Path addCurveToPoint:CGPointMake(17.52, 22.5) controlPoint1:CGPointMake(17.58, 22.53) controlPoint2:CGPointMake(17.56, 22.51)];
                [bezier5Path addCurveToPoint:CGPointMake(17.4, 22.48) controlPoint1:CGPointMake(17.49, 22.49) controlPoint2:CGPointMake(17.45, 22.48)];
                [bezier5Path addCurveToPoint:CGPointMake(17.25, 22.47) controlPoint1:CGPointMake(17.36, 22.48) controlPoint2:CGPointMake(17.3, 22.47)];
                [bezier5Path addCurveToPoint:CGPointMake(17.08, 22.48) controlPoint1:CGPointMake(17.18, 22.47) controlPoint2:CGPointMake(17.13, 22.47)];
                [bezier5Path addCurveToPoint:CGPointMake(16.97, 22.51) controlPoint1:CGPointMake(17.03, 22.48) controlPoint2:CGPointMake(17, 22.5)];
                [bezier5Path addCurveToPoint:CGPointMake(16.91, 22.58) controlPoint1:CGPointMake(16.94, 22.53) controlPoint2:CGPointMake(16.92, 22.55)];
                [bezier5Path addCurveToPoint:CGPointMake(16.89, 22.71) controlPoint1:CGPointMake(16.89, 22.61) controlPoint2:CGPointMake(16.89, 22.65)];
                [bezier5Path addCurveToPoint:CGPointMake(16.89, 22.83) controlPoint1:CGPointMake(16.89, 22.76) controlPoint2:CGPointMake(16.89, 22.8)];
                [bezier5Path addCurveToPoint:CGPointMake(16.93, 22.9) controlPoint1:CGPointMake(16.9, 22.86) controlPoint2:CGPointMake(16.91, 22.88)];
                [bezier5Path addCurveToPoint:CGPointMake(17.04, 22.95) controlPoint1:CGPointMake(16.95, 22.92) controlPoint2:CGPointMake(16.99, 22.93)];
                [bezier5Path addCurveToPoint:CGPointMake(17.25, 23) controlPoint1:CGPointMake(17.09, 22.95) controlPoint2:CGPointMake(17.16, 22.97)];
                [bezier5Path closePath];
                bezier5Path.miterLimit = 4;

                [fillColor setFill];
                [bezier5Path fill];

                //// Bezier 6 Drawing
                UIBezierPath *bezier6Path = [UIBezierPath bezierPath];
                [bezier6Path moveToPoint:CGPointMake(20.21, 23.62)];
                [bezier6Path addLineToPoint:CGPointMake(20.21, 23.62)];
                [bezier6Path addCurveToPoint:CGPointMake(20.16, 23.88) controlPoint1:CGPointMake(20.21, 23.72) controlPoint2:CGPointMake(20.19, 23.81)];
                [bezier6Path addCurveToPoint:CGPointMake(20.01, 24.05) controlPoint1:CGPointMake(20.12, 23.95) controlPoint2:CGPointMake(20.07, 24.01)];
                [bezier6Path addCurveToPoint:CGPointMake(19.77, 24.14) controlPoint1:CGPointMake(19.94, 24.09) controlPoint2:CGPointMake(19.86, 24.12)];
                [bezier6Path addCurveToPoint:CGPointMake(19.46, 24.17) controlPoint1:CGPointMake(19.68, 24.16) controlPoint2:CGPointMake(19.57, 24.17)];
                [bezier6Path addCurveToPoint:CGPointMake(19.15, 24.14) controlPoint1:CGPointMake(19.34, 24.17) controlPoint2:CGPointMake(19.24, 24.16)];
                [bezier6Path addCurveToPoint:CGPointMake(18.92, 24.05) controlPoint1:CGPointMake(19.06, 24.12) controlPoint2:CGPointMake(18.98, 24.09)];
                [bezier6Path addCurveToPoint:CGPointMake(18.77, 23.88) controlPoint1:CGPointMake(18.86, 24.01) controlPoint2:CGPointMake(18.81, 23.95)];
                [bezier6Path addCurveToPoint:CGPointMake(18.72, 23.64) controlPoint1:CGPointMake(18.73, 23.81) controlPoint2:CGPointMake(18.72, 23.73)];
                [bezier6Path addLineToPoint:CGPointMake(18.72, 22.67)];
                [bezier6Path addCurveToPoint:CGPointMake(18.92, 22.28) controlPoint1:CGPointMake(18.72, 22.5) controlPoint2:CGPointMake(18.79, 22.37)];
                [bezier6Path addCurveToPoint:CGPointMake(19.48, 22.15) controlPoint1:CGPointMake(19.05, 22.19) controlPoint2:CGPointMake(19.24, 22.15)];
                [bezier6Path addCurveToPoint:CGPointMake(19.78, 22.18) controlPoint1:CGPointMake(19.59, 22.15) controlPoint2:CGPointMake(19.69, 22.16)];
                [bezier6Path addCurveToPoint:CGPointMake(20.01, 22.28) controlPoint1:CGPointMake(19.87, 22.2) controlPoint2:CGPointMake(19.95, 22.24)];
                [bezier6Path addCurveToPoint:CGPointMake(20.16, 22.44) controlPoint1:CGPointMake(20.08, 22.32) controlPoint2:CGPointMake(20.13, 22.38)];
                [bezier6Path addCurveToPoint:CGPointMake(20.21, 22.68) controlPoint1:CGPointMake(20.2, 22.51) controlPoint2:CGPointMake(20.21, 22.59)];
                [bezier6Path addLineToPoint:CGPointMake(20.21, 23.62)];
                [bezier6Path closePath];
                [bezier6Path moveToPoint:CGPointMake(19.81, 22.69)];
                [bezier6Path addCurveToPoint:CGPointMake(19.72, 22.52) controlPoint1:CGPointMake(19.81, 22.62) controlPoint2:CGPointMake(19.78, 22.56)];
                [bezier6Path addCurveToPoint:CGPointMake(19.45, 22.46) controlPoint1:CGPointMake(19.66, 22.48) controlPoint2:CGPointMake(19.57, 22.46)];
                [bezier6Path addCurveToPoint:CGPointMake(19.18, 22.52) controlPoint1:CGPointMake(19.33, 22.46) controlPoint2:CGPointMake(19.24, 22.48)];
                [bezier6Path addCurveToPoint:CGPointMake(19.09, 22.68) controlPoint1:CGPointMake(19.12, 22.56) controlPoint2:CGPointMake(19.09, 22.61)];
                [bezier6Path addLineToPoint:CGPointMake(19.09, 23.63)];
                [bezier6Path addCurveToPoint:CGPointMake(19.18, 23.8) controlPoint1:CGPointMake(19.09, 23.71) controlPoint2:CGPointMake(19.12, 23.76)];
                [bezier6Path addCurveToPoint:CGPointMake(19.45, 23.85) controlPoint1:CGPointMake(19.24, 23.83) controlPoint2:CGPointMake(19.33, 23.85)];
                [bezier6Path addCurveToPoint:CGPointMake(19.72, 23.8) controlPoint1:CGPointMake(19.56, 23.85) controlPoint2:CGPointMake(19.65, 23.83)];
                [bezier6Path addCurveToPoint:CGPointMake(19.82, 23.63) controlPoint1:CGPointMake(19.79, 23.77) controlPoint2:CGPointMake(19.82, 23.71)];
                [bezier6Path addLineToPoint:CGPointMake(19.82, 22.69)];
                [bezier6Path addLineToPoint:CGPointMake(19.81, 22.69)];
                [bezier6Path closePath];
                bezier6Path.miterLimit = 4;

                [fillColor setFill];
                [bezier6Path fill];

                //// Bezier 7 Drawing
                UIBezierPath *bezier7Path = [UIBezierPath bezierPath];
                [bezier7Path moveToPoint:CGPointMake(22.4, 23.62)];
                [bezier7Path addLineToPoint:CGPointMake(22.4, 23.62)];
                [bezier7Path addCurveToPoint:CGPointMake(22.35, 23.88) controlPoint1:CGPointMake(22.41, 23.72) controlPoint2:CGPointMake(22.38, 23.81)];
                [bezier7Path addCurveToPoint:CGPointMake(22.2, 24.05) controlPoint1:CGPointMake(22.31, 23.95) controlPoint2:CGPointMake(22.26, 24.01)];
                [bezier7Path addCurveToPoint:CGPointMake(21.96, 24.14) controlPoint1:CGPointMake(22.13, 24.09) controlPoint2:CGPointMake(22.05, 24.12)];
                [bezier7Path addCurveToPoint:CGPointMake(21.65, 24.17) controlPoint1:CGPointMake(21.87, 24.16) controlPoint2:CGPointMake(21.76, 24.17)];
                [bezier7Path addCurveToPoint:CGPointMake(21.34, 24.14) controlPoint1:CGPointMake(21.53, 24.17) controlPoint2:CGPointMake(21.43, 24.16)];
                [bezier7Path addCurveToPoint:CGPointMake(21.1, 24.05) controlPoint1:CGPointMake(21.25, 24.12) controlPoint2:CGPointMake(21.17, 24.09)];
                [bezier7Path addCurveToPoint:CGPointMake(20.95, 23.88) controlPoint1:CGPointMake(21.04, 24.01) controlPoint2:CGPointMake(20.99, 23.95)];
                [bezier7Path addCurveToPoint:CGPointMake(20.9, 23.64) controlPoint1:CGPointMake(20.92, 23.81) controlPoint2:CGPointMake(20.9, 23.73)];
                [bezier7Path addLineToPoint:CGPointMake(20.9, 22.67)];
                [bezier7Path addCurveToPoint:CGPointMake(21.1, 22.28) controlPoint1:CGPointMake(20.9, 22.5) controlPoint2:CGPointMake(20.97, 22.37)];
                [bezier7Path addCurveToPoint:CGPointMake(21.66, 22.15) controlPoint1:CGPointMake(21.23, 22.19) controlPoint2:CGPointMake(21.42, 22.15)];
                [bezier7Path addCurveToPoint:CGPointMake(21.96, 22.18) controlPoint1:CGPointMake(21.77, 22.15) controlPoint2:CGPointMake(21.87, 22.16)];
                [bezier7Path addCurveToPoint:CGPointMake(22.19, 22.28) controlPoint1:CGPointMake(22.05, 22.2) controlPoint2:CGPointMake(22.13, 22.24)];
                [bezier7Path addCurveToPoint:CGPointMake(22.34, 22.44) controlPoint1:CGPointMake(22.26, 22.32) controlPoint2:CGPointMake(22.31, 22.38)];
                [bezier7Path addCurveToPoint:CGPointMake(22.39, 22.68) controlPoint1:CGPointMake(22.37, 22.51) controlPoint2:CGPointMake(22.39, 22.59)];
                [bezier7Path addLineToPoint:CGPointMake(22.39, 23.62)];
                [bezier7Path addLineToPoint:CGPointMake(22.4, 23.62)];
                [bezier7Path closePath];
                [bezier7Path moveToPoint:CGPointMake(22.01, 22.69)];
                [bezier7Path addCurveToPoint:CGPointMake(21.92, 22.52) controlPoint1:CGPointMake(22.01, 22.62) controlPoint2:CGPointMake(21.98, 22.56)];
                [bezier7Path addCurveToPoint:CGPointMake(21.65, 22.46) controlPoint1:CGPointMake(21.86, 22.48) controlPoint2:CGPointMake(21.77, 22.46)];
                [bezier7Path addCurveToPoint:CGPointMake(21.38, 22.52) controlPoint1:CGPointMake(21.53, 22.46) controlPoint2:CGPointMake(21.44, 22.48)];
                [bezier7Path addCurveToPoint:CGPointMake(21.29, 22.68) controlPoint1:CGPointMake(21.32, 22.56) controlPoint2:CGPointMake(21.29, 22.61)];
                [bezier7Path addLineToPoint:CGPointMake(21.29, 23.63)];
                [bezier7Path addCurveToPoint:CGPointMake(21.38, 23.8) controlPoint1:CGPointMake(21.29, 23.71) controlPoint2:CGPointMake(21.32, 23.76)];
                [bezier7Path addCurveToPoint:CGPointMake(21.64, 23.85) controlPoint1:CGPointMake(21.44, 23.83) controlPoint2:CGPointMake(21.52, 23.85)];
                [bezier7Path addCurveToPoint:CGPointMake(21.91, 23.8) controlPoint1:CGPointMake(21.75, 23.85) controlPoint2:CGPointMake(21.84, 23.83)];
                [bezier7Path addCurveToPoint:CGPointMake(22.01, 23.63) controlPoint1:CGPointMake(21.97, 23.77) controlPoint2:CGPointMake(22.01, 23.71)];
                [bezier7Path addLineToPoint:CGPointMake(22.01, 22.69)];
                [bezier7Path closePath];
                bezier7Path.miterLimit = 4;

                [fillColor setFill];
                [bezier7Path fill];

                //// Bezier 8 Drawing
                UIBezierPath *bezier8Path = [UIBezierPath bezierPath];
                [bezier8Path moveToPoint:CGPointMake(25.63, 23.01)];
                [bezier8Path addCurveToPoint:CGPointMake(25.81, 23.1) controlPoint1:CGPointMake(25.7, 23.03) controlPoint2:CGPointMake(25.76, 23.06)];
                [bezier8Path addCurveToPoint:CGPointMake(25.9, 23.28) controlPoint1:CGPointMake(25.86, 23.14) controlPoint2:CGPointMake(25.89, 23.2)];
                [bezier8Path addCurveToPoint:CGPointMake(25.93, 23.56) controlPoint1:CGPointMake(25.92, 23.35) controlPoint2:CGPointMake(25.93, 23.45)];
                [bezier8Path addCurveToPoint:CGPointMake(25.9, 23.85) controlPoint1:CGPointMake(25.93, 23.68) controlPoint2:CGPointMake(25.92, 23.77)];
                [bezier8Path addCurveToPoint:CGPointMake(25.77, 24.03) controlPoint1:CGPointMake(25.87, 23.93) controlPoint2:CGPointMake(25.83, 23.99)];
                [bezier8Path addCurveToPoint:CGPointMake(25.52, 24.13) controlPoint1:CGPointMake(25.71, 24.08) controlPoint2:CGPointMake(25.63, 24.11)];
                [bezier8Path addCurveToPoint:CGPointMake(25.12, 24.16) controlPoint1:CGPointMake(25.42, 24.15) controlPoint2:CGPointMake(25.28, 24.16)];
                [bezier8Path addLineToPoint:CGPointMake(25.04, 24.16)];
                [bezier8Path addCurveToPoint:CGPointMake(24.84, 24.15) controlPoint1:CGPointMake(24.98, 24.16) controlPoint2:CGPointMake(24.91, 24.16)];
                [bezier8Path addCurveToPoint:CGPointMake(24.64, 24.12) controlPoint1:CGPointMake(24.77, 24.15) controlPoint2:CGPointMake(24.7, 24.14)];
                [bezier8Path addCurveToPoint:CGPointMake(24.48, 24.04) controlPoint1:CGPointMake(24.58, 24.1) controlPoint2:CGPointMake(24.53, 24.07)];
                [bezier8Path addCurveToPoint:CGPointMake(24.41, 23.89) controlPoint1:CGPointMake(24.44, 24) controlPoint2:CGPointMake(24.41, 23.95)];
                [bezier8Path addLineToPoint:CGPointMake(24.41, 23.89)];
                [bezier8Path addCurveToPoint:CGPointMake(24.46, 23.78) controlPoint1:CGPointMake(24.41, 23.84) controlPoint2:CGPointMake(24.43, 23.81)];
                [bezier8Path addCurveToPoint:CGPointMake(24.58, 23.73) controlPoint1:CGPointMake(24.5, 23.75) controlPoint2:CGPointMake(24.54, 23.73)];
                [bezier8Path addLineToPoint:CGPointMake(24.59, 23.73)];
                [bezier8Path addCurveToPoint:CGPointMake(24.68, 23.74) controlPoint1:CGPointMake(24.63, 23.73) controlPoint2:CGPointMake(24.66, 23.74)];
                [bezier8Path addCurveToPoint:CGPointMake(24.73, 23.76) controlPoint1:CGPointMake(24.7, 23.75) controlPoint2:CGPointMake(24.72, 23.76)];
                [bezier8Path addCurveToPoint:CGPointMake(24.78, 23.79) controlPoint1:CGPointMake(24.75, 23.77) controlPoint2:CGPointMake(24.76, 23.78)];
                [bezier8Path addCurveToPoint:CGPointMake(24.85, 23.82) controlPoint1:CGPointMake(24.8, 23.8) controlPoint2:CGPointMake(24.82, 23.81)];
                [bezier8Path addCurveToPoint:CGPointMake(24.97, 23.84) controlPoint1:CGPointMake(24.88, 23.83) controlPoint2:CGPointMake(24.92, 23.83)];
                [bezier8Path addCurveToPoint:CGPointMake(25.16, 23.85) controlPoint1:CGPointMake(25.02, 23.85) controlPoint2:CGPointMake(25.08, 23.85)];
                [bezier8Path addCurveToPoint:CGPointMake(25.36, 23.83) controlPoint1:CGPointMake(25.24, 23.85) controlPoint2:CGPointMake(25.3, 23.85)];
                [bezier8Path addCurveToPoint:CGPointMake(25.48, 23.78) controlPoint1:CGPointMake(25.41, 23.82) controlPoint2:CGPointMake(25.45, 23.8)];
                [bezier8Path addCurveToPoint:CGPointMake(25.54, 23.69) controlPoint1:CGPointMake(25.51, 23.76) controlPoint2:CGPointMake(25.52, 23.73)];
                [bezier8Path addCurveToPoint:CGPointMake(25.55, 23.56) controlPoint1:CGPointMake(25.55, 23.65) controlPoint2:CGPointMake(25.55, 23.61)];
                [bezier8Path addCurveToPoint:CGPointMake(25.52, 23.37) controlPoint1:CGPointMake(25.55, 23.47) controlPoint2:CGPointMake(25.54, 23.41)];
                [bezier8Path addCurveToPoint:CGPointMake(25.39, 23.31) controlPoint1:CGPointMake(25.5, 23.33) controlPoint2:CGPointMake(25.46, 23.31)];
                [bezier8Path addLineToPoint:CGPointMake(24.72, 23.31)];
                [bezier8Path addCurveToPoint:CGPointMake(24.58, 23.3) controlPoint1:CGPointMake(24.67, 23.31) controlPoint2:CGPointMake(24.62, 23.31)];
                [bezier8Path addCurveToPoint:CGPointMake(24.5, 23.27) controlPoint1:CGPointMake(24.54, 23.29) controlPoint2:CGPointMake(24.52, 23.28)];
                [bezier8Path addCurveToPoint:CGPointMake(24.46, 23.2) controlPoint1:CGPointMake(24.48, 23.25) controlPoint2:CGPointMake(24.47, 23.23)];
                [bezier8Path addCurveToPoint:CGPointMake(24.45, 23.08) controlPoint1:CGPointMake(24.46, 23.17) controlPoint2:CGPointMake(24.45, 23.13)];
                [bezier8Path addLineToPoint:CGPointMake(24.45, 22.34)];
                [bezier8Path addCurveToPoint:CGPointMake(24.5, 22.21) controlPoint1:CGPointMake(24.45, 22.29) controlPoint2:CGPointMake(24.47, 22.24)];
                [bezier8Path addCurveToPoint:CGPointMake(24.67, 22.17) controlPoint1:CGPointMake(24.53, 22.18) controlPoint2:CGPointMake(24.59, 22.17)];
                [bezier8Path addCurveToPoint:CGPointMake(24.79, 22.17) controlPoint1:CGPointMake(24.69, 22.17) controlPoint2:CGPointMake(24.74, 22.17)];
                [bezier8Path addCurveToPoint:CGPointMake(24.97, 22.17) controlPoint1:CGPointMake(24.85, 22.17) controlPoint2:CGPointMake(24.9, 22.17)];
                [bezier8Path addCurveToPoint:CGPointMake(25.17, 22.17) controlPoint1:CGPointMake(25.04, 22.17) controlPoint2:CGPointMake(25.1, 22.17)];
                [bezier8Path addCurveToPoint:CGPointMake(25.37, 22.17) controlPoint1:CGPointMake(25.24, 22.17) controlPoint2:CGPointMake(25.31, 22.17)];
                [bezier8Path addCurveToPoint:CGPointMake(25.53, 22.17) controlPoint1:CGPointMake(25.43, 22.17) controlPoint2:CGPointMake(25.48, 22.17)];
                [bezier8Path addCurveToPoint:CGPointMake(25.61, 22.17) controlPoint1:CGPointMake(25.57, 22.17) controlPoint2:CGPointMake(25.6, 22.17)];
                [bezier8Path addCurveToPoint:CGPointMake(25.68, 22.18) controlPoint1:CGPointMake(25.63, 22.17) controlPoint2:CGPointMake(25.66, 22.17)];
                [bezier8Path addCurveToPoint:CGPointMake(25.75, 22.2) controlPoint1:CGPointMake(25.71, 22.18) controlPoint2:CGPointMake(25.73, 22.19)];
                [bezier8Path addCurveToPoint:CGPointMake(25.81, 22.25) controlPoint1:CGPointMake(25.77, 22.21) controlPoint2:CGPointMake(25.79, 22.23)];
                [bezier8Path addCurveToPoint:CGPointMake(25.84, 22.33) controlPoint1:CGPointMake(25.83, 22.27) controlPoint2:CGPointMake(25.84, 22.3)];
                [bezier8Path addLineToPoint:CGPointMake(25.84, 22.34)];
                [bezier8Path addCurveToPoint:CGPointMake(25.82, 22.43) controlPoint1:CGPointMake(25.84, 22.38) controlPoint2:CGPointMake(25.83, 22.41)];
                [bezier8Path addCurveToPoint:CGPointMake(25.77, 22.48) controlPoint1:CGPointMake(25.81, 22.45) controlPoint2:CGPointMake(25.79, 22.47)];
                [bezier8Path addCurveToPoint:CGPointMake(25.7, 22.5) controlPoint1:CGPointMake(25.75, 22.49) controlPoint2:CGPointMake(25.72, 22.5)];
                [bezier8Path addCurveToPoint:CGPointMake(25.61, 22.5) controlPoint1:CGPointMake(25.67, 22.5) controlPoint2:CGPointMake(25.64, 22.5)];
                [bezier8Path addLineToPoint:CGPointMake(24.83, 22.5)];
                [bezier8Path addLineToPoint:CGPointMake(24.83, 23.01)];
                [bezier8Path addLineToPoint:CGPointMake(25.35, 23.01)];
                [bezier8Path addCurveToPoint:CGPointMake(25.63, 23.01) controlPoint1:CGPointMake(25.47, 22.99) controlPoint2:CGPointMake(25.56, 22.99)];
                [bezier8Path closePath];
                bezier8Path.miterLimit = 4;

                [fillColor setFill];
                [bezier8Path fill];

                //// Bezier 9 Drawing
                UIBezierPath *bezier9Path = [UIBezierPath bezierPath];
                [bezier9Path moveToPoint:CGPointMake(28.11, 23.62)];
                [bezier9Path addLineToPoint:CGPointMake(28.11, 23.62)];
                [bezier9Path addCurveToPoint:CGPointMake(28.06, 23.88) controlPoint1:CGPointMake(28.11, 23.72) controlPoint2:CGPointMake(28.09, 23.81)];
                [bezier9Path addCurveToPoint:CGPointMake(27.9, 24.05) controlPoint1:CGPointMake(28.02, 23.95) controlPoint2:CGPointMake(27.97, 24.01)];
                [bezier9Path addCurveToPoint:CGPointMake(27.66, 24.14) controlPoint1:CGPointMake(27.83, 24.09) controlPoint2:CGPointMake(27.75, 24.12)];
                [bezier9Path addCurveToPoint:CGPointMake(27.35, 24.17) controlPoint1:CGPointMake(27.57, 24.16) controlPoint2:CGPointMake(27.46, 24.17)];
                [bezier9Path addCurveToPoint:CGPointMake(27.04, 24.14) controlPoint1:CGPointMake(27.24, 24.17) controlPoint2:CGPointMake(27.13, 24.16)];
                [bezier9Path addCurveToPoint:CGPointMake(26.8, 24.05) controlPoint1:CGPointMake(26.95, 24.12) controlPoint2:CGPointMake(26.87, 24.09)];
                [bezier9Path addCurveToPoint:CGPointMake(26.65, 23.88) controlPoint1:CGPointMake(26.74, 24.01) controlPoint2:CGPointMake(26.69, 23.95)];
                [bezier9Path addCurveToPoint:CGPointMake(26.6, 23.64) controlPoint1:CGPointMake(26.62, 23.81) controlPoint2:CGPointMake(26.6, 23.73)];
                [bezier9Path addLineToPoint:CGPointMake(26.6, 22.67)];
                [bezier9Path addCurveToPoint:CGPointMake(26.8, 22.28) controlPoint1:CGPointMake(26.6, 22.5) controlPoint2:CGPointMake(26.67, 22.37)];
                [bezier9Path addCurveToPoint:CGPointMake(27.36, 22.15) controlPoint1:CGPointMake(26.93, 22.19) controlPoint2:CGPointMake(27.12, 22.15)];
                [bezier9Path addCurveToPoint:CGPointMake(27.67, 22.18) controlPoint1:CGPointMake(27.47, 22.15) controlPoint2:CGPointMake(27.58, 22.16)];
                [bezier9Path addCurveToPoint:CGPointMake(27.91, 22.28) controlPoint1:CGPointMake(27.76, 22.2) controlPoint2:CGPointMake(27.84, 22.24)];
                [bezier9Path addCurveToPoint:CGPointMake(28.06, 22.44) controlPoint1:CGPointMake(27.97, 22.32) controlPoint2:CGPointMake(28.02, 22.38)];
                [bezier9Path addCurveToPoint:CGPointMake(28.11, 22.68) controlPoint1:CGPointMake(28.09, 22.51) controlPoint2:CGPointMake(28.11, 22.59)];
                [bezier9Path addLineToPoint:CGPointMake(28.11, 23.62)];
                [bezier9Path closePath];
                [bezier9Path moveToPoint:CGPointMake(27.72, 22.69)];
                [bezier9Path addCurveToPoint:CGPointMake(27.63, 22.52) controlPoint1:CGPointMake(27.72, 22.62) controlPoint2:CGPointMake(27.69, 22.56)];
                [bezier9Path addCurveToPoint:CGPointMake(27.36, 22.46) controlPoint1:CGPointMake(27.57, 22.48) controlPoint2:CGPointMake(27.48, 22.46)];
                [bezier9Path addCurveToPoint:CGPointMake(27.09, 22.52) controlPoint1:CGPointMake(27.23, 22.46) controlPoint2:CGPointMake(27.15, 22.48)];
                [bezier9Path addCurveToPoint:CGPointMake(27, 22.67) controlPoint1:CGPointMake(27.03, 22.56) controlPoint2:CGPointMake(27, 22.61)];
                [bezier9Path addLineToPoint:CGPointMake(27, 23.62)];
                [bezier9Path addCurveToPoint:CGPointMake(27.09, 23.79) controlPoint1:CGPointMake(27, 23.7) controlPoint2:CGPointMake(27.03, 23.75)];
                [bezier9Path addCurveToPoint:CGPointMake(27.36, 23.84) controlPoint1:CGPointMake(27.15, 23.82) controlPoint2:CGPointMake(27.24, 23.84)];
                [bezier9Path addCurveToPoint:CGPointMake(27.63, 23.79) controlPoint1:CGPointMake(27.48, 23.84) controlPoint2:CGPointMake(27.56, 23.82)];
                [bezier9Path addCurveToPoint:CGPointMake(27.73, 23.62) controlPoint1:CGPointMake(27.7, 23.76) controlPoint2:CGPointMake(27.73, 23.7)];
                [bezier9Path addLineToPoint:CGPointMake(27.73, 22.69)];
                [bezier9Path addLineToPoint:CGPointMake(27.72, 22.69)];
                [bezier9Path closePath];
                bezier9Path.miterLimit = 4;

                [fillColor setFill];
                [bezier9Path fill];

                //// Bezier 10 Drawing
                UIBezierPath *bezier10Path = [UIBezierPath bezierPath];
                [bezier10Path moveToPoint:CGPointMake(29.56, 22.14)];
                [bezier10Path addCurveToPoint:CGPointMake(29.93, 22.17) controlPoint1:CGPointMake(29.7, 22.14) controlPoint2:CGPointMake(29.83, 22.15)];
                [bezier10Path addCurveToPoint:CGPointMake(30.18, 22.27) controlPoint1:CGPointMake(30.03, 22.19) controlPoint2:CGPointMake(30.11, 22.22)];
                [bezier10Path addCurveToPoint:CGPointMake(30.32, 22.45) controlPoint1:CGPointMake(30.24, 22.31) controlPoint2:CGPointMake(30.29, 22.37)];
                [bezier10Path addCurveToPoint:CGPointMake(30.36, 22.72) controlPoint1:CGPointMake(30.35, 22.52) controlPoint2:CGPointMake(30.36, 22.61)];
                [bezier10Path addLineToPoint:CGPointMake(30.36, 22.73)];
                [bezier10Path addCurveToPoint:CGPointMake(30.33, 23.02) controlPoint1:CGPointMake(30.36, 22.84) controlPoint2:CGPointMake(30.35, 22.94)];
                [bezier10Path addCurveToPoint:CGPointMake(30.22, 23.2) controlPoint1:CGPointMake(30.31, 23.1) controlPoint2:CGPointMake(30.27, 23.15)];
                [bezier10Path addCurveToPoint:CGPointMake(30.02, 23.3) controlPoint1:CGPointMake(30.17, 23.25) controlPoint2:CGPointMake(30.1, 23.28)];
                [bezier10Path addCurveToPoint:CGPointMake(29.71, 23.33) controlPoint1:CGPointMake(29.94, 23.32) controlPoint2:CGPointMake(29.83, 23.33)];
                [bezier10Path addCurveToPoint:CGPointMake(29.45, 23.33) controlPoint1:CGPointMake(29.61, 23.33) controlPoint2:CGPointMake(29.52, 23.33)];
                [bezier10Path addCurveToPoint:CGPointMake(29.28, 23.37) controlPoint1:CGPointMake(29.38, 23.33) controlPoint2:CGPointMake(29.33, 23.35)];
                [bezier10Path addCurveToPoint:CGPointMake(29.2, 23.46) controlPoint1:CGPointMake(29.24, 23.39) controlPoint2:CGPointMake(29.21, 23.42)];
                [bezier10Path addCurveToPoint:CGPointMake(29.18, 23.65) controlPoint1:CGPointMake(29.19, 23.5) controlPoint2:CGPointMake(29.18, 23.57)];
                [bezier10Path addLineToPoint:CGPointMake(29.18, 23.83)];
                [bezier10Path addLineToPoint:CGPointMake(30.15, 23.83)];
                [bezier10Path addCurveToPoint:CGPointMake(30.22, 23.84) controlPoint1:CGPointMake(30.17, 23.83) controlPoint2:CGPointMake(30.2, 23.83)];
                [bezier10Path addCurveToPoint:CGPointMake(30.28, 23.87) controlPoint1:CGPointMake(30.24, 23.85) controlPoint2:CGPointMake(30.26, 23.86)];
                [bezier10Path addCurveToPoint:CGPointMake(30.33, 23.92) controlPoint1:CGPointMake(30.3, 23.88) controlPoint2:CGPointMake(30.32, 23.9)];
                [bezier10Path addCurveToPoint:CGPointMake(30.35, 23.99) controlPoint1:CGPointMake(30.34, 23.94) controlPoint2:CGPointMake(30.35, 23.96)];
                [bezier10Path addCurveToPoint:CGPointMake(30.33, 24.07) controlPoint1:CGPointMake(30.35, 24.02) controlPoint2:CGPointMake(30.35, 24.05)];
                [bezier10Path addCurveToPoint:CGPointMake(30.28, 24.12) controlPoint1:CGPointMake(30.32, 24.09) controlPoint2:CGPointMake(30.3, 24.11)];
                [bezier10Path addCurveToPoint:CGPointMake(30.21, 24.15) controlPoint1:CGPointMake(30.26, 24.13) controlPoint2:CGPointMake(30.24, 24.14)];
                [bezier10Path addCurveToPoint:CGPointMake(30.13, 24.16) controlPoint1:CGPointMake(30.19, 24.16) controlPoint2:CGPointMake(30.16, 24.16)];
                [bezier10Path addLineToPoint:CGPointMake(29, 24.16)];
                [bezier10Path addCurveToPoint:CGPointMake(28.83, 24.12) controlPoint1:CGPointMake(28.91, 24.16) controlPoint2:CGPointMake(28.86, 24.15)];
                [bezier10Path addCurveToPoint:CGPointMake(28.78, 23.99) controlPoint1:CGPointMake(28.8, 24.09) controlPoint2:CGPointMake(28.78, 24.05)];
                [bezier10Path addLineToPoint:CGPointMake(28.78, 23.59)];
                [bezier10Path addCurveToPoint:CGPointMake(28.82, 23.32) controlPoint1:CGPointMake(28.78, 23.48) controlPoint2:CGPointMake(28.8, 23.39)];
                [bezier10Path addCurveToPoint:CGPointMake(28.94, 23.14) controlPoint1:CGPointMake(28.85, 23.25) controlPoint2:CGPointMake(28.89, 23.19)];
                [bezier10Path addCurveToPoint:CGPointMake(29.13, 23.05) controlPoint1:CGPointMake(28.99, 23.1) controlPoint2:CGPointMake(29.06, 23.07)];
                [bezier10Path addCurveToPoint:CGPointMake(29.4, 23) controlPoint1:CGPointMake(29.22, 23.01) controlPoint2:CGPointMake(29.31, 23)];
                [bezier10Path addLineToPoint:CGPointMake(29.69, 22.99)];
                [bezier10Path addCurveToPoint:CGPointMake(29.82, 22.98) controlPoint1:CGPointMake(29.74, 22.99) controlPoint2:CGPointMake(29.79, 22.99)];
                [bezier10Path addCurveToPoint:CGPointMake(29.9, 22.94) controlPoint1:CGPointMake(29.86, 22.97) controlPoint2:CGPointMake(29.88, 22.96)];
                [bezier10Path addCurveToPoint:CGPointMake(29.95, 22.86) controlPoint1:CGPointMake(29.92, 22.92) controlPoint2:CGPointMake(29.94, 22.9)];
                [bezier10Path addCurveToPoint:CGPointMake(29.96, 22.74) controlPoint1:CGPointMake(29.96, 22.83) controlPoint2:CGPointMake(29.96, 22.79)];
                [bezier10Path addLineToPoint:CGPointMake(29.96, 22.73)];
                [bezier10Path addCurveToPoint:CGPointMake(29.94, 22.6) controlPoint1:CGPointMake(29.96, 22.68) controlPoint2:CGPointMake(29.95, 22.64)];
                [bezier10Path addCurveToPoint:CGPointMake(29.88, 22.52) controlPoint1:CGPointMake(29.93, 22.57) controlPoint2:CGPointMake(29.91, 22.54)];
                [bezier10Path addCurveToPoint:CGPointMake(29.75, 22.47) controlPoint1:CGPointMake(29.85, 22.5) controlPoint2:CGPointMake(29.81, 22.48)];
                [bezier10Path addCurveToPoint:CGPointMake(29.54, 22.46) controlPoint1:CGPointMake(29.7, 22.46) controlPoint2:CGPointMake(29.62, 22.46)];
                [bezier10Path addCurveToPoint:CGPointMake(29.35, 22.47) controlPoint1:CGPointMake(29.47, 22.46) controlPoint2:CGPointMake(29.41, 22.46)];
                [bezier10Path addCurveToPoint:CGPointMake(29.21, 22.5) controlPoint1:CGPointMake(29.29, 22.48) controlPoint2:CGPointMake(29.25, 22.49)];
                [bezier10Path addCurveToPoint:CGPointMake(29.11, 22.54) controlPoint1:CGPointMake(29.17, 22.51) controlPoint2:CGPointMake(29.14, 22.52)];
                [bezier10Path addCurveToPoint:CGPointMake(29.01, 22.56) controlPoint1:CGPointMake(29.09, 22.55) controlPoint2:CGPointMake(29.05, 22.56)];
                [bezier10Path addLineToPoint:CGPointMake(29, 22.56)];
                [bezier10Path addCurveToPoint:CGPointMake(28.88, 22.51) controlPoint1:CGPointMake(28.95, 22.56) controlPoint2:CGPointMake(28.92, 22.54)];
                [bezier10Path addCurveToPoint:CGPointMake(28.84, 22.39) controlPoint1:CGPointMake(28.85, 22.48) controlPoint2:CGPointMake(28.84, 22.44)];
                [bezier10Path addLineToPoint:CGPointMake(28.84, 22.38)];
                [bezier10Path addCurveToPoint:CGPointMake(28.9, 22.27) controlPoint1:CGPointMake(28.84, 22.33) controlPoint2:CGPointMake(28.86, 22.3)];
                [bezier10Path addCurveToPoint:CGPointMake(29.06, 22.2) controlPoint1:CGPointMake(28.94, 22.24) controlPoint2:CGPointMake(28.99, 22.21)];
                [bezier10Path addCurveToPoint:CGPointMake(29.29, 22.16) controlPoint1:CGPointMake(29.13, 22.18) controlPoint2:CGPointMake(29.2, 22.17)];
                [bezier10Path addCurveToPoint:CGPointMake(29.56, 22.14) controlPoint1:CGPointMake(29.37, 22.14) controlPoint2:CGPointMake(29.46, 22.14)];
                [bezier10Path closePath];
                bezier10Path.miterLimit = 4;

                [fillColor setFill];
                [bezier10Path fill];

                //// Bezier 11 Drawing
                UIBezierPath *bezier11Path = [UIBezierPath bezierPath];
                [bezier11Path moveToPoint:CGPointMake(39.41, 22.14)];
                [bezier11Path addCurveToPoint:CGPointMake(39.78, 22.17) controlPoint1:CGPointMake(39.55, 22.14) controlPoint2:CGPointMake(39.68, 22.15)];
                [bezier11Path addCurveToPoint:CGPointMake(40.03, 22.27) controlPoint1:CGPointMake(39.88, 22.19) controlPoint2:CGPointMake(39.96, 22.22)];
                [bezier11Path addCurveToPoint:CGPointMake(40.17, 22.45) controlPoint1:CGPointMake(40.09, 22.31) controlPoint2:CGPointMake(40.14, 22.37)];
                [bezier11Path addCurveToPoint:CGPointMake(40.21, 22.72) controlPoint1:CGPointMake(40.2, 22.52) controlPoint2:CGPointMake(40.21, 22.61)];
                [bezier11Path addLineToPoint:CGPointMake(40.21, 22.73)];
                [bezier11Path addCurveToPoint:CGPointMake(40.18, 23.02) controlPoint1:CGPointMake(40.21, 22.84) controlPoint2:CGPointMake(40.2, 22.94)];
                [bezier11Path addCurveToPoint:CGPointMake(40.07, 23.2) controlPoint1:CGPointMake(40.16, 23.1) controlPoint2:CGPointMake(40.12, 23.15)];
                [bezier11Path addCurveToPoint:CGPointMake(39.87, 23.3) controlPoint1:CGPointMake(40.02, 23.25) controlPoint2:CGPointMake(39.95, 23.28)];
                [bezier11Path addCurveToPoint:CGPointMake(39.56, 23.33) controlPoint1:CGPointMake(39.79, 23.32) controlPoint2:CGPointMake(39.68, 23.33)];
                [bezier11Path addCurveToPoint:CGPointMake(39.3, 23.33) controlPoint1:CGPointMake(39.46, 23.33) controlPoint2:CGPointMake(39.37, 23.33)];
                [bezier11Path addCurveToPoint:CGPointMake(39.13, 23.37) controlPoint1:CGPointMake(39.23, 23.33) controlPoint2:CGPointMake(39.18, 23.35)];
                [bezier11Path addCurveToPoint:CGPointMake(39.05, 23.46) controlPoint1:CGPointMake(39.09, 23.39) controlPoint2:CGPointMake(39.06, 23.42)];
                [bezier11Path addCurveToPoint:CGPointMake(39.03, 23.65) controlPoint1:CGPointMake(39.04, 23.5) controlPoint2:CGPointMake(39.03, 23.57)];
                [bezier11Path addLineToPoint:CGPointMake(39.03, 23.83)];
                [bezier11Path addLineToPoint:CGPointMake(40, 23.83)];
                [bezier11Path addCurveToPoint:CGPointMake(40.07, 23.84) controlPoint1:CGPointMake(40.02, 23.83) controlPoint2:CGPointMake(40.05, 23.83)];
                [bezier11Path addCurveToPoint:CGPointMake(40.13, 23.87) controlPoint1:CGPointMake(40.09, 23.85) controlPoint2:CGPointMake(40.11, 23.86)];
                [bezier11Path addCurveToPoint:CGPointMake(40.18, 23.92) controlPoint1:CGPointMake(40.15, 23.88) controlPoint2:CGPointMake(40.17, 23.9)];
                [bezier11Path addCurveToPoint:CGPointMake(40.2, 23.99) controlPoint1:CGPointMake(40.19, 23.94) controlPoint2:CGPointMake(40.2, 23.96)];
                [bezier11Path addCurveToPoint:CGPointMake(40.18, 24.07) controlPoint1:CGPointMake(40.2, 24.02) controlPoint2:CGPointMake(40.2, 24.05)];
                [bezier11Path addCurveToPoint:CGPointMake(40.13, 24.12) controlPoint1:CGPointMake(40.17, 24.09) controlPoint2:CGPointMake(40.15, 24.11)];
                [bezier11Path addCurveToPoint:CGPointMake(40.06, 24.15) controlPoint1:CGPointMake(40.11, 24.13) controlPoint2:CGPointMake(40.09, 24.14)];
                [bezier11Path addCurveToPoint:CGPointMake(39.98, 24.16) controlPoint1:CGPointMake(40.04, 24.16) controlPoint2:CGPointMake(40.01, 24.16)];
                [bezier11Path addLineToPoint:CGPointMake(38.84, 24.16)];
                [bezier11Path addCurveToPoint:CGPointMake(38.67, 24.12) controlPoint1:CGPointMake(38.75, 24.16) controlPoint2:CGPointMake(38.7, 24.15)];
                [bezier11Path addCurveToPoint:CGPointMake(38.62, 23.99) controlPoint1:CGPointMake(38.64, 24.09) controlPoint2:CGPointMake(38.62, 24.05)];
                [bezier11Path addLineToPoint:CGPointMake(38.62, 23.59)];
                [bezier11Path addCurveToPoint:CGPointMake(38.66, 23.32) controlPoint1:CGPointMake(38.62, 23.48) controlPoint2:CGPointMake(38.64, 23.39)];
                [bezier11Path addCurveToPoint:CGPointMake(38.78, 23.14) controlPoint1:CGPointMake(38.69, 23.25) controlPoint2:CGPointMake(38.73, 23.19)];
                [bezier11Path addCurveToPoint:CGPointMake(38.97, 23.05) controlPoint1:CGPointMake(38.83, 23.1) controlPoint2:CGPointMake(38.9, 23.07)];
                [bezier11Path addCurveToPoint:CGPointMake(39.23, 23.02) controlPoint1:CGPointMake(39.05, 23.03) controlPoint2:CGPointMake(39.14, 23.02)];
                [bezier11Path addLineToPoint:CGPointMake(39.52, 23.01)];
                [bezier11Path addCurveToPoint:CGPointMake(39.65, 23) controlPoint1:CGPointMake(39.57, 23.01) controlPoint2:CGPointMake(39.62, 23.01)];
                [bezier11Path addCurveToPoint:CGPointMake(39.73, 22.96) controlPoint1:CGPointMake(39.69, 22.99) controlPoint2:CGPointMake(39.71, 22.98)];
                [bezier11Path addCurveToPoint:CGPointMake(39.78, 22.88) controlPoint1:CGPointMake(39.75, 22.94) controlPoint2:CGPointMake(39.77, 22.92)];
                [bezier11Path addCurveToPoint:CGPointMake(39.79, 22.76) controlPoint1:CGPointMake(39.79, 22.85) controlPoint2:CGPointMake(39.79, 22.81)];
                [bezier11Path addLineToPoint:CGPointMake(39.79, 22.75)];
                [bezier11Path addCurveToPoint:CGPointMake(39.77, 22.62) controlPoint1:CGPointMake(39.79, 22.7) controlPoint2:CGPointMake(39.78, 22.66)];
                [bezier11Path addCurveToPoint:CGPointMake(39.71, 22.54) controlPoint1:CGPointMake(39.76, 22.59) controlPoint2:CGPointMake(39.74, 22.56)];
                [bezier11Path addCurveToPoint:CGPointMake(39.58, 22.49) controlPoint1:CGPointMake(39.68, 22.52) controlPoint2:CGPointMake(39.64, 22.5)];
                [bezier11Path addCurveToPoint:CGPointMake(39.37, 22.48) controlPoint1:CGPointMake(39.53, 22.48) controlPoint2:CGPointMake(39.45, 22.48)];
                [bezier11Path addCurveToPoint:CGPointMake(39.18, 22.49) controlPoint1:CGPointMake(39.3, 22.48) controlPoint2:CGPointMake(39.24, 22.48)];
                [bezier11Path addCurveToPoint:CGPointMake(39.04, 22.52) controlPoint1:CGPointMake(39.12, 22.5) controlPoint2:CGPointMake(39.08, 22.51)];
                [bezier11Path addCurveToPoint:CGPointMake(38.94, 22.56) controlPoint1:CGPointMake(39, 22.53) controlPoint2:CGPointMake(38.97, 22.54)];
                [bezier11Path addCurveToPoint:CGPointMake(38.84, 22.58) controlPoint1:CGPointMake(38.92, 22.57) controlPoint2:CGPointMake(38.88, 22.58)];
                [bezier11Path addLineToPoint:CGPointMake(38.83, 22.58)];
                [bezier11Path addCurveToPoint:CGPointMake(38.71, 22.53) controlPoint1:CGPointMake(38.78, 22.58) controlPoint2:CGPointMake(38.75, 22.56)];
                [bezier11Path addCurveToPoint:CGPointMake(38.67, 22.41) controlPoint1:CGPointMake(38.68, 22.5) controlPoint2:CGPointMake(38.67, 22.46)];
                [bezier11Path addLineToPoint:CGPointMake(38.67, 22.4)];
                [bezier11Path addCurveToPoint:CGPointMake(38.73, 22.29) controlPoint1:CGPointMake(38.67, 22.35) controlPoint2:CGPointMake(38.69, 22.32)];
                [bezier11Path addCurveToPoint:CGPointMake(38.89, 22.22) controlPoint1:CGPointMake(38.77, 22.26) controlPoint2:CGPointMake(38.82, 22.23)];
                [bezier11Path addCurveToPoint:CGPointMake(39.12, 22.18) controlPoint1:CGPointMake(38.96, 22.2) controlPoint2:CGPointMake(39.03, 22.19)];
                [bezier11Path addCurveToPoint:CGPointMake(39.41, 22.14) controlPoint1:CGPointMake(39.22, 22.14) controlPoint2:CGPointMake(39.31, 22.14)];
                [bezier11Path closePath];
                bezier11Path.miterLimit = 4;

                [fillColor setFill];
                [bezier11Path fill];

                //// Bezier 12 Drawing
                UIBezierPath *bezier12Path = [UIBezierPath bezierPath];
                [bezier12Path moveToPoint:CGPointMake(31.83, 22.93)];
                [bezier12Path addCurveToPoint:CGPointMake(32.15, 22.97) controlPoint1:CGPointMake(31.96, 22.93) controlPoint2:CGPointMake(32.07, 22.94)];
                [bezier12Path addCurveToPoint:CGPointMake(32.36, 23.09) controlPoint1:CGPointMake(32.24, 23) controlPoint2:CGPointMake(32.31, 23.04)];
                [bezier12Path addCurveToPoint:CGPointMake(32.47, 23.29) controlPoint1:CGPointMake(32.41, 23.14) controlPoint2:CGPointMake(32.45, 23.21)];
                [bezier12Path addCurveToPoint:CGPointMake(32.51, 23.56) controlPoint1:CGPointMake(32.49, 23.37) controlPoint2:CGPointMake(32.51, 23.46)];
                [bezier12Path addCurveToPoint:CGPointMake(32.47, 23.82) controlPoint1:CGPointMake(32.51, 23.66) controlPoint2:CGPointMake(32.5, 23.75)];
                [bezier12Path addCurveToPoint:CGPointMake(32.34, 24.01) controlPoint1:CGPointMake(32.45, 23.9) controlPoint2:CGPointMake(32.4, 23.96)];
                [bezier12Path addCurveToPoint:CGPointMake(32.11, 24.13) controlPoint1:CGPointMake(32.28, 24.06) controlPoint2:CGPointMake(32.2, 24.1)];
                [bezier12Path addCurveToPoint:CGPointMake(31.75, 24.17) controlPoint1:CGPointMake(32.01, 24.16) controlPoint2:CGPointMake(31.89, 24.17)];
                [bezier12Path addCurveToPoint:CGPointMake(31.45, 24.14) controlPoint1:CGPointMake(31.64, 24.17) controlPoint2:CGPointMake(31.54, 24.16)];
                [bezier12Path addCurveToPoint:CGPointMake(31.22, 24.04) controlPoint1:CGPointMake(31.36, 24.12) controlPoint2:CGPointMake(31.28, 24.09)];
                [bezier12Path addCurveToPoint:CGPointMake(31.07, 23.87) controlPoint1:CGPointMake(31.15, 24) controlPoint2:CGPointMake(31.1, 23.94)];
                [bezier12Path addCurveToPoint:CGPointMake(31.02, 23.61) controlPoint1:CGPointMake(31.03, 23.8) controlPoint2:CGPointMake(31.02, 23.71)];
                [bezier12Path addLineToPoint:CGPointMake(31.02, 22.31)];
                [bezier12Path addCurveToPoint:CGPointMake(31.03, 22.25) controlPoint1:CGPointMake(31.02, 22.29) controlPoint2:CGPointMake(31.02, 22.27)];
                [bezier12Path addCurveToPoint:CGPointMake(31.06, 22.2) controlPoint1:CGPointMake(31.04, 22.23) controlPoint2:CGPointMake(31.05, 22.21)];
                [bezier12Path addCurveToPoint:CGPointMake(31.12, 22.16) controlPoint1:CGPointMake(31.08, 22.18) controlPoint2:CGPointMake(31.1, 22.17)];
                [bezier12Path addCurveToPoint:CGPointMake(31.21, 22.15) controlPoint1:CGPointMake(31.15, 22.15) controlPoint2:CGPointMake(31.18, 22.15)];
                [bezier12Path addCurveToPoint:CGPointMake(31.36, 22.2) controlPoint1:CGPointMake(31.28, 22.15) controlPoint2:CGPointMake(31.33, 22.17)];
                [bezier12Path addCurveToPoint:CGPointMake(31.41, 22.32) controlPoint1:CGPointMake(31.39, 22.23) controlPoint2:CGPointMake(31.41, 22.27)];
                [bezier12Path addLineToPoint:CGPointMake(31.41, 22.97)];
                [bezier12Path addCurveToPoint:CGPointMake(31.66, 22.95) controlPoint1:CGPointMake(31.5, 22.96) controlPoint2:CGPointMake(31.59, 22.95)];
                [bezier12Path addCurveToPoint:CGPointMake(31.83, 22.93) controlPoint1:CGPointMake(31.72, 22.93) controlPoint2:CGPointMake(31.78, 22.93)];
                [bezier12Path closePath];
                [bezier12Path moveToPoint:CGPointMake(32.12, 23.54)];
                [bezier12Path addCurveToPoint:CGPointMake(32.1, 23.39) controlPoint1:CGPointMake(32.12, 23.48) controlPoint2:CGPointMake(32.11, 23.43)];
                [bezier12Path addCurveToPoint:CGPointMake(32.04, 23.3) controlPoint1:CGPointMake(32.09, 23.35) controlPoint2:CGPointMake(32.07, 23.32)];
                [bezier12Path addCurveToPoint:CGPointMake(31.93, 23.26) controlPoint1:CGPointMake(32.01, 23.28) controlPoint2:CGPointMake(31.97, 23.26)];
                [bezier12Path addCurveToPoint:CGPointMake(31.75, 23.25) controlPoint1:CGPointMake(31.88, 23.25) controlPoint2:CGPointMake(31.83, 23.25)];
                [bezier12Path addCurveToPoint:CGPointMake(31.62, 23.25) controlPoint1:CGPointMake(31.7, 23.25) controlPoint2:CGPointMake(31.65, 23.25)];
                [bezier12Path addCurveToPoint:CGPointMake(31.53, 23.25) controlPoint1:CGPointMake(31.58, 23.25) controlPoint2:CGPointMake(31.56, 23.25)];
                [bezier12Path addCurveToPoint:CGPointMake(31.46, 23.26) controlPoint1:CGPointMake(31.51, 23.25) controlPoint2:CGPointMake(31.48, 23.25)];
                [bezier12Path addCurveToPoint:CGPointMake(31.39, 23.27) controlPoint1:CGPointMake(31.44, 23.26) controlPoint2:CGPointMake(31.42, 23.27)];
                [bezier12Path addLineToPoint:CGPointMake(31.39, 23.52)];
                [bezier12Path addCurveToPoint:CGPointMake(31.41, 23.66) controlPoint1:CGPointMake(31.39, 23.58) controlPoint2:CGPointMake(31.4, 23.63)];
                [bezier12Path addCurveToPoint:CGPointMake(31.47, 23.76) controlPoint1:CGPointMake(31.42, 23.7) controlPoint2:CGPointMake(31.44, 23.73)];
                [bezier12Path addCurveToPoint:CGPointMake(31.58, 23.82) controlPoint1:CGPointMake(31.5, 23.79) controlPoint2:CGPointMake(31.53, 23.81)];
                [bezier12Path addCurveToPoint:CGPointMake(31.75, 23.84) controlPoint1:CGPointMake(31.62, 23.83) controlPoint2:CGPointMake(31.68, 23.84)];
                [bezier12Path addCurveToPoint:CGPointMake(31.92, 23.83) controlPoint1:CGPointMake(31.82, 23.84) controlPoint2:CGPointMake(31.87, 23.84)];
                [bezier12Path addCurveToPoint:CGPointMake(32.03, 23.79) controlPoint1:CGPointMake(31.97, 23.82) controlPoint2:CGPointMake(32, 23.81)];
                [bezier12Path addCurveToPoint:CGPointMake(32.1, 23.7) controlPoint1:CGPointMake(32.06, 23.77) controlPoint2:CGPointMake(32.08, 23.74)];
                [bezier12Path addCurveToPoint:CGPointMake(32.12, 23.54) controlPoint1:CGPointMake(32.12, 23.66) controlPoint2:CGPointMake(32.12, 23.61)];
                [bezier12Path closePath];
                bezier12Path.miterLimit = 4;

                [fillColor setFill];
                [bezier12Path fill];

                //// Bezier 13 Drawing
                UIBezierPath *bezier13Path = [UIBezierPath bezierPath];
                [bezier13Path moveToPoint:CGPointMake(36, 23.62)];
                [bezier13Path addCurveToPoint:CGPointMake(35.97, 23.85) controlPoint1:CGPointMake(36, 23.71) controlPoint2:CGPointMake(35.99, 23.78)];
                [bezier13Path addCurveToPoint:CGPointMake(35.86, 24.02) controlPoint1:CGPointMake(35.95, 23.92) controlPoint2:CGPointMake(35.91, 23.98)];
                [bezier13Path addCurveToPoint:CGPointMake(35.62, 24.13) controlPoint1:CGPointMake(35.81, 24.07) controlPoint2:CGPointMake(35.72, 24.1)];
                [bezier13Path addCurveToPoint:CGPointMake(35.22, 24.17) controlPoint1:CGPointMake(35.52, 24.15) controlPoint2:CGPointMake(35.38, 24.17)];
                [bezier13Path addCurveToPoint:CGPointMake(34.83, 24.13) controlPoint1:CGPointMake(35.06, 24.17) controlPoint2:CGPointMake(34.93, 24.16)];
                [bezier13Path addCurveToPoint:CGPointMake(34.61, 24.02) controlPoint1:CGPointMake(34.73, 24.1) controlPoint2:CGPointMake(34.66, 24.07)];
                [bezier13Path addCurveToPoint:CGPointMake(34.5, 23.85) controlPoint1:CGPointMake(34.55, 23.97) controlPoint2:CGPointMake(34.52, 23.91)];
                [bezier13Path addCurveToPoint:CGPointMake(34.47, 23.63) controlPoint1:CGPointMake(34.48, 23.78) controlPoint2:CGPointMake(34.47, 23.71)];
                [bezier13Path addCurveToPoint:CGPointMake(34.48, 23.46) controlPoint1:CGPointMake(34.47, 23.56) controlPoint2:CGPointMake(34.47, 23.51)];
                [bezier13Path addCurveToPoint:CGPointMake(34.51, 23.35) controlPoint1:CGPointMake(34.48, 23.42) controlPoint2:CGPointMake(34.49, 23.38)];
                [bezier13Path addCurveToPoint:CGPointMake(34.6, 23.27) controlPoint1:CGPointMake(34.53, 23.32) controlPoint2:CGPointMake(34.56, 23.29)];
                [bezier13Path addCurveToPoint:CGPointMake(34.77, 23.18) controlPoint1:CGPointMake(34.64, 23.24) controlPoint2:CGPointMake(34.7, 23.21)];
                [bezier13Path addCurveToPoint:CGPointMake(34.6, 23.11) controlPoint1:CGPointMake(34.7, 23.15) controlPoint2:CGPointMake(34.64, 23.13)];
                [bezier13Path addCurveToPoint:CGPointMake(34.51, 23.03) controlPoint1:CGPointMake(34.56, 23.09) controlPoint2:CGPointMake(34.53, 23.06)];
                [bezier13Path addCurveToPoint:CGPointMake(34.48, 22.91) controlPoint1:CGPointMake(34.49, 23) controlPoint2:CGPointMake(34.48, 22.96)];
                [bezier13Path addCurveToPoint:CGPointMake(34.48, 22.71) controlPoint1:CGPointMake(34.48, 22.86) controlPoint2:CGPointMake(34.48, 22.79)];
                [bezier13Path addCurveToPoint:CGPointMake(34.51, 22.44) controlPoint1:CGPointMake(34.48, 22.6) controlPoint2:CGPointMake(34.49, 22.51)];
                [bezier13Path addCurveToPoint:CGPointMake(34.64, 22.27) controlPoint1:CGPointMake(34.54, 22.37) controlPoint2:CGPointMake(34.58, 22.31)];
                [bezier13Path addCurveToPoint:CGPointMake(34.87, 22.18) controlPoint1:CGPointMake(34.7, 22.23) controlPoint2:CGPointMake(34.78, 22.2)];
                [bezier13Path addCurveToPoint:CGPointMake(35.22, 22.15) controlPoint1:CGPointMake(34.97, 22.16) controlPoint2:CGPointMake(35.08, 22.15)];
                [bezier13Path addCurveToPoint:CGPointMake(35.57, 22.18) controlPoint1:CGPointMake(35.36, 22.15) controlPoint2:CGPointMake(35.48, 22.16)];
                [bezier13Path addCurveToPoint:CGPointMake(35.81, 22.27) controlPoint1:CGPointMake(35.67, 22.2) controlPoint2:CGPointMake(35.75, 22.23)];
                [bezier13Path addCurveToPoint:CGPointMake(35.94, 22.44) controlPoint1:CGPointMake(35.87, 22.31) controlPoint2:CGPointMake(35.91, 22.37)];
                [bezier13Path addCurveToPoint:CGPointMake(35.98, 22.7) controlPoint1:CGPointMake(35.97, 22.51) controlPoint2:CGPointMake(35.98, 22.6)];
                [bezier13Path addCurveToPoint:CGPointMake(35.97, 22.9) controlPoint1:CGPointMake(35.98, 22.78) controlPoint2:CGPointMake(35.98, 22.85)];
                [bezier13Path addCurveToPoint:CGPointMake(35.94, 23.02) controlPoint1:CGPointMake(35.97, 22.95) controlPoint2:CGPointMake(35.96, 22.99)];
                [bezier13Path addCurveToPoint:CGPointMake(35.86, 23.1) controlPoint1:CGPointMake(35.92, 23.05) controlPoint2:CGPointMake(35.89, 23.08)];
                [bezier13Path addCurveToPoint:CGPointMake(35.7, 23.17) controlPoint1:CGPointMake(35.82, 23.12) controlPoint2:CGPointMake(35.77, 23.14)];
                [bezier13Path addCurveToPoint:CGPointMake(35.86, 23.25) controlPoint1:CGPointMake(35.77, 23.2) controlPoint2:CGPointMake(35.82, 23.23)];
                [bezier13Path addCurveToPoint:CGPointMake(35.95, 23.33) controlPoint1:CGPointMake(35.9, 23.27) controlPoint2:CGPointMake(35.93, 23.3)];
                [bezier13Path addCurveToPoint:CGPointMake(35.98, 23.45) controlPoint1:CGPointMake(35.97, 23.36) controlPoint2:CGPointMake(35.98, 23.4)];
                [bezier13Path addCurveToPoint:CGPointMake(36, 23.62) controlPoint1:CGPointMake(36, 23.48) controlPoint2:CGPointMake(36, 23.54)];
                [bezier13Path closePath];
                [bezier13Path moveToPoint:CGPointMake(35.61, 23.58)];
                [bezier13Path addCurveToPoint:CGPointMake(35.6, 23.55) controlPoint1:CGPointMake(35.61, 23.58) controlPoint2:CGPointMake(35.61, 23.57)];
                [bezier13Path addCurveToPoint:CGPointMake(35.55, 23.48) controlPoint1:CGPointMake(35.59, 23.53) controlPoint2:CGPointMake(35.58, 23.51)];
                [bezier13Path addCurveToPoint:CGPointMake(35.44, 23.39) controlPoint1:CGPointMake(35.53, 23.45) controlPoint2:CGPointMake(35.49, 23.42)];
                [bezier13Path addCurveToPoint:CGPointMake(35.24, 23.3) controlPoint1:CGPointMake(35.4, 23.35) controlPoint2:CGPointMake(35.33, 23.33)];
                [bezier13Path addCurveToPoint:CGPointMake(35.04, 23.4) controlPoint1:CGPointMake(35.16, 23.33) controlPoint2:CGPointMake(35.09, 23.36)];
                [bezier13Path addCurveToPoint:CGPointMake(34.93, 23.49) controlPoint1:CGPointMake(34.99, 23.43) controlPoint2:CGPointMake(34.95, 23.47)];
                [bezier13Path addCurveToPoint:CGPointMake(34.88, 23.57) controlPoint1:CGPointMake(34.9, 23.52) controlPoint2:CGPointMake(34.89, 23.55)];
                [bezier13Path addCurveToPoint:CGPointMake(34.87, 23.61) controlPoint1:CGPointMake(34.87, 23.59) controlPoint2:CGPointMake(34.87, 23.61)];
                [bezier13Path addLineToPoint:CGPointMake(34.87, 23.61)];
                [bezier13Path addCurveToPoint:CGPointMake(34.89, 23.71) controlPoint1:CGPointMake(34.87, 23.65) controlPoint2:CGPointMake(34.87, 23.69)];
                [bezier13Path addCurveToPoint:CGPointMake(34.95, 23.78) controlPoint1:CGPointMake(34.9, 23.74) controlPoint2:CGPointMake(34.92, 23.76)];
                [bezier13Path addCurveToPoint:CGPointMake(35.07, 23.82) controlPoint1:CGPointMake(34.98, 23.8) controlPoint2:CGPointMake(35.02, 23.81)];
                [bezier13Path addCurveToPoint:CGPointMake(35.26, 23.83) controlPoint1:CGPointMake(35.12, 23.83) controlPoint2:CGPointMake(35.19, 23.83)];
                [bezier13Path addCurveToPoint:CGPointMake(35.43, 23.82) controlPoint1:CGPointMake(35.33, 23.83) controlPoint2:CGPointMake(35.39, 23.83)];
                [bezier13Path addCurveToPoint:CGPointMake(35.54, 23.78) controlPoint1:CGPointMake(35.48, 23.81) controlPoint2:CGPointMake(35.52, 23.8)];
                [bezier13Path addCurveToPoint:CGPointMake(35.6, 23.71) controlPoint1:CGPointMake(35.57, 23.76) controlPoint2:CGPointMake(35.59, 23.74)];
                [bezier13Path addCurveToPoint:CGPointMake(35.61, 23.61) controlPoint1:CGPointMake(35.61, 23.68) controlPoint2:CGPointMake(35.61, 23.65)];
                [bezier13Path addLineToPoint:CGPointMake(35.61, 23.58)];
                [bezier13Path closePath];
                [bezier13Path moveToPoint:CGPointMake(35.24, 23)];
                [bezier13Path addCurveToPoint:CGPointMake(35.45, 22.95) controlPoint1:CGPointMake(35.33, 22.98) controlPoint2:CGPointMake(35.4, 22.96)];
                [bezier13Path addCurveToPoint:CGPointMake(35.55, 22.9) controlPoint1:CGPointMake(35.5, 22.93) controlPoint2:CGPointMake(35.53, 22.92)];
                [bezier13Path addCurveToPoint:CGPointMake(35.59, 22.81) controlPoint1:CGPointMake(35.58, 22.88) controlPoint2:CGPointMake(35.59, 22.85)];
                [bezier13Path addCurveToPoint:CGPointMake(35.6, 22.66) controlPoint1:CGPointMake(35.59, 22.78) controlPoint2:CGPointMake(35.6, 22.73)];
                [bezier13Path addCurveToPoint:CGPointMake(35.58, 22.56) controlPoint1:CGPointMake(35.6, 22.62) controlPoint2:CGPointMake(35.59, 22.58)];
                [bezier13Path addCurveToPoint:CGPointMake(35.51, 22.5) controlPoint1:CGPointMake(35.56, 22.53) controlPoint2:CGPointMake(35.54, 22.51)];
                [bezier13Path addCurveToPoint:CGPointMake(35.39, 22.48) controlPoint1:CGPointMake(35.48, 22.49) controlPoint2:CGPointMake(35.44, 22.48)];
                [bezier13Path addCurveToPoint:CGPointMake(35.24, 22.47) controlPoint1:CGPointMake(35.35, 22.48) controlPoint2:CGPointMake(35.29, 22.47)];
                [bezier13Path addCurveToPoint:CGPointMake(35.08, 22.48) controlPoint1:CGPointMake(35.17, 22.47) controlPoint2:CGPointMake(35.12, 22.47)];
                [bezier13Path addCurveToPoint:CGPointMake(34.97, 22.51) controlPoint1:CGPointMake(35.03, 22.48) controlPoint2:CGPointMake(35, 22.5)];
                [bezier13Path addCurveToPoint:CGPointMake(34.91, 22.58) controlPoint1:CGPointMake(34.94, 22.53) controlPoint2:CGPointMake(34.92, 22.55)];
                [bezier13Path addCurveToPoint:CGPointMake(34.89, 22.71) controlPoint1:CGPointMake(34.9, 22.61) controlPoint2:CGPointMake(34.89, 22.65)];
                [bezier13Path addCurveToPoint:CGPointMake(34.9, 22.83) controlPoint1:CGPointMake(34.89, 22.76) controlPoint2:CGPointMake(34.89, 22.8)];
                [bezier13Path addCurveToPoint:CGPointMake(34.94, 22.9) controlPoint1:CGPointMake(34.9, 22.86) controlPoint2:CGPointMake(34.92, 22.88)];
                [bezier13Path addCurveToPoint:CGPointMake(35.05, 22.95) controlPoint1:CGPointMake(34.97, 22.92) controlPoint2:CGPointMake(35, 22.93)];
                [bezier13Path addCurveToPoint:CGPointMake(35.24, 23) controlPoint1:CGPointMake(35.08, 22.95) controlPoint2:CGPointMake(35.15, 22.97)];
                [bezier13Path closePath];
                bezier13Path.miterLimit = 4;

                [fillColor setFill];
                [bezier13Path fill];

                //// Bezier 14 Drawing
                UIBezierPath *bezier14Path = [UIBezierPath bezierPath];
                [bezier14Path moveToPoint:CGPointMake(42.05, 23.98)];
                [bezier14Path addCurveToPoint:CGPointMake(42.03, 24.06) controlPoint1:CGPointMake(42.05, 24.01) controlPoint2:CGPointMake(42.04, 24.03)];
                [bezier14Path addCurveToPoint:CGPointMake(41.98, 24.11) controlPoint1:CGPointMake(42.02, 24.08) controlPoint2:CGPointMake(42, 24.1)];
                [bezier14Path addCurveToPoint:CGPointMake(41.93, 24.14) controlPoint1:CGPointMake(41.96, 24.12) controlPoint2:CGPointMake(41.95, 24.13)];
                [bezier14Path addCurveToPoint:CGPointMake(41.88, 24.15) controlPoint1:CGPointMake(41.91, 24.15) controlPoint2:CGPointMake(41.89, 24.15)];
                [bezier14Path addLineToPoint:CGPointMake(40.77, 24.15)];
                [bezier14Path addCurveToPoint:CGPointMake(40.71, 24.14) controlPoint1:CGPointMake(40.75, 24.15) controlPoint2:CGPointMake(40.73, 24.15)];
                [bezier14Path addCurveToPoint:CGPointMake(40.65, 24.11) controlPoint1:CGPointMake(40.69, 24.13) controlPoint2:CGPointMake(40.67, 24.12)];
                [bezier14Path addCurveToPoint:CGPointMake(40.61, 24.06) controlPoint1:CGPointMake(40.64, 24.1) controlPoint2:CGPointMake(40.62, 24.08)];
                [bezier14Path addCurveToPoint:CGPointMake(40.6, 23.98) controlPoint1:CGPointMake(40.6, 24.04) controlPoint2:CGPointMake(40.6, 24.01)];
                [bezier14Path addCurveToPoint:CGPointMake(40.61, 23.91) controlPoint1:CGPointMake(40.6, 23.95) controlPoint2:CGPointMake(40.6, 23.93)];
                [bezier14Path addCurveToPoint:CGPointMake(40.65, 23.86) controlPoint1:CGPointMake(40.62, 23.89) controlPoint2:CGPointMake(40.63, 23.87)];
                [bezier14Path addCurveToPoint:CGPointMake(40.71, 23.83) controlPoint1:CGPointMake(40.67, 23.85) controlPoint2:CGPointMake(40.68, 23.84)];
                [bezier14Path addCurveToPoint:CGPointMake(40.77, 23.82) controlPoint1:CGPointMake(40.73, 23.82) controlPoint2:CGPointMake(40.75, 23.82)];
                [bezier14Path addLineToPoint:CGPointMake(41.13, 23.82)];
                [bezier14Path addLineToPoint:CGPointMake(41.13, 22.49)];
                [bezier14Path addCurveToPoint:CGPointMake(41.05, 22.48) controlPoint1:CGPointMake(41.1, 22.49) controlPoint2:CGPointMake(41.07, 22.48)];
                [bezier14Path addCurveToPoint:CGPointMake(40.98, 22.45) controlPoint1:CGPointMake(41.02, 22.47) controlPoint2:CGPointMake(41, 22.46)];
                [bezier14Path addCurveToPoint:CGPointMake(40.93, 22.4) controlPoint1:CGPointMake(40.96, 22.44) controlPoint2:CGPointMake(40.94, 22.42)];
                [bezier14Path addCurveToPoint:CGPointMake(40.91, 22.33) controlPoint1:CGPointMake(40.92, 22.38) controlPoint2:CGPointMake(40.91, 22.36)];
                [bezier14Path addCurveToPoint:CGPointMake(40.94, 22.23) controlPoint1:CGPointMake(40.91, 22.29) controlPoint2:CGPointMake(40.92, 22.25)];
                [bezier14Path addCurveToPoint:CGPointMake(41.02, 22.17) controlPoint1:CGPointMake(40.96, 22.2) controlPoint2:CGPointMake(40.99, 22.19)];
                [bezier14Path addCurveToPoint:CGPointMake(41.15, 22.15) controlPoint1:CGPointMake(41.06, 22.16) controlPoint2:CGPointMake(41.1, 22.15)];
                [bezier14Path addCurveToPoint:CGPointMake(41.31, 22.15) controlPoint1:CGPointMake(41.2, 22.15) controlPoint2:CGPointMake(41.25, 22.15)];
                [bezier14Path addLineToPoint:CGPointMake(41.4, 22.15)];
                [bezier14Path addCurveToPoint:CGPointMake(41.5, 22.18) controlPoint1:CGPointMake(41.44, 22.15) controlPoint2:CGPointMake(41.48, 22.16)];
                [bezier14Path addCurveToPoint:CGPointMake(41.53, 22.25) controlPoint1:CGPointMake(41.52, 22.2) controlPoint2:CGPointMake(41.53, 22.22)];
                [bezier14Path addLineToPoint:CGPointMake(41.53, 23.82)];
                [bezier14Path addLineToPoint:CGPointMake(41.9, 23.82)];
                [bezier14Path addCurveToPoint:CGPointMake(41.94, 23.85) controlPoint1:CGPointMake(41.92, 23.82) controlPoint2:CGPointMake(41.93, 23.83)];
                [bezier14Path addCurveToPoint:CGPointMake(41.96, 23.9) controlPoint1:CGPointMake(41.95, 23.87) controlPoint2:CGPointMake(41.96, 23.88)];
                [bezier14Path addCurveToPoint:CGPointMake(41.97, 23.95) controlPoint1:CGPointMake(41.97, 23.92) controlPoint2:CGPointMake(41.97, 23.94)];
                [bezier14Path addCurveToPoint:CGPointMake(41.97, 23.97) controlPoint1:CGPointMake(41.97, 23.96) controlPoint2:CGPointMake(41.97, 23.97)];
                [bezier14Path addLineToPoint:CGPointMake(42.05, 23.97)];
                [bezier14Path addLineToPoint:CGPointMake(42.05, 23.98)];
                [bezier14Path closePath];
                bezier14Path.miterLimit = 4;

                [fillColor setFill];
                [bezier14Path fill];
            }
        }

        //// Bezier 15 Drawing
        UIBezierPath *bezier15Path = [UIBezierPath bezierPath];
        [bezier15Path moveToPoint:CGPointMake(4.71, 16.18)];
        [bezier15Path addCurveToPoint:CGPointMake(4.04, 15.51) controlPoint1:CGPointMake(4.34, 16.18) controlPoint2:CGPointMake(4.04, 15.88)];
        [bezier15Path addLineToPoint:CGPointMake(4.04, 12.21)];
        [bezier15Path addCurveToPoint:CGPointMake(4.71, 11.54) controlPoint1:CGPointMake(4.04, 11.84) controlPoint2:CGPointMake(4.34, 11.54)];
        [bezier15Path addLineToPoint:CGPointMake(10.29, 11.54)];
        [bezier15Path addCurveToPoint:CGPointMake(10.96, 12.21) controlPoint1:CGPointMake(10.66, 11.54) controlPoint2:CGPointMake(10.96, 11.84)];
        [bezier15Path addLineToPoint:CGPointMake(10.96, 15.51)];
        [bezier15Path addCurveToPoint:CGPointMake(10.29, 16.18) controlPoint1:CGPointMake(10.96, 15.88) controlPoint2:CGPointMake(10.66, 16.18)];
        [bezier15Path addLineToPoint:CGPointMake(4.71, 16.18)];
        [bezier15Path closePath];
        [bezier15Path moveToPoint:CGPointMake(4.71, 11.89)];
        [bezier15Path addCurveToPoint:CGPointMake(4.39, 12.21) controlPoint1:CGPointMake(4.53, 11.89) controlPoint2:CGPointMake(4.39, 12.04)];
        [bezier15Path addLineToPoint:CGPointMake(4.39, 15.51)];
        [bezier15Path addCurveToPoint:CGPointMake(4.71, 15.83) controlPoint1:CGPointMake(4.39, 15.69) controlPoint2:CGPointMake(4.54, 15.83)];
        [bezier15Path addLineToPoint:CGPointMake(10.29, 15.83)];
        [bezier15Path addCurveToPoint:CGPointMake(10.61, 15.51) controlPoint1:CGPointMake(10.47, 15.83) controlPoint2:CGPointMake(10.61, 15.68)];
        [bezier15Path addLineToPoint:CGPointMake(10.61, 12.21)];
        [bezier15Path addCurveToPoint:CGPointMake(10.29, 11.89) controlPoint1:CGPointMake(10.61, 12.03) controlPoint2:CGPointMake(10.47, 11.89)];
        [bezier15Path addLineToPoint:CGPointMake(4.71, 11.89)];
        [bezier15Path closePath];
        bezier15Path.miterLimit = 4;

        [fillColor setFill];
        [bezier15Path fill];

        //// Bezier 16 Drawing
        UIBezierPath *bezier16Path = [UIBezierPath bezierPath];
        [bezier16Path moveToPoint:CGPointMake(5.11, 22.93)];
        [bezier16Path addCurveToPoint:CGPointMake(5.43, 22.97) controlPoint1:CGPointMake(5.24, 22.93) controlPoint2:CGPointMake(5.34, 22.94)];
        [bezier16Path addCurveToPoint:CGPointMake(5.64, 23.09) controlPoint1:CGPointMake(5.52, 23) controlPoint2:CGPointMake(5.59, 23.04)];
        [bezier16Path addCurveToPoint:CGPointMake(5.75, 23.29) controlPoint1:CGPointMake(5.69, 23.14) controlPoint2:CGPointMake(5.73, 23.21)];
        [bezier16Path addCurveToPoint:CGPointMake(5.79, 23.56) controlPoint1:CGPointMake(5.77, 23.37) controlPoint2:CGPointMake(5.79, 23.46)];
        [bezier16Path addCurveToPoint:CGPointMake(5.75, 23.82) controlPoint1:CGPointMake(5.79, 23.66) controlPoint2:CGPointMake(5.77, 23.75)];
        [bezier16Path addCurveToPoint:CGPointMake(5.62, 24.01) controlPoint1:CGPointMake(5.72, 23.9) controlPoint2:CGPointMake(5.68, 23.96)];
        [bezier16Path addCurveToPoint:CGPointMake(5.38, 24.13) controlPoint1:CGPointMake(5.56, 24.06) controlPoint2:CGPointMake(5.48, 24.1)];
        [bezier16Path addCurveToPoint:CGPointMake(5.02, 24.17) controlPoint1:CGPointMake(5.28, 24.16) controlPoint2:CGPointMake(5.16, 24.17)];
        [bezier16Path addCurveToPoint:CGPointMake(4.73, 24.14) controlPoint1:CGPointMake(4.91, 24.17) controlPoint2:CGPointMake(4.82, 24.16)];
        [bezier16Path addCurveToPoint:CGPointMake(4.5, 24.04) controlPoint1:CGPointMake(4.64, 24.12) controlPoint2:CGPointMake(4.56, 24.09)];
        [bezier16Path addCurveToPoint:CGPointMake(4.35, 23.87) controlPoint1:CGPointMake(4.43, 24) controlPoint2:CGPointMake(4.38, 23.94)];
        [bezier16Path addCurveToPoint:CGPointMake(4.3, 23.61) controlPoint1:CGPointMake(4.32, 23.8) controlPoint2:CGPointMake(4.3, 23.71)];
        [bezier16Path addLineToPoint:CGPointMake(4.3, 22.31)];
        [bezier16Path addCurveToPoint:CGPointMake(4.31, 22.25) controlPoint1:CGPointMake(4.3, 22.29) controlPoint2:CGPointMake(4.3, 22.27)];
        [bezier16Path addCurveToPoint:CGPointMake(4.35, 22.2) controlPoint1:CGPointMake(4.32, 22.23) controlPoint2:CGPointMake(4.33, 22.21)];
        [bezier16Path addCurveToPoint:CGPointMake(4.41, 22.16) controlPoint1:CGPointMake(4.37, 22.18) controlPoint2:CGPointMake(4.38, 22.17)];
        [bezier16Path addCurveToPoint:CGPointMake(4.5, 22.15) controlPoint1:CGPointMake(4.44, 22.15) controlPoint2:CGPointMake(4.47, 22.15)];
        [bezier16Path addCurveToPoint:CGPointMake(4.65, 22.2) controlPoint1:CGPointMake(4.57, 22.15) controlPoint2:CGPointMake(4.61, 22.17)];
        [bezier16Path addCurveToPoint:CGPointMake(4.7, 22.32) controlPoint1:CGPointMake(4.68, 22.23) controlPoint2:CGPointMake(4.7, 22.27)];
        [bezier16Path addLineToPoint:CGPointMake(4.7, 22.97)];
        [bezier16Path addCurveToPoint:CGPointMake(4.95, 22.95) controlPoint1:CGPointMake(4.79, 22.96) controlPoint2:CGPointMake(4.88, 22.95)];
        [bezier16Path addCurveToPoint:CGPointMake(5.11, 22.93) controlPoint1:CGPointMake(5, 22.93) controlPoint2:CGPointMake(5.06, 22.93)];
        [bezier16Path closePath];
        [bezier16Path moveToPoint:CGPointMake(5.4, 23.54)];
        [bezier16Path addCurveToPoint:CGPointMake(5.38, 23.39) controlPoint1:CGPointMake(5.4, 23.48) controlPoint2:CGPointMake(5.4, 23.43)];
        [bezier16Path addCurveToPoint:CGPointMake(5.32, 23.3) controlPoint1:CGPointMake(5.37, 23.35) controlPoint2:CGPointMake(5.35, 23.32)];
        [bezier16Path addCurveToPoint:CGPointMake(5.21, 23.26) controlPoint1:CGPointMake(5.29, 23.28) controlPoint2:CGPointMake(5.26, 23.26)];
        [bezier16Path addCurveToPoint:CGPointMake(5.03, 23.25) controlPoint1:CGPointMake(5.16, 23.25) controlPoint2:CGPointMake(5.1, 23.25)];
        [bezier16Path addCurveToPoint:CGPointMake(4.89, 23.25) controlPoint1:CGPointMake(4.98, 23.25) controlPoint2:CGPointMake(4.93, 23.25)];
        [bezier16Path addCurveToPoint:CGPointMake(4.8, 23.25) controlPoint1:CGPointMake(4.85, 23.25) controlPoint2:CGPointMake(4.83, 23.25)];
        [bezier16Path addCurveToPoint:CGPointMake(4.74, 23.26) controlPoint1:CGPointMake(4.78, 23.25) controlPoint2:CGPointMake(4.75, 23.25)];
        [bezier16Path addCurveToPoint:CGPointMake(4.67, 23.27) controlPoint1:CGPointMake(4.72, 23.26) controlPoint2:CGPointMake(4.7, 23.27)];
        [bezier16Path addLineToPoint:CGPointMake(4.67, 23.52)];
        [bezier16Path addCurveToPoint:CGPointMake(4.69, 23.66) controlPoint1:CGPointMake(4.67, 23.58) controlPoint2:CGPointMake(4.68, 23.63)];
        [bezier16Path addCurveToPoint:CGPointMake(4.75, 23.76) controlPoint1:CGPointMake(4.7, 23.7) controlPoint2:CGPointMake(4.72, 23.73)];
        [bezier16Path addCurveToPoint:CGPointMake(4.86, 23.82) controlPoint1:CGPointMake(4.78, 23.79) controlPoint2:CGPointMake(4.81, 23.81)];
        [bezier16Path addCurveToPoint:CGPointMake(5.03, 23.84) controlPoint1:CGPointMake(4.91, 23.83) controlPoint2:CGPointMake(4.96, 23.84)];
        [bezier16Path addCurveToPoint:CGPointMake(5.2, 23.83) controlPoint1:CGPointMake(5.09, 23.84) controlPoint2:CGPointMake(5.15, 23.84)];
        [bezier16Path addCurveToPoint:CGPointMake(5.31, 23.79) controlPoint1:CGPointMake(5.24, 23.82) controlPoint2:CGPointMake(5.28, 23.81)];
        [bezier16Path addCurveToPoint:CGPointMake(5.38, 23.7) controlPoint1:CGPointMake(5.34, 23.77) controlPoint2:CGPointMake(5.37, 23.74)];
        [bezier16Path addCurveToPoint:CGPointMake(5.4, 23.54) controlPoint1:CGPointMake(5.39, 23.66) controlPoint2:CGPointMake(5.4, 23.61)];
        [bezier16Path closePath];
        bezier16Path.miterLimit = 4;

        [fillColor setFill];
        [bezier16Path fill];

        //// Bezier 17 Drawing
        UIBezierPath *bezier17Path = [UIBezierPath bezierPath];
        [bezier17Path moveToPoint:CGPointMake(7.65, 24.12)];
        [bezier17Path addCurveToPoint:CGPointMake(7.51, 24.17) controlPoint1:CGPointMake(7.61, 24.15) controlPoint2:CGPointMake(7.57, 24.17)];
        [bezier17Path addCurveToPoint:CGPointMake(7.36, 24.12) controlPoint1:CGPointMake(7.44, 24.17) controlPoint2:CGPointMake(7.39, 24.16)];
        [bezier17Path addCurveToPoint:CGPointMake(7.3, 24) controlPoint1:CGPointMake(7.32, 24.09) controlPoint2:CGPointMake(7.3, 24.05)];
        [bezier17Path addLineToPoint:CGPointMake(7.3, 22.49)];
        [bezier17Path addLineToPoint:CGPointMake(6.36, 22.49)];
        [bezier17Path addCurveToPoint:CGPointMake(6.23, 22.45) controlPoint1:CGPointMake(6.31, 22.49) controlPoint2:CGPointMake(6.26, 22.48)];
        [bezier17Path addCurveToPoint:CGPointMake(6.17, 22.33) controlPoint1:CGPointMake(6.19, 22.42) controlPoint2:CGPointMake(6.17, 22.38)];
        [bezier17Path addCurveToPoint:CGPointMake(6.23, 22.21) controlPoint1:CGPointMake(6.17, 22.28) controlPoint2:CGPointMake(6.19, 22.24)];
        [bezier17Path addCurveToPoint:CGPointMake(6.36, 22.17) controlPoint1:CGPointMake(6.27, 22.18) controlPoint2:CGPointMake(6.31, 22.17)];
        [bezier17Path addLineToPoint:CGPointMake(7.37, 22.17)];
        [bezier17Path addCurveToPoint:CGPointMake(7.54, 22.18) controlPoint1:CGPointMake(7.44, 22.17) controlPoint2:CGPointMake(7.5, 22.17)];
        [bezier17Path addCurveToPoint:CGPointMake(7.64, 22.22) controlPoint1:CGPointMake(7.58, 22.19) controlPoint2:CGPointMake(7.62, 22.2)];
        [bezier17Path addCurveToPoint:CGPointMake(7.69, 22.3) controlPoint1:CGPointMake(7.67, 22.24) controlPoint2:CGPointMake(7.68, 22.27)];
        [bezier17Path addCurveToPoint:CGPointMake(7.7, 22.43) controlPoint1:CGPointMake(7.7, 22.34) controlPoint2:CGPointMake(7.7, 22.38)];
        [bezier17Path addLineToPoint:CGPointMake(7.7, 23.99)];
        [bezier17Path addCurveToPoint:CGPointMake(7.65, 24.12) controlPoint1:CGPointMake(7.7, 24.04) controlPoint2:CGPointMake(7.68, 24.09)];
        [bezier17Path closePath];
        bezier17Path.miterLimit = 4;

        [fillColor setFill];
        [bezier17Path fill];

        //// Bezier 18 Drawing
        UIBezierPath *bezier18Path = [UIBezierPath bezierPath];
        [bezier18Path moveToPoint:CGPointMake(37.81, 23.01)];
        [bezier18Path addCurveToPoint:CGPointMake(37.99, 23.1) controlPoint1:CGPointMake(37.88, 23.03) controlPoint2:CGPointMake(37.94, 23.06)];
        [bezier18Path addCurveToPoint:CGPointMake(38.08, 23.28) controlPoint1:CGPointMake(38.04, 23.14) controlPoint2:CGPointMake(38.07, 23.2)];
        [bezier18Path addCurveToPoint:CGPointMake(38.11, 23.56) controlPoint1:CGPointMake(38.1, 23.35) controlPoint2:CGPointMake(38.11, 23.45)];
        [bezier18Path addCurveToPoint:CGPointMake(38.08, 23.85) controlPoint1:CGPointMake(38.11, 23.68) controlPoint2:CGPointMake(38.1, 23.77)];
        [bezier18Path addCurveToPoint:CGPointMake(37.95, 24.03) controlPoint1:CGPointMake(38.05, 23.93) controlPoint2:CGPointMake(38.01, 23.99)];
        [bezier18Path addCurveToPoint:CGPointMake(37.7, 24.13) controlPoint1:CGPointMake(37.89, 24.08) controlPoint2:CGPointMake(37.81, 24.11)];
        [bezier18Path addCurveToPoint:CGPointMake(37.3, 24.16) controlPoint1:CGPointMake(37.6, 24.15) controlPoint2:CGPointMake(37.46, 24.16)];
        [bezier18Path addLineToPoint:CGPointMake(37.22, 24.16)];
        [bezier18Path addCurveToPoint:CGPointMake(37.02, 24.15) controlPoint1:CGPointMake(37.16, 24.16) controlPoint2:CGPointMake(37.09, 24.16)];
        [bezier18Path addCurveToPoint:CGPointMake(36.82, 24.12) controlPoint1:CGPointMake(36.95, 24.15) controlPoint2:CGPointMake(36.88, 24.14)];
        [bezier18Path addCurveToPoint:CGPointMake(36.66, 24.04) controlPoint1:CGPointMake(36.76, 24.1) controlPoint2:CGPointMake(36.71, 24.07)];
        [bezier18Path addCurveToPoint:CGPointMake(36.59, 23.89) controlPoint1:CGPointMake(36.62, 24) controlPoint2:CGPointMake(36.59, 23.95)];
        [bezier18Path addLineToPoint:CGPointMake(36.59, 23.89)];
        [bezier18Path addCurveToPoint:CGPointMake(36.64, 23.78) controlPoint1:CGPointMake(36.59, 23.84) controlPoint2:CGPointMake(36.61, 23.81)];
        [bezier18Path addCurveToPoint:CGPointMake(36.76, 23.73) controlPoint1:CGPointMake(36.68, 23.75) controlPoint2:CGPointMake(36.72, 23.73)];
        [bezier18Path addLineToPoint:CGPointMake(36.77, 23.73)];
        [bezier18Path addCurveToPoint:CGPointMake(36.86, 23.74) controlPoint1:CGPointMake(36.81, 23.73) controlPoint2:CGPointMake(36.84, 23.74)];
        [bezier18Path addCurveToPoint:CGPointMake(36.91, 23.76) controlPoint1:CGPointMake(36.88, 23.75) controlPoint2:CGPointMake(36.9, 23.76)];
        [bezier18Path addCurveToPoint:CGPointMake(36.96, 23.79) controlPoint1:CGPointMake(36.93, 23.77) controlPoint2:CGPointMake(36.94, 23.78)];
        [bezier18Path addCurveToPoint:CGPointMake(37.03, 23.82) controlPoint1:CGPointMake(36.98, 23.8) controlPoint2:CGPointMake(37, 23.81)];
        [bezier18Path addCurveToPoint:CGPointMake(37.15, 23.84) controlPoint1:CGPointMake(37.06, 23.83) controlPoint2:CGPointMake(37.1, 23.83)];
        [bezier18Path addCurveToPoint:CGPointMake(37.34, 23.85) controlPoint1:CGPointMake(37.2, 23.85) controlPoint2:CGPointMake(37.26, 23.85)];
        [bezier18Path addCurveToPoint:CGPointMake(37.54, 23.83) controlPoint1:CGPointMake(37.42, 23.85) controlPoint2:CGPointMake(37.48, 23.85)];
        [bezier18Path addCurveToPoint:CGPointMake(37.66, 23.78) controlPoint1:CGPointMake(37.59, 23.82) controlPoint2:CGPointMake(37.63, 23.8)];
        [bezier18Path addCurveToPoint:CGPointMake(37.72, 23.69) controlPoint1:CGPointMake(37.69, 23.76) controlPoint2:CGPointMake(37.7, 23.73)];
        [bezier18Path addCurveToPoint:CGPointMake(37.73, 23.56) controlPoint1:CGPointMake(37.73, 23.65) controlPoint2:CGPointMake(37.73, 23.61)];
        [bezier18Path addCurveToPoint:CGPointMake(37.7, 23.37) controlPoint1:CGPointMake(37.73, 23.47) controlPoint2:CGPointMake(37.72, 23.41)];
        [bezier18Path addCurveToPoint:CGPointMake(37.57, 23.31) controlPoint1:CGPointMake(37.68, 23.33) controlPoint2:CGPointMake(37.64, 23.31)];
        [bezier18Path addLineToPoint:CGPointMake(36.9, 23.31)];
        [bezier18Path addCurveToPoint:CGPointMake(36.76, 23.3) controlPoint1:CGPointMake(36.85, 23.31) controlPoint2:CGPointMake(36.8, 23.31)];
        [bezier18Path addCurveToPoint:CGPointMake(36.68, 23.27) controlPoint1:CGPointMake(36.72, 23.29) controlPoint2:CGPointMake(36.7, 23.28)];
        [bezier18Path addCurveToPoint:CGPointMake(36.64, 23.2) controlPoint1:CGPointMake(36.66, 23.25) controlPoint2:CGPointMake(36.65, 23.23)];
        [bezier18Path addCurveToPoint:CGPointMake(36.63, 23.08) controlPoint1:CGPointMake(36.64, 23.17) controlPoint2:CGPointMake(36.63, 23.13)];
        [bezier18Path addLineToPoint:CGPointMake(36.63, 22.34)];
        [bezier18Path addCurveToPoint:CGPointMake(36.68, 22.21) controlPoint1:CGPointMake(36.63, 22.29) controlPoint2:CGPointMake(36.65, 22.24)];
        [bezier18Path addCurveToPoint:CGPointMake(36.85, 22.17) controlPoint1:CGPointMake(36.71, 22.18) controlPoint2:CGPointMake(36.77, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(36.97, 22.17) controlPoint1:CGPointMake(36.87, 22.17) controlPoint2:CGPointMake(36.92, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(37.15, 22.17) controlPoint1:CGPointMake(37.03, 22.17) controlPoint2:CGPointMake(37.08, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(37.35, 22.17) controlPoint1:CGPointMake(37.22, 22.17) controlPoint2:CGPointMake(37.28, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(37.55, 22.17) controlPoint1:CGPointMake(37.42, 22.17) controlPoint2:CGPointMake(37.49, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(37.71, 22.17) controlPoint1:CGPointMake(37.61, 22.17) controlPoint2:CGPointMake(37.66, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(37.79, 22.17) controlPoint1:CGPointMake(37.75, 22.17) controlPoint2:CGPointMake(37.78, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(37.86, 22.18) controlPoint1:CGPointMake(37.81, 22.17) controlPoint2:CGPointMake(37.84, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(37.93, 22.2) controlPoint1:CGPointMake(37.89, 22.18) controlPoint2:CGPointMake(37.91, 22.19)];
        [bezier18Path addCurveToPoint:CGPointMake(37.99, 22.25) controlPoint1:CGPointMake(37.95, 22.21) controlPoint2:CGPointMake(37.97, 22.23)];
        [bezier18Path addCurveToPoint:CGPointMake(38.02, 22.33) controlPoint1:CGPointMake(38.01, 22.27) controlPoint2:CGPointMake(38.02, 22.3)];
        [bezier18Path addLineToPoint:CGPointMake(38.02, 22.34)];
        [bezier18Path addCurveToPoint:CGPointMake(38, 22.43) controlPoint1:CGPointMake(38.02, 22.38) controlPoint2:CGPointMake(38.01, 22.41)];
        [bezier18Path addCurveToPoint:CGPointMake(37.95, 22.48) controlPoint1:CGPointMake(37.99, 22.45) controlPoint2:CGPointMake(37.97, 22.47)];
        [bezier18Path addCurveToPoint:CGPointMake(37.88, 22.5) controlPoint1:CGPointMake(37.93, 22.49) controlPoint2:CGPointMake(37.9, 22.5)];
        [bezier18Path addCurveToPoint:CGPointMake(37.79, 22.5) controlPoint1:CGPointMake(37.85, 22.5) controlPoint2:CGPointMake(37.82, 22.5)];
        [bezier18Path addLineToPoint:CGPointMake(37.01, 22.5)];
        [bezier18Path addLineToPoint:CGPointMake(37.01, 23.01)];
        [bezier18Path addLineToPoint:CGPointMake(37.53, 23.01)];
        [bezier18Path addCurveToPoint:CGPointMake(37.81, 23.01) controlPoint1:CGPointMake(37.64, 22.99) controlPoint2:CGPointMake(37.73, 22.99)];
        [bezier18Path closePath];
        bezier18Path.miterLimit = 4;

        [fillColor setFill];
        [bezier18Path fill];

        //// Group 5
        {
            //// Group 6
            {
                //// Bezier 19 Drawing
                UIBezierPath *bezier19Path = [UIBezierPath bezierPath];
                [bezier19Path moveToPoint:CGPointMake(29.18, 18.14)];
                [bezier19Path addLineToPoint:CGPointMake(29.18, 17.16)];
                [bezier19Path addCurveToPoint:CGPointMake(28.56, 16.54) controlPoint1:CGPointMake(29.18, 16.79) controlPoint2:CGPointMake(28.94, 16.54)];
                [bezier19Path addCurveToPoint:CGPointMake(28.01, 16.82) controlPoint1:CGPointMake(28.36, 16.54) controlPoint2:CGPointMake(28.15, 16.6)];
                [bezier19Path addCurveToPoint:CGPointMake(27.49, 16.54) controlPoint1:CGPointMake(27.9, 16.65) controlPoint2:CGPointMake(27.73, 16.54)];
                [bezier19Path addCurveToPoint:CGPointMake(27.03, 16.77) controlPoint1:CGPointMake(27.32, 16.54) controlPoint2:CGPointMake(27.16, 16.59)];
                [bezier19Path addLineToPoint:CGPointMake(27.03, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(26.7, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(26.7, 18.14)];
                [bezier19Path addLineToPoint:CGPointMake(27.04, 18.14)];
                [bezier19Path addLineToPoint:CGPointMake(27.04, 17.27)];
                [bezier19Path addCurveToPoint:CGPointMake(27.42, 16.85) controlPoint1:CGPointMake(27.04, 17) controlPoint2:CGPointMake(27.19, 16.85)];
                [bezier19Path addCurveToPoint:CGPointMake(27.76, 17.26) controlPoint1:CGPointMake(27.65, 16.85) controlPoint2:CGPointMake(27.76, 17)];
                [bezier19Path addLineToPoint:CGPointMake(27.76, 18.13)];
                [bezier19Path addLineToPoint:CGPointMake(28.1, 18.13)];
                [bezier19Path addLineToPoint:CGPointMake(28.1, 17.26)];
                [bezier19Path addCurveToPoint:CGPointMake(28.48, 16.84) controlPoint1:CGPointMake(28.1, 16.99) controlPoint2:CGPointMake(28.26, 16.84)];
                [bezier19Path addCurveToPoint:CGPointMake(28.82, 17.25) controlPoint1:CGPointMake(28.71, 16.84) controlPoint2:CGPointMake(28.82, 16.99)];
                [bezier19Path addLineToPoint:CGPointMake(28.82, 18.12)];
                [bezier19Path addLineToPoint:CGPointMake(29.18, 18.12)];
                [bezier19Path addLineToPoint:CGPointMake(29.18, 18.14)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(31.1, 17.36)];
                [bezier19Path addLineToPoint:CGPointMake(31.1, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(30.76, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(30.76, 16.77)];
                [bezier19Path addCurveToPoint:CGPointMake(30.27, 16.54) controlPoint1:CGPointMake(30.65, 16.63) controlPoint2:CGPointMake(30.49, 16.54)];
                [bezier19Path addCurveToPoint:CGPointMake(29.49, 17.36) controlPoint1:CGPointMake(29.83, 16.54) controlPoint2:CGPointMake(29.49, 16.88)];
                [bezier19Path addCurveToPoint:CGPointMake(30.27, 18.18) controlPoint1:CGPointMake(29.49, 17.84) controlPoint2:CGPointMake(29.83, 18.18)];
                [bezier19Path addCurveToPoint:CGPointMake(30.76, 17.95) controlPoint1:CGPointMake(30.49, 18.18) controlPoint2:CGPointMake(30.66, 18.09)];
                [bezier19Path addLineToPoint:CGPointMake(30.76, 18.14)];
                [bezier19Path addLineToPoint:CGPointMake(31.1, 18.14)];
                [bezier19Path addLineToPoint:CGPointMake(31.1, 17.36)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(29.83, 17.36)];
                [bezier19Path addCurveToPoint:CGPointMake(30.3, 16.86) controlPoint1:CGPointMake(29.83, 17.09) controlPoint2:CGPointMake(30.01, 16.86)];
                [bezier19Path addCurveToPoint:CGPointMake(30.77, 17.36) controlPoint1:CGPointMake(30.58, 16.86) controlPoint2:CGPointMake(30.77, 17.08)];
                [bezier19Path addCurveToPoint:CGPointMake(30.3, 17.86) controlPoint1:CGPointMake(30.77, 17.64) controlPoint2:CGPointMake(30.58, 17.86)];
                [bezier19Path addCurveToPoint:CGPointMake(29.83, 17.36) controlPoint1:CGPointMake(30.01, 17.86) controlPoint2:CGPointMake(29.83, 17.63)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(38.38, 16.54)];
                [bezier19Path addCurveToPoint:CGPointMake(38.72, 16.6) controlPoint1:CGPointMake(38.5, 16.54) controlPoint2:CGPointMake(38.61, 16.56)];
                [bezier19Path addCurveToPoint:CGPointMake(38.99, 16.77) controlPoint1:CGPointMake(38.82, 16.64) controlPoint2:CGPointMake(38.91, 16.7)];
                [bezier19Path addCurveToPoint:CGPointMake(39.17, 17.03) controlPoint1:CGPointMake(39.07, 16.84) controlPoint2:CGPointMake(39.12, 16.93)];
                [bezier19Path addCurveToPoint:CGPointMake(39.23, 17.36) controlPoint1:CGPointMake(39.21, 17.13) controlPoint2:CGPointMake(39.23, 17.24)];
                [bezier19Path addCurveToPoint:CGPointMake(39.17, 17.69) controlPoint1:CGPointMake(39.23, 17.48) controlPoint2:CGPointMake(39.21, 17.59)];
                [bezier19Path addCurveToPoint:CGPointMake(38.99, 17.95) controlPoint1:CGPointMake(39.13, 17.79) controlPoint2:CGPointMake(39.07, 17.88)];
                [bezier19Path addCurveToPoint:CGPointMake(38.72, 18.12) controlPoint1:CGPointMake(38.91, 18.02) controlPoint2:CGPointMake(38.83, 18.08)];
                [bezier19Path addCurveToPoint:CGPointMake(38.38, 18.18) controlPoint1:CGPointMake(38.62, 18.16) controlPoint2:CGPointMake(38.51, 18.18)];
                [bezier19Path addCurveToPoint:CGPointMake(38.04, 18.12) controlPoint1:CGPointMake(38.26, 18.18) controlPoint2:CGPointMake(38.15, 18.16)];
                [bezier19Path addCurveToPoint:CGPointMake(37.77, 17.95) controlPoint1:CGPointMake(37.94, 18.08) controlPoint2:CGPointMake(37.85, 18.02)];
                [bezier19Path addCurveToPoint:CGPointMake(37.59, 17.69) controlPoint1:CGPointMake(37.7, 17.88) controlPoint2:CGPointMake(37.64, 17.79)];
                [bezier19Path addCurveToPoint:CGPointMake(37.53, 17.36) controlPoint1:CGPointMake(37.55, 17.59) controlPoint2:CGPointMake(37.53, 17.48)];
                [bezier19Path addCurveToPoint:CGPointMake(37.59, 17.03) controlPoint1:CGPointMake(37.53, 17.24) controlPoint2:CGPointMake(37.55, 17.13)];
                [bezier19Path addCurveToPoint:CGPointMake(37.77, 16.77) controlPoint1:CGPointMake(37.63, 16.93) controlPoint2:CGPointMake(37.69, 16.84)];
                [bezier19Path addCurveToPoint:CGPointMake(38.04, 16.6) controlPoint1:CGPointMake(37.84, 16.7) controlPoint2:CGPointMake(37.93, 16.64)];
                [bezier19Path addCurveToPoint:CGPointMake(38.38, 16.54) controlPoint1:CGPointMake(38.15, 16.56) controlPoint2:CGPointMake(38.26, 16.54)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(38.38, 16.86)];
                [bezier19Path addCurveToPoint:CGPointMake(38.19, 16.9) controlPoint1:CGPointMake(38.31, 16.86) controlPoint2:CGPointMake(38.25, 16.87)];
                [bezier19Path addCurveToPoint:CGPointMake(38.03, 17) controlPoint1:CGPointMake(38.13, 16.92) controlPoint2:CGPointMake(38.08, 16.96)];
                [bezier19Path addCurveToPoint:CGPointMake(37.93, 17.16) controlPoint1:CGPointMake(37.99, 17.04) controlPoint2:CGPointMake(37.95, 17.1)];
                [bezier19Path addCurveToPoint:CGPointMake(37.89, 17.36) controlPoint1:CGPointMake(37.9, 17.22) controlPoint2:CGPointMake(37.89, 17.29)];
                [bezier19Path addCurveToPoint:CGPointMake(37.93, 17.56) controlPoint1:CGPointMake(37.89, 17.43) controlPoint2:CGPointMake(37.9, 17.5)];
                [bezier19Path addCurveToPoint:CGPointMake(38.03, 17.72) controlPoint1:CGPointMake(37.96, 17.62) controlPoint2:CGPointMake(37.99, 17.67)];
                [bezier19Path addCurveToPoint:CGPointMake(38.19, 17.82) controlPoint1:CGPointMake(38.07, 17.76) controlPoint2:CGPointMake(38.13, 17.8)];
                [bezier19Path addCurveToPoint:CGPointMake(38.38, 17.86) controlPoint1:CGPointMake(38.25, 17.84) controlPoint2:CGPointMake(38.31, 17.86)];
                [bezier19Path addCurveToPoint:CGPointMake(38.57, 17.82) controlPoint1:CGPointMake(38.45, 17.86) controlPoint2:CGPointMake(38.51, 17.85)];
                [bezier19Path addCurveToPoint:CGPointMake(38.73, 17.72) controlPoint1:CGPointMake(38.63, 17.8) controlPoint2:CGPointMake(38.68, 17.76)];
                [bezier19Path addCurveToPoint:CGPointMake(38.83, 17.56) controlPoint1:CGPointMake(38.77, 17.68) controlPoint2:CGPointMake(38.81, 17.62)];
                [bezier19Path addCurveToPoint:CGPointMake(38.87, 17.36) controlPoint1:CGPointMake(38.86, 17.5) controlPoint2:CGPointMake(38.87, 17.43)];
                [bezier19Path addCurveToPoint:CGPointMake(38.83, 17.16) controlPoint1:CGPointMake(38.87, 17.29) controlPoint2:CGPointMake(38.86, 17.22)];
                [bezier19Path addCurveToPoint:CGPointMake(38.73, 17) controlPoint1:CGPointMake(38.8, 17.1) controlPoint2:CGPointMake(38.77, 17.05)];
                [bezier19Path addCurveToPoint:CGPointMake(38.57, 16.9) controlPoint1:CGPointMake(38.69, 16.96) controlPoint2:CGPointMake(38.63, 16.92)];
                [bezier19Path addCurveToPoint:CGPointMake(38.38, 16.86) controlPoint1:CGPointMake(38.52, 16.87) controlPoint2:CGPointMake(38.45, 16.86)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(32.95, 17.36)];
                [bezier19Path addCurveToPoint:CGPointMake(32.21, 16.54) controlPoint1:CGPointMake(32.95, 16.87) controlPoint2:CGPointMake(32.65, 16.54)];
                [bezier19Path addCurveToPoint:CGPointMake(31.43, 17.36) controlPoint1:CGPointMake(31.75, 16.54) controlPoint2:CGPointMake(31.43, 16.87)];
                [bezier19Path addCurveToPoint:CGPointMake(32.23, 18.18) controlPoint1:CGPointMake(31.43, 17.86) controlPoint2:CGPointMake(31.76, 18.18)];
                [bezier19Path addCurveToPoint:CGPointMake(32.87, 17.96) controlPoint1:CGPointMake(32.47, 18.18) controlPoint2:CGPointMake(32.68, 18.12)];
                [bezier19Path addLineToPoint:CGPointMake(32.7, 17.71)];
                [bezier19Path addCurveToPoint:CGPointMake(32.24, 17.87) controlPoint1:CGPointMake(32.57, 17.81) controlPoint2:CGPointMake(32.4, 17.87)];
                [bezier19Path addCurveToPoint:CGPointMake(31.77, 17.49) controlPoint1:CGPointMake(32.02, 17.87) controlPoint2:CGPointMake(31.82, 17.77)];
                [bezier19Path addLineToPoint:CGPointMake(32.93, 17.49)];
                [bezier19Path addCurveToPoint:CGPointMake(32.95, 17.36) controlPoint1:CGPointMake(32.95, 17.45) controlPoint2:CGPointMake(32.95, 17.41)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(31.78, 17.22)];
                [bezier19Path addCurveToPoint:CGPointMake(32.2, 16.84) controlPoint1:CGPointMake(31.82, 16.99) controlPoint2:CGPointMake(31.95, 16.84)];
                [bezier19Path addCurveToPoint:CGPointMake(32.6, 17.22) controlPoint1:CGPointMake(32.42, 16.84) controlPoint2:CGPointMake(32.56, 16.98)];
                [bezier19Path addLineToPoint:CGPointMake(31.78, 17.22)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(34.38, 16.98)];
                [bezier19Path addCurveToPoint:CGPointMake(33.89, 16.85) controlPoint1:CGPointMake(34.29, 16.92) controlPoint2:CGPointMake(34.09, 16.85)];
                [bezier19Path addCurveToPoint:CGPointMake(33.59, 17.03) controlPoint1:CGPointMake(33.7, 16.85) controlPoint2:CGPointMake(33.59, 16.92)];
                [bezier19Path addCurveToPoint:CGPointMake(33.86, 17.18) controlPoint1:CGPointMake(33.59, 17.13) controlPoint2:CGPointMake(33.71, 17.16)];
                [bezier19Path addLineToPoint:CGPointMake(34.02, 17.2)];
                [bezier19Path addCurveToPoint:CGPointMake(34.57, 17.67) controlPoint1:CGPointMake(34.36, 17.25) controlPoint2:CGPointMake(34.57, 17.39)];
                [bezier19Path addCurveToPoint:CGPointMake(33.86, 18.18) controlPoint1:CGPointMake(34.57, 17.97) controlPoint2:CGPointMake(34.31, 18.18)];
                [bezier19Path addCurveToPoint:CGPointMake(33.18, 17.98) controlPoint1:CGPointMake(33.6, 18.18) controlPoint2:CGPointMake(33.37, 18.11)];
                [bezier19Path addLineToPoint:CGPointMake(33.34, 17.71)];
                [bezier19Path addCurveToPoint:CGPointMake(33.86, 17.87) controlPoint1:CGPointMake(33.45, 17.8) controlPoint2:CGPointMake(33.62, 17.87)];
                [bezier19Path addCurveToPoint:CGPointMake(34.22, 17.68) controlPoint1:CGPointMake(34.09, 17.87) controlPoint2:CGPointMake(34.22, 17.8)];
                [bezier19Path addCurveToPoint:CGPointMake(33.95, 17.52) controlPoint1:CGPointMake(34.22, 17.59) controlPoint2:CGPointMake(34.13, 17.54)];
                [bezier19Path addLineToPoint:CGPointMake(33.79, 17.5)];
                [bezier19Path addCurveToPoint:CGPointMake(33.25, 17.04) controlPoint1:CGPointMake(33.44, 17.45) controlPoint2:CGPointMake(33.25, 17.29)];
                [bezier19Path addCurveToPoint:CGPointMake(33.9, 16.54) controlPoint1:CGPointMake(33.25, 16.73) controlPoint2:CGPointMake(33.51, 16.54)];
                [bezier19Path addCurveToPoint:CGPointMake(34.54, 16.7) controlPoint1:CGPointMake(34.15, 16.54) controlPoint2:CGPointMake(34.37, 16.6)];
                [bezier19Path addLineToPoint:CGPointMake(34.38, 16.98)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(36.02, 16.89)];
                [bezier19Path addLineToPoint:CGPointMake(35.46, 16.89)];
                [bezier19Path addLineToPoint:CGPointMake(35.46, 17.6)];
                [bezier19Path addCurveToPoint:CGPointMake(35.69, 17.86) controlPoint1:CGPointMake(35.46, 17.76) controlPoint2:CGPointMake(35.52, 17.86)];
                [bezier19Path addCurveToPoint:CGPointMake(35.99, 17.77) controlPoint1:CGPointMake(35.78, 17.86) controlPoint2:CGPointMake(35.89, 17.83)];
                [bezier19Path addLineToPoint:CGPointMake(36.09, 18.06)];
                [bezier19Path addCurveToPoint:CGPointMake(35.66, 18.18) controlPoint1:CGPointMake(35.98, 18.14) controlPoint2:CGPointMake(35.81, 18.18)];
                [bezier19Path addCurveToPoint:CGPointMake(35.12, 17.6) controlPoint1:CGPointMake(35.26, 18.18) controlPoint2:CGPointMake(35.12, 17.96)];
                [bezier19Path addLineToPoint:CGPointMake(35.12, 16.89)];
                [bezier19Path addLineToPoint:CGPointMake(34.8, 16.89)];
                [bezier19Path addLineToPoint:CGPointMake(34.8, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(35.12, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(35.12, 16.11)];
                [bezier19Path addLineToPoint:CGPointMake(35.46, 16.11)];
                [bezier19Path addLineToPoint:CGPointMake(35.46, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(36.02, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(36.02, 16.89)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(37.2, 16.54)];
                [bezier19Path addCurveToPoint:CGPointMake(37.44, 16.58) controlPoint1:CGPointMake(37.27, 16.54) controlPoint2:CGPointMake(37.37, 16.55)];
                [bezier19Path addLineToPoint:CGPointMake(37.34, 16.9)];
                [bezier19Path addCurveToPoint:CGPointMake(37.13, 16.86) controlPoint1:CGPointMake(37.27, 16.87) controlPoint2:CGPointMake(37.2, 16.86)];
                [bezier19Path addCurveToPoint:CGPointMake(36.8, 17.26) controlPoint1:CGPointMake(36.91, 16.86) controlPoint2:CGPointMake(36.8, 17)];
                [bezier19Path addLineToPoint:CGPointMake(36.8, 18.14)];
                [bezier19Path addLineToPoint:CGPointMake(36.46, 18.14)];
                [bezier19Path addLineToPoint:CGPointMake(36.46, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(36.8, 16.58)];
                [bezier19Path addLineToPoint:CGPointMake(36.8, 16.77)];
                [bezier19Path addCurveToPoint:CGPointMake(37.2, 16.54) controlPoint1:CGPointMake(36.87, 16.63) controlPoint2:CGPointMake(37, 16.54)];
                [bezier19Path addLineToPoint:CGPointMake(37.2, 16.54)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(39.55, 17.91)];
                [bezier19Path addCurveToPoint:CGPointMake(39.61, 17.92) controlPoint1:CGPointMake(39.57, 17.91) controlPoint2:CGPointMake(39.59, 17.91)];
                [bezier19Path addCurveToPoint:CGPointMake(39.66, 17.95) controlPoint1:CGPointMake(39.63, 17.93) controlPoint2:CGPointMake(39.65, 17.94)];
                [bezier19Path addCurveToPoint:CGPointMake(39.69, 18) controlPoint1:CGPointMake(39.67, 17.96) controlPoint2:CGPointMake(39.69, 17.98)];
                [bezier19Path addCurveToPoint:CGPointMake(39.7, 18.06) controlPoint1:CGPointMake(39.7, 18.02) controlPoint2:CGPointMake(39.7, 18.04)];
                [bezier19Path addCurveToPoint:CGPointMake(39.69, 18.12) controlPoint1:CGPointMake(39.7, 18.08) controlPoint2:CGPointMake(39.7, 18.1)];
                [bezier19Path addCurveToPoint:CGPointMake(39.66, 18.17) controlPoint1:CGPointMake(39.68, 18.14) controlPoint2:CGPointMake(39.67, 18.16)];
                [bezier19Path addCurveToPoint:CGPointMake(39.61, 18.2) controlPoint1:CGPointMake(39.65, 18.18) controlPoint2:CGPointMake(39.63, 18.2)];
                [bezier19Path addCurveToPoint:CGPointMake(39.55, 18.21) controlPoint1:CGPointMake(39.59, 18.21) controlPoint2:CGPointMake(39.57, 18.21)];
                [bezier19Path addCurveToPoint:CGPointMake(39.49, 18.2) controlPoint1:CGPointMake(39.53, 18.21) controlPoint2:CGPointMake(39.51, 18.21)];
                [bezier19Path addCurveToPoint:CGPointMake(39.44, 18.17) controlPoint1:CGPointMake(39.47, 18.19) controlPoint2:CGPointMake(39.45, 18.18)];
                [bezier19Path addCurveToPoint:CGPointMake(39.41, 18.12) controlPoint1:CGPointMake(39.43, 18.16) controlPoint2:CGPointMake(39.41, 18.14)];
                [bezier19Path addCurveToPoint:CGPointMake(39.4, 18.06) controlPoint1:CGPointMake(39.4, 18.1) controlPoint2:CGPointMake(39.4, 18.08)];
                [bezier19Path addCurveToPoint:CGPointMake(39.41, 18) controlPoint1:CGPointMake(39.4, 18.04) controlPoint2:CGPointMake(39.4, 18.02)];
                [bezier19Path addCurveToPoint:CGPointMake(39.44, 17.95) controlPoint1:CGPointMake(39.42, 17.98) controlPoint2:CGPointMake(39.43, 17.96)];
                [bezier19Path addCurveToPoint:CGPointMake(39.49, 17.92) controlPoint1:CGPointMake(39.45, 17.94) controlPoint2:CGPointMake(39.47, 17.92)];
                [bezier19Path addCurveToPoint:CGPointMake(39.55, 17.91) controlPoint1:CGPointMake(39.51, 17.92) controlPoint2:CGPointMake(39.53, 17.91)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(39.55, 18.19)];
                [bezier19Path addCurveToPoint:CGPointMake(39.6, 18.18) controlPoint1:CGPointMake(39.57, 18.19) controlPoint2:CGPointMake(39.58, 18.19)];
                [bezier19Path addCurveToPoint:CGPointMake(39.64, 18.15) controlPoint1:CGPointMake(39.62, 18.17) controlPoint2:CGPointMake(39.63, 18.16)];
                [bezier19Path addCurveToPoint:CGPointMake(39.67, 18.11) controlPoint1:CGPointMake(39.65, 18.14) controlPoint2:CGPointMake(39.66, 18.13)];
                [bezier19Path addCurveToPoint:CGPointMake(39.68, 18.06) controlPoint1:CGPointMake(39.68, 18.1) controlPoint2:CGPointMake(39.68, 18.08)];
                [bezier19Path addCurveToPoint:CGPointMake(39.67, 18.01) controlPoint1:CGPointMake(39.68, 18.04) controlPoint2:CGPointMake(39.68, 18.03)];
                [bezier19Path addCurveToPoint:CGPointMake(39.64, 17.97) controlPoint1:CGPointMake(39.66, 18) controlPoint2:CGPointMake(39.66, 17.98)];
                [bezier19Path addCurveToPoint:CGPointMake(39.6, 17.94) controlPoint1:CGPointMake(39.63, 17.96) controlPoint2:CGPointMake(39.62, 17.95)];
                [bezier19Path addCurveToPoint:CGPointMake(39.55, 17.93) controlPoint1:CGPointMake(39.59, 17.93) controlPoint2:CGPointMake(39.57, 17.93)];
                [bezier19Path addCurveToPoint:CGPointMake(39.5, 17.94) controlPoint1:CGPointMake(39.53, 17.93) controlPoint2:CGPointMake(39.52, 17.93)];
                [bezier19Path addCurveToPoint:CGPointMake(39.46, 17.97) controlPoint1:CGPointMake(39.49, 17.95) controlPoint2:CGPointMake(39.47, 17.95)];
                [bezier19Path addCurveToPoint:CGPointMake(39.43, 18.01) controlPoint1:CGPointMake(39.45, 17.98) controlPoint2:CGPointMake(39.44, 17.99)];
                [bezier19Path addCurveToPoint:CGPointMake(39.42, 18.06) controlPoint1:CGPointMake(39.42, 18.02) controlPoint2:CGPointMake(39.42, 18.04)];
                [bezier19Path addCurveToPoint:CGPointMake(39.43, 18.11) controlPoint1:CGPointMake(39.42, 18.08) controlPoint2:CGPointMake(39.42, 18.09)];
                [bezier19Path addCurveToPoint:CGPointMake(39.46, 18.15) controlPoint1:CGPointMake(39.44, 18.12) controlPoint2:CGPointMake(39.44, 18.14)];
                [bezier19Path addCurveToPoint:CGPointMake(39.5, 18.18) controlPoint1:CGPointMake(39.47, 18.16) controlPoint2:CGPointMake(39.48, 18.17)];
                [bezier19Path addCurveToPoint:CGPointMake(39.55, 18.19) controlPoint1:CGPointMake(39.52, 18.19) controlPoint2:CGPointMake(39.54, 18.19)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(39.56, 18)];
                [bezier19Path addCurveToPoint:CGPointMake(39.6, 18.01) controlPoint1:CGPointMake(39.58, 18) controlPoint2:CGPointMake(39.59, 18)];
                [bezier19Path addCurveToPoint:CGPointMake(39.62, 18.04) controlPoint1:CGPointMake(39.61, 18.02) controlPoint2:CGPointMake(39.62, 18.03)];
                [bezier19Path addCurveToPoint:CGPointMake(39.61, 18.07) controlPoint1:CGPointMake(39.62, 18.05) controlPoint2:CGPointMake(39.62, 18.06)];
                [bezier19Path addCurveToPoint:CGPointMake(39.58, 18.08) controlPoint1:CGPointMake(39.6, 18.08) controlPoint2:CGPointMake(39.59, 18.08)];
                [bezier19Path addLineToPoint:CGPointMake(39.63, 18.13)];
                [bezier19Path addLineToPoint:CGPointMake(39.59, 18.13)];
                [bezier19Path addLineToPoint:CGPointMake(39.55, 18.08)];
                [bezier19Path addLineToPoint:CGPointMake(39.54, 18.08)];
                [bezier19Path addLineToPoint:CGPointMake(39.54, 18.13)];
                [bezier19Path addLineToPoint:CGPointMake(39.5, 18.13)];
                [bezier19Path addLineToPoint:CGPointMake(39.5, 18)];
                [bezier19Path addLineToPoint:CGPointMake(39.56, 18)];
                [bezier19Path closePath];
                [bezier19Path moveToPoint:CGPointMake(39.53, 18.02)];
                [bezier19Path addLineToPoint:CGPointMake(39.53, 18.06)];
                [bezier19Path addLineToPoint:CGPointMake(39.57, 18.06)];
                [bezier19Path addCurveToPoint:CGPointMake(39.59, 18.06) controlPoint1:CGPointMake(39.58, 18.06) controlPoint2:CGPointMake(39.58, 18.06)];
                [bezier19Path addLineToPoint:CGPointMake(39.6, 18.05)];
                [bezier19Path addCurveToPoint:CGPointMake(39.59, 18.04) controlPoint1:CGPointMake(39.6, 18.04) controlPoint2:CGPointMake(39.6, 18.04)];
                [bezier19Path addCurveToPoint:CGPointMake(39.57, 18.04) controlPoint1:CGPointMake(39.59, 18.04) controlPoint2:CGPointMake(39.58, 18.04)];
                [bezier19Path addLineToPoint:CGPointMake(39.53, 18.04)];
                [bezier19Path addLineToPoint:CGPointMake(39.53, 18.02)];
                [bezier19Path closePath];
                bezier19Path.miterLimit = 4;

                [fillColor8 setFill];
                [bezier19Path fill];

                //// XMLID_1_
                {
                    //// Rectangle 2 Drawing
                    UIBezierPath *rectangle2Path = [UIBezierPath bezierPathWithRect:CGRectMake(30.37, 4.63, 5.16, 9.28)];
                    [fillColor9 setFill];
                    [rectangle2Path fill];

                    //// XMLID_2_ Drawing
                    UIBezierPath *xMLID_2_Path = [UIBezierPath bezierPath];
                    [xMLID_2_Path moveToPoint:CGPointMake(30.7, 9.27)];
                    [xMLID_2_Path addCurveToPoint:CGPointMake(32.95, 4.63) controlPoint1:CGPointMake(30.7, 7.39) controlPoint2:CGPointMake(31.58, 5.71)];
                    [xMLID_2_Path addCurveToPoint:CGPointMake(29.3, 3.37) controlPoint1:CGPointMake(31.95, 3.84) controlPoint2:CGPointMake(30.68, 3.37)];
                    [xMLID_2_Path addCurveToPoint:CGPointMake(23.4, 9.27) controlPoint1:CGPointMake(26.04, 3.37) controlPoint2:CGPointMake(23.4, 6.01)];
                    [xMLID_2_Path addCurveToPoint:CGPointMake(29.3, 15.17) controlPoint1:CGPointMake(23.4, 12.53) controlPoint2:CGPointMake(26.04, 15.17)];
                    [xMLID_2_Path addCurveToPoint:CGPointMake(32.95, 13.91) controlPoint1:CGPointMake(30.68, 15.17) controlPoint2:CGPointMake(31.94, 14.7)];
                    [xMLID_2_Path addCurveToPoint:CGPointMake(30.7, 9.27) controlPoint1:CGPointMake(31.58, 12.83) controlPoint2:CGPointMake(30.7, 11.16)];
                    [xMLID_2_Path closePath];
                    xMLID_2_Path.miterLimit = 4;

                    [fillColor10 setFill];
                    [xMLID_2_Path fill];

                    //// Bezier 21 Drawing
                    UIBezierPath *bezier21Path = [UIBezierPath bezierPath];
                    [bezier21Path moveToPoint:CGPointMake(42.5, 9.27)];
                    [bezier21Path addCurveToPoint:CGPointMake(36.6, 15.17) controlPoint1:CGPointMake(42.5, 12.53) controlPoint2:CGPointMake(39.86, 15.17)];
                    [bezier21Path addCurveToPoint:CGPointMake(32.95, 13.91) controlPoint1:CGPointMake(35.22, 15.17) controlPoint2:CGPointMake(33.96, 14.7)];
                    [bezier21Path addCurveToPoint:CGPointMake(35.2, 9.27) controlPoint1:CGPointMake(34.32, 12.83) controlPoint2:CGPointMake(35.2, 11.15)];
                    [bezier21Path addCurveToPoint:CGPointMake(32.95, 4.63) controlPoint1:CGPointMake(35.2, 7.39) controlPoint2:CGPointMake(34.32, 5.71)];
                    [bezier21Path addCurveToPoint:CGPointMake(36.6, 3.37) controlPoint1:CGPointMake(33.95, 3.84) controlPoint2:CGPointMake(35.22, 3.37)];
                    [bezier21Path addCurveToPoint:CGPointMake(42.5, 9.27) controlPoint1:CGPointMake(39.86, 3.37) controlPoint2:CGPointMake(42.5, 6.01)];
                    [bezier21Path closePath];
                    bezier21Path.miterLimit = 4;

                    [fillColor11 setFill];
                    [bezier21Path fill];
                }
            }
        }
    }
}

- (void)drawIc_card_mastercardCanvas {
    //// Color Declarations
    UIColor *fillColor = [UIColor colorWithRed:0.647 green:0.647 blue:0.647 alpha:1];
    UIColor *fillColor2 = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1];
    UIColor *fillColor8 = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    UIColor *fillColor10 = [UIColor colorWithRed:0.889 green:0 blue:0.087 alpha:1];
    UIColor *fillColor12 = [UIColor colorWithRed:0.988 green:0.279 blue:0.03 alpha:1];
    UIColor *fillColor13 = [UIColor colorWithRed:0.952 green:0.55 blue:0.09 alpha:1];

    //// Group
    {
        //// Group 2
        {
            //// Bezier Drawing
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(43.77, 0)];
            [bezierPath addLineToPoint:CGPointMake(2.23, 0)];
            [bezierPath addCurveToPoint:CGPointMake(0, 2.22) controlPoint1:CGPointMake(1, 0) controlPoint2:CGPointMake(0, 0.99)];
            [bezierPath addLineToPoint:CGPointMake(0, 3.33)];
            [bezierPath addLineToPoint:CGPointMake(0, 26.67)];
            [bezierPath addLineToPoint:CGPointMake(0, 27.79)];
            [bezierPath addCurveToPoint:CGPointMake(2.23, 30) controlPoint1:CGPointMake(0, 29.01) controlPoint2:CGPointMake(1, 30)];
            [bezierPath addLineToPoint:CGPointMake(43.77, 30)];
            [bezierPath addCurveToPoint:CGPointMake(46, 27.79) controlPoint1:CGPointMake(45, 30) controlPoint2:CGPointMake(46, 29.01)];
            [bezierPath addLineToPoint:CGPointMake(46, 2.22)];
            [bezierPath addCurveToPoint:CGPointMake(43.77, 0) controlPoint1:CGPointMake(46, 0.99) controlPoint2:CGPointMake(45, 0)];
            [bezierPath closePath];
            bezierPath.miterLimit = 4;

            [fillColor setFill];
            [bezierPath fill];

            //// Rectangle Drawing
            UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.55, 0.57, 44.9, 28.35) cornerRadius:1.6];
            [fillColor2 setFill];
            [rectanglePath fill];
        }

        //// Group 3
        {
            //// Group 4
            {
                //// Bezier 2 Drawing
                UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
                [bezier2Path moveToPoint:CGPointMake(5.45, 23.01)];
                [bezier2Path addCurveToPoint:CGPointMake(5.63, 23.1) controlPoint1:CGPointMake(5.52, 23.03) controlPoint2:CGPointMake(5.58, 23.06)];
                [bezier2Path addCurveToPoint:CGPointMake(5.73, 23.28) controlPoint1:CGPointMake(5.68, 23.14) controlPoint2:CGPointMake(5.71, 23.2)];
                [bezier2Path addCurveToPoint:CGPointMake(5.76, 23.56) controlPoint1:CGPointMake(5.75, 23.35) controlPoint2:CGPointMake(5.76, 23.45)];
                [bezier2Path addCurveToPoint:CGPointMake(5.72, 23.85) controlPoint1:CGPointMake(5.76, 23.68) controlPoint2:CGPointMake(5.75, 23.77)];
                [bezier2Path addCurveToPoint:CGPointMake(5.59, 24.03) controlPoint1:CGPointMake(5.69, 23.93) controlPoint2:CGPointMake(5.65, 23.99)];
                [bezier2Path addCurveToPoint:CGPointMake(5.34, 24.13) controlPoint1:CGPointMake(5.53, 24.08) controlPoint2:CGPointMake(5.45, 24.11)];
                [bezier2Path addCurveToPoint:CGPointMake(4.94, 24.16) controlPoint1:CGPointMake(5.23, 24.15) controlPoint2:CGPointMake(5.1, 24.16)];
                [bezier2Path addLineToPoint:CGPointMake(4.86, 24.16)];
                [bezier2Path addCurveToPoint:CGPointMake(4.66, 24.15) controlPoint1:CGPointMake(4.8, 24.16) controlPoint2:CGPointMake(4.74, 24.16)];
                [bezier2Path addCurveToPoint:CGPointMake(4.46, 24.12) controlPoint1:CGPointMake(4.59, 24.15) controlPoint2:CGPointMake(4.52, 24.14)];
                [bezier2Path addCurveToPoint:CGPointMake(4.3, 24.04) controlPoint1:CGPointMake(4.4, 24.1) controlPoint2:CGPointMake(4.35, 24.07)];
                [bezier2Path addCurveToPoint:CGPointMake(4.23, 23.89) controlPoint1:CGPointMake(4.26, 24) controlPoint2:CGPointMake(4.24, 23.95)];
                [bezier2Path addLineToPoint:CGPointMake(4.23, 23.89)];
                [bezier2Path addCurveToPoint:CGPointMake(4.29, 23.78) controlPoint1:CGPointMake(4.23, 23.84) controlPoint2:CGPointMake(4.25, 23.81)];
                [bezier2Path addCurveToPoint:CGPointMake(4.41, 23.73) controlPoint1:CGPointMake(4.33, 23.75) controlPoint2:CGPointMake(4.36, 23.73)];
                [bezier2Path addLineToPoint:CGPointMake(4.42, 23.73)];
                [bezier2Path addCurveToPoint:CGPointMake(4.51, 23.74) controlPoint1:CGPointMake(4.46, 23.73) controlPoint2:CGPointMake(4.49, 23.74)];
                [bezier2Path addCurveToPoint:CGPointMake(4.56, 23.76) controlPoint1:CGPointMake(4.53, 23.75) controlPoint2:CGPointMake(4.55, 23.76)];
                [bezier2Path addCurveToPoint:CGPointMake(4.61, 23.79) controlPoint1:CGPointMake(4.57, 23.77) controlPoint2:CGPointMake(4.59, 23.78)];
                [bezier2Path addCurveToPoint:CGPointMake(4.67, 23.82) controlPoint1:CGPointMake(4.62, 23.8) controlPoint2:CGPointMake(4.65, 23.81)];
                [bezier2Path addCurveToPoint:CGPointMake(4.79, 23.84) controlPoint1:CGPointMake(4.7, 23.83) controlPoint2:CGPointMake(4.74, 23.83)];
                [bezier2Path addCurveToPoint:CGPointMake(4.98, 23.85) controlPoint1:CGPointMake(4.84, 23.85) controlPoint2:CGPointMake(4.9, 23.85)];
                [bezier2Path addCurveToPoint:CGPointMake(5.18, 23.83) controlPoint1:CGPointMake(5.06, 23.85) controlPoint2:CGPointMake(5.12, 23.85)];
                [bezier2Path addCurveToPoint:CGPointMake(5.3, 23.78) controlPoint1:CGPointMake(5.23, 23.82) controlPoint2:CGPointMake(5.27, 23.8)];
                [bezier2Path addCurveToPoint:CGPointMake(5.36, 23.69) controlPoint1:CGPointMake(5.33, 23.76) controlPoint2:CGPointMake(5.35, 23.73)];
                [bezier2Path addCurveToPoint:CGPointMake(5.38, 23.56) controlPoint1:CGPointMake(5.37, 23.65) controlPoint2:CGPointMake(5.38, 23.61)];
                [bezier2Path addCurveToPoint:CGPointMake(5.35, 23.37) controlPoint1:CGPointMake(5.38, 23.47) controlPoint2:CGPointMake(5.37, 23.41)];
                [bezier2Path addCurveToPoint:CGPointMake(5.19, 23.3) controlPoint1:CGPointMake(5.3, 23.32) controlPoint2:CGPointMake(5.26, 23.3)];
                [bezier2Path addLineToPoint:CGPointMake(4.53, 23.3)];
                [bezier2Path addCurveToPoint:CGPointMake(4.39, 23.29) controlPoint1:CGPointMake(4.47, 23.3) controlPoint2:CGPointMake(4.43, 23.3)];
                [bezier2Path addCurveToPoint:CGPointMake(4.31, 23.26) controlPoint1:CGPointMake(4.36, 23.28) controlPoint2:CGPointMake(4.33, 23.27)];
                [bezier2Path addCurveToPoint:CGPointMake(4.27, 23.19) controlPoint1:CGPointMake(4.29, 23.24) controlPoint2:CGPointMake(4.28, 23.22)];
                [bezier2Path addCurveToPoint:CGPointMake(4.26, 23.07) controlPoint1:CGPointMake(4.26, 23.16) controlPoint2:CGPointMake(4.26, 23.12)];
                [bezier2Path addLineToPoint:CGPointMake(4.26, 22.33)];
                [bezier2Path addCurveToPoint:CGPointMake(4.3, 22.2) controlPoint1:CGPointMake(4.26, 22.28) controlPoint2:CGPointMake(4.28, 22.23)];
                [bezier2Path addCurveToPoint:CGPointMake(4.47, 22.16) controlPoint1:CGPointMake(4.33, 22.17) controlPoint2:CGPointMake(4.39, 22.16)];
                [bezier2Path addCurveToPoint:CGPointMake(4.59, 22.16) controlPoint1:CGPointMake(4.5, 22.16) controlPoint2:CGPointMake(4.54, 22.16)];
                [bezier2Path addCurveToPoint:CGPointMake(4.77, 22.16) controlPoint1:CGPointMake(4.64, 22.16) controlPoint2:CGPointMake(4.7, 22.16)];
                [bezier2Path addCurveToPoint:CGPointMake(4.98, 22.16) controlPoint1:CGPointMake(4.84, 22.16) controlPoint2:CGPointMake(4.91, 22.16)];
                [bezier2Path addCurveToPoint:CGPointMake(5.18, 22.16) controlPoint1:CGPointMake(5.05, 22.16) controlPoint2:CGPointMake(5.12, 22.16)];
                [bezier2Path addCurveToPoint:CGPointMake(5.34, 22.16) controlPoint1:CGPointMake(5.24, 22.16) controlPoint2:CGPointMake(5.29, 22.16)];
                [bezier2Path addCurveToPoint:CGPointMake(5.41, 22.16) controlPoint1:CGPointMake(5.38, 22.16) controlPoint2:CGPointMake(5.41, 22.16)];
                [bezier2Path addCurveToPoint:CGPointMake(5.49, 22.17) controlPoint1:CGPointMake(5.44, 22.16) controlPoint2:CGPointMake(5.46, 22.16)];
                [bezier2Path addCurveToPoint:CGPointMake(5.56, 22.19) controlPoint1:CGPointMake(5.52, 22.17) controlPoint2:CGPointMake(5.54, 22.18)];
                [bezier2Path addCurveToPoint:CGPointMake(5.62, 22.24) controlPoint1:CGPointMake(5.58, 22.2) controlPoint2:CGPointMake(5.6, 22.22)];
                [bezier2Path addCurveToPoint:CGPointMake(5.64, 22.32) controlPoint1:CGPointMake(5.64, 22.26) controlPoint2:CGPointMake(5.64, 22.29)];
                [bezier2Path addLineToPoint:CGPointMake(5.64, 22.33)];
                [bezier2Path addCurveToPoint:CGPointMake(5.62, 22.42) controlPoint1:CGPointMake(5.64, 22.37) controlPoint2:CGPointMake(5.63, 22.4)];
                [bezier2Path addCurveToPoint:CGPointMake(5.57, 22.47) controlPoint1:CGPointMake(5.61, 22.44) controlPoint2:CGPointMake(5.59, 22.46)];
                [bezier2Path addCurveToPoint:CGPointMake(5.5, 22.49) controlPoint1:CGPointMake(5.55, 22.48) controlPoint2:CGPointMake(5.53, 22.49)];
                [bezier2Path addCurveToPoint:CGPointMake(5.41, 22.49) controlPoint1:CGPointMake(5.47, 22.49) controlPoint2:CGPointMake(5.44, 22.49)];
                [bezier2Path addLineToPoint:CGPointMake(4.65, 22.49)];
                [bezier2Path addLineToPoint:CGPointMake(4.65, 23)];
                [bezier2Path addLineToPoint:CGPointMake(5.17, 23)];
                [bezier2Path addCurveToPoint:CGPointMake(5.45, 23.01) controlPoint1:CGPointMake(5.28, 22.99) controlPoint2:CGPointMake(5.37, 22.99)];
                [bezier2Path closePath];
                bezier2Path.miterLimit = 4;

                [fillColor setFill];
                [bezier2Path fill];

                //// Bezier 3 Drawing
                UIBezierPath *bezier3Path = [UIBezierPath bezierPath];
                [bezier3Path moveToPoint:CGPointMake(7.76, 23.01)];
                [bezier3Path addCurveToPoint:CGPointMake(7.9, 23.04) controlPoint1:CGPointMake(7.81, 23.01) controlPoint2:CGPointMake(7.86, 23.02)];
                [bezier3Path addCurveToPoint:CGPointMake(7.96, 23.16) controlPoint1:CGPointMake(7.94, 23.06) controlPoint2:CGPointMake(7.96, 23.1)];
                [bezier3Path addCurveToPoint:CGPointMake(7.9, 23.29) controlPoint1:CGPointMake(7.96, 23.22) controlPoint2:CGPointMake(7.94, 23.27)];
                [bezier3Path addCurveToPoint:CGPointMake(7.77, 23.33) controlPoint1:CGPointMake(7.86, 23.32) controlPoint2:CGPointMake(7.82, 23.33)];
                [bezier3Path addLineToPoint:CGPointMake(7.7, 23.33)];
                [bezier3Path addLineToPoint:CGPointMake(7.7, 24)];
                [bezier3Path addCurveToPoint:CGPointMake(7.69, 24.05) controlPoint1:CGPointMake(7.7, 24.02) controlPoint2:CGPointMake(7.7, 24.03)];
                [bezier3Path addCurveToPoint:CGPointMake(7.65, 24.1) controlPoint1:CGPointMake(7.68, 24.07) controlPoint2:CGPointMake(7.67, 24.09)];
                [bezier3Path addCurveToPoint:CGPointMake(7.59, 24.14) controlPoint1:CGPointMake(7.63, 24.12) controlPoint2:CGPointMake(7.61, 24.13)];
                [bezier3Path addCurveToPoint:CGPointMake(7.5, 24.16) controlPoint1:CGPointMake(7.56, 24.15) controlPoint2:CGPointMake(7.53, 24.16)];
                [bezier3Path addCurveToPoint:CGPointMake(7.41, 24.14) controlPoint1:CGPointMake(7.47, 24.16) controlPoint2:CGPointMake(7.44, 24.16)];
                [bezier3Path addCurveToPoint:CGPointMake(7.35, 24.1) controlPoint1:CGPointMake(7.39, 24.13) controlPoint2:CGPointMake(7.36, 24.12)];
                [bezier3Path addCurveToPoint:CGPointMake(7.31, 24.05) controlPoint1:CGPointMake(7.33, 24.08) controlPoint2:CGPointMake(7.32, 24.07)];
                [bezier3Path addCurveToPoint:CGPointMake(7.3, 24) controlPoint1:CGPointMake(7.31, 24.04) controlPoint2:CGPointMake(7.3, 24.02)];
                [bezier3Path addLineToPoint:CGPointMake(7.3, 23.33)];
                [bezier3Path addLineToPoint:CGPointMake(6.54, 23.33)];
                [bezier3Path addCurveToPoint:CGPointMake(6.44, 23.31) controlPoint1:CGPointMake(6.49, 23.33) controlPoint2:CGPointMake(6.46, 23.32)];
                [bezier3Path addCurveToPoint:CGPointMake(6.42, 23.23) controlPoint1:CGPointMake(6.43, 23.29) controlPoint2:CGPointMake(6.42, 23.27)];
                [bezier3Path addLineToPoint:CGPointMake(6.42, 22.32)];
                [bezier3Path addCurveToPoint:CGPointMake(6.43, 22.26) controlPoint1:CGPointMake(6.42, 22.3) controlPoint2:CGPointMake(6.42, 22.28)];
                [bezier3Path addCurveToPoint:CGPointMake(6.46, 22.2) controlPoint1:CGPointMake(6.44, 22.24) controlPoint2:CGPointMake(6.45, 22.22)];
                [bezier3Path addCurveToPoint:CGPointMake(6.52, 22.16) controlPoint1:CGPointMake(6.48, 22.18) controlPoint2:CGPointMake(6.5, 22.17)];
                [bezier3Path addCurveToPoint:CGPointMake(6.61, 22.14) controlPoint1:CGPointMake(6.55, 22.15) controlPoint2:CGPointMake(6.57, 22.14)];
                [bezier3Path addCurveToPoint:CGPointMake(6.76, 22.19) controlPoint1:CGPointMake(6.68, 22.14) controlPoint2:CGPointMake(6.73, 22.15)];
                [bezier3Path addCurveToPoint:CGPointMake(6.81, 22.32) controlPoint1:CGPointMake(6.79, 22.22) controlPoint2:CGPointMake(6.81, 22.26)];
                [bezier3Path addLineToPoint:CGPointMake(6.81, 23.01)];
                [bezier3Path addLineToPoint:CGPointMake(7.3, 23.01)];
                [bezier3Path addLineToPoint:CGPointMake(7.3, 22.31)];
                [bezier3Path addCurveToPoint:CGPointMake(7.35, 22.19) controlPoint1:CGPointMake(7.3, 22.26) controlPoint2:CGPointMake(7.32, 22.22)];
                [bezier3Path addCurveToPoint:CGPointMake(7.49, 22.14) controlPoint1:CGPointMake(7.38, 22.16) controlPoint2:CGPointMake(7.43, 22.14)];
                [bezier3Path addCurveToPoint:CGPointMake(7.64, 22.19) controlPoint1:CGPointMake(7.56, 22.14) controlPoint2:CGPointMake(7.6, 22.16)];
                [bezier3Path addCurveToPoint:CGPointMake(7.69, 22.31) controlPoint1:CGPointMake(7.68, 22.22) controlPoint2:CGPointMake(7.69, 22.26)];
                [bezier3Path addLineToPoint:CGPointMake(7.69, 23.01)];
                [bezier3Path addLineToPoint:CGPointMake(7.76, 23.01)];
                [bezier3Path addLineToPoint:CGPointMake(7.76, 23.01)];
                [bezier3Path closePath];
                bezier3Path.miterLimit = 4;

                [fillColor setFill];
                [bezier3Path fill];

                //// Bezier 4 Drawing
                UIBezierPath *bezier4Path = [UIBezierPath bezierPath];
                [bezier4Path moveToPoint:CGPointMake(9.43, 22.93)];
                [bezier4Path addCurveToPoint:CGPointMake(9.75, 22.97) controlPoint1:CGPointMake(9.56, 22.93) controlPoint2:CGPointMake(9.66, 22.94)];
                [bezier4Path addCurveToPoint:CGPointMake(9.96, 23.09) controlPoint1:CGPointMake(9.84, 23) controlPoint2:CGPointMake(9.91, 23.04)];
                [bezier4Path addCurveToPoint:CGPointMake(10.07, 23.29) controlPoint1:CGPointMake(10.01, 23.14) controlPoint2:CGPointMake(10.05, 23.21)];
                [bezier4Path addCurveToPoint:CGPointMake(10.11, 23.56) controlPoint1:CGPointMake(10.09, 23.37) controlPoint2:CGPointMake(10.11, 23.46)];
                [bezier4Path addCurveToPoint:CGPointMake(10.07, 23.82) controlPoint1:CGPointMake(10.11, 23.66) controlPoint2:CGPointMake(10.09, 23.75)];
                [bezier4Path addCurveToPoint:CGPointMake(9.94, 24.01) controlPoint1:CGPointMake(10.05, 23.9) controlPoint2:CGPointMake(10, 23.96)];
                [bezier4Path addCurveToPoint:CGPointMake(9.7, 24.13) controlPoint1:CGPointMake(9.88, 24.06) controlPoint2:CGPointMake(9.8, 24.1)];
                [bezier4Path addCurveToPoint:CGPointMake(9.34, 24.17) controlPoint1:CGPointMake(9.61, 24.16) controlPoint2:CGPointMake(9.48, 24.17)];
                [bezier4Path addCurveToPoint:CGPointMake(9.05, 24.14) controlPoint1:CGPointMake(9.23, 24.17) controlPoint2:CGPointMake(9.13, 24.16)];
                [bezier4Path addCurveToPoint:CGPointMake(8.82, 24.04) controlPoint1:CGPointMake(8.96, 24.12) controlPoint2:CGPointMake(8.88, 24.09)];
                [bezier4Path addCurveToPoint:CGPointMake(8.67, 23.87) controlPoint1:CGPointMake(8.75, 24) controlPoint2:CGPointMake(8.7, 23.94)];
                [bezier4Path addCurveToPoint:CGPointMake(8.62, 23.61) controlPoint1:CGPointMake(8.64, 23.8) controlPoint2:CGPointMake(8.62, 23.71)];
                [bezier4Path addLineToPoint:CGPointMake(8.62, 22.31)];
                [bezier4Path addCurveToPoint:CGPointMake(8.63, 22.25) controlPoint1:CGPointMake(8.62, 22.29) controlPoint2:CGPointMake(8.62, 22.27)];
                [bezier4Path addCurveToPoint:CGPointMake(8.67, 22.2) controlPoint1:CGPointMake(8.64, 22.23) controlPoint2:CGPointMake(8.65, 22.21)];
                [bezier4Path addCurveToPoint:CGPointMake(8.73, 22.16) controlPoint1:CGPointMake(8.69, 22.18) controlPoint2:CGPointMake(8.71, 22.17)];
                [bezier4Path addCurveToPoint:CGPointMake(8.82, 22.15) controlPoint1:CGPointMake(8.76, 22.15) controlPoint2:CGPointMake(8.79, 22.15)];
                [bezier4Path addCurveToPoint:CGPointMake(8.97, 22.2) controlPoint1:CGPointMake(8.89, 22.15) controlPoint2:CGPointMake(8.93, 22.17)];
                [bezier4Path addCurveToPoint:CGPointMake(9.02, 22.32) controlPoint1:CGPointMake(9, 22.23) controlPoint2:CGPointMake(9.02, 22.27)];
                [bezier4Path addLineToPoint:CGPointMake(9.02, 22.97)];
                [bezier4Path addCurveToPoint:CGPointMake(9.27, 22.95) controlPoint1:CGPointMake(9.11, 22.96) controlPoint2:CGPointMake(9.2, 22.95)];
                [bezier4Path addCurveToPoint:CGPointMake(9.43, 22.93) controlPoint1:CGPointMake(9.32, 22.93) controlPoint2:CGPointMake(9.38, 22.93)];
                [bezier4Path closePath];
                [bezier4Path moveToPoint:CGPointMake(9.72, 23.54)];
                [bezier4Path addCurveToPoint:CGPointMake(9.7, 23.39) controlPoint1:CGPointMake(9.72, 23.48) controlPoint2:CGPointMake(9.72, 23.43)];
                [bezier4Path addCurveToPoint:CGPointMake(9.64, 23.3) controlPoint1:CGPointMake(9.69, 23.35) controlPoint2:CGPointMake(9.67, 23.32)];
                [bezier4Path addCurveToPoint:CGPointMake(9.53, 23.26) controlPoint1:CGPointMake(9.61, 23.28) controlPoint2:CGPointMake(9.58, 23.26)];
                [bezier4Path addCurveToPoint:CGPointMake(9.35, 23.25) controlPoint1:CGPointMake(9.48, 23.25) controlPoint2:CGPointMake(9.42, 23.25)];
                [bezier4Path addCurveToPoint:CGPointMake(9.21, 23.25) controlPoint1:CGPointMake(9.3, 23.25) controlPoint2:CGPointMake(9.25, 23.25)];
                [bezier4Path addCurveToPoint:CGPointMake(9.12, 23.25) controlPoint1:CGPointMake(9.17, 23.25) controlPoint2:CGPointMake(9.15, 23.25)];
                [bezier4Path addCurveToPoint:CGPointMake(9.06, 23.26) controlPoint1:CGPointMake(9.1, 23.25) controlPoint2:CGPointMake(9.07, 23.25)];
                [bezier4Path addCurveToPoint:CGPointMake(8.99, 23.27) controlPoint1:CGPointMake(9.04, 23.26) controlPoint2:CGPointMake(9.02, 23.27)];
                [bezier4Path addLineToPoint:CGPointMake(8.99, 23.52)];
                [bezier4Path addCurveToPoint:CGPointMake(9.01, 23.66) controlPoint1:CGPointMake(8.99, 23.58) controlPoint2:CGPointMake(9, 23.63)];
                [bezier4Path addCurveToPoint:CGPointMake(9.07, 23.76) controlPoint1:CGPointMake(9.02, 23.7) controlPoint2:CGPointMake(9.04, 23.73)];
                [bezier4Path addCurveToPoint:CGPointMake(9.18, 23.82) controlPoint1:CGPointMake(9.1, 23.79) controlPoint2:CGPointMake(9.13, 23.81)];
                [bezier4Path addCurveToPoint:CGPointMake(9.35, 23.84) controlPoint1:CGPointMake(9.23, 23.83) controlPoint2:CGPointMake(9.28, 23.84)];
                [bezier4Path addCurveToPoint:CGPointMake(9.52, 23.83) controlPoint1:CGPointMake(9.41, 23.84) controlPoint2:CGPointMake(9.47, 23.84)];
                [bezier4Path addCurveToPoint:CGPointMake(9.63, 23.79) controlPoint1:CGPointMake(9.56, 23.82) controlPoint2:CGPointMake(9.6, 23.81)];
                [bezier4Path addCurveToPoint:CGPointMake(9.7, 23.7) controlPoint1:CGPointMake(9.66, 23.77) controlPoint2:CGPointMake(9.69, 23.74)];
                [bezier4Path addCurveToPoint:CGPointMake(9.72, 23.54) controlPoint1:CGPointMake(9.72, 23.66) controlPoint2:CGPointMake(9.72, 23.61)];
                [bezier4Path closePath];
                bezier4Path.miterLimit = 4;

                [fillColor setFill];
                [bezier4Path fill];

                //// Bezier 5 Drawing
                UIBezierPath *bezier5Path = [UIBezierPath bezierPath];
                [bezier5Path moveToPoint:CGPointMake(11.46, 22.14)];
                [bezier5Path addCurveToPoint:CGPointMake(11.83, 22.17) controlPoint1:CGPointMake(11.61, 22.14) controlPoint2:CGPointMake(11.73, 22.15)];
                [bezier5Path addCurveToPoint:CGPointMake(12.07, 22.27) controlPoint1:CGPointMake(11.93, 22.19) controlPoint2:CGPointMake(12.01, 22.22)];
                [bezier5Path addCurveToPoint:CGPointMake(12.21, 22.45) controlPoint1:CGPointMake(12.14, 22.31) controlPoint2:CGPointMake(12.18, 22.37)];
                [bezier5Path addCurveToPoint:CGPointMake(12.26, 22.72) controlPoint1:CGPointMake(12.24, 22.52) controlPoint2:CGPointMake(12.25, 22.61)];
                [bezier5Path addLineToPoint:CGPointMake(12.26, 22.73)];
                [bezier5Path addCurveToPoint:CGPointMake(12.22, 23.02) controlPoint1:CGPointMake(12.26, 22.84) controlPoint2:CGPointMake(12.25, 22.94)];
                [bezier5Path addCurveToPoint:CGPointMake(12.11, 23.2) controlPoint1:CGPointMake(12.2, 23.1) controlPoint2:CGPointMake(12.16, 23.15)];
                [bezier5Path addCurveToPoint:CGPointMake(11.91, 23.3) controlPoint1:CGPointMake(12.06, 23.25) controlPoint2:CGPointMake(11.99, 23.28)];
                [bezier5Path addCurveToPoint:CGPointMake(11.6, 23.33) controlPoint1:CGPointMake(11.83, 23.32) controlPoint2:CGPointMake(11.73, 23.33)];
                [bezier5Path addCurveToPoint:CGPointMake(11.34, 23.33) controlPoint1:CGPointMake(11.5, 23.33) controlPoint2:CGPointMake(11.41, 23.33)];
                [bezier5Path addCurveToPoint:CGPointMake(11.18, 23.37) controlPoint1:CGPointMake(11.27, 23.33) controlPoint2:CGPointMake(11.22, 23.35)];
                [bezier5Path addCurveToPoint:CGPointMake(11.1, 23.46) controlPoint1:CGPointMake(11.14, 23.39) controlPoint2:CGPointMake(11.11, 23.42)];
                [bezier5Path addCurveToPoint:CGPointMake(11.07, 23.65) controlPoint1:CGPointMake(11.08, 23.5) controlPoint2:CGPointMake(11.07, 23.57)];
                [bezier5Path addLineToPoint:CGPointMake(11.07, 23.83)];
                [bezier5Path addLineToPoint:CGPointMake(12.04, 23.83)];
                [bezier5Path addCurveToPoint:CGPointMake(12.11, 23.84) controlPoint1:CGPointMake(12.06, 23.83) controlPoint2:CGPointMake(12.08, 23.83)];
                [bezier5Path addCurveToPoint:CGPointMake(12.18, 23.87) controlPoint1:CGPointMake(12.13, 23.85) controlPoint2:CGPointMake(12.16, 23.86)];
                [bezier5Path addCurveToPoint:CGPointMake(12.23, 23.92) controlPoint1:CGPointMake(12.2, 23.88) controlPoint2:CGPointMake(12.21, 23.9)];
                [bezier5Path addCurveToPoint:CGPointMake(12.26, 23.99) controlPoint1:CGPointMake(12.24, 23.94) controlPoint2:CGPointMake(12.25, 23.96)];
                [bezier5Path addCurveToPoint:CGPointMake(12.24, 24.07) controlPoint1:CGPointMake(12.26, 24.02) controlPoint2:CGPointMake(12.25, 24.05)];
                [bezier5Path addCurveToPoint:CGPointMake(12.19, 24.12) controlPoint1:CGPointMake(12.23, 24.09) controlPoint2:CGPointMake(12.21, 24.11)];
                [bezier5Path addCurveToPoint:CGPointMake(12.13, 24.15) controlPoint1:CGPointMake(12.17, 24.13) controlPoint2:CGPointMake(12.15, 24.14)];
                [bezier5Path addCurveToPoint:CGPointMake(12.05, 24.16) controlPoint1:CGPointMake(12.1, 24.16) controlPoint2:CGPointMake(12.08, 24.16)];
                [bezier5Path addLineToPoint:CGPointMake(10.91, 24.16)];
                [bezier5Path addCurveToPoint:CGPointMake(10.74, 24.12) controlPoint1:CGPointMake(10.83, 24.16) controlPoint2:CGPointMake(10.77, 24.15)];
                [bezier5Path addCurveToPoint:CGPointMake(10.69, 23.99) controlPoint1:CGPointMake(10.71, 24.09) controlPoint2:CGPointMake(10.69, 24.05)];
                [bezier5Path addLineToPoint:CGPointMake(10.69, 23.59)];
                [bezier5Path addCurveToPoint:CGPointMake(10.73, 23.32) controlPoint1:CGPointMake(10.69, 23.48) controlPoint2:CGPointMake(10.7, 23.39)];
                [bezier5Path addCurveToPoint:CGPointMake(10.85, 23.14) controlPoint1:CGPointMake(10.76, 23.25) controlPoint2:CGPointMake(10.8, 23.19)];
                [bezier5Path addCurveToPoint:CGPointMake(11.05, 23.05) controlPoint1:CGPointMake(10.9, 23.1) controlPoint2:CGPointMake(10.97, 23.07)];
                [bezier5Path addCurveToPoint:CGPointMake(11.31, 23.02) controlPoint1:CGPointMake(11.13, 23.03) controlPoint2:CGPointMake(11.22, 23.02)];
                [bezier5Path addLineToPoint:CGPointMake(11.6, 23.01)];
                [bezier5Path addCurveToPoint:CGPointMake(11.73, 23) controlPoint1:CGPointMake(11.65, 23.01) controlPoint2:CGPointMake(11.7, 23.01)];
                [bezier5Path addCurveToPoint:CGPointMake(11.81, 22.96) controlPoint1:CGPointMake(11.76, 22.99) controlPoint2:CGPointMake(11.79, 22.98)];
                [bezier5Path addCurveToPoint:CGPointMake(11.86, 22.88) controlPoint1:CGPointMake(11.83, 22.94) controlPoint2:CGPointMake(11.85, 22.92)];
                [bezier5Path addCurveToPoint:CGPointMake(11.87, 22.76) controlPoint1:CGPointMake(11.87, 22.85) controlPoint2:CGPointMake(11.87, 22.81)];
                [bezier5Path addLineToPoint:CGPointMake(11.87, 22.75)];
                [bezier5Path addCurveToPoint:CGPointMake(11.85, 22.62) controlPoint1:CGPointMake(11.87, 22.7) controlPoint2:CGPointMake(11.87, 22.66)];
                [bezier5Path addCurveToPoint:CGPointMake(11.79, 22.54) controlPoint1:CGPointMake(11.84, 22.59) controlPoint2:CGPointMake(11.82, 22.56)];
                [bezier5Path addCurveToPoint:CGPointMake(11.66, 22.49) controlPoint1:CGPointMake(11.76, 22.52) controlPoint2:CGPointMake(11.72, 22.5)];
                [bezier5Path addCurveToPoint:CGPointMake(11.45, 22.48) controlPoint1:CGPointMake(11.6, 22.48) controlPoint2:CGPointMake(11.53, 22.48)];
                [bezier5Path addCurveToPoint:CGPointMake(11.26, 22.49) controlPoint1:CGPointMake(11.38, 22.48) controlPoint2:CGPointMake(11.32, 22.48)];
                [bezier5Path addCurveToPoint:CGPointMake(11.12, 22.52) controlPoint1:CGPointMake(11.2, 22.5) controlPoint2:CGPointMake(11.16, 22.51)];
                [bezier5Path addCurveToPoint:CGPointMake(11.02, 22.56) controlPoint1:CGPointMake(11.08, 22.53) controlPoint2:CGPointMake(11.05, 22.54)];
                [bezier5Path addCurveToPoint:CGPointMake(10.91, 22.58) controlPoint1:CGPointMake(10.99, 22.57) controlPoint2:CGPointMake(10.96, 22.58)];
                [bezier5Path addLineToPoint:CGPointMake(10.9, 22.58)];
                [bezier5Path addCurveToPoint:CGPointMake(10.78, 22.53) controlPoint1:CGPointMake(10.85, 22.58) controlPoint2:CGPointMake(10.81, 22.56)];
                [bezier5Path addCurveToPoint:CGPointMake(10.74, 22.41) controlPoint1:CGPointMake(10.75, 22.5) controlPoint2:CGPointMake(10.74, 22.46)];
                [bezier5Path addLineToPoint:CGPointMake(10.74, 22.4)];
                [bezier5Path addCurveToPoint:CGPointMake(10.8, 22.29) controlPoint1:CGPointMake(10.74, 22.35) controlPoint2:CGPointMake(10.76, 22.32)];
                [bezier5Path addCurveToPoint:CGPointMake(10.96, 22.22) controlPoint1:CGPointMake(10.84, 22.26) controlPoint2:CGPointMake(10.89, 22.23)];
                [bezier5Path addCurveToPoint:CGPointMake(11.19, 22.18) controlPoint1:CGPointMake(11.03, 22.2) controlPoint2:CGPointMake(11.1, 22.19)];
                [bezier5Path addCurveToPoint:CGPointMake(11.46, 22.14) controlPoint1:CGPointMake(11.27, 22.14) controlPoint2:CGPointMake(11.36, 22.14)];
                [bezier5Path closePath];
                bezier5Path.miterLimit = 4;

                [fillColor setFill];
                [bezier5Path fill];

                //// Bezier 6 Drawing
                UIBezierPath *bezier6Path = [UIBezierPath bezierPath];
                [bezier6Path moveToPoint:CGPointMake(15.03, 22.14)];
                [bezier6Path addCurveToPoint:CGPointMake(15.4, 22.17) controlPoint1:CGPointMake(15.18, 22.14) controlPoint2:CGPointMake(15.3, 22.15)];
                [bezier6Path addCurveToPoint:CGPointMake(15.65, 22.27) controlPoint1:CGPointMake(15.5, 22.19) controlPoint2:CGPointMake(15.58, 22.22)];
                [bezier6Path addCurveToPoint:CGPointMake(15.78, 22.45) controlPoint1:CGPointMake(15.71, 22.31) controlPoint2:CGPointMake(15.75, 22.37)];
                [bezier6Path addCurveToPoint:CGPointMake(15.82, 22.72) controlPoint1:CGPointMake(15.81, 22.52) controlPoint2:CGPointMake(15.82, 22.61)];
                [bezier6Path addLineToPoint:CGPointMake(15.82, 22.73)];
                [bezier6Path addCurveToPoint:CGPointMake(15.79, 23.02) controlPoint1:CGPointMake(15.82, 22.84) controlPoint2:CGPointMake(15.81, 22.94)];
                [bezier6Path addCurveToPoint:CGPointMake(15.68, 23.2) controlPoint1:CGPointMake(15.77, 23.1) controlPoint2:CGPointMake(15.73, 23.15)];
                [bezier6Path addCurveToPoint:CGPointMake(15.48, 23.3) controlPoint1:CGPointMake(15.63, 23.25) controlPoint2:CGPointMake(15.56, 23.28)];
                [bezier6Path addCurveToPoint:CGPointMake(15.18, 23.33) controlPoint1:CGPointMake(15.4, 23.32) controlPoint2:CGPointMake(15.3, 23.33)];
                [bezier6Path addCurveToPoint:CGPointMake(14.92, 23.33) controlPoint1:CGPointMake(15.08, 23.33) controlPoint2:CGPointMake(14.99, 23.33)];
                [bezier6Path addCurveToPoint:CGPointMake(14.75, 23.37) controlPoint1:CGPointMake(14.85, 23.33) controlPoint2:CGPointMake(14.8, 23.35)];
                [bezier6Path addCurveToPoint:CGPointMake(14.66, 23.46) controlPoint1:CGPointMake(14.71, 23.39) controlPoint2:CGPointMake(14.68, 23.42)];
                [bezier6Path addCurveToPoint:CGPointMake(14.64, 23.65) controlPoint1:CGPointMake(14.65, 23.5) controlPoint2:CGPointMake(14.64, 23.57)];
                [bezier6Path addLineToPoint:CGPointMake(14.64, 23.83)];
                [bezier6Path addLineToPoint:CGPointMake(15.61, 23.83)];
                [bezier6Path addCurveToPoint:CGPointMake(15.68, 23.84) controlPoint1:CGPointMake(15.63, 23.83) controlPoint2:CGPointMake(15.66, 23.83)];
                [bezier6Path addCurveToPoint:CGPointMake(15.74, 23.87) controlPoint1:CGPointMake(15.7, 23.85) controlPoint2:CGPointMake(15.73, 23.86)];
                [bezier6Path addCurveToPoint:CGPointMake(15.79, 23.92) controlPoint1:CGPointMake(15.76, 23.88) controlPoint2:CGPointMake(15.78, 23.9)];
                [bezier6Path addCurveToPoint:CGPointMake(15.81, 23.99) controlPoint1:CGPointMake(15.8, 23.94) controlPoint2:CGPointMake(15.81, 23.96)];
                [bezier6Path addCurveToPoint:CGPointMake(15.79, 24.07) controlPoint1:CGPointMake(15.81, 24.02) controlPoint2:CGPointMake(15.81, 24.05)];
                [bezier6Path addCurveToPoint:CGPointMake(15.74, 24.12) controlPoint1:CGPointMake(15.77, 24.09) controlPoint2:CGPointMake(15.76, 24.11)];
                [bezier6Path addCurveToPoint:CGPointMake(15.67, 24.15) controlPoint1:CGPointMake(15.72, 24.13) controlPoint2:CGPointMake(15.7, 24.14)];
                [bezier6Path addCurveToPoint:CGPointMake(15.59, 24.16) controlPoint1:CGPointMake(15.64, 24.16) controlPoint2:CGPointMake(15.62, 24.16)];
                [bezier6Path addLineToPoint:CGPointMake(14.45, 24.16)];
                [bezier6Path addCurveToPoint:CGPointMake(14.28, 24.12) controlPoint1:CGPointMake(14.37, 24.16) controlPoint2:CGPointMake(14.31, 24.15)];
                [bezier6Path addCurveToPoint:CGPointMake(14.23, 23.99) controlPoint1:CGPointMake(14.24, 24.09) controlPoint2:CGPointMake(14.23, 24.05)];
                [bezier6Path addLineToPoint:CGPointMake(14.23, 23.59)];
                [bezier6Path addCurveToPoint:CGPointMake(14.27, 23.32) controlPoint1:CGPointMake(14.23, 23.48) controlPoint2:CGPointMake(14.24, 23.39)];
                [bezier6Path addCurveToPoint:CGPointMake(14.39, 23.14) controlPoint1:CGPointMake(14.3, 23.25) controlPoint2:CGPointMake(14.34, 23.19)];
                [bezier6Path addCurveToPoint:CGPointMake(14.58, 23.05) controlPoint1:CGPointMake(14.44, 23.1) controlPoint2:CGPointMake(14.51, 23.07)];
                [bezier6Path addCurveToPoint:CGPointMake(14.88, 23) controlPoint1:CGPointMake(14.7, 23.01) controlPoint2:CGPointMake(14.78, 23)];
                [bezier6Path addLineToPoint:CGPointMake(15.17, 22.99)];
                [bezier6Path addCurveToPoint:CGPointMake(15.3, 22.98) controlPoint1:CGPointMake(15.22, 22.99) controlPoint2:CGPointMake(15.27, 22.99)];
                [bezier6Path addCurveToPoint:CGPointMake(15.38, 22.94) controlPoint1:CGPointMake(15.33, 22.97) controlPoint2:CGPointMake(15.36, 22.96)];
                [bezier6Path addCurveToPoint:CGPointMake(15.43, 22.86) controlPoint1:CGPointMake(15.41, 22.92) controlPoint2:CGPointMake(15.42, 22.9)];
                [bezier6Path addCurveToPoint:CGPointMake(15.44, 22.74) controlPoint1:CGPointMake(15.44, 22.83) controlPoint2:CGPointMake(15.44, 22.79)];
                [bezier6Path addLineToPoint:CGPointMake(15.44, 22.73)];
                [bezier6Path addCurveToPoint:CGPointMake(15.42, 22.6) controlPoint1:CGPointMake(15.44, 22.68) controlPoint2:CGPointMake(15.43, 22.64)];
                [bezier6Path addCurveToPoint:CGPointMake(15.36, 22.52) controlPoint1:CGPointMake(15.41, 22.57) controlPoint2:CGPointMake(15.39, 22.54)];
                [bezier6Path addCurveToPoint:CGPointMake(15.23, 22.47) controlPoint1:CGPointMake(15.33, 22.5) controlPoint2:CGPointMake(15.29, 22.48)];
                [bezier6Path addCurveToPoint:CGPointMake(15.02, 22.46) controlPoint1:CGPointMake(15.17, 22.46) controlPoint2:CGPointMake(15.1, 22.46)];
                [bezier6Path addCurveToPoint:CGPointMake(14.83, 22.47) controlPoint1:CGPointMake(14.95, 22.46) controlPoint2:CGPointMake(14.89, 22.46)];
                [bezier6Path addCurveToPoint:CGPointMake(14.69, 22.5) controlPoint1:CGPointMake(14.77, 22.48) controlPoint2:CGPointMake(14.73, 22.49)];
                [bezier6Path addCurveToPoint:CGPointMake(14.59, 22.54) controlPoint1:CGPointMake(14.65, 22.51) controlPoint2:CGPointMake(14.62, 22.52)];
                [bezier6Path addCurveToPoint:CGPointMake(14.49, 22.56) controlPoint1:CGPointMake(14.56, 22.55) controlPoint2:CGPointMake(14.53, 22.56)];
                [bezier6Path addLineToPoint:CGPointMake(14.48, 22.56)];
                [bezier6Path addCurveToPoint:CGPointMake(14.36, 22.51) controlPoint1:CGPointMake(14.43, 22.56) controlPoint2:CGPointMake(14.39, 22.54)];
                [bezier6Path addCurveToPoint:CGPointMake(14.32, 22.39) controlPoint1:CGPointMake(14.33, 22.48) controlPoint2:CGPointMake(14.32, 22.44)];
                [bezier6Path addLineToPoint:CGPointMake(14.32, 22.38)];
                [bezier6Path addCurveToPoint:CGPointMake(14.38, 22.27) controlPoint1:CGPointMake(14.32, 22.33) controlPoint2:CGPointMake(14.34, 22.3)];
                [bezier6Path addCurveToPoint:CGPointMake(14.54, 22.2) controlPoint1:CGPointMake(14.42, 22.24) controlPoint2:CGPointMake(14.47, 22.21)];
                [bezier6Path addCurveToPoint:CGPointMake(14.77, 22.16) controlPoint1:CGPointMake(14.61, 22.18) controlPoint2:CGPointMake(14.68, 22.17)];
                [bezier6Path addCurveToPoint:CGPointMake(15.03, 22.14) controlPoint1:CGPointMake(14.84, 22.14) controlPoint2:CGPointMake(14.93, 22.14)];
                [bezier6Path closePath];
                bezier6Path.miterLimit = 4;

                [fillColor setFill];
                [bezier6Path fill];

                //// Bezier 7 Drawing
                UIBezierPath *bezier7Path = [UIBezierPath bezierPath];
                [bezier7Path moveToPoint:CGPointMake(18.01, 23.62)];
                [bezier7Path addCurveToPoint:CGPointMake(17.98, 23.85) controlPoint1:CGPointMake(18.01, 23.71) controlPoint2:CGPointMake(18, 23.78)];
                [bezier7Path addCurveToPoint:CGPointMake(17.87, 24.02) controlPoint1:CGPointMake(17.96, 23.92) controlPoint2:CGPointMake(17.92, 23.98)];
                [bezier7Path addCurveToPoint:CGPointMake(17.63, 24.13) controlPoint1:CGPointMake(17.81, 24.07) controlPoint2:CGPointMake(17.74, 24.1)];
                [bezier7Path addCurveToPoint:CGPointMake(17.23, 24.17) controlPoint1:CGPointMake(17.53, 24.15) controlPoint2:CGPointMake(17.39, 24.17)];
                [bezier7Path addCurveToPoint:CGPointMake(16.84, 24.13) controlPoint1:CGPointMake(17.07, 24.17) controlPoint2:CGPointMake(16.94, 24.16)];
                [bezier7Path addCurveToPoint:CGPointMake(16.62, 24.02) controlPoint1:CGPointMake(16.74, 24.1) controlPoint2:CGPointMake(16.67, 24.07)];
                [bezier7Path addCurveToPoint:CGPointMake(16.51, 23.85) controlPoint1:CGPointMake(16.57, 23.97) controlPoint2:CGPointMake(16.53, 23.91)];
                [bezier7Path addCurveToPoint:CGPointMake(16.48, 23.63) controlPoint1:CGPointMake(16.49, 23.78) controlPoint2:CGPointMake(16.48, 23.71)];
                [bezier7Path addCurveToPoint:CGPointMake(16.49, 23.46) controlPoint1:CGPointMake(16.48, 23.56) controlPoint2:CGPointMake(16.48, 23.51)];
                [bezier7Path addCurveToPoint:CGPointMake(16.52, 23.35) controlPoint1:CGPointMake(16.49, 23.42) controlPoint2:CGPointMake(16.5, 23.38)];
                [bezier7Path addCurveToPoint:CGPointMake(16.6, 23.27) controlPoint1:CGPointMake(16.54, 23.32) controlPoint2:CGPointMake(16.56, 23.29)];
                [bezier7Path addCurveToPoint:CGPointMake(16.77, 23.18) controlPoint1:CGPointMake(16.64, 23.24) controlPoint2:CGPointMake(16.7, 23.21)];
                [bezier7Path addCurveToPoint:CGPointMake(16.6, 23.11) controlPoint1:CGPointMake(16.7, 23.15) controlPoint2:CGPointMake(16.64, 23.13)];
                [bezier7Path addCurveToPoint:CGPointMake(16.51, 23.03) controlPoint1:CGPointMake(16.56, 23.09) controlPoint2:CGPointMake(16.53, 23.06)];
                [bezier7Path addCurveToPoint:CGPointMake(16.48, 22.91) controlPoint1:CGPointMake(16.49, 23) controlPoint2:CGPointMake(16.48, 22.96)];
                [bezier7Path addCurveToPoint:CGPointMake(16.47, 22.71) controlPoint1:CGPointMake(16.47, 22.86) controlPoint2:CGPointMake(16.47, 22.79)];
                [bezier7Path addCurveToPoint:CGPointMake(16.51, 22.44) controlPoint1:CGPointMake(16.47, 22.6) controlPoint2:CGPointMake(16.48, 22.51)];
                [bezier7Path addCurveToPoint:CGPointMake(16.64, 22.27) controlPoint1:CGPointMake(16.54, 22.37) controlPoint2:CGPointMake(16.58, 22.31)];
                [bezier7Path addCurveToPoint:CGPointMake(16.87, 22.18) controlPoint1:CGPointMake(16.7, 22.23) controlPoint2:CGPointMake(16.78, 22.2)];
                [bezier7Path addCurveToPoint:CGPointMake(17.22, 22.15) controlPoint1:CGPointMake(16.97, 22.16) controlPoint2:CGPointMake(17.08, 22.15)];
                [bezier7Path addCurveToPoint:CGPointMake(17.58, 22.18) controlPoint1:CGPointMake(17.36, 22.15) controlPoint2:CGPointMake(17.48, 22.16)];
                [bezier7Path addCurveToPoint:CGPointMake(17.82, 22.27) controlPoint1:CGPointMake(17.68, 22.2) controlPoint2:CGPointMake(17.76, 22.23)];
                [bezier7Path addCurveToPoint:CGPointMake(17.95, 22.44) controlPoint1:CGPointMake(17.88, 22.31) controlPoint2:CGPointMake(17.93, 22.37)];
                [bezier7Path addCurveToPoint:CGPointMake(17.99, 22.7) controlPoint1:CGPointMake(17.98, 22.51) controlPoint2:CGPointMake(17.99, 22.6)];
                [bezier7Path addCurveToPoint:CGPointMake(17.99, 22.9) controlPoint1:CGPointMake(17.99, 22.78) controlPoint2:CGPointMake(17.99, 22.85)];
                [bezier7Path addCurveToPoint:CGPointMake(17.96, 23.02) controlPoint1:CGPointMake(17.99, 22.95) controlPoint2:CGPointMake(17.98, 22.99)];
                [bezier7Path addCurveToPoint:CGPointMake(17.88, 23.1) controlPoint1:CGPointMake(17.94, 23.05) controlPoint2:CGPointMake(17.91, 23.08)];
                [bezier7Path addCurveToPoint:CGPointMake(17.73, 23.17) controlPoint1:CGPointMake(17.84, 23.12) controlPoint2:CGPointMake(17.79, 23.14)];
                [bezier7Path addCurveToPoint:CGPointMake(17.89, 23.25) controlPoint1:CGPointMake(17.8, 23.2) controlPoint2:CGPointMake(17.85, 23.23)];
                [bezier7Path addCurveToPoint:CGPointMake(17.97, 23.33) controlPoint1:CGPointMake(17.93, 23.27) controlPoint2:CGPointMake(17.96, 23.3)];
                [bezier7Path addCurveToPoint:CGPointMake(18, 23.45) controlPoint1:CGPointMake(17.99, 23.36) controlPoint2:CGPointMake(18, 23.4)];
                [bezier7Path addCurveToPoint:CGPointMake(18.01, 23.62) controlPoint1:CGPointMake(18.01, 23.48) controlPoint2:CGPointMake(18.01, 23.54)];
                [bezier7Path closePath];
                [bezier7Path moveToPoint:CGPointMake(17.62, 23.58)];
                [bezier7Path addCurveToPoint:CGPointMake(17.61, 23.55) controlPoint1:CGPointMake(17.62, 23.58) controlPoint2:CGPointMake(17.61, 23.57)];
                [bezier7Path addCurveToPoint:CGPointMake(17.56, 23.48) controlPoint1:CGPointMake(17.6, 23.53) controlPoint2:CGPointMake(17.59, 23.51)];
                [bezier7Path addCurveToPoint:CGPointMake(17.45, 23.39) controlPoint1:CGPointMake(17.54, 23.45) controlPoint2:CGPointMake(17.5, 23.42)];
                [bezier7Path addCurveToPoint:CGPointMake(17.24, 23.3) controlPoint1:CGPointMake(17.4, 23.35) controlPoint2:CGPointMake(17.33, 23.33)];
                [bezier7Path addCurveToPoint:CGPointMake(17.04, 23.4) controlPoint1:CGPointMake(17.15, 23.33) controlPoint2:CGPointMake(17.08, 23.36)];
                [bezier7Path addCurveToPoint:CGPointMake(16.93, 23.49) controlPoint1:CGPointMake(16.99, 23.43) controlPoint2:CGPointMake(16.96, 23.47)];
                [bezier7Path addCurveToPoint:CGPointMake(16.88, 23.57) controlPoint1:CGPointMake(16.9, 23.52) controlPoint2:CGPointMake(16.89, 23.55)];
                [bezier7Path addCurveToPoint:CGPointMake(16.87, 23.61) controlPoint1:CGPointMake(16.87, 23.59) controlPoint2:CGPointMake(16.87, 23.61)];
                [bezier7Path addLineToPoint:CGPointMake(16.87, 23.61)];
                [bezier7Path addCurveToPoint:CGPointMake(16.89, 23.71) controlPoint1:CGPointMake(16.87, 23.65) controlPoint2:CGPointMake(16.87, 23.69)];
                [bezier7Path addCurveToPoint:CGPointMake(16.95, 23.78) controlPoint1:CGPointMake(16.9, 23.74) controlPoint2:CGPointMake(16.92, 23.76)];
                [bezier7Path addCurveToPoint:CGPointMake(17.07, 23.82) controlPoint1:CGPointMake(16.98, 23.8) controlPoint2:CGPointMake(17.02, 23.81)];
                [bezier7Path addCurveToPoint:CGPointMake(17.26, 23.83) controlPoint1:CGPointMake(17.12, 23.83) controlPoint2:CGPointMake(17.19, 23.83)];
                [bezier7Path addCurveToPoint:CGPointMake(17.43, 23.82) controlPoint1:CGPointMake(17.33, 23.83) controlPoint2:CGPointMake(17.39, 23.83)];
                [bezier7Path addCurveToPoint:CGPointMake(17.54, 23.78) controlPoint1:CGPointMake(17.48, 23.81) controlPoint2:CGPointMake(17.51, 23.8)];
                [bezier7Path addCurveToPoint:CGPointMake(17.6, 23.71) controlPoint1:CGPointMake(17.57, 23.76) controlPoint2:CGPointMake(17.59, 23.74)];
                [bezier7Path addCurveToPoint:CGPointMake(17.62, 23.61) controlPoint1:CGPointMake(17.61, 23.68) controlPoint2:CGPointMake(17.62, 23.65)];
                [bezier7Path addLineToPoint:CGPointMake(17.62, 23.58)];
                [bezier7Path closePath];
                [bezier7Path moveToPoint:CGPointMake(17.25, 23)];
                [bezier7Path addCurveToPoint:CGPointMake(17.46, 22.95) controlPoint1:CGPointMake(17.34, 22.98) controlPoint2:CGPointMake(17.41, 22.96)];
                [bezier7Path addCurveToPoint:CGPointMake(17.57, 22.9) controlPoint1:CGPointMake(17.51, 22.93) controlPoint2:CGPointMake(17.54, 22.92)];
                [bezier7Path addCurveToPoint:CGPointMake(17.61, 22.81) controlPoint1:CGPointMake(17.59, 22.88) controlPoint2:CGPointMake(17.61, 22.85)];
                [bezier7Path addCurveToPoint:CGPointMake(17.62, 22.66) controlPoint1:CGPointMake(17.61, 22.78) controlPoint2:CGPointMake(17.62, 22.73)];
                [bezier7Path addCurveToPoint:CGPointMake(17.6, 22.56) controlPoint1:CGPointMake(17.62, 22.62) controlPoint2:CGPointMake(17.61, 22.58)];
                [bezier7Path addCurveToPoint:CGPointMake(17.52, 22.5) controlPoint1:CGPointMake(17.58, 22.53) controlPoint2:CGPointMake(17.56, 22.51)];
                [bezier7Path addCurveToPoint:CGPointMake(17.4, 22.48) controlPoint1:CGPointMake(17.49, 22.49) controlPoint2:CGPointMake(17.45, 22.48)];
                [bezier7Path addCurveToPoint:CGPointMake(17.25, 22.47) controlPoint1:CGPointMake(17.36, 22.48) controlPoint2:CGPointMake(17.31, 22.47)];
                [bezier7Path addCurveToPoint:CGPointMake(17.09, 22.48) controlPoint1:CGPointMake(17.18, 22.47) controlPoint2:CGPointMake(17.13, 22.47)];
                [bezier7Path addCurveToPoint:CGPointMake(16.97, 22.51) controlPoint1:CGPointMake(17.04, 22.48) controlPoint2:CGPointMake(17.01, 22.5)];
                [bezier7Path addCurveToPoint:CGPointMake(16.91, 22.58) controlPoint1:CGPointMake(16.94, 22.53) controlPoint2:CGPointMake(16.92, 22.55)];
                [bezier7Path addCurveToPoint:CGPointMake(16.89, 22.71) controlPoint1:CGPointMake(16.89, 22.61) controlPoint2:CGPointMake(16.89, 22.65)];
                [bezier7Path addCurveToPoint:CGPointMake(16.89, 22.83) controlPoint1:CGPointMake(16.89, 22.76) controlPoint2:CGPointMake(16.89, 22.8)];
                [bezier7Path addCurveToPoint:CGPointMake(16.93, 22.9) controlPoint1:CGPointMake(16.9, 22.86) controlPoint2:CGPointMake(16.91, 22.88)];
                [bezier7Path addCurveToPoint:CGPointMake(17.04, 22.95) controlPoint1:CGPointMake(16.96, 22.92) controlPoint2:CGPointMake(16.99, 22.93)];
                [bezier7Path addCurveToPoint:CGPointMake(17.25, 23) controlPoint1:CGPointMake(17.09, 22.95) controlPoint2:CGPointMake(17.16, 22.97)];
                [bezier7Path closePath];
                bezier7Path.miterLimit = 4;

                [fillColor setFill];
                [bezier7Path fill];

                //// Bezier 8 Drawing
                UIBezierPath *bezier8Path = [UIBezierPath bezierPath];
                [bezier8Path moveToPoint:CGPointMake(20.2, 23.62)];
                [bezier8Path addLineToPoint:CGPointMake(20.2, 23.62)];
                [bezier8Path addCurveToPoint:CGPointMake(20.15, 23.88) controlPoint1:CGPointMake(20.2, 23.72) controlPoint2:CGPointMake(20.18, 23.81)];
                [bezier8Path addCurveToPoint:CGPointMake(20, 24.05) controlPoint1:CGPointMake(20.11, 23.95) controlPoint2:CGPointMake(20.06, 24.01)];
                [bezier8Path addCurveToPoint:CGPointMake(19.76, 24.14) controlPoint1:CGPointMake(19.93, 24.09) controlPoint2:CGPointMake(19.85, 24.12)];
                [bezier8Path addCurveToPoint:CGPointMake(19.45, 24.17) controlPoint1:CGPointMake(19.67, 24.16) controlPoint2:CGPointMake(19.56, 24.17)];
                [bezier8Path addCurveToPoint:CGPointMake(19.14, 24.14) controlPoint1:CGPointMake(19.33, 24.17) controlPoint2:CGPointMake(19.23, 24.16)];
                [bezier8Path addCurveToPoint:CGPointMake(18.91, 24.05) controlPoint1:CGPointMake(19.05, 24.12) controlPoint2:CGPointMake(18.97, 24.09)];
                [bezier8Path addCurveToPoint:CGPointMake(18.76, 23.88) controlPoint1:CGPointMake(18.85, 24.01) controlPoint2:CGPointMake(18.8, 23.95)];
                [bezier8Path addCurveToPoint:CGPointMake(18.71, 23.64) controlPoint1:CGPointMake(18.72, 23.81) controlPoint2:CGPointMake(18.71, 23.73)];
                [bezier8Path addLineToPoint:CGPointMake(18.71, 22.67)];
                [bezier8Path addCurveToPoint:CGPointMake(18.91, 22.28) controlPoint1:CGPointMake(18.71, 22.5) controlPoint2:CGPointMake(18.78, 22.37)];
                [bezier8Path addCurveToPoint:CGPointMake(19.47, 22.15) controlPoint1:CGPointMake(19.04, 22.19) controlPoint2:CGPointMake(19.23, 22.15)];
                [bezier8Path addCurveToPoint:CGPointMake(19.77, 22.18) controlPoint1:CGPointMake(19.58, 22.15) controlPoint2:CGPointMake(19.68, 22.16)];
                [bezier8Path addCurveToPoint:CGPointMake(20, 22.28) controlPoint1:CGPointMake(19.86, 22.2) controlPoint2:CGPointMake(19.94, 22.24)];
                [bezier8Path addCurveToPoint:CGPointMake(20.15, 22.44) controlPoint1:CGPointMake(20.07, 22.32) controlPoint2:CGPointMake(20.12, 22.38)];
                [bezier8Path addCurveToPoint:CGPointMake(20.2, 22.68) controlPoint1:CGPointMake(20.19, 22.51) controlPoint2:CGPointMake(20.2, 22.59)];
                [bezier8Path addLineToPoint:CGPointMake(20.2, 23.62)];
                [bezier8Path closePath];
                [bezier8Path moveToPoint:CGPointMake(19.81, 22.69)];
                [bezier8Path addCurveToPoint:CGPointMake(19.72, 22.52) controlPoint1:CGPointMake(19.81, 22.62) controlPoint2:CGPointMake(19.78, 22.56)];
                [bezier8Path addCurveToPoint:CGPointMake(19.45, 22.46) controlPoint1:CGPointMake(19.66, 22.48) controlPoint2:CGPointMake(19.57, 22.46)];
                [bezier8Path addCurveToPoint:CGPointMake(19.18, 22.52) controlPoint1:CGPointMake(19.33, 22.46) controlPoint2:CGPointMake(19.24, 22.48)];
                [bezier8Path addCurveToPoint:CGPointMake(19.09, 22.68) controlPoint1:CGPointMake(19.12, 22.56) controlPoint2:CGPointMake(19.09, 22.61)];
                [bezier8Path addLineToPoint:CGPointMake(19.09, 23.63)];
                [bezier8Path addCurveToPoint:CGPointMake(19.18, 23.8) controlPoint1:CGPointMake(19.09, 23.71) controlPoint2:CGPointMake(19.12, 23.76)];
                [bezier8Path addCurveToPoint:CGPointMake(19.45, 23.85) controlPoint1:CGPointMake(19.24, 23.83) controlPoint2:CGPointMake(19.33, 23.85)];
                [bezier8Path addCurveToPoint:CGPointMake(19.72, 23.8) controlPoint1:CGPointMake(19.56, 23.85) controlPoint2:CGPointMake(19.65, 23.83)];
                [bezier8Path addCurveToPoint:CGPointMake(19.82, 23.63) controlPoint1:CGPointMake(19.79, 23.77) controlPoint2:CGPointMake(19.82, 23.71)];
                [bezier8Path addLineToPoint:CGPointMake(19.82, 22.69)];
                [bezier8Path addLineToPoint:CGPointMake(19.81, 22.69)];
                [bezier8Path closePath];
                bezier8Path.miterLimit = 4;

                [fillColor setFill];
                [bezier8Path fill];

                //// Bezier 9 Drawing
                UIBezierPath *bezier9Path = [UIBezierPath bezierPath];
                [bezier9Path moveToPoint:CGPointMake(22.4, 23.62)];
                [bezier9Path addLineToPoint:CGPointMake(22.4, 23.62)];
                [bezier9Path addCurveToPoint:CGPointMake(22.35, 23.88) controlPoint1:CGPointMake(22.41, 23.72) controlPoint2:CGPointMake(22.38, 23.81)];
                [bezier9Path addCurveToPoint:CGPointMake(22.2, 24.05) controlPoint1:CGPointMake(22.31, 23.95) controlPoint2:CGPointMake(22.26, 24.01)];
                [bezier9Path addCurveToPoint:CGPointMake(21.96, 24.14) controlPoint1:CGPointMake(22.13, 24.09) controlPoint2:CGPointMake(22.05, 24.12)];
                [bezier9Path addCurveToPoint:CGPointMake(21.65, 24.17) controlPoint1:CGPointMake(21.86, 24.16) controlPoint2:CGPointMake(21.76, 24.17)];
                [bezier9Path addCurveToPoint:CGPointMake(21.34, 24.14) controlPoint1:CGPointMake(21.53, 24.17) controlPoint2:CGPointMake(21.43, 24.16)];
                [bezier9Path addCurveToPoint:CGPointMake(21.1, 24.05) controlPoint1:CGPointMake(21.25, 24.12) controlPoint2:CGPointMake(21.17, 24.09)];
                [bezier9Path addCurveToPoint:CGPointMake(20.95, 23.88) controlPoint1:CGPointMake(21.04, 24.01) controlPoint2:CGPointMake(20.99, 23.95)];
                [bezier9Path addCurveToPoint:CGPointMake(20.9, 23.64) controlPoint1:CGPointMake(20.92, 23.81) controlPoint2:CGPointMake(20.9, 23.73)];
                [bezier9Path addLineToPoint:CGPointMake(20.9, 22.67)];
                [bezier9Path addCurveToPoint:CGPointMake(21.1, 22.28) controlPoint1:CGPointMake(20.9, 22.5) controlPoint2:CGPointMake(20.97, 22.37)];
                [bezier9Path addCurveToPoint:CGPointMake(21.66, 22.15) controlPoint1:CGPointMake(21.23, 22.19) controlPoint2:CGPointMake(21.42, 22.15)];
                [bezier9Path addCurveToPoint:CGPointMake(21.96, 22.18) controlPoint1:CGPointMake(21.77, 22.15) controlPoint2:CGPointMake(21.87, 22.16)];
                [bezier9Path addCurveToPoint:CGPointMake(22.19, 22.28) controlPoint1:CGPointMake(22.05, 22.2) controlPoint2:CGPointMake(22.13, 22.24)];
                [bezier9Path addCurveToPoint:CGPointMake(22.34, 22.44) controlPoint1:CGPointMake(22.26, 22.32) controlPoint2:CGPointMake(22.31, 22.38)];
                [bezier9Path addCurveToPoint:CGPointMake(22.39, 22.68) controlPoint1:CGPointMake(22.38, 22.51) controlPoint2:CGPointMake(22.39, 22.59)];
                [bezier9Path addLineToPoint:CGPointMake(22.39, 23.62)];
                [bezier9Path addLineToPoint:CGPointMake(22.4, 23.62)];
                [bezier9Path closePath];
                [bezier9Path moveToPoint:CGPointMake(22, 22.69)];
                [bezier9Path addCurveToPoint:CGPointMake(21.91, 22.52) controlPoint1:CGPointMake(22, 22.62) controlPoint2:CGPointMake(21.97, 22.56)];
                [bezier9Path addCurveToPoint:CGPointMake(21.64, 22.46) controlPoint1:CGPointMake(21.85, 22.48) controlPoint2:CGPointMake(21.76, 22.46)];
                [bezier9Path addCurveToPoint:CGPointMake(21.37, 22.52) controlPoint1:CGPointMake(21.52, 22.46) controlPoint2:CGPointMake(21.43, 22.48)];
                [bezier9Path addCurveToPoint:CGPointMake(21.28, 22.68) controlPoint1:CGPointMake(21.31, 22.56) controlPoint2:CGPointMake(21.28, 22.61)];
                [bezier9Path addLineToPoint:CGPointMake(21.28, 23.63)];
                [bezier9Path addCurveToPoint:CGPointMake(21.37, 23.8) controlPoint1:CGPointMake(21.28, 23.71) controlPoint2:CGPointMake(21.31, 23.76)];
                [bezier9Path addCurveToPoint:CGPointMake(21.63, 23.85) controlPoint1:CGPointMake(21.42, 23.83) controlPoint2:CGPointMake(21.51, 23.85)];
                [bezier9Path addCurveToPoint:CGPointMake(21.9, 23.8) controlPoint1:CGPointMake(21.74, 23.85) controlPoint2:CGPointMake(21.83, 23.83)];
                [bezier9Path addCurveToPoint:CGPointMake(22, 23.63) controlPoint1:CGPointMake(21.96, 23.77) controlPoint2:CGPointMake(22, 23.71)];
                [bezier9Path addLineToPoint:CGPointMake(22, 22.69)];
                [bezier9Path closePath];
                bezier9Path.miterLimit = 4;

                [fillColor setFill];
                [bezier9Path fill];

                //// Bezier 10 Drawing
                UIBezierPath *bezier10Path = [UIBezierPath bezierPath];
                [bezier10Path moveToPoint:CGPointMake(25.63, 23.01)];
                [bezier10Path addCurveToPoint:CGPointMake(25.81, 23.1) controlPoint1:CGPointMake(25.7, 23.03) controlPoint2:CGPointMake(25.76, 23.06)];
                [bezier10Path addCurveToPoint:CGPointMake(25.9, 23.28) controlPoint1:CGPointMake(25.86, 23.14) controlPoint2:CGPointMake(25.89, 23.2)];
                [bezier10Path addCurveToPoint:CGPointMake(25.93, 23.56) controlPoint1:CGPointMake(25.92, 23.35) controlPoint2:CGPointMake(25.93, 23.45)];
                [bezier10Path addCurveToPoint:CGPointMake(25.9, 23.85) controlPoint1:CGPointMake(25.93, 23.68) controlPoint2:CGPointMake(25.92, 23.77)];
                [bezier10Path addCurveToPoint:CGPointMake(25.77, 24.03) controlPoint1:CGPointMake(25.87, 23.93) controlPoint2:CGPointMake(25.83, 23.99)];
                [bezier10Path addCurveToPoint:CGPointMake(25.52, 24.13) controlPoint1:CGPointMake(25.71, 24.08) controlPoint2:CGPointMake(25.63, 24.11)];
                [bezier10Path addCurveToPoint:CGPointMake(25.12, 24.16) controlPoint1:CGPointMake(25.42, 24.15) controlPoint2:CGPointMake(25.28, 24.16)];
                [bezier10Path addLineToPoint:CGPointMake(25.04, 24.16)];
                [bezier10Path addCurveToPoint:CGPointMake(24.84, 24.15) controlPoint1:CGPointMake(24.98, 24.16) controlPoint2:CGPointMake(24.91, 24.16)];
                [bezier10Path addCurveToPoint:CGPointMake(24.64, 24.12) controlPoint1:CGPointMake(24.77, 24.15) controlPoint2:CGPointMake(24.7, 24.14)];
                [bezier10Path addCurveToPoint:CGPointMake(24.48, 24.04) controlPoint1:CGPointMake(24.58, 24.1) controlPoint2:CGPointMake(24.53, 24.07)];
                [bezier10Path addCurveToPoint:CGPointMake(24.41, 23.89) controlPoint1:CGPointMake(24.44, 24) controlPoint2:CGPointMake(24.41, 23.95)];
                [bezier10Path addLineToPoint:CGPointMake(24.41, 23.89)];
                [bezier10Path addCurveToPoint:CGPointMake(24.46, 23.78) controlPoint1:CGPointMake(24.41, 23.84) controlPoint2:CGPointMake(24.43, 23.81)];
                [bezier10Path addCurveToPoint:CGPointMake(24.58, 23.73) controlPoint1:CGPointMake(24.5, 23.75) controlPoint2:CGPointMake(24.54, 23.73)];
                [bezier10Path addLineToPoint:CGPointMake(24.59, 23.73)];
                [bezier10Path addCurveToPoint:CGPointMake(24.68, 23.74) controlPoint1:CGPointMake(24.63, 23.73) controlPoint2:CGPointMake(24.66, 23.74)];
                [bezier10Path addCurveToPoint:CGPointMake(24.73, 23.76) controlPoint1:CGPointMake(24.7, 23.75) controlPoint2:CGPointMake(24.72, 23.76)];
                [bezier10Path addCurveToPoint:CGPointMake(24.78, 23.79) controlPoint1:CGPointMake(24.75, 23.77) controlPoint2:CGPointMake(24.76, 23.78)];
                [bezier10Path addCurveToPoint:CGPointMake(24.84, 23.82) controlPoint1:CGPointMake(24.8, 23.8) controlPoint2:CGPointMake(24.82, 23.81)];
                [bezier10Path addCurveToPoint:CGPointMake(24.96, 23.84) controlPoint1:CGPointMake(24.87, 23.83) controlPoint2:CGPointMake(24.91, 23.83)];
                [bezier10Path addCurveToPoint:CGPointMake(25.15, 23.85) controlPoint1:CGPointMake(25.02, 23.85) controlPoint2:CGPointMake(25.08, 23.85)];
                [bezier10Path addCurveToPoint:CGPointMake(25.35, 23.83) controlPoint1:CGPointMake(25.23, 23.85) controlPoint2:CGPointMake(25.29, 23.85)];
                [bezier10Path addCurveToPoint:CGPointMake(25.47, 23.78) controlPoint1:CGPointMake(25.4, 23.82) controlPoint2:CGPointMake(25.44, 23.8)];
                [bezier10Path addCurveToPoint:CGPointMake(25.53, 23.69) controlPoint1:CGPointMake(25.5, 23.76) controlPoint2:CGPointMake(25.52, 23.73)];
                [bezier10Path addCurveToPoint:CGPointMake(25.54, 23.56) controlPoint1:CGPointMake(25.54, 23.65) controlPoint2:CGPointMake(25.54, 23.61)];
                [bezier10Path addCurveToPoint:CGPointMake(25.51, 23.37) controlPoint1:CGPointMake(25.54, 23.47) controlPoint2:CGPointMake(25.53, 23.41)];
                [bezier10Path addCurveToPoint:CGPointMake(25.38, 23.31) controlPoint1:CGPointMake(25.49, 23.33) controlPoint2:CGPointMake(25.45, 23.31)];
                [bezier10Path addLineToPoint:CGPointMake(24.71, 23.31)];
                [bezier10Path addCurveToPoint:CGPointMake(24.58, 23.3) controlPoint1:CGPointMake(24.66, 23.31) controlPoint2:CGPointMake(24.61, 23.31)];
                [bezier10Path addCurveToPoint:CGPointMake(24.5, 23.27) controlPoint1:CGPointMake(24.54, 23.29) controlPoint2:CGPointMake(24.52, 23.28)];
                [bezier10Path addCurveToPoint:CGPointMake(24.46, 23.2) controlPoint1:CGPointMake(24.48, 23.25) controlPoint2:CGPointMake(24.47, 23.23)];
                [bezier10Path addCurveToPoint:CGPointMake(24.45, 23.08) controlPoint1:CGPointMake(24.46, 23.17) controlPoint2:CGPointMake(24.45, 23.13)];
                [bezier10Path addLineToPoint:CGPointMake(24.45, 22.34)];
                [bezier10Path addCurveToPoint:CGPointMake(24.5, 22.21) controlPoint1:CGPointMake(24.45, 22.29) controlPoint2:CGPointMake(24.47, 22.24)];
                [bezier10Path addCurveToPoint:CGPointMake(24.67, 22.17) controlPoint1:CGPointMake(24.53, 22.18) controlPoint2:CGPointMake(24.59, 22.17)];
                [bezier10Path addCurveToPoint:CGPointMake(24.79, 22.17) controlPoint1:CGPointMake(24.69, 22.17) controlPoint2:CGPointMake(24.74, 22.17)];
                [bezier10Path addCurveToPoint:CGPointMake(24.97, 22.17) controlPoint1:CGPointMake(24.84, 22.17) controlPoint2:CGPointMake(24.9, 22.17)];
                [bezier10Path addCurveToPoint:CGPointMake(25.18, 22.17) controlPoint1:CGPointMake(25.04, 22.17) controlPoint2:CGPointMake(25.1, 22.17)];
                [bezier10Path addCurveToPoint:CGPointMake(25.38, 22.17) controlPoint1:CGPointMake(25.25, 22.17) controlPoint2:CGPointMake(25.32, 22.17)];
                [bezier10Path addCurveToPoint:CGPointMake(25.54, 22.17) controlPoint1:CGPointMake(25.44, 22.17) controlPoint2:CGPointMake(25.49, 22.17)];
                [bezier10Path addCurveToPoint:CGPointMake(25.62, 22.17) controlPoint1:CGPointMake(25.58, 22.17) controlPoint2:CGPointMake(25.61, 22.17)];
                [bezier10Path addCurveToPoint:CGPointMake(25.69, 22.18) controlPoint1:CGPointMake(25.64, 22.17) controlPoint2:CGPointMake(25.67, 22.17)];
                [bezier10Path addCurveToPoint:CGPointMake(25.76, 22.2) controlPoint1:CGPointMake(25.72, 22.18) controlPoint2:CGPointMake(25.74, 22.19)];
                [bezier10Path addCurveToPoint:CGPointMake(25.82, 22.25) controlPoint1:CGPointMake(25.78, 22.21) controlPoint2:CGPointMake(25.8, 22.23)];
                [bezier10Path addCurveToPoint:CGPointMake(25.85, 22.33) controlPoint1:CGPointMake(25.84, 22.27) controlPoint2:CGPointMake(25.85, 22.3)];
                [bezier10Path addLineToPoint:CGPointMake(25.85, 22.34)];
                [bezier10Path addCurveToPoint:CGPointMake(25.83, 22.43) controlPoint1:CGPointMake(25.85, 22.38) controlPoint2:CGPointMake(25.84, 22.41)];
                [bezier10Path addCurveToPoint:CGPointMake(25.78, 22.48) controlPoint1:CGPointMake(25.82, 22.45) controlPoint2:CGPointMake(25.8, 22.47)];
                [bezier10Path addCurveToPoint:CGPointMake(25.71, 22.5) controlPoint1:CGPointMake(25.76, 22.49) controlPoint2:CGPointMake(25.73, 22.5)];
                [bezier10Path addCurveToPoint:CGPointMake(25.62, 22.5) controlPoint1:CGPointMake(25.68, 22.5) controlPoint2:CGPointMake(25.65, 22.5)];
                [bezier10Path addLineToPoint:CGPointMake(24.84, 22.5)];
                [bezier10Path addLineToPoint:CGPointMake(24.84, 23.01)];
                [bezier10Path addLineToPoint:CGPointMake(25.36, 23.01)];
                [bezier10Path addCurveToPoint:CGPointMake(25.63, 23.01) controlPoint1:CGPointMake(25.47, 22.99) controlPoint2:CGPointMake(25.56, 22.99)];
                [bezier10Path closePath];
                bezier10Path.miterLimit = 4;

                [fillColor setFill];
                [bezier10Path fill];

                //// Bezier 11 Drawing
                UIBezierPath *bezier11Path = [UIBezierPath bezierPath];
                [bezier11Path moveToPoint:CGPointMake(28.11, 23.62)];
                [bezier11Path addLineToPoint:CGPointMake(28.11, 23.62)];
                [bezier11Path addCurveToPoint:CGPointMake(28.06, 23.88) controlPoint1:CGPointMake(28.11, 23.72) controlPoint2:CGPointMake(28.09, 23.81)];
                [bezier11Path addCurveToPoint:CGPointMake(27.9, 24.05) controlPoint1:CGPointMake(28.02, 23.95) controlPoint2:CGPointMake(27.97, 24.01)];
                [bezier11Path addCurveToPoint:CGPointMake(27.66, 24.14) controlPoint1:CGPointMake(27.83, 24.09) controlPoint2:CGPointMake(27.75, 24.12)];
                [bezier11Path addCurveToPoint:CGPointMake(27.35, 24.17) controlPoint1:CGPointMake(27.57, 24.16) controlPoint2:CGPointMake(27.46, 24.17)];
                [bezier11Path addCurveToPoint:CGPointMake(27.04, 24.14) controlPoint1:CGPointMake(27.24, 24.17) controlPoint2:CGPointMake(27.13, 24.16)];
                [bezier11Path addCurveToPoint:CGPointMake(26.8, 24.05) controlPoint1:CGPointMake(26.95, 24.12) controlPoint2:CGPointMake(26.87, 24.09)];
                [bezier11Path addCurveToPoint:CGPointMake(26.65, 23.88) controlPoint1:CGPointMake(26.74, 24.01) controlPoint2:CGPointMake(26.69, 23.95)];
                [bezier11Path addCurveToPoint:CGPointMake(26.6, 23.64) controlPoint1:CGPointMake(26.62, 23.81) controlPoint2:CGPointMake(26.6, 23.73)];
                [bezier11Path addLineToPoint:CGPointMake(26.6, 22.67)];
                [bezier11Path addCurveToPoint:CGPointMake(26.8, 22.28) controlPoint1:CGPointMake(26.6, 22.5) controlPoint2:CGPointMake(26.67, 22.37)];
                [bezier11Path addCurveToPoint:CGPointMake(27.36, 22.15) controlPoint1:CGPointMake(26.94, 22.19) controlPoint2:CGPointMake(27.12, 22.15)];
                [bezier11Path addCurveToPoint:CGPointMake(27.67, 22.18) controlPoint1:CGPointMake(27.47, 22.15) controlPoint2:CGPointMake(27.57, 22.16)];
                [bezier11Path addCurveToPoint:CGPointMake(27.91, 22.28) controlPoint1:CGPointMake(27.76, 22.2) controlPoint2:CGPointMake(27.84, 22.24)];
                [bezier11Path addCurveToPoint:CGPointMake(28.06, 22.44) controlPoint1:CGPointMake(27.98, 22.32) controlPoint2:CGPointMake(28.02, 22.38)];
                [bezier11Path addCurveToPoint:CGPointMake(28.11, 22.68) controlPoint1:CGPointMake(28.09, 22.51) controlPoint2:CGPointMake(28.11, 22.59)];
                [bezier11Path addLineToPoint:CGPointMake(28.11, 23.62)];
                [bezier11Path closePath];
                [bezier11Path moveToPoint:CGPointMake(27.72, 22.69)];
                [bezier11Path addCurveToPoint:CGPointMake(27.63, 22.52) controlPoint1:CGPointMake(27.72, 22.62) controlPoint2:CGPointMake(27.69, 22.56)];
                [bezier11Path addCurveToPoint:CGPointMake(27.36, 22.46) controlPoint1:CGPointMake(27.57, 22.48) controlPoint2:CGPointMake(27.48, 22.46)];
                [bezier11Path addCurveToPoint:CGPointMake(27.09, 22.52) controlPoint1:CGPointMake(27.23, 22.46) controlPoint2:CGPointMake(27.15, 22.48)];
                [bezier11Path addCurveToPoint:CGPointMake(27, 22.67) controlPoint1:CGPointMake(27.03, 22.56) controlPoint2:CGPointMake(27, 22.61)];
                [bezier11Path addLineToPoint:CGPointMake(27, 23.62)];
                [bezier11Path addCurveToPoint:CGPointMake(27.09, 23.79) controlPoint1:CGPointMake(27, 23.7) controlPoint2:CGPointMake(27.03, 23.75)];
                [bezier11Path addCurveToPoint:CGPointMake(27.36, 23.84) controlPoint1:CGPointMake(27.15, 23.82) controlPoint2:CGPointMake(27.24, 23.84)];
                [bezier11Path addCurveToPoint:CGPointMake(27.63, 23.79) controlPoint1:CGPointMake(27.48, 23.84) controlPoint2:CGPointMake(27.56, 23.82)];
                [bezier11Path addCurveToPoint:CGPointMake(27.73, 23.62) controlPoint1:CGPointMake(27.7, 23.76) controlPoint2:CGPointMake(27.73, 23.7)];
                [bezier11Path addLineToPoint:CGPointMake(27.73, 22.69)];
                [bezier11Path addLineToPoint:CGPointMake(27.72, 22.69)];
                [bezier11Path closePath];
                bezier11Path.miterLimit = 4;

                [fillColor setFill];
                [bezier11Path fill];

                //// Bezier 12 Drawing
                UIBezierPath *bezier12Path = [UIBezierPath bezierPath];
                [bezier12Path moveToPoint:CGPointMake(29.56, 22.14)];
                [bezier12Path addCurveToPoint:CGPointMake(29.93, 22.17) controlPoint1:CGPointMake(29.7, 22.14) controlPoint2:CGPointMake(29.83, 22.15)];
                [bezier12Path addCurveToPoint:CGPointMake(30.18, 22.27) controlPoint1:CGPointMake(30.03, 22.19) controlPoint2:CGPointMake(30.11, 22.22)];
                [bezier12Path addCurveToPoint:CGPointMake(30.32, 22.45) controlPoint1:CGPointMake(30.24, 22.31) controlPoint2:CGPointMake(30.29, 22.37)];
                [bezier12Path addCurveToPoint:CGPointMake(30.36, 22.72) controlPoint1:CGPointMake(30.35, 22.52) controlPoint2:CGPointMake(30.36, 22.61)];
                [bezier12Path addLineToPoint:CGPointMake(30.36, 22.73)];
                [bezier12Path addCurveToPoint:CGPointMake(30.33, 23.02) controlPoint1:CGPointMake(30.36, 22.84) controlPoint2:CGPointMake(30.35, 22.94)];
                [bezier12Path addCurveToPoint:CGPointMake(30.22, 23.2) controlPoint1:CGPointMake(30.31, 23.1) controlPoint2:CGPointMake(30.27, 23.15)];
                [bezier12Path addCurveToPoint:CGPointMake(30.02, 23.3) controlPoint1:CGPointMake(30.17, 23.25) controlPoint2:CGPointMake(30.1, 23.28)];
                [bezier12Path addCurveToPoint:CGPointMake(29.71, 23.33) controlPoint1:CGPointMake(29.94, 23.32) controlPoint2:CGPointMake(29.84, 23.33)];
                [bezier12Path addCurveToPoint:CGPointMake(29.45, 23.33) controlPoint1:CGPointMake(29.61, 23.33) controlPoint2:CGPointMake(29.52, 23.33)];
                [bezier12Path addCurveToPoint:CGPointMake(29.29, 23.37) controlPoint1:CGPointMake(29.38, 23.33) controlPoint2:CGPointMake(29.33, 23.35)];
                [bezier12Path addCurveToPoint:CGPointMake(29.21, 23.46) controlPoint1:CGPointMake(29.25, 23.39) controlPoint2:CGPointMake(29.22, 23.42)];
                [bezier12Path addCurveToPoint:CGPointMake(29.19, 23.65) controlPoint1:CGPointMake(29.2, 23.5) controlPoint2:CGPointMake(29.19, 23.57)];
                [bezier12Path addLineToPoint:CGPointMake(29.19, 23.83)];
                [bezier12Path addLineToPoint:CGPointMake(30.16, 23.83)];
                [bezier12Path addCurveToPoint:CGPointMake(30.24, 23.84) controlPoint1:CGPointMake(30.19, 23.83) controlPoint2:CGPointMake(30.21, 23.83)];
                [bezier12Path addCurveToPoint:CGPointMake(30.3, 23.87) controlPoint1:CGPointMake(30.26, 23.85) controlPoint2:CGPointMake(30.28, 23.86)];
                [bezier12Path addCurveToPoint:CGPointMake(30.35, 23.92) controlPoint1:CGPointMake(30.32, 23.88) controlPoint2:CGPointMake(30.34, 23.9)];
                [bezier12Path addCurveToPoint:CGPointMake(30.37, 23.99) controlPoint1:CGPointMake(30.36, 23.94) controlPoint2:CGPointMake(30.37, 23.96)];
                [bezier12Path addCurveToPoint:CGPointMake(30.35, 24.07) controlPoint1:CGPointMake(30.37, 24.02) controlPoint2:CGPointMake(30.37, 24.05)];
                [bezier12Path addCurveToPoint:CGPointMake(30.3, 24.12) controlPoint1:CGPointMake(30.34, 24.09) controlPoint2:CGPointMake(30.32, 24.11)];
                [bezier12Path addCurveToPoint:CGPointMake(30.23, 24.15) controlPoint1:CGPointMake(30.28, 24.13) controlPoint2:CGPointMake(30.26, 24.14)];
                [bezier12Path addCurveToPoint:CGPointMake(30.15, 24.16) controlPoint1:CGPointMake(30.21, 24.16) controlPoint2:CGPointMake(30.18, 24.16)];
                [bezier12Path addLineToPoint:CGPointMake(29, 24.16)];
                [bezier12Path addCurveToPoint:CGPointMake(28.83, 24.12) controlPoint1:CGPointMake(28.92, 24.16) controlPoint2:CGPointMake(28.86, 24.15)];
                [bezier12Path addCurveToPoint:CGPointMake(28.78, 23.99) controlPoint1:CGPointMake(28.8, 24.09) controlPoint2:CGPointMake(28.78, 24.05)];
                [bezier12Path addLineToPoint:CGPointMake(28.78, 23.59)];
                [bezier12Path addCurveToPoint:CGPointMake(28.82, 23.32) controlPoint1:CGPointMake(28.78, 23.48) controlPoint2:CGPointMake(28.8, 23.39)];
                [bezier12Path addCurveToPoint:CGPointMake(28.94, 23.14) controlPoint1:CGPointMake(28.85, 23.25) controlPoint2:CGPointMake(28.89, 23.19)];
                [bezier12Path addCurveToPoint:CGPointMake(29.13, 23.05) controlPoint1:CGPointMake(28.99, 23.1) controlPoint2:CGPointMake(29.06, 23.07)];
                [bezier12Path addCurveToPoint:CGPointMake(29.4, 23) controlPoint1:CGPointMake(29.22, 23.01) controlPoint2:CGPointMake(29.31, 23)];
                [bezier12Path addLineToPoint:CGPointMake(29.69, 22.99)];
                [bezier12Path addCurveToPoint:CGPointMake(29.82, 22.98) controlPoint1:CGPointMake(29.74, 22.99) controlPoint2:CGPointMake(29.79, 22.99)];
                [bezier12Path addCurveToPoint:CGPointMake(29.9, 22.94) controlPoint1:CGPointMake(29.85, 22.97) controlPoint2:CGPointMake(29.88, 22.96)];
                [bezier12Path addCurveToPoint:CGPointMake(29.94, 22.86) controlPoint1:CGPointMake(29.92, 22.92) controlPoint2:CGPointMake(29.94, 22.9)];
                [bezier12Path addCurveToPoint:CGPointMake(29.96, 22.74) controlPoint1:CGPointMake(29.95, 22.83) controlPoint2:CGPointMake(29.96, 22.79)];
                [bezier12Path addLineToPoint:CGPointMake(29.96, 22.73)];
                [bezier12Path addCurveToPoint:CGPointMake(29.94, 22.6) controlPoint1:CGPointMake(29.96, 22.68) controlPoint2:CGPointMake(29.95, 22.64)];
                [bezier12Path addCurveToPoint:CGPointMake(29.88, 22.52) controlPoint1:CGPointMake(29.93, 22.57) controlPoint2:CGPointMake(29.91, 22.54)];
                [bezier12Path addCurveToPoint:CGPointMake(29.75, 22.47) controlPoint1:CGPointMake(29.85, 22.5) controlPoint2:CGPointMake(29.81, 22.48)];
                [bezier12Path addCurveToPoint:CGPointMake(29.54, 22.46) controlPoint1:CGPointMake(29.7, 22.46) controlPoint2:CGPointMake(29.62, 22.46)];
                [bezier12Path addCurveToPoint:CGPointMake(29.35, 22.47) controlPoint1:CGPointMake(29.47, 22.46) controlPoint2:CGPointMake(29.41, 22.46)];
                [bezier12Path addCurveToPoint:CGPointMake(29.21, 22.5) controlPoint1:CGPointMake(29.29, 22.48) controlPoint2:CGPointMake(29.25, 22.49)];
                [bezier12Path addCurveToPoint:CGPointMake(29.11, 22.54) controlPoint1:CGPointMake(29.17, 22.51) controlPoint2:CGPointMake(29.14, 22.52)];
                [bezier12Path addCurveToPoint:CGPointMake(29.01, 22.56) controlPoint1:CGPointMake(29.09, 22.55) controlPoint2:CGPointMake(29.05, 22.56)];
                [bezier12Path addLineToPoint:CGPointMake(29, 22.56)];
                [bezier12Path addCurveToPoint:CGPointMake(28.88, 22.51) controlPoint1:CGPointMake(28.95, 22.56) controlPoint2:CGPointMake(28.92, 22.54)];
                [bezier12Path addCurveToPoint:CGPointMake(28.84, 22.39) controlPoint1:CGPointMake(28.85, 22.48) controlPoint2:CGPointMake(28.84, 22.44)];
                [bezier12Path addLineToPoint:CGPointMake(28.84, 22.38)];
                [bezier12Path addCurveToPoint:CGPointMake(28.9, 22.27) controlPoint1:CGPointMake(28.84, 22.33) controlPoint2:CGPointMake(28.86, 22.3)];
                [bezier12Path addCurveToPoint:CGPointMake(29.06, 22.2) controlPoint1:CGPointMake(28.94, 22.24) controlPoint2:CGPointMake(28.99, 22.21)];
                [bezier12Path addCurveToPoint:CGPointMake(29.29, 22.16) controlPoint1:CGPointMake(29.13, 22.18) controlPoint2:CGPointMake(29.21, 22.17)];
                [bezier12Path addCurveToPoint:CGPointMake(29.56, 22.14) controlPoint1:CGPointMake(29.37, 22.14) controlPoint2:CGPointMake(29.46, 22.14)];
                [bezier12Path closePath];
                bezier12Path.miterLimit = 4;

                [fillColor setFill];
                [bezier12Path fill];

                //// Bezier 13 Drawing
                UIBezierPath *bezier13Path = [UIBezierPath bezierPath];
                [bezier13Path moveToPoint:CGPointMake(31.83, 22.93)];
                [bezier13Path addCurveToPoint:CGPointMake(32.15, 22.97) controlPoint1:CGPointMake(31.96, 22.93) controlPoint2:CGPointMake(32.07, 22.94)];
                [bezier13Path addCurveToPoint:CGPointMake(32.36, 23.09) controlPoint1:CGPointMake(32.24, 23) controlPoint2:CGPointMake(32.31, 23.04)];
                [bezier13Path addCurveToPoint:CGPointMake(32.47, 23.29) controlPoint1:CGPointMake(32.41, 23.14) controlPoint2:CGPointMake(32.45, 23.21)];
                [bezier13Path addCurveToPoint:CGPointMake(32.51, 23.56) controlPoint1:CGPointMake(32.49, 23.37) controlPoint2:CGPointMake(32.51, 23.46)];
                [bezier13Path addCurveToPoint:CGPointMake(32.47, 23.82) controlPoint1:CGPointMake(32.51, 23.66) controlPoint2:CGPointMake(32.5, 23.75)];
                [bezier13Path addCurveToPoint:CGPointMake(32.34, 24.01) controlPoint1:CGPointMake(32.44, 23.9) controlPoint2:CGPointMake(32.4, 23.96)];
                [bezier13Path addCurveToPoint:CGPointMake(32.11, 24.13) controlPoint1:CGPointMake(32.28, 24.06) controlPoint2:CGPointMake(32.2, 24.1)];
                [bezier13Path addCurveToPoint:CGPointMake(31.75, 24.17) controlPoint1:CGPointMake(32.01, 24.16) controlPoint2:CGPointMake(31.89, 24.17)];
                [bezier13Path addCurveToPoint:CGPointMake(31.45, 24.14) controlPoint1:CGPointMake(31.64, 24.17) controlPoint2:CGPointMake(31.54, 24.16)];
                [bezier13Path addCurveToPoint:CGPointMake(31.22, 24.04) controlPoint1:CGPointMake(31.36, 24.12) controlPoint2:CGPointMake(31.28, 24.09)];
                [bezier13Path addCurveToPoint:CGPointMake(31.07, 23.87) controlPoint1:CGPointMake(31.15, 24) controlPoint2:CGPointMake(31.1, 23.94)];
                [bezier13Path addCurveToPoint:CGPointMake(31.02, 23.61) controlPoint1:CGPointMake(31.03, 23.8) controlPoint2:CGPointMake(31.02, 23.71)];
                [bezier13Path addLineToPoint:CGPointMake(31.02, 22.31)];
                [bezier13Path addCurveToPoint:CGPointMake(31.03, 22.25) controlPoint1:CGPointMake(31.02, 22.29) controlPoint2:CGPointMake(31.02, 22.27)];
                [bezier13Path addCurveToPoint:CGPointMake(31.06, 22.2) controlPoint1:CGPointMake(31.04, 22.23) controlPoint2:CGPointMake(31.05, 22.21)];
                [bezier13Path addCurveToPoint:CGPointMake(31.12, 22.16) controlPoint1:CGPointMake(31.08, 22.18) controlPoint2:CGPointMake(31.1, 22.17)];
                [bezier13Path addCurveToPoint:CGPointMake(31.21, 22.15) controlPoint1:CGPointMake(31.15, 22.15) controlPoint2:CGPointMake(31.18, 22.15)];
                [bezier13Path addCurveToPoint:CGPointMake(31.36, 22.2) controlPoint1:CGPointMake(31.28, 22.15) controlPoint2:CGPointMake(31.33, 22.17)];
                [bezier13Path addCurveToPoint:CGPointMake(31.41, 22.32) controlPoint1:CGPointMake(31.39, 22.23) controlPoint2:CGPointMake(31.41, 22.27)];
                [bezier13Path addLineToPoint:CGPointMake(31.41, 22.97)];
                [bezier13Path addCurveToPoint:CGPointMake(31.66, 22.95) controlPoint1:CGPointMake(31.5, 22.96) controlPoint2:CGPointMake(31.59, 22.95)];
                [bezier13Path addCurveToPoint:CGPointMake(31.83, 22.93) controlPoint1:CGPointMake(31.72, 22.93) controlPoint2:CGPointMake(31.78, 22.93)];
                [bezier13Path closePath];
                [bezier13Path moveToPoint:CGPointMake(32.12, 23.54)];
                [bezier13Path addCurveToPoint:CGPointMake(32.1, 23.39) controlPoint1:CGPointMake(32.12, 23.48) controlPoint2:CGPointMake(32.12, 23.43)];
                [bezier13Path addCurveToPoint:CGPointMake(32.04, 23.3) controlPoint1:CGPointMake(32.09, 23.35) controlPoint2:CGPointMake(32.07, 23.32)];
                [bezier13Path addCurveToPoint:CGPointMake(31.93, 23.26) controlPoint1:CGPointMake(32.01, 23.28) controlPoint2:CGPointMake(31.97, 23.26)];
                [bezier13Path addCurveToPoint:CGPointMake(31.75, 23.25) controlPoint1:CGPointMake(31.88, 23.25) controlPoint2:CGPointMake(31.82, 23.25)];
                [bezier13Path addCurveToPoint:CGPointMake(31.62, 23.25) controlPoint1:CGPointMake(31.7, 23.25) controlPoint2:CGPointMake(31.65, 23.25)];
                [bezier13Path addCurveToPoint:CGPointMake(31.53, 23.25) controlPoint1:CGPointMake(31.58, 23.25) controlPoint2:CGPointMake(31.55, 23.25)];
                [bezier13Path addCurveToPoint:CGPointMake(31.46, 23.26) controlPoint1:CGPointMake(31.51, 23.25) controlPoint2:CGPointMake(31.48, 23.25)];
                [bezier13Path addCurveToPoint:CGPointMake(31.4, 23.27) controlPoint1:CGPointMake(31.44, 23.26) controlPoint2:CGPointMake(31.42, 23.27)];
                [bezier13Path addLineToPoint:CGPointMake(31.4, 23.52)];
                [bezier13Path addCurveToPoint:CGPointMake(31.42, 23.66) controlPoint1:CGPointMake(31.4, 23.58) controlPoint2:CGPointMake(31.41, 23.63)];
                [bezier13Path addCurveToPoint:CGPointMake(31.48, 23.76) controlPoint1:CGPointMake(31.43, 23.7) controlPoint2:CGPointMake(31.45, 23.73)];
                [bezier13Path addCurveToPoint:CGPointMake(31.59, 23.82) controlPoint1:CGPointMake(31.51, 23.79) controlPoint2:CGPointMake(31.54, 23.81)];
                [bezier13Path addCurveToPoint:CGPointMake(31.76, 23.84) controlPoint1:CGPointMake(31.63, 23.83) controlPoint2:CGPointMake(31.69, 23.84)];
                [bezier13Path addCurveToPoint:CGPointMake(31.93, 23.83) controlPoint1:CGPointMake(31.83, 23.84) controlPoint2:CGPointMake(31.88, 23.84)];
                [bezier13Path addCurveToPoint:CGPointMake(32.04, 23.79) controlPoint1:CGPointMake(31.98, 23.82) controlPoint2:CGPointMake(32.01, 23.81)];
                [bezier13Path addCurveToPoint:CGPointMake(32.11, 23.7) controlPoint1:CGPointMake(32.07, 23.77) controlPoint2:CGPointMake(32.09, 23.74)];
                [bezier13Path addCurveToPoint:CGPointMake(32.12, 23.54) controlPoint1:CGPointMake(32.11, 23.66) controlPoint2:CGPointMake(32.12, 23.61)];
                [bezier13Path closePath];
                bezier13Path.miterLimit = 4;

                [fillColor setFill];
                [bezier13Path fill];

                //// Bezier 14 Drawing
                UIBezierPath *bezier14Path = [UIBezierPath bezierPath];
                [bezier14Path moveToPoint:CGPointMake(36, 23.62)];
                [bezier14Path addCurveToPoint:CGPointMake(35.97, 23.85) controlPoint1:CGPointMake(36, 23.71) controlPoint2:CGPointMake(35.99, 23.78)];
                [bezier14Path addCurveToPoint:CGPointMake(35.86, 24.02) controlPoint1:CGPointMake(35.95, 23.92) controlPoint2:CGPointMake(35.91, 23.98)];
                [bezier14Path addCurveToPoint:CGPointMake(35.62, 24.13) controlPoint1:CGPointMake(35.81, 24.07) controlPoint2:CGPointMake(35.72, 24.1)];
                [bezier14Path addCurveToPoint:CGPointMake(35.22, 24.17) controlPoint1:CGPointMake(35.52, 24.15) controlPoint2:CGPointMake(35.38, 24.17)];
                [bezier14Path addCurveToPoint:CGPointMake(34.83, 24.13) controlPoint1:CGPointMake(35.06, 24.17) controlPoint2:CGPointMake(34.93, 24.16)];
                [bezier14Path addCurveToPoint:CGPointMake(34.61, 24.02) controlPoint1:CGPointMake(34.73, 24.1) controlPoint2:CGPointMake(34.66, 24.07)];
                [bezier14Path addCurveToPoint:CGPointMake(34.5, 23.85) controlPoint1:CGPointMake(34.56, 23.97) controlPoint2:CGPointMake(34.52, 23.91)];
                [bezier14Path addCurveToPoint:CGPointMake(34.47, 23.63) controlPoint1:CGPointMake(34.48, 23.78) controlPoint2:CGPointMake(34.47, 23.71)];
                [bezier14Path addCurveToPoint:CGPointMake(34.48, 23.46) controlPoint1:CGPointMake(34.47, 23.56) controlPoint2:CGPointMake(34.47, 23.51)];
                [bezier14Path addCurveToPoint:CGPointMake(34.51, 23.35) controlPoint1:CGPointMake(34.48, 23.42) controlPoint2:CGPointMake(34.49, 23.38)];
                [bezier14Path addCurveToPoint:CGPointMake(34.6, 23.27) controlPoint1:CGPointMake(34.53, 23.32) controlPoint2:CGPointMake(34.56, 23.29)];
                [bezier14Path addCurveToPoint:CGPointMake(34.77, 23.18) controlPoint1:CGPointMake(34.64, 23.24) controlPoint2:CGPointMake(34.7, 23.21)];
                [bezier14Path addCurveToPoint:CGPointMake(34.6, 23.11) controlPoint1:CGPointMake(34.7, 23.15) controlPoint2:CGPointMake(34.64, 23.13)];
                [bezier14Path addCurveToPoint:CGPointMake(34.51, 23.03) controlPoint1:CGPointMake(34.56, 23.09) controlPoint2:CGPointMake(34.53, 23.06)];
                [bezier14Path addCurveToPoint:CGPointMake(34.48, 22.91) controlPoint1:CGPointMake(34.49, 23) controlPoint2:CGPointMake(34.48, 22.96)];
                [bezier14Path addCurveToPoint:CGPointMake(34.48, 22.71) controlPoint1:CGPointMake(34.48, 22.86) controlPoint2:CGPointMake(34.48, 22.79)];
                [bezier14Path addCurveToPoint:CGPointMake(34.51, 22.44) controlPoint1:CGPointMake(34.48, 22.6) controlPoint2:CGPointMake(34.49, 22.51)];
                [bezier14Path addCurveToPoint:CGPointMake(34.64, 22.27) controlPoint1:CGPointMake(34.54, 22.37) controlPoint2:CGPointMake(34.58, 22.31)];
                [bezier14Path addCurveToPoint:CGPointMake(34.87, 22.18) controlPoint1:CGPointMake(34.7, 22.23) controlPoint2:CGPointMake(34.78, 22.2)];
                [bezier14Path addCurveToPoint:CGPointMake(35.22, 22.15) controlPoint1:CGPointMake(34.97, 22.16) controlPoint2:CGPointMake(35.08, 22.15)];
                [bezier14Path addCurveToPoint:CGPointMake(35.57, 22.18) controlPoint1:CGPointMake(35.36, 22.15) controlPoint2:CGPointMake(35.48, 22.16)];
                [bezier14Path addCurveToPoint:CGPointMake(35.81, 22.27) controlPoint1:CGPointMake(35.67, 22.2) controlPoint2:CGPointMake(35.75, 22.23)];
                [bezier14Path addCurveToPoint:CGPointMake(35.94, 22.44) controlPoint1:CGPointMake(35.87, 22.31) controlPoint2:CGPointMake(35.91, 22.37)];
                [bezier14Path addCurveToPoint:CGPointMake(35.98, 22.7) controlPoint1:CGPointMake(35.97, 22.51) controlPoint2:CGPointMake(35.98, 22.6)];
                [bezier14Path addCurveToPoint:CGPointMake(35.97, 22.9) controlPoint1:CGPointMake(35.98, 22.78) controlPoint2:CGPointMake(35.98, 22.85)];
                [bezier14Path addCurveToPoint:CGPointMake(35.94, 23.02) controlPoint1:CGPointMake(35.97, 22.95) controlPoint2:CGPointMake(35.96, 22.99)];
                [bezier14Path addCurveToPoint:CGPointMake(35.86, 23.1) controlPoint1:CGPointMake(35.92, 23.05) controlPoint2:CGPointMake(35.89, 23.08)];
                [bezier14Path addCurveToPoint:CGPointMake(35.7, 23.17) controlPoint1:CGPointMake(35.82, 23.12) controlPoint2:CGPointMake(35.77, 23.14)];
                [bezier14Path addCurveToPoint:CGPointMake(35.86, 23.25) controlPoint1:CGPointMake(35.77, 23.2) controlPoint2:CGPointMake(35.82, 23.23)];
                [bezier14Path addCurveToPoint:CGPointMake(35.94, 23.33) controlPoint1:CGPointMake(35.9, 23.27) controlPoint2:CGPointMake(35.93, 23.3)];
                [bezier14Path addCurveToPoint:CGPointMake(35.97, 23.45) controlPoint1:CGPointMake(35.96, 23.36) controlPoint2:CGPointMake(35.97, 23.4)];
                [bezier14Path addCurveToPoint:CGPointMake(36, 23.62) controlPoint1:CGPointMake(36, 23.48) controlPoint2:CGPointMake(36, 23.54)];
                [bezier14Path closePath];
                [bezier14Path moveToPoint:CGPointMake(35.61, 23.58)];
                [bezier14Path addCurveToPoint:CGPointMake(35.6, 23.55) controlPoint1:CGPointMake(35.61, 23.58) controlPoint2:CGPointMake(35.61, 23.57)];
                [bezier14Path addCurveToPoint:CGPointMake(35.55, 23.48) controlPoint1:CGPointMake(35.59, 23.53) controlPoint2:CGPointMake(35.58, 23.51)];
                [bezier14Path addCurveToPoint:CGPointMake(35.44, 23.39) controlPoint1:CGPointMake(35.52, 23.45) controlPoint2:CGPointMake(35.49, 23.42)];
                [bezier14Path addCurveToPoint:CGPointMake(35.24, 23.3) controlPoint1:CGPointMake(35.4, 23.35) controlPoint2:CGPointMake(35.33, 23.33)];
                [bezier14Path addCurveToPoint:CGPointMake(35.04, 23.4) controlPoint1:CGPointMake(35.15, 23.33) controlPoint2:CGPointMake(35.09, 23.36)];
                [bezier14Path addCurveToPoint:CGPointMake(34.93, 23.49) controlPoint1:CGPointMake(34.99, 23.43) controlPoint2:CGPointMake(34.95, 23.47)];
                [bezier14Path addCurveToPoint:CGPointMake(34.88, 23.57) controlPoint1:CGPointMake(34.9, 23.52) controlPoint2:CGPointMake(34.89, 23.55)];
                [bezier14Path addCurveToPoint:CGPointMake(34.87, 23.61) controlPoint1:CGPointMake(34.87, 23.59) controlPoint2:CGPointMake(34.87, 23.61)];
                [bezier14Path addLineToPoint:CGPointMake(34.87, 23.61)];
                [bezier14Path addCurveToPoint:CGPointMake(34.89, 23.71) controlPoint1:CGPointMake(34.87, 23.65) controlPoint2:CGPointMake(34.87, 23.69)];
                [bezier14Path addCurveToPoint:CGPointMake(34.95, 23.78) controlPoint1:CGPointMake(34.9, 23.74) controlPoint2:CGPointMake(34.92, 23.76)];
                [bezier14Path addCurveToPoint:CGPointMake(35.07, 23.82) controlPoint1:CGPointMake(34.98, 23.8) controlPoint2:CGPointMake(35.02, 23.81)];
                [bezier14Path addCurveToPoint:CGPointMake(35.26, 23.83) controlPoint1:CGPointMake(35.12, 23.83) controlPoint2:CGPointMake(35.19, 23.83)];
                [bezier14Path addCurveToPoint:CGPointMake(35.43, 23.82) controlPoint1:CGPointMake(35.33, 23.83) controlPoint2:CGPointMake(35.39, 23.83)];
                [bezier14Path addCurveToPoint:CGPointMake(35.54, 23.78) controlPoint1:CGPointMake(35.47, 23.81) controlPoint2:CGPointMake(35.51, 23.8)];
                [bezier14Path addCurveToPoint:CGPointMake(35.6, 23.71) controlPoint1:CGPointMake(35.57, 23.76) controlPoint2:CGPointMake(35.59, 23.74)];
                [bezier14Path addCurveToPoint:CGPointMake(35.61, 23.61) controlPoint1:CGPointMake(35.61, 23.68) controlPoint2:CGPointMake(35.61, 23.65)];
                [bezier14Path addLineToPoint:CGPointMake(35.61, 23.58)];
                [bezier14Path closePath];
                [bezier14Path moveToPoint:CGPointMake(35.24, 23)];
                [bezier14Path addCurveToPoint:CGPointMake(35.45, 22.95) controlPoint1:CGPointMake(35.33, 22.98) controlPoint2:CGPointMake(35.4, 22.96)];
                [bezier14Path addCurveToPoint:CGPointMake(35.56, 22.9) controlPoint1:CGPointMake(35.5, 22.93) controlPoint2:CGPointMake(35.53, 22.92)];
                [bezier14Path addCurveToPoint:CGPointMake(35.6, 22.81) controlPoint1:CGPointMake(35.58, 22.88) controlPoint2:CGPointMake(35.59, 22.85)];
                [bezier14Path addCurveToPoint:CGPointMake(35.61, 22.66) controlPoint1:CGPointMake(35.6, 22.78) controlPoint2:CGPointMake(35.61, 22.73)];
                [bezier14Path addCurveToPoint:CGPointMake(35.58, 22.56) controlPoint1:CGPointMake(35.61, 22.62) controlPoint2:CGPointMake(35.6, 22.58)];
                [bezier14Path addCurveToPoint:CGPointMake(35.51, 22.5) controlPoint1:CGPointMake(35.56, 22.53) controlPoint2:CGPointMake(35.54, 22.51)];
                [bezier14Path addCurveToPoint:CGPointMake(35.39, 22.48) controlPoint1:CGPointMake(35.48, 22.49) controlPoint2:CGPointMake(35.44, 22.48)];
                [bezier14Path addCurveToPoint:CGPointMake(35.24, 22.47) controlPoint1:CGPointMake(35.35, 22.48) controlPoint2:CGPointMake(35.29, 22.47)];
                [bezier14Path addCurveToPoint:CGPointMake(35.08, 22.48) controlPoint1:CGPointMake(35.17, 22.47) controlPoint2:CGPointMake(35.12, 22.47)];
                [bezier14Path addCurveToPoint:CGPointMake(34.97, 22.51) controlPoint1:CGPointMake(35.03, 22.48) controlPoint2:CGPointMake(35, 22.5)];
                [bezier14Path addCurveToPoint:CGPointMake(34.91, 22.58) controlPoint1:CGPointMake(34.94, 22.53) controlPoint2:CGPointMake(34.92, 22.55)];
                [bezier14Path addCurveToPoint:CGPointMake(34.89, 22.71) controlPoint1:CGPointMake(34.9, 22.61) controlPoint2:CGPointMake(34.89, 22.65)];
                [bezier14Path addCurveToPoint:CGPointMake(34.9, 22.83) controlPoint1:CGPointMake(34.89, 22.76) controlPoint2:CGPointMake(34.89, 22.8)];
                [bezier14Path addCurveToPoint:CGPointMake(34.94, 22.9) controlPoint1:CGPointMake(34.9, 22.86) controlPoint2:CGPointMake(34.92, 22.88)];
                [bezier14Path addCurveToPoint:CGPointMake(35.05, 22.95) controlPoint1:CGPointMake(34.97, 22.92) controlPoint2:CGPointMake(35, 22.93)];
                [bezier14Path addCurveToPoint:CGPointMake(35.24, 23) controlPoint1:CGPointMake(35.08, 22.95) controlPoint2:CGPointMake(35.15, 22.97)];
                [bezier14Path closePath];
                bezier14Path.miterLimit = 4;

                [fillColor setFill];
                [bezier14Path fill];

                //// Bezier 15 Drawing
                UIBezierPath *bezier15Path = [UIBezierPath bezierPath];
                [bezier15Path moveToPoint:CGPointMake(37.44, 22.14)];
                [bezier15Path addCurveToPoint:CGPointMake(37.81, 22.17) controlPoint1:CGPointMake(37.59, 22.14) controlPoint2:CGPointMake(37.71, 22.15)];
                [bezier15Path addCurveToPoint:CGPointMake(38.06, 22.27) controlPoint1:CGPointMake(37.91, 22.19) controlPoint2:CGPointMake(37.99, 22.22)];
                [bezier15Path addCurveToPoint:CGPointMake(38.2, 22.45) controlPoint1:CGPointMake(38.12, 22.31) controlPoint2:CGPointMake(38.17, 22.37)];
                [bezier15Path addCurveToPoint:CGPointMake(38.25, 22.72) controlPoint1:CGPointMake(38.23, 22.52) controlPoint2:CGPointMake(38.25, 22.61)];
                [bezier15Path addLineToPoint:CGPointMake(38.25, 22.73)];
                [bezier15Path addCurveToPoint:CGPointMake(38.22, 23.02) controlPoint1:CGPointMake(38.25, 22.84) controlPoint2:CGPointMake(38.24, 22.94)];
                [bezier15Path addCurveToPoint:CGPointMake(38.11, 23.2) controlPoint1:CGPointMake(38.2, 23.1) controlPoint2:CGPointMake(38.16, 23.15)];
                [bezier15Path addCurveToPoint:CGPointMake(37.91, 23.3) controlPoint1:CGPointMake(38.06, 23.25) controlPoint2:CGPointMake(37.99, 23.28)];
                [bezier15Path addCurveToPoint:CGPointMake(37.61, 23.33) controlPoint1:CGPointMake(37.83, 23.32) controlPoint2:CGPointMake(37.73, 23.33)];
                [bezier15Path addCurveToPoint:CGPointMake(37.35, 23.33) controlPoint1:CGPointMake(37.51, 23.33) controlPoint2:CGPointMake(37.42, 23.33)];
                [bezier15Path addCurveToPoint:CGPointMake(37.19, 23.37) controlPoint1:CGPointMake(37.28, 23.33) controlPoint2:CGPointMake(37.23, 23.35)];
                [bezier15Path addCurveToPoint:CGPointMake(37.1, 23.46) controlPoint1:CGPointMake(37.15, 23.39) controlPoint2:CGPointMake(37.12, 23.42)];
                [bezier15Path addCurveToPoint:CGPointMake(37.08, 23.65) controlPoint1:CGPointMake(37.08, 23.5) controlPoint2:CGPointMake(37.08, 23.57)];
                [bezier15Path addLineToPoint:CGPointMake(37.08, 23.83)];
                [bezier15Path addLineToPoint:CGPointMake(38.05, 23.83)];
                [bezier15Path addCurveToPoint:CGPointMake(38.12, 23.84) controlPoint1:CGPointMake(38.07, 23.83) controlPoint2:CGPointMake(38.1, 23.83)];
                [bezier15Path addCurveToPoint:CGPointMake(38.18, 23.87) controlPoint1:CGPointMake(38.14, 23.85) controlPoint2:CGPointMake(38.16, 23.86)];
                [bezier15Path addCurveToPoint:CGPointMake(38.23, 23.92) controlPoint1:CGPointMake(38.2, 23.88) controlPoint2:CGPointMake(38.22, 23.9)];
                [bezier15Path addCurveToPoint:CGPointMake(38.25, 23.99) controlPoint1:CGPointMake(38.24, 23.94) controlPoint2:CGPointMake(38.25, 23.96)];
                [bezier15Path addCurveToPoint:CGPointMake(38.23, 24.07) controlPoint1:CGPointMake(38.25, 24.02) controlPoint2:CGPointMake(38.24, 24.05)];
                [bezier15Path addCurveToPoint:CGPointMake(38.18, 24.12) controlPoint1:CGPointMake(38.22, 24.09) controlPoint2:CGPointMake(38.2, 24.11)];
                [bezier15Path addCurveToPoint:CGPointMake(38.11, 24.15) controlPoint1:CGPointMake(38.16, 24.13) controlPoint2:CGPointMake(38.14, 24.14)];
                [bezier15Path addCurveToPoint:CGPointMake(38.03, 24.16) controlPoint1:CGPointMake(38.09, 24.16) controlPoint2:CGPointMake(38.06, 24.16)];
                [bezier15Path addLineToPoint:CGPointMake(36.89, 24.16)];
                [bezier15Path addCurveToPoint:CGPointMake(36.71, 24.12) controlPoint1:CGPointMake(36.81, 24.16) controlPoint2:CGPointMake(36.75, 24.15)];
                [bezier15Path addCurveToPoint:CGPointMake(36.67, 23.99) controlPoint1:CGPointMake(36.68, 24.09) controlPoint2:CGPointMake(36.67, 24.05)];
                [bezier15Path addLineToPoint:CGPointMake(36.67, 23.59)];
                [bezier15Path addCurveToPoint:CGPointMake(36.71, 23.32) controlPoint1:CGPointMake(36.67, 23.48) controlPoint2:CGPointMake(36.68, 23.39)];
                [bezier15Path addCurveToPoint:CGPointMake(36.83, 23.14) controlPoint1:CGPointMake(36.74, 23.25) controlPoint2:CGPointMake(36.78, 23.19)];
                [bezier15Path addCurveToPoint:CGPointMake(37.03, 23.05) controlPoint1:CGPointMake(36.88, 23.1) controlPoint2:CGPointMake(36.95, 23.07)];
                [bezier15Path addCurveToPoint:CGPointMake(37.29, 23) controlPoint1:CGPointMake(37.1, 23.01) controlPoint2:CGPointMake(37.19, 23)];
                [bezier15Path addLineToPoint:CGPointMake(37.57, 22.99)];
                [bezier15Path addCurveToPoint:CGPointMake(37.7, 22.98) controlPoint1:CGPointMake(37.62, 22.99) controlPoint2:CGPointMake(37.66, 22.99)];
                [bezier15Path addCurveToPoint:CGPointMake(37.78, 22.94) controlPoint1:CGPointMake(37.73, 22.97) controlPoint2:CGPointMake(37.76, 22.96)];
                [bezier15Path addCurveToPoint:CGPointMake(37.83, 22.86) controlPoint1:CGPointMake(37.8, 22.92) controlPoint2:CGPointMake(37.82, 22.9)];
                [bezier15Path addCurveToPoint:CGPointMake(37.84, 22.74) controlPoint1:CGPointMake(37.84, 22.83) controlPoint2:CGPointMake(37.84, 22.79)];
                [bezier15Path addLineToPoint:CGPointMake(37.84, 22.73)];
                [bezier15Path addCurveToPoint:CGPointMake(37.82, 22.6) controlPoint1:CGPointMake(37.84, 22.68) controlPoint2:CGPointMake(37.83, 22.64)];
                [bezier15Path addCurveToPoint:CGPointMake(37.76, 22.52) controlPoint1:CGPointMake(37.81, 22.57) controlPoint2:CGPointMake(37.79, 22.54)];
                [bezier15Path addCurveToPoint:CGPointMake(37.63, 22.47) controlPoint1:CGPointMake(37.73, 22.5) controlPoint2:CGPointMake(37.69, 22.48)];
                [bezier15Path addCurveToPoint:CGPointMake(37.42, 22.46) controlPoint1:CGPointMake(37.58, 22.46) controlPoint2:CGPointMake(37.5, 22.46)];
                [bezier15Path addCurveToPoint:CGPointMake(37.23, 22.47) controlPoint1:CGPointMake(37.35, 22.46) controlPoint2:CGPointMake(37.29, 22.46)];
                [bezier15Path addCurveToPoint:CGPointMake(37.09, 22.5) controlPoint1:CGPointMake(37.17, 22.48) controlPoint2:CGPointMake(37.13, 22.49)];
                [bezier15Path addCurveToPoint:CGPointMake(36.99, 22.54) controlPoint1:CGPointMake(37.05, 22.51) controlPoint2:CGPointMake(37.02, 22.52)];
                [bezier15Path addCurveToPoint:CGPointMake(36.89, 22.56) controlPoint1:CGPointMake(36.96, 22.55) controlPoint2:CGPointMake(36.93, 22.56)];
                [bezier15Path addLineToPoint:CGPointMake(36.88, 22.56)];
                [bezier15Path addCurveToPoint:CGPointMake(36.77, 22.51) controlPoint1:CGPointMake(36.84, 22.56) controlPoint2:CGPointMake(36.8, 22.54)];
                [bezier15Path addCurveToPoint:CGPointMake(36.72, 22.39) controlPoint1:CGPointMake(36.74, 22.48) controlPoint2:CGPointMake(36.72, 22.44)];
                [bezier15Path addLineToPoint:CGPointMake(36.72, 22.38)];
                [bezier15Path addCurveToPoint:CGPointMake(36.78, 22.27) controlPoint1:CGPointMake(36.72, 22.33) controlPoint2:CGPointMake(36.74, 22.3)];
                [bezier15Path addCurveToPoint:CGPointMake(36.94, 22.2) controlPoint1:CGPointMake(36.82, 22.24) controlPoint2:CGPointMake(36.87, 22.21)];
                [bezier15Path addCurveToPoint:CGPointMake(37.16, 22.16) controlPoint1:CGPointMake(37, 22.18) controlPoint2:CGPointMake(37.08, 22.17)];
                [bezier15Path addCurveToPoint:CGPointMake(37.44, 22.14) controlPoint1:CGPointMake(37.25, 22.14) controlPoint2:CGPointMake(37.34, 22.14)];
                [bezier15Path closePath];
                bezier15Path.miterLimit = 4;

                [fillColor setFill];
                [bezier15Path fill];

                //// Bezier 16 Drawing
                UIBezierPath *bezier16Path = [UIBezierPath bezierPath];
                [bezier16Path moveToPoint:CGPointMake(39.98, 24.12)];
                [bezier16Path addCurveToPoint:CGPointMake(39.84, 24.17) controlPoint1:CGPointMake(39.94, 24.15) controlPoint2:CGPointMake(39.9, 24.17)];
                [bezier16Path addCurveToPoint:CGPointMake(39.69, 24.12) controlPoint1:CGPointMake(39.77, 24.17) controlPoint2:CGPointMake(39.72, 24.16)];
                [bezier16Path addCurveToPoint:CGPointMake(39.64, 24) controlPoint1:CGPointMake(39.66, 24.09) controlPoint2:CGPointMake(39.64, 24.05)];
                [bezier16Path addLineToPoint:CGPointMake(39.64, 22.49)];
                [bezier16Path addLineToPoint:CGPointMake(38.7, 22.49)];
                [bezier16Path addCurveToPoint:CGPointMake(38.57, 22.45) controlPoint1:CGPointMake(38.65, 22.49) controlPoint2:CGPointMake(38.6, 22.48)];
                [bezier16Path addCurveToPoint:CGPointMake(38.51, 22.33) controlPoint1:CGPointMake(38.53, 22.42) controlPoint2:CGPointMake(38.51, 22.38)];
                [bezier16Path addCurveToPoint:CGPointMake(38.57, 22.21) controlPoint1:CGPointMake(38.51, 22.28) controlPoint2:CGPointMake(38.53, 22.24)];
                [bezier16Path addCurveToPoint:CGPointMake(38.7, 22.17) controlPoint1:CGPointMake(38.61, 22.18) controlPoint2:CGPointMake(38.65, 22.17)];
                [bezier16Path addLineToPoint:CGPointMake(39.71, 22.17)];
                [bezier16Path addCurveToPoint:CGPointMake(39.88, 22.18) controlPoint1:CGPointMake(39.78, 22.17) controlPoint2:CGPointMake(39.84, 22.17)];
                [bezier16Path addCurveToPoint:CGPointMake(39.98, 22.22) controlPoint1:CGPointMake(39.92, 22.19) controlPoint2:CGPointMake(39.96, 22.2)];
                [bezier16Path addCurveToPoint:CGPointMake(40.03, 22.3) controlPoint1:CGPointMake(40.01, 22.24) controlPoint2:CGPointMake(40.02, 22.27)];
                [bezier16Path addCurveToPoint:CGPointMake(40.04, 22.43) controlPoint1:CGPointMake(40.04, 22.34) controlPoint2:CGPointMake(40.04, 22.38)];
                [bezier16Path addLineToPoint:CGPointMake(40.04, 23.99)];
                [bezier16Path addCurveToPoint:CGPointMake(39.98, 24.12) controlPoint1:CGPointMake(40.03, 24.04) controlPoint2:CGPointMake(40.01, 24.09)];
                [bezier16Path closePath];
                bezier16Path.miterLimit = 4;

                [fillColor setFill];
                [bezier16Path fill];

                //// Bezier 17 Drawing
                UIBezierPath *bezier17Path = [UIBezierPath bezierPath];
                [bezier17Path moveToPoint:CGPointMake(42.05, 23.98)];
                [bezier17Path addCurveToPoint:CGPointMake(42.03, 24.06) controlPoint1:CGPointMake(42.05, 24.01) controlPoint2:CGPointMake(42.04, 24.03)];
                [bezier17Path addCurveToPoint:CGPointMake(41.98, 24.11) controlPoint1:CGPointMake(42.02, 24.08) controlPoint2:CGPointMake(42, 24.1)];
                [bezier17Path addCurveToPoint:CGPointMake(41.93, 24.14) controlPoint1:CGPointMake(41.96, 24.12) controlPoint2:CGPointMake(41.95, 24.13)];
                [bezier17Path addCurveToPoint:CGPointMake(41.88, 24.15) controlPoint1:CGPointMake(41.91, 24.15) controlPoint2:CGPointMake(41.89, 24.15)];
                [bezier17Path addLineToPoint:CGPointMake(40.77, 24.15)];
                [bezier17Path addCurveToPoint:CGPointMake(40.71, 24.14) controlPoint1:CGPointMake(40.75, 24.15) controlPoint2:CGPointMake(40.73, 24.15)];
                [bezier17Path addCurveToPoint:CGPointMake(40.65, 24.11) controlPoint1:CGPointMake(40.69, 24.13) controlPoint2:CGPointMake(40.67, 24.12)];
                [bezier17Path addCurveToPoint:CGPointMake(40.61, 24.06) controlPoint1:CGPointMake(40.64, 24.1) controlPoint2:CGPointMake(40.62, 24.08)];
                [bezier17Path addCurveToPoint:CGPointMake(40.6, 23.98) controlPoint1:CGPointMake(40.6, 24.04) controlPoint2:CGPointMake(40.6, 24.01)];
                [bezier17Path addCurveToPoint:CGPointMake(40.61, 23.91) controlPoint1:CGPointMake(40.6, 23.95) controlPoint2:CGPointMake(40.6, 23.93)];
                [bezier17Path addCurveToPoint:CGPointMake(40.65, 23.86) controlPoint1:CGPointMake(40.62, 23.89) controlPoint2:CGPointMake(40.63, 23.87)];
                [bezier17Path addCurveToPoint:CGPointMake(40.71, 23.83) controlPoint1:CGPointMake(40.67, 23.85) controlPoint2:CGPointMake(40.69, 23.84)];
                [bezier17Path addCurveToPoint:CGPointMake(40.77, 23.82) controlPoint1:CGPointMake(40.73, 23.82) controlPoint2:CGPointMake(40.75, 23.82)];
                [bezier17Path addLineToPoint:CGPointMake(41.13, 23.82)];
                [bezier17Path addLineToPoint:CGPointMake(41.13, 22.49)];
                [bezier17Path addCurveToPoint:CGPointMake(41.05, 22.48) controlPoint1:CGPointMake(41.1, 22.49) controlPoint2:CGPointMake(41.07, 22.48)];
                [bezier17Path addCurveToPoint:CGPointMake(40.98, 22.45) controlPoint1:CGPointMake(41.02, 22.47) controlPoint2:CGPointMake(41, 22.46)];
                [bezier17Path addCurveToPoint:CGPointMake(40.93, 22.4) controlPoint1:CGPointMake(40.96, 22.44) controlPoint2:CGPointMake(40.94, 22.42)];
                [bezier17Path addCurveToPoint:CGPointMake(40.91, 22.33) controlPoint1:CGPointMake(40.92, 22.38) controlPoint2:CGPointMake(40.91, 22.36)];
                [bezier17Path addCurveToPoint:CGPointMake(40.94, 22.23) controlPoint1:CGPointMake(40.91, 22.29) controlPoint2:CGPointMake(40.92, 22.25)];
                [bezier17Path addCurveToPoint:CGPointMake(41.02, 22.17) controlPoint1:CGPointMake(40.96, 22.2) controlPoint2:CGPointMake(40.99, 22.19)];
                [bezier17Path addCurveToPoint:CGPointMake(41.15, 22.15) controlPoint1:CGPointMake(41.06, 22.16) controlPoint2:CGPointMake(41.1, 22.15)];
                [bezier17Path addCurveToPoint:CGPointMake(41.31, 22.15) controlPoint1:CGPointMake(41.2, 22.15) controlPoint2:CGPointMake(41.25, 22.15)];
                [bezier17Path addLineToPoint:CGPointMake(41.4, 22.15)];
                [bezier17Path addCurveToPoint:CGPointMake(41.49, 22.18) controlPoint1:CGPointMake(41.44, 22.15) controlPoint2:CGPointMake(41.48, 22.16)];
                [bezier17Path addCurveToPoint:CGPointMake(41.52, 22.25) controlPoint1:CGPointMake(41.51, 22.2) controlPoint2:CGPointMake(41.52, 22.22)];
                [bezier17Path addLineToPoint:CGPointMake(41.52, 23.82)];
                [bezier17Path addLineToPoint:CGPointMake(41.89, 23.82)];
                [bezier17Path addCurveToPoint:CGPointMake(41.93, 23.85) controlPoint1:CGPointMake(41.91, 23.82) controlPoint2:CGPointMake(41.92, 23.83)];
                [bezier17Path addCurveToPoint:CGPointMake(41.95, 23.9) controlPoint1:CGPointMake(41.94, 23.87) controlPoint2:CGPointMake(41.95, 23.88)];
                [bezier17Path addCurveToPoint:CGPointMake(41.96, 23.95) controlPoint1:CGPointMake(41.96, 23.92) controlPoint2:CGPointMake(41.96, 23.94)];
                [bezier17Path addCurveToPoint:CGPointMake(41.96, 23.97) controlPoint1:CGPointMake(41.96, 23.96) controlPoint2:CGPointMake(41.96, 23.97)];
                [bezier17Path addLineToPoint:CGPointMake(42.05, 23.97)];
                [bezier17Path addLineToPoint:CGPointMake(42.05, 23.98)];
                [bezier17Path closePath];
                bezier17Path.miterLimit = 4;

                [fillColor setFill];
                [bezier17Path fill];
            }
        }

        //// Bezier 18 Drawing
        UIBezierPath *bezier18Path = [UIBezierPath bezierPath];
        [bezier18Path moveToPoint:CGPointMake(4.71, 16.18)];
        [bezier18Path addCurveToPoint:CGPointMake(4.04, 15.51) controlPoint1:CGPointMake(4.34, 16.18) controlPoint2:CGPointMake(4.04, 15.88)];
        [bezier18Path addLineToPoint:CGPointMake(4.04, 12.21)];
        [bezier18Path addCurveToPoint:CGPointMake(4.71, 11.54) controlPoint1:CGPointMake(4.04, 11.84) controlPoint2:CGPointMake(4.34, 11.54)];
        [bezier18Path addLineToPoint:CGPointMake(10.29, 11.54)];
        [bezier18Path addCurveToPoint:CGPointMake(10.96, 12.21) controlPoint1:CGPointMake(10.66, 11.54) controlPoint2:CGPointMake(10.96, 11.84)];
        [bezier18Path addLineToPoint:CGPointMake(10.96, 15.51)];
        [bezier18Path addCurveToPoint:CGPointMake(10.29, 16.18) controlPoint1:CGPointMake(10.96, 15.88) controlPoint2:CGPointMake(10.66, 16.18)];
        [bezier18Path addLineToPoint:CGPointMake(4.71, 16.18)];
        [bezier18Path closePath];
        [bezier18Path moveToPoint:CGPointMake(4.71, 11.89)];
        [bezier18Path addCurveToPoint:CGPointMake(4.39, 12.21) controlPoint1:CGPointMake(4.53, 11.89) controlPoint2:CGPointMake(4.39, 12.04)];
        [bezier18Path addLineToPoint:CGPointMake(4.39, 15.51)];
        [bezier18Path addCurveToPoint:CGPointMake(4.71, 15.83) controlPoint1:CGPointMake(4.39, 15.69) controlPoint2:CGPointMake(4.54, 15.83)];
        [bezier18Path addLineToPoint:CGPointMake(10.29, 15.83)];
        [bezier18Path addCurveToPoint:CGPointMake(10.61, 15.51) controlPoint1:CGPointMake(10.47, 15.83) controlPoint2:CGPointMake(10.61, 15.68)];
        [bezier18Path addLineToPoint:CGPointMake(10.61, 12.21)];
        [bezier18Path addCurveToPoint:CGPointMake(10.29, 11.89) controlPoint1:CGPointMake(10.61, 12.03) controlPoint2:CGPointMake(10.47, 11.89)];
        [bezier18Path addLineToPoint:CGPointMake(4.71, 11.89)];
        [bezier18Path closePath];
        bezier18Path.miterLimit = 4;

        [fillColor setFill];
        [bezier18Path fill];

        //// Group 5
        {
            //// Group 6
            {
                //// Group 7
                {
                    //// XMLID_7_ Drawing
                    UIBezierPath *xMLID_7_Path = [UIBezierPath bezierPath];
                    [xMLID_7_Path moveToPoint:CGPointMake(26.82, 18.14)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(26.82, 17.16)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(26.2, 16.54) controlPoint1:CGPointMake(26.82, 16.79) controlPoint2:CGPointMake(26.58, 16.54)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(25.65, 16.82) controlPoint1:CGPointMake(26, 16.54) controlPoint2:CGPointMake(25.79, 16.6)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(25.13, 16.54) controlPoint1:CGPointMake(25.54, 16.65) controlPoint2:CGPointMake(25.37, 16.54)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(24.67, 16.77) controlPoint1:CGPointMake(24.96, 16.54) controlPoint2:CGPointMake(24.8, 16.59)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(24.67, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(24.33, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(24.33, 18.15)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(24.67, 18.15)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(24.67, 17.28)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(25.05, 16.86) controlPoint1:CGPointMake(24.67, 17.01) controlPoint2:CGPointMake(24.82, 16.86)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(25.39, 17.27) controlPoint1:CGPointMake(25.28, 16.86) controlPoint2:CGPointMake(25.39, 17.01)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(25.39, 18.14)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(25.73, 18.14)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(25.73, 17.27)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(26.11, 16.85) controlPoint1:CGPointMake(25.73, 17) controlPoint2:CGPointMake(25.89, 16.85)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(26.45, 17.26) controlPoint1:CGPointMake(26.34, 16.85) controlPoint2:CGPointMake(26.45, 17)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(26.45, 18.13)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(26.82, 18.13)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(26.82, 18.14)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(31.91, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.35, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.35, 16.1)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.01, 16.1)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.01, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(30.69, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(30.69, 16.89)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.01, 16.89)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.01, 17.6)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(31.55, 18.18) controlPoint1:CGPointMake(31.01, 17.96) controlPoint2:CGPointMake(31.15, 18.18)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(31.98, 18.06) controlPoint1:CGPointMake(31.7, 18.18) controlPoint2:CGPointMake(31.87, 18.13)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.88, 17.77)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(31.58, 17.86) controlPoint1:CGPointMake(31.78, 17.83) controlPoint2:CGPointMake(31.67, 17.86)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(31.35, 17.6) controlPoint1:CGPointMake(31.41, 17.86) controlPoint2:CGPointMake(31.35, 17.76)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.35, 16.89)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.91, 16.89)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(31.91, 16.58)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(34.82, 16.54)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(34.41, 16.77) controlPoint1:CGPointMake(34.62, 16.54) controlPoint2:CGPointMake(34.5, 16.63)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(34.41, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(34.07, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(34.07, 18.15)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(34.41, 18.15)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(34.41, 17.27)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(34.74, 16.87) controlPoint1:CGPointMake(34.41, 17.01) controlPoint2:CGPointMake(34.52, 16.87)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(34.95, 16.91) controlPoint1:CGPointMake(34.81, 16.87) controlPoint2:CGPointMake(34.88, 16.88)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(35.05, 16.59)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(34.82, 16.54) controlPoint1:CGPointMake(34.98, 16.55) controlPoint2:CGPointMake(34.89, 16.54)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(34.82, 16.54)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(30.42, 16.7)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(29.78, 16.54) controlPoint1:CGPointMake(30.26, 16.59) controlPoint2:CGPointMake(30.03, 16.54)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(29.13, 17.04) controlPoint1:CGPointMake(29.38, 16.54) controlPoint2:CGPointMake(29.13, 16.73)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(29.67, 17.5) controlPoint1:CGPointMake(29.13, 17.3) controlPoint2:CGPointMake(29.32, 17.45)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(29.83, 17.52)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(30.11, 17.68) controlPoint1:CGPointMake(30.02, 17.55) controlPoint2:CGPointMake(30.11, 17.6)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(29.75, 17.87) controlPoint1:CGPointMake(30.11, 17.8) controlPoint2:CGPointMake(29.99, 17.87)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(29.23, 17.71) controlPoint1:CGPointMake(29.51, 17.87) controlPoint2:CGPointMake(29.34, 17.79)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(29.07, 17.98)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(29.75, 18.18) controlPoint1:CGPointMake(29.26, 18.12) controlPoint2:CGPointMake(29.49, 18.18)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(30.46, 17.67) controlPoint1:CGPointMake(30.2, 18.18) controlPoint2:CGPointMake(30.46, 17.97)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(29.91, 17.2) controlPoint1:CGPointMake(30.46, 17.39) controlPoint2:CGPointMake(30.25, 17.25)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(29.75, 17.18)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(29.48, 17.03) controlPoint1:CGPointMake(29.6, 17.16) controlPoint2:CGPointMake(29.48, 17.13)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(29.78, 16.85) controlPoint1:CGPointMake(29.48, 16.92) controlPoint2:CGPointMake(29.59, 16.85)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(30.27, 16.98) controlPoint1:CGPointMake(29.98, 16.85) controlPoint2:CGPointMake(30.17, 16.93)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(30.42, 16.7)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(39.55, 16.54)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(39.14, 16.77) controlPoint1:CGPointMake(39.35, 16.54) controlPoint2:CGPointMake(39.23, 16.63)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(39.14, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(38.8, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(38.8, 18.15)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(39.14, 18.15)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(39.14, 17.27)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(39.47, 16.87) controlPoint1:CGPointMake(39.14, 17.01) controlPoint2:CGPointMake(39.25, 16.87)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(39.68, 16.91) controlPoint1:CGPointMake(39.54, 16.87) controlPoint2:CGPointMake(39.61, 16.88)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(39.78, 16.59)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(39.55, 16.54) controlPoint1:CGPointMake(39.72, 16.55) controlPoint2:CGPointMake(39.62, 16.54)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(39.55, 16.54)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(35.16, 17.36)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(36, 18.18) controlPoint1:CGPointMake(35.16, 17.84) controlPoint2:CGPointMake(35.49, 18.18)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(36.56, 17.99) controlPoint1:CGPointMake(36.24, 18.18) controlPoint2:CGPointMake(36.39, 18.13)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(36.4, 17.71)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(35.99, 17.85) controlPoint1:CGPointMake(36.27, 17.8) controlPoint2:CGPointMake(36.14, 17.85)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(35.52, 17.35) controlPoint1:CGPointMake(35.72, 17.85) controlPoint2:CGPointMake(35.52, 17.65)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(35.99, 16.85) controlPoint1:CGPointMake(35.52, 17.05) controlPoint2:CGPointMake(35.72, 16.85)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(36.4, 16.99) controlPoint1:CGPointMake(36.14, 16.85) controlPoint2:CGPointMake(36.27, 16.9)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(36.56, 16.71)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(36, 16.52) controlPoint1:CGPointMake(36.39, 16.58) controlPoint2:CGPointMake(36.23, 16.52)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(35.16, 17.36) controlPoint1:CGPointMake(35.49, 16.54) controlPoint2:CGPointMake(35.16, 16.88)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(35.16, 17.36)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(38.35, 17.36)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(38.35, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(38.01, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(38.01, 16.77)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(37.52, 16.54) controlPoint1:CGPointMake(37.9, 16.63) controlPoint2:CGPointMake(37.74, 16.54)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(36.74, 17.36) controlPoint1:CGPointMake(37.08, 16.54) controlPoint2:CGPointMake(36.74, 16.88)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(37.52, 18.18) controlPoint1:CGPointMake(36.74, 17.84) controlPoint2:CGPointMake(37.08, 18.18)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(38.01, 17.95) controlPoint1:CGPointMake(37.74, 18.18) controlPoint2:CGPointMake(37.91, 18.09)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(38.01, 18.14)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(38.35, 18.14)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(38.35, 17.36)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(37.09, 17.36)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(37.57, 16.86) controlPoint1:CGPointMake(37.09, 17.08) controlPoint2:CGPointMake(37.27, 16.86)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(38.04, 17.36) controlPoint1:CGPointMake(37.85, 16.86) controlPoint2:CGPointMake(38.04, 17.08)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(37.57, 17.86) controlPoint1:CGPointMake(38.04, 17.65) controlPoint2:CGPointMake(37.85, 17.86)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(37.09, 17.36) controlPoint1:CGPointMake(37.27, 17.86) controlPoint2:CGPointMake(37.09, 17.63)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(37.09, 17.36)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(32.97, 16.54)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(32.19, 17.36) controlPoint1:CGPointMake(32.51, 16.54) controlPoint2:CGPointMake(32.19, 16.87)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(32.99, 18.18) controlPoint1:CGPointMake(32.19, 17.86) controlPoint2:CGPointMake(32.52, 18.18)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(33.63, 17.96) controlPoint1:CGPointMake(33.23, 18.18) controlPoint2:CGPointMake(33.44, 18.12)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(33.46, 17.71)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(33, 17.87) controlPoint1:CGPointMake(33.33, 17.81) controlPoint2:CGPointMake(33.16, 17.87)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(32.53, 17.49) controlPoint1:CGPointMake(32.78, 17.87) controlPoint2:CGPointMake(32.58, 17.77)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(33.69, 17.49)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(33.7, 17.36) controlPoint1:CGPointMake(33.69, 17.45) controlPoint2:CGPointMake(33.7, 17.4)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(32.97, 16.54) controlPoint1:CGPointMake(33.71, 16.87) controlPoint2:CGPointMake(33.41, 16.54)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(32.97, 16.54)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(32.96, 16.84)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(33.36, 17.22) controlPoint1:CGPointMake(33.18, 16.84) controlPoint2:CGPointMake(33.32, 16.98)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(32.55, 17.22)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(32.96, 16.84) controlPoint1:CGPointMake(32.58, 16.99) controlPoint2:CGPointMake(32.72, 16.84)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(32.96, 16.84)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(41.52, 17.36)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(41.52, 15.95)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(41.18, 15.95)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(41.18, 16.77)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(40.69, 16.54) controlPoint1:CGPointMake(41.07, 16.63) controlPoint2:CGPointMake(40.91, 16.54)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(39.91, 17.36) controlPoint1:CGPointMake(40.25, 16.54) controlPoint2:CGPointMake(39.91, 16.88)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(40.69, 18.18) controlPoint1:CGPointMake(39.91, 17.84) controlPoint2:CGPointMake(40.25, 18.18)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(41.18, 17.95) controlPoint1:CGPointMake(40.91, 18.18) controlPoint2:CGPointMake(41.08, 18.09)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(41.18, 18.14)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(41.52, 18.14)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(41.52, 17.36)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(40.25, 17.36)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(40.73, 16.86) controlPoint1:CGPointMake(40.25, 17.08) controlPoint2:CGPointMake(40.43, 16.86)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(41.2, 17.36) controlPoint1:CGPointMake(41.01, 16.86) controlPoint2:CGPointMake(41.2, 17.08)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(40.73, 17.86) controlPoint1:CGPointMake(41.2, 17.65) controlPoint2:CGPointMake(41.01, 17.86)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(40.25, 17.36) controlPoint1:CGPointMake(40.43, 17.86) controlPoint2:CGPointMake(40.25, 17.63)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(40.25, 17.36)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(28.74, 17.36)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(28.74, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(28.4, 16.58)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(28.4, 16.77)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(27.91, 16.54) controlPoint1:CGPointMake(28.29, 16.63) controlPoint2:CGPointMake(28.13, 16.54)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(27.13, 17.36) controlPoint1:CGPointMake(27.47, 16.54) controlPoint2:CGPointMake(27.13, 16.88)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(27.91, 18.18) controlPoint1:CGPointMake(27.13, 17.84) controlPoint2:CGPointMake(27.47, 18.18)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(28.4, 17.95) controlPoint1:CGPointMake(28.13, 18.18) controlPoint2:CGPointMake(28.3, 18.09)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(28.4, 18.14)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(28.74, 18.14)];
                    [xMLID_7_Path addLineToPoint:CGPointMake(28.74, 17.36)];
                    [xMLID_7_Path closePath];
                    [xMLID_7_Path moveToPoint:CGPointMake(27.47, 17.36)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(27.95, 16.86) controlPoint1:CGPointMake(27.47, 17.08) controlPoint2:CGPointMake(27.65, 16.86)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(28.42, 17.36) controlPoint1:CGPointMake(28.23, 16.86) controlPoint2:CGPointMake(28.42, 17.08)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(27.95, 17.86) controlPoint1:CGPointMake(28.42, 17.65) controlPoint2:CGPointMake(28.23, 17.86)];
                    [xMLID_7_Path addCurveToPoint:CGPointMake(27.47, 17.36) controlPoint1:CGPointMake(27.65, 17.86) controlPoint2:CGPointMake(27.47, 17.63)];
                    [xMLID_7_Path closePath];
                    xMLID_7_Path.miterLimit = 4;

                    [fillColor8 setFill];
                    [xMLID_7_Path fill];
                }

                //// XMLID_2_
                {
                    //// Rectangle 2 Drawing
                    UIBezierPath *rectangle2Path = [UIBezierPath bezierPathWithRect:CGRectMake(30.31, 4.63, 5.16, 9.28)];
                    [fillColor12 setFill];
                    [rectangle2Path fill];

                    //// XMLID_6_ Drawing
                    UIBezierPath *xMLID_6_Path = [UIBezierPath bezierPath];
                    [xMLID_6_Path moveToPoint:CGPointMake(30.64, 9.27)];
                    [xMLID_6_Path addCurveToPoint:CGPointMake(32.89, 4.63) controlPoint1:CGPointMake(30.64, 7.39) controlPoint2:CGPointMake(31.52, 5.71)];
                    [xMLID_6_Path addCurveToPoint:CGPointMake(29.24, 3.37) controlPoint1:CGPointMake(31.89, 3.84) controlPoint2:CGPointMake(30.62, 3.37)];
                    [xMLID_6_Path addCurveToPoint:CGPointMake(23.34, 9.27) controlPoint1:CGPointMake(25.98, 3.37) controlPoint2:CGPointMake(23.34, 6.01)];
                    [xMLID_6_Path addCurveToPoint:CGPointMake(29.24, 15.17) controlPoint1:CGPointMake(23.34, 12.53) controlPoint2:CGPointMake(25.98, 15.17)];
                    [xMLID_6_Path addCurveToPoint:CGPointMake(32.89, 13.91) controlPoint1:CGPointMake(30.62, 15.17) controlPoint2:CGPointMake(31.88, 14.7)];
                    [xMLID_6_Path addCurveToPoint:CGPointMake(30.64, 9.27) controlPoint1:CGPointMake(31.52, 12.83) controlPoint2:CGPointMake(30.64, 11.16)];
                    [xMLID_6_Path closePath];
                    xMLID_6_Path.miterLimit = 4;

                    [fillColor10 setFill];
                    [xMLID_6_Path fill];

                    //// Bezier 21 Drawing
                    UIBezierPath *bezier21Path = [UIBezierPath bezierPath];
                    [bezier21Path moveToPoint:CGPointMake(42.44, 9.27)];
                    [bezier21Path addCurveToPoint:CGPointMake(36.54, 15.17) controlPoint1:CGPointMake(42.44, 12.53) controlPoint2:CGPointMake(39.8, 15.17)];
                    [bezier21Path addCurveToPoint:CGPointMake(32.89, 13.91) controlPoint1:CGPointMake(35.16, 15.17) controlPoint2:CGPointMake(33.9, 14.7)];
                    [bezier21Path addCurveToPoint:CGPointMake(35.14, 9.27) controlPoint1:CGPointMake(34.26, 12.83) controlPoint2:CGPointMake(35.14, 11.15)];
                    [bezier21Path addCurveToPoint:CGPointMake(32.89, 4.63) controlPoint1:CGPointMake(35.14, 7.39) controlPoint2:CGPointMake(34.26, 5.71)];
                    [bezier21Path addCurveToPoint:CGPointMake(36.54, 3.37) controlPoint1:CGPointMake(33.89, 3.84) controlPoint2:CGPointMake(35.16, 3.37)];
                    [bezier21Path addCurveToPoint:CGPointMake(42.44, 9.27) controlPoint1:CGPointMake(39.8, 3.37) controlPoint2:CGPointMake(42.44, 6.01)];
                    [bezier21Path closePath];
                    bezier21Path.miterLimit = 4;

                    [fillColor13 setFill];
                    [bezier21Path fill];
                }
            }
        }
    }
}

- (void)drawIc_card_unknownCanvas {
    //// Color Declarations
    UIColor *fillColor = [UIColor colorWithRed:0.647 green:0.647 blue:0.647 alpha:1];
    UIColor *fillColor2 = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1];
    UIColor *fillColor5 = [UIColor colorWithRed:0.229 green:0.229 blue:0.229 alpha:1];
    UIColor *strokeColor = [UIColor colorWithRed:0.296 green:0.66 blue:0.357 alpha:1];
    UIColor *fillColor14 = [UIColor colorWithRed:0.296 green:0.66 blue:0.357 alpha:1];

    //// Group
    {
        //// Group 2
        {
            //// Bezier Drawing
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(43.77, 0)];
            [bezierPath addLineToPoint:CGPointMake(2.23, 0)];
            [bezierPath addCurveToPoint:CGPointMake(0, 2.22) controlPoint1:CGPointMake(1, 0) controlPoint2:CGPointMake(0, 0.99)];
            [bezierPath addLineToPoint:CGPointMake(0, 3.33)];
            [bezierPath addLineToPoint:CGPointMake(0, 26.67)];
            [bezierPath addLineToPoint:CGPointMake(0, 27.79)];
            [bezierPath addCurveToPoint:CGPointMake(2.23, 30) controlPoint1:CGPointMake(0, 29.01) controlPoint2:CGPointMake(1, 30)];
            [bezierPath addLineToPoint:CGPointMake(43.77, 30)];
            [bezierPath addCurveToPoint:CGPointMake(46, 27.79) controlPoint1:CGPointMake(45, 30) controlPoint2:CGPointMake(46, 29.01)];
            [bezierPath addLineToPoint:CGPointMake(46, 2.22)];
            [bezierPath addCurveToPoint:CGPointMake(43.77, 0) controlPoint1:CGPointMake(46, 0.99) controlPoint2:CGPointMake(45, 0)];
            [bezierPath closePath];
            bezierPath.miterLimit = 4;

            [fillColor setFill];
            [bezierPath fill];

            //// Rectangle Drawing
            UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.55, 0.57, 44.9, 28.35) cornerRadius:1.6];
            [fillColor2 setFill];
            [rectanglePath fill];
        }

        //// Bezier 2 Drawing
        UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint:CGPointMake(4.71, 16.18)];
        [bezier2Path addCurveToPoint:CGPointMake(4.04, 15.51) controlPoint1:CGPointMake(4.34, 16.18) controlPoint2:CGPointMake(4.04, 15.88)];
        [bezier2Path addLineToPoint:CGPointMake(4.04, 12.21)];
        [bezier2Path addCurveToPoint:CGPointMake(4.71, 11.54) controlPoint1:CGPointMake(4.04, 11.84) controlPoint2:CGPointMake(4.34, 11.54)];
        [bezier2Path addLineToPoint:CGPointMake(10.29, 11.54)];
        [bezier2Path addCurveToPoint:CGPointMake(10.96, 12.21) controlPoint1:CGPointMake(10.66, 11.54) controlPoint2:CGPointMake(10.96, 11.84)];
        [bezier2Path addLineToPoint:CGPointMake(10.96, 15.51)];
        [bezier2Path addCurveToPoint:CGPointMake(10.29, 16.18) controlPoint1:CGPointMake(10.96, 15.88) controlPoint2:CGPointMake(10.66, 16.18)];
        [bezier2Path addLineToPoint:CGPointMake(4.71, 16.18)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint:CGPointMake(4.71, 11.89)];
        [bezier2Path addCurveToPoint:CGPointMake(4.39, 12.21) controlPoint1:CGPointMake(4.53, 11.89) controlPoint2:CGPointMake(4.39, 12.04)];
        [bezier2Path addLineToPoint:CGPointMake(4.39, 15.51)];
        [bezier2Path addCurveToPoint:CGPointMake(4.71, 15.83) controlPoint1:CGPointMake(4.39, 15.69) controlPoint2:CGPointMake(4.54, 15.83)];
        [bezier2Path addLineToPoint:CGPointMake(10.29, 15.83)];
        [bezier2Path addCurveToPoint:CGPointMake(10.61, 15.51) controlPoint1:CGPointMake(10.47, 15.83) controlPoint2:CGPointMake(10.61, 15.68)];
        [bezier2Path addLineToPoint:CGPointMake(10.61, 12.21)];
        [bezier2Path addCurveToPoint:CGPointMake(10.29, 11.89) controlPoint1:CGPointMake(10.61, 12.03) controlPoint2:CGPointMake(10.47, 11.89)];
        [bezier2Path addLineToPoint:CGPointMake(4.71, 11.89)];
        [bezier2Path closePath];
        bezier2Path.miterLimit = 4;

        [fillColor setFill];
        [bezier2Path fill];

        //// Group 3
        {
            //// Group 4
            {
                //// Bezier 3 Drawing
                UIBezierPath *bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint:CGPointMake(5.38, 23.04)];
        [bezier3Path addCurveToPoint:CGPointMake(5.52, 23.08) controlPoint1:CGPointMake(5.43, 23.04) controlPoint2:CGPointMake(5.48, 23.05)];
        [bezier3Path addCurveToPoint:CGPointMake(5.58, 23.2) controlPoint1:CGPointMake(5.55, 23.1) controlPoint2:CGPointMake(5.57, 23.14)];
        [bezier3Path addCurveToPoint:CGPointMake(5.52, 23.33) controlPoint1:CGPointMake(5.58, 23.26) controlPoint2:CGPointMake(5.56, 23.3)];
        [bezier3Path addCurveToPoint:CGPointMake(5.39, 23.37) controlPoint1:CGPointMake(5.48, 23.36) controlPoint2:CGPointMake(5.44, 23.37)];
        [bezier3Path addLineToPoint:CGPointMake(5.32, 23.37)];
        [bezier3Path addLineToPoint:CGPointMake(5.32, 24.04)];
        [bezier3Path addCurveToPoint:CGPointMake(5.31, 24.09) controlPoint1:CGPointMake(5.32, 24.06) controlPoint2:CGPointMake(5.32, 24.08)];
        [bezier3Path addCurveToPoint:CGPointMake(5.28, 24.14) controlPoint1:CGPointMake(5.3, 24.11) controlPoint2:CGPointMake(5.29, 24.13)];
        [bezier3Path addCurveToPoint:CGPointMake(5.22, 24.18) controlPoint1:CGPointMake(5.26, 24.16) controlPoint2:CGPointMake(5.24, 24.17)];
        [bezier3Path addCurveToPoint:CGPointMake(5.13, 24.2) controlPoint1:CGPointMake(5.2, 24.19) controlPoint2:CGPointMake(5.16, 24.2)];
        [bezier3Path addCurveToPoint:CGPointMake(5.04, 24.18) controlPoint1:CGPointMake(5.1, 24.2) controlPoint2:CGPointMake(5.07, 24.2)];
        [bezier3Path addCurveToPoint:CGPointMake(4.98, 24.14) controlPoint1:CGPointMake(5.01, 24.17) controlPoint2:CGPointMake(4.99, 24.16)];
        [bezier3Path addCurveToPoint:CGPointMake(4.94, 24.09) controlPoint1:CGPointMake(4.96, 24.12) controlPoint2:CGPointMake(4.95, 24.11)];
        [bezier3Path addCurveToPoint:CGPointMake(4.93, 24.04) controlPoint1:CGPointMake(4.93, 24.07) controlPoint2:CGPointMake(4.93, 24.05)];
        [bezier3Path addLineToPoint:CGPointMake(4.93, 23.37)];
        [bezier3Path addLineToPoint:CGPointMake(4.16, 23.37)];
        [bezier3Path addCurveToPoint:CGPointMake(4.07, 23.35) controlPoint1:CGPointMake(4.11, 23.37) controlPoint2:CGPointMake(4.08, 23.36)];
        [bezier3Path addCurveToPoint:CGPointMake(4.05, 23.27) controlPoint1:CGPointMake(4.06, 23.33) controlPoint2:CGPointMake(4.05, 23.31)];
        [bezier3Path addLineToPoint:CGPointMake(4.05, 22.36)];
        [bezier3Path addCurveToPoint:CGPointMake(4.06, 22.3) controlPoint1:CGPointMake(4.05, 22.34) controlPoint2:CGPointMake(4.05, 22.32)];
        [bezier3Path addCurveToPoint:CGPointMake(4.09, 22.24) controlPoint1:CGPointMake(4.06, 22.28) controlPoint2:CGPointMake(4.08, 22.26)];
        [bezier3Path addCurveToPoint:CGPointMake(4.15, 22.2) controlPoint1:CGPointMake(4.1, 22.22) controlPoint2:CGPointMake(4.12, 22.21)];
        [bezier3Path addCurveToPoint:CGPointMake(4.24, 22.18) controlPoint1:CGPointMake(4.17, 22.19) controlPoint2:CGPointMake(4.2, 22.18)];
        [bezier3Path addCurveToPoint:CGPointMake(4.39, 22.23) controlPoint1:CGPointMake(4.31, 22.18) controlPoint2:CGPointMake(4.36, 22.2)];
        [bezier3Path addCurveToPoint:CGPointMake(4.44, 22.36) controlPoint1:CGPointMake(4.42, 22.26) controlPoint2:CGPointMake(4.44, 22.31)];
        [bezier3Path addLineToPoint:CGPointMake(4.44, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(4.93, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(4.93, 22.36)];
        [bezier3Path addCurveToPoint:CGPointMake(4.98, 22.24) controlPoint1:CGPointMake(4.93, 22.31) controlPoint2:CGPointMake(4.95, 22.27)];
        [bezier3Path addCurveToPoint:CGPointMake(5.12, 22.19) controlPoint1:CGPointMake(5.01, 22.21) controlPoint2:CGPointMake(5.06, 22.19)];
        [bezier3Path addCurveToPoint:CGPointMake(5.27, 22.24) controlPoint1:CGPointMake(5.19, 22.19) controlPoint2:CGPointMake(5.24, 22.21)];
        [bezier3Path addCurveToPoint:CGPointMake(5.32, 22.36) controlPoint1:CGPointMake(5.3, 22.27) controlPoint2:CGPointMake(5.32, 22.31)];
        [bezier3Path addLineToPoint:CGPointMake(5.32, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(5.37, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(5.38, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(5.38, 23.04)];
        [bezier3Path closePath];
        bezier3Path.miterLimit = 4;

        [fillColor setFill];
        [bezier3Path fill];

        //// Bezier 4 Drawing
        UIBezierPath *bezier4Path = [UIBezierPath bezierPath];
        [bezier4Path moveToPoint:CGPointMake(7.69, 23.59)];
        [bezier4Path addCurveToPoint:CGPointMake(7.65, 23.88) controlPoint1:CGPointMake(7.69, 23.71) controlPoint2:CGPointMake(7.68, 23.8)];
        [bezier4Path addCurveToPoint:CGPointMake(7.52, 24.07) controlPoint1:CGPointMake(7.63, 23.96) controlPoint2:CGPointMake(7.58, 24.02)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 24.17) controlPoint1:CGPointMake(7.46, 24.12) controlPoint2:CGPointMake(7.38, 24.15)];
        [bezier4Path addCurveToPoint:CGPointMake(6.87, 24.2) controlPoint1:CGPointMake(7.16, 24.19) controlPoint2:CGPointMake(7.03, 24.2)];
        [bezier4Path addLineToPoint:CGPointMake(6.85, 24.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.72, 24.2) controlPoint1:CGPointMake(6.81, 24.2) controlPoint2:CGPointMake(6.77, 24.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.57, 24.19) controlPoint1:CGPointMake(6.67, 24.2) controlPoint2:CGPointMake(6.62, 24.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.43, 24.16) controlPoint1:CGPointMake(6.52, 24.18) controlPoint2:CGPointMake(6.47, 24.18)];
        [bezier4Path addCurveToPoint:CGPointMake(6.3, 24.11) controlPoint1:CGPointMake(6.38, 24.15) controlPoint2:CGPointMake(6.34, 24.13)];
        [bezier4Path addCurveToPoint:CGPointMake(6.21, 24.03) controlPoint1:CGPointMake(6.26, 24.09) controlPoint2:CGPointMake(6.23, 24.06)];
        [bezier4Path addCurveToPoint:CGPointMake(6.17, 23.92) controlPoint1:CGPointMake(6.19, 24) controlPoint2:CGPointMake(6.17, 23.96)];
        [bezier4Path addLineToPoint:CGPointMake(6.17, 23.91)];
        [bezier4Path addCurveToPoint:CGPointMake(6.23, 23.79) controlPoint1:CGPointMake(6.17, 23.86) controlPoint2:CGPointMake(6.19, 23.82)];
        [bezier4Path addCurveToPoint:CGPointMake(6.35, 23.75) controlPoint1:CGPointMake(6.27, 23.76) controlPoint2:CGPointMake(6.31, 23.75)];
        [bezier4Path addLineToPoint:CGPointMake(6.36, 23.75)];
        [bezier4Path addCurveToPoint:CGPointMake(6.42, 23.75) controlPoint1:CGPointMake(6.39, 23.75) controlPoint2:CGPointMake(6.41, 23.75)];
        [bezier4Path addCurveToPoint:CGPointMake(6.46, 23.76) controlPoint1:CGPointMake(6.44, 23.76) controlPoint2:CGPointMake(6.45, 23.76)];
        [bezier4Path addCurveToPoint:CGPointMake(6.49, 23.78) controlPoint1:CGPointMake(6.47, 23.77) controlPoint2:CGPointMake(6.48, 23.77)];
        [bezier4Path addCurveToPoint:CGPointMake(6.52, 23.8) controlPoint1:CGPointMake(6.5, 23.79) controlPoint2:CGPointMake(6.51, 23.79)];
        [bezier4Path addLineToPoint:CGPointMake(6.52, 23.8)];
        [bezier4Path addCurveToPoint:CGPointMake(6.56, 23.83) controlPoint1:CGPointMake(6.53, 23.81) controlPoint2:CGPointMake(6.55, 23.82)];
        [bezier4Path addCurveToPoint:CGPointMake(6.62, 23.85) controlPoint1:CGPointMake(6.57, 23.84) controlPoint2:CGPointMake(6.6, 23.84)];
        [bezier4Path addCurveToPoint:CGPointMake(6.72, 23.86) controlPoint1:CGPointMake(6.65, 23.86) controlPoint2:CGPointMake(6.68, 23.86)];
        [bezier4Path addCurveToPoint:CGPointMake(6.88, 23.87) controlPoint1:CGPointMake(6.76, 23.86) controlPoint2:CGPointMake(6.82, 23.87)];
        [bezier4Path addLineToPoint:CGPointMake(6.9, 23.87)];
        [bezier4Path addCurveToPoint:CGPointMake(7.09, 23.85) controlPoint1:CGPointMake(6.98, 23.87) controlPoint2:CGPointMake(7.05, 23.86)];
        [bezier4Path addCurveToPoint:CGPointMake(7.21, 23.8) controlPoint1:CGPointMake(7.14, 23.84) controlPoint2:CGPointMake(7.18, 23.82)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 23.71) controlPoint1:CGPointMake(7.24, 23.78) controlPoint2:CGPointMake(7.26, 23.74)];
        [bezier4Path addCurveToPoint:CGPointMake(7.29, 23.58) controlPoint1:CGPointMake(7.28, 23.67) controlPoint2:CGPointMake(7.29, 23.63)];
        [bezier4Path addCurveToPoint:CGPointMake(7.25, 23.39) controlPoint1:CGPointMake(7.29, 23.49) controlPoint2:CGPointMake(7.28, 23.42)];
        [bezier4Path addCurveToPoint:CGPointMake(7.12, 23.33) controlPoint1:CGPointMake(7.23, 23.35) controlPoint2:CGPointMake(7.19, 23.33)];
        [bezier4Path addLineToPoint:CGPointMake(6.7, 23.33)];
        [bezier4Path addCurveToPoint:CGPointMake(6.63, 23.32) controlPoint1:CGPointMake(6.68, 23.33) controlPoint2:CGPointMake(6.65, 23.33)];
        [bezier4Path addCurveToPoint:CGPointMake(6.57, 23.3) controlPoint1:CGPointMake(6.61, 23.32) controlPoint2:CGPointMake(6.58, 23.31)];
        [bezier4Path addCurveToPoint:CGPointMake(6.53, 23.25) controlPoint1:CGPointMake(6.55, 23.29) controlPoint2:CGPointMake(6.54, 23.27)];
        [bezier4Path addCurveToPoint:CGPointMake(6.51, 23.17) controlPoint1:CGPointMake(6.52, 23.23) controlPoint2:CGPointMake(6.51, 23.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.57, 23.04) controlPoint1:CGPointMake(6.51, 23.11) controlPoint2:CGPointMake(6.53, 23.07)];
        [bezier4Path addCurveToPoint:CGPointMake(6.7, 23) controlPoint1:CGPointMake(6.61, 23.02) controlPoint2:CGPointMake(6.65, 23)];
        [bezier4Path addLineToPoint:CGPointMake(7.1, 23)];
        [bezier4Path addCurveToPoint:CGPointMake(7.18, 22.99) controlPoint1:CGPointMake(7.13, 23) controlPoint2:CGPointMake(7.15, 23)];
        [bezier4Path addCurveToPoint:CGPointMake(7.24, 22.95) controlPoint1:CGPointMake(7.2, 22.98) controlPoint2:CGPointMake(7.22, 22.97)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 22.88) controlPoint1:CGPointMake(7.25, 22.93) controlPoint2:CGPointMake(7.27, 22.91)];
        [bezier4Path addCurveToPoint:CGPointMake(7.28, 22.76) controlPoint1:CGPointMake(7.28, 22.85) controlPoint2:CGPointMake(7.28, 22.81)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 22.63) controlPoint1:CGPointMake(7.28, 22.71) controlPoint2:CGPointMake(7.28, 22.66)];
        [bezier4Path addCurveToPoint:CGPointMake(7.22, 22.54) controlPoint1:CGPointMake(7.27, 22.59) controlPoint2:CGPointMake(7.25, 22.56)];
        [bezier4Path addCurveToPoint:CGPointMake(7.11, 22.49) controlPoint1:CGPointMake(7.2, 22.52) controlPoint2:CGPointMake(7.16, 22.5)];
        [bezier4Path addCurveToPoint:CGPointMake(6.92, 22.5) controlPoint1:CGPointMake(7.07, 22.5) controlPoint2:CGPointMake(7, 22.5)];
        [bezier4Path addLineToPoint:CGPointMake(6.9, 22.5)];
        [bezier4Path addCurveToPoint:CGPointMake(6.73, 22.51) controlPoint1:CGPointMake(6.85, 22.5) controlPoint2:CGPointMake(6.79, 22.5)];
        [bezier4Path addCurveToPoint:CGPointMake(6.59, 22.55) controlPoint1:CGPointMake(6.67, 22.52) controlPoint2:CGPointMake(6.62, 22.53)];
        [bezier4Path addCurveToPoint:CGPointMake(6.54, 22.57) controlPoint1:CGPointMake(6.57, 22.56) controlPoint2:CGPointMake(6.56, 22.57)];
        [bezier4Path addCurveToPoint:CGPointMake(6.5, 22.59) controlPoint1:CGPointMake(6.53, 22.58) controlPoint2:CGPointMake(6.51, 22.59)];
        [bezier4Path addCurveToPoint:CGPointMake(6.47, 22.61) controlPoint1:CGPointMake(6.5, 22.6) controlPoint2:CGPointMake(6.48, 22.6)];
        [bezier4Path addCurveToPoint:CGPointMake(6.41, 22.61) controlPoint1:CGPointMake(6.45, 22.61) controlPoint2:CGPointMake(6.44, 22.61)];
        [bezier4Path addLineToPoint:CGPointMake(6.4, 22.61)];
        [bezier4Path addCurveToPoint:CGPointMake(6.28, 22.56) controlPoint1:CGPointMake(6.35, 22.61) controlPoint2:CGPointMake(6.31, 22.59)];
        [bezier4Path addCurveToPoint:CGPointMake(6.23, 22.45) controlPoint1:CGPointMake(6.24, 22.53) controlPoint2:CGPointMake(6.23, 22.49)];
        [bezier4Path addLineToPoint:CGPointMake(6.23, 22.45)];
        [bezier4Path addCurveToPoint:CGPointMake(6.27, 22.33) controlPoint1:CGPointMake(6.23, 22.4) controlPoint2:CGPointMake(6.25, 22.36)];
        [bezier4Path addCurveToPoint:CGPointMake(6.39, 22.24) controlPoint1:CGPointMake(6.3, 22.29) controlPoint2:CGPointMake(6.34, 22.27)];
        [bezier4Path addCurveToPoint:CGPointMake(6.59, 22.18) controlPoint1:CGPointMake(6.44, 22.22) controlPoint2:CGPointMake(6.51, 22.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.9, 22.16) controlPoint1:CGPointMake(6.68, 22.17) controlPoint2:CGPointMake(6.78, 22.16)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 22.18) controlPoint1:CGPointMake(7.04, 22.16) controlPoint2:CGPointMake(7.17, 22.17)];
        [bezier4Path addCurveToPoint:CGPointMake(7.52, 22.26) controlPoint1:CGPointMake(7.37, 22.2) controlPoint2:CGPointMake(7.45, 22.22)];
        [bezier4Path addCurveToPoint:CGPointMake(7.65, 22.43) controlPoint1:CGPointMake(7.58, 22.3) controlPoint2:CGPointMake(7.63, 22.36)];
        [bezier4Path addCurveToPoint:CGPointMake(7.69, 22.71) controlPoint1:CGPointMake(7.68, 22.5) controlPoint2:CGPointMake(7.69, 22.6)];
        [bezier4Path addCurveToPoint:CGPointMake(7.68, 22.87) controlPoint1:CGPointMake(7.69, 22.77) controlPoint2:CGPointMake(7.69, 22.82)];
        [bezier4Path addCurveToPoint:CGPointMake(7.66, 22.99) controlPoint1:CGPointMake(7.67, 22.91) controlPoint2:CGPointMake(7.67, 22.95)];
        [bezier4Path addCurveToPoint:CGPointMake(7.62, 23.08) controlPoint1:CGPointMake(7.65, 23.02) controlPoint2:CGPointMake(7.64, 23.05)];
        [bezier4Path addCurveToPoint:CGPointMake(7.57, 23.15) controlPoint1:CGPointMake(7.6, 23.11) controlPoint2:CGPointMake(7.59, 23.13)];
        [bezier4Path addCurveToPoint:CGPointMake(7.62, 23.2) controlPoint1:CGPointMake(7.59, 23.16) controlPoint2:CGPointMake(7.6, 23.18)];
        [bezier4Path addCurveToPoint:CGPointMake(7.66, 23.28) controlPoint1:CGPointMake(7.64, 23.22) controlPoint2:CGPointMake(7.65, 23.25)];
        [bezier4Path addCurveToPoint:CGPointMake(7.69, 23.4) controlPoint1:CGPointMake(7.67, 23.31) controlPoint2:CGPointMake(7.68, 23.35)];
        [bezier4Path addCurveToPoint:CGPointMake(7.69, 23.59) controlPoint1:CGPointMake(7.68, 23.46) controlPoint2:CGPointMake(7.69, 23.52)];
        [bezier4Path closePath];
        bezier4Path.miterLimit = 4;

        [fillColor setFill];
        [bezier4Path fill];

        //// Bezier 5 Drawing
        UIBezierPath *bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint:CGPointMake(9.88, 23.65)];
        [bezier5Path addLineToPoint:CGPointMake(9.88, 23.65)];
        [bezier5Path addCurveToPoint:CGPointMake(9.84, 23.91) controlPoint1:CGPointMake(9.89, 23.75) controlPoint2:CGPointMake(9.87, 23.84)];
        [bezier5Path addCurveToPoint:CGPointMake(9.68, 24.08) controlPoint1:CGPointMake(9.8, 23.98) controlPoint2:CGPointMake(9.75, 24.04)];
        [bezier5Path addCurveToPoint:CGPointMake(9.44, 24.17) controlPoint1:CGPointMake(9.61, 24.12) controlPoint2:CGPointMake(9.53, 24.15)];
        [bezier5Path addCurveToPoint:CGPointMake(9.13, 24.2) controlPoint1:CGPointMake(9.35, 24.19) controlPoint2:CGPointMake(9.24, 24.2)];
        [bezier5Path addCurveToPoint:CGPointMake(8.82, 24.17) controlPoint1:CGPointMake(9.01, 24.2) controlPoint2:CGPointMake(8.91, 24.19)];
        [bezier5Path addCurveToPoint:CGPointMake(8.58, 24.08) controlPoint1:CGPointMake(8.73, 24.15) controlPoint2:CGPointMake(8.65, 24.12)];
        [bezier5Path addCurveToPoint:CGPointMake(8.43, 23.91) controlPoint1:CGPointMake(8.52, 24.04) controlPoint2:CGPointMake(8.47, 23.98)];
        [bezier5Path addCurveToPoint:CGPointMake(8.38, 23.67) controlPoint1:CGPointMake(8.4, 23.84) controlPoint2:CGPointMake(8.38, 23.76)];
        [bezier5Path addLineToPoint:CGPointMake(8.38, 22.7)];
        [bezier5Path addCurveToPoint:CGPointMake(8.58, 22.31) controlPoint1:CGPointMake(8.38, 22.53) controlPoint2:CGPointMake(8.45, 22.4)];
        [bezier5Path addCurveToPoint:CGPointMake(9.14, 22.18) controlPoint1:CGPointMake(8.71, 22.22) controlPoint2:CGPointMake(8.9, 22.18)];
        [bezier5Path addCurveToPoint:CGPointMake(9.45, 22.21) controlPoint1:CGPointMake(9.25, 22.18) controlPoint2:CGPointMake(9.36, 22.19)];
        [bezier5Path addCurveToPoint:CGPointMake(9.68, 22.31) controlPoint1:CGPointMake(9.54, 22.23) controlPoint2:CGPointMake(9.62, 22.27)];
        [bezier5Path addCurveToPoint:CGPointMake(9.83, 22.48) controlPoint1:CGPointMake(9.75, 22.35) controlPoint2:CGPointMake(9.8, 22.41)];
        [bezier5Path addCurveToPoint:CGPointMake(9.88, 22.71) controlPoint1:CGPointMake(9.86, 22.55) controlPoint2:CGPointMake(9.88, 22.62)];
        [bezier5Path addLineToPoint:CGPointMake(9.88, 23.65)];
        [bezier5Path closePath];
        [bezier5Path moveToPoint:CGPointMake(9.49, 22.72)];
        [bezier5Path addCurveToPoint:CGPointMake(9.4, 22.55) controlPoint1:CGPointMake(9.49, 22.65) controlPoint2:CGPointMake(9.46, 22.59)];
        [bezier5Path addCurveToPoint:CGPointMake(9.13, 22.49) controlPoint1:CGPointMake(9.34, 22.51) controlPoint2:CGPointMake(9.25, 22.49)];
        [bezier5Path addCurveToPoint:CGPointMake(8.86, 22.55) controlPoint1:CGPointMake(9.01, 22.49) controlPoint2:CGPointMake(8.92, 22.51)];
        [bezier5Path addCurveToPoint:CGPointMake(8.77, 22.7) controlPoint1:CGPointMake(8.8, 22.59) controlPoint2:CGPointMake(8.77, 22.64)];
        [bezier5Path addLineToPoint:CGPointMake(8.77, 23.65)];
        [bezier5Path addCurveToPoint:CGPointMake(8.86, 23.82) controlPoint1:CGPointMake(8.77, 23.73) controlPoint2:CGPointMake(8.8, 23.78)];
        [bezier5Path addCurveToPoint:CGPointMake(9.13, 23.87) controlPoint1:CGPointMake(8.92, 23.85) controlPoint2:CGPointMake(9.01, 23.87)];
        [bezier5Path addCurveToPoint:CGPointMake(9.4, 23.82) controlPoint1:CGPointMake(9.24, 23.87) controlPoint2:CGPointMake(9.33, 23.85)];
        [bezier5Path addCurveToPoint:CGPointMake(9.5, 23.65) controlPoint1:CGPointMake(9.47, 23.79) controlPoint2:CGPointMake(9.5, 23.73)];
        [bezier5Path addLineToPoint:CGPointMake(9.5, 22.72)];
        [bezier5Path addLineToPoint:CGPointMake(9.49, 22.72)];
        [bezier5Path closePath];
        bezier5Path.miterLimit = 4;

        [fillColor setFill];
        [bezier5Path fill];

        //// Bezier 6 Drawing
        UIBezierPath *bezier6Path = [UIBezierPath bezierPath];
        [bezier6Path moveToPoint:CGPointMake(11.75, 23.04)];
        [bezier6Path addCurveToPoint:CGPointMake(11.93, 23.13) controlPoint1:CGPointMake(11.82, 23.06) controlPoint2:CGPointMake(11.88, 23.09)];
        [bezier6Path addCurveToPoint:CGPointMake(12.03, 23.31) controlPoint1:CGPointMake(11.98, 23.17) controlPoint2:CGPointMake(12.01, 23.23)];
        [bezier6Path addCurveToPoint:CGPointMake(12.06, 23.59) controlPoint1:CGPointMake(12.05, 23.38) controlPoint2:CGPointMake(12.06, 23.48)];
        [bezier6Path addCurveToPoint:CGPointMake(12.02, 23.88) controlPoint1:CGPointMake(12.06, 23.71) controlPoint2:CGPointMake(12.05, 23.8)];
        [bezier6Path addCurveToPoint:CGPointMake(11.89, 24.07) controlPoint1:CGPointMake(12, 23.96) controlPoint2:CGPointMake(11.95, 24.02)];
        [bezier6Path addCurveToPoint:CGPointMake(11.64, 24.17) controlPoint1:CGPointMake(11.83, 24.11) controlPoint2:CGPointMake(11.75, 24.15)];
        [bezier6Path addCurveToPoint:CGPointMake(11.24, 24.2) controlPoint1:CGPointMake(11.54, 24.19) controlPoint2:CGPointMake(11.4, 24.2)];
        [bezier6Path addLineToPoint:CGPointMake(11.15, 24.2)];
        [bezier6Path addCurveToPoint:CGPointMake(10.95, 24.19) controlPoint1:CGPointMake(11.09, 24.2) controlPoint2:CGPointMake(11.02, 24.2)];
        [bezier6Path addCurveToPoint:CGPointMake(10.75, 24.16) controlPoint1:CGPointMake(10.88, 24.19) controlPoint2:CGPointMake(10.81, 24.17)];
        [bezier6Path addCurveToPoint:CGPointMake(10.59, 24.08) controlPoint1:CGPointMake(10.69, 24.14) controlPoint2:CGPointMake(10.64, 24.11)];
        [bezier6Path addCurveToPoint:CGPointMake(10.52, 23.93) controlPoint1:CGPointMake(10.55, 24.04) controlPoint2:CGPointMake(10.52, 23.99)];
        [bezier6Path addLineToPoint:CGPointMake(10.52, 23.92)];
        [bezier6Path addCurveToPoint:CGPointMake(10.57, 23.8) controlPoint1:CGPointMake(10.52, 23.87) controlPoint2:CGPointMake(10.54, 23.84)];
        [bezier6Path addCurveToPoint:CGPointMake(10.69, 23.75) controlPoint1:CGPointMake(10.6, 23.77) controlPoint2:CGPointMake(10.65, 23.75)];
        [bezier6Path addLineToPoint:CGPointMake(10.69, 23.75)];
        [bezier6Path addCurveToPoint:CGPointMake(10.78, 23.76) controlPoint1:CGPointMake(10.73, 23.75) controlPoint2:CGPointMake(10.76, 23.76)];
        [bezier6Path addCurveToPoint:CGPointMake(10.83, 23.78) controlPoint1:CGPointMake(10.8, 23.77) controlPoint2:CGPointMake(10.82, 23.78)];
        [bezier6Path addCurveToPoint:CGPointMake(10.88, 23.81) controlPoint1:CGPointMake(10.85, 23.79) controlPoint2:CGPointMake(10.86, 23.8)];
        [bezier6Path addCurveToPoint:CGPointMake(10.95, 23.84) controlPoint1:CGPointMake(10.9, 23.82) controlPoint2:CGPointMake(10.92, 23.83)];
        [bezier6Path addCurveToPoint:CGPointMake(11.07, 23.86) controlPoint1:CGPointMake(10.98, 23.85) controlPoint2:CGPointMake(11.02, 23.85)];
        [bezier6Path addCurveToPoint:CGPointMake(11.26, 23.87) controlPoint1:CGPointMake(11.12, 23.87) controlPoint2:CGPointMake(11.18, 23.87)];
        [bezier6Path addCurveToPoint:CGPointMake(11.45, 23.85) controlPoint1:CGPointMake(11.34, 23.87) controlPoint2:CGPointMake(11.4, 23.86)];
        [bezier6Path addCurveToPoint:CGPointMake(11.57, 23.8) controlPoint1:CGPointMake(11.5, 23.84) controlPoint2:CGPointMake(11.54, 23.82)];
        [bezier6Path addCurveToPoint:CGPointMake(11.63, 23.71) controlPoint1:CGPointMake(11.6, 23.78) controlPoint2:CGPointMake(11.62, 23.74)];
        [bezier6Path addCurveToPoint:CGPointMake(11.65, 23.58) controlPoint1:CGPointMake(11.64, 23.67) controlPoint2:CGPointMake(11.65, 23.63)];
        [bezier6Path addCurveToPoint:CGPointMake(11.61, 23.39) controlPoint1:CGPointMake(11.65, 23.49) controlPoint2:CGPointMake(11.64, 23.43)];
        [bezier6Path addCurveToPoint:CGPointMake(11.48, 23.33) controlPoint1:CGPointMake(11.59, 23.35) controlPoint2:CGPointMake(11.54, 23.33)];
        [bezier6Path addLineToPoint:CGPointMake(10.82, 23.33)];
        [bezier6Path addCurveToPoint:CGPointMake(10.68, 23.32) controlPoint1:CGPointMake(10.76, 23.33) controlPoint2:CGPointMake(10.72, 23.33)];
        [bezier6Path addCurveToPoint:CGPointMake(10.6, 23.29) controlPoint1:CGPointMake(10.65, 23.32) controlPoint2:CGPointMake(10.62, 23.3)];
        [bezier6Path addCurveToPoint:CGPointMake(10.56, 23.22) controlPoint1:CGPointMake(10.58, 23.27) controlPoint2:CGPointMake(10.57, 23.25)];
        [bezier6Path addCurveToPoint:CGPointMake(10.55, 23.1) controlPoint1:CGPointMake(10.55, 23.19) controlPoint2:CGPointMake(10.55, 23.15)];
        [bezier6Path addLineToPoint:CGPointMake(10.55, 22.36)];
        [bezier6Path addCurveToPoint:CGPointMake(10.6, 22.23) controlPoint1:CGPointMake(10.55, 22.3) controlPoint2:CGPointMake(10.57, 22.26)];
        [bezier6Path addCurveToPoint:CGPointMake(10.77, 22.19) controlPoint1:CGPointMake(10.63, 22.2) controlPoint2:CGPointMake(10.69, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(10.89, 22.19) controlPoint1:CGPointMake(10.79, 22.19) controlPoint2:CGPointMake(10.83, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.07, 22.19) controlPoint1:CGPointMake(10.94, 22.19) controlPoint2:CGPointMake(11, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.28, 22.19) controlPoint1:CGPointMake(11.13, 22.19) controlPoint2:CGPointMake(11.2, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.48, 22.19) controlPoint1:CGPointMake(11.35, 22.19) controlPoint2:CGPointMake(11.42, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.64, 22.19) controlPoint1:CGPointMake(11.54, 22.19) controlPoint2:CGPointMake(11.59, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.72, 22.19) controlPoint1:CGPointMake(11.68, 22.19) controlPoint2:CGPointMake(11.71, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.79, 22.2) controlPoint1:CGPointMake(11.74, 22.19) controlPoint2:CGPointMake(11.76, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.86, 22.22) controlPoint1:CGPointMake(11.81, 22.2) controlPoint2:CGPointMake(11.84, 22.21)];
        [bezier6Path addCurveToPoint:CGPointMake(11.92, 22.27) controlPoint1:CGPointMake(11.88, 22.23) controlPoint2:CGPointMake(11.9, 22.25)];
        [bezier6Path addCurveToPoint:CGPointMake(11.94, 22.35) controlPoint1:CGPointMake(11.93, 22.29) controlPoint2:CGPointMake(11.94, 22.32)];
        [bezier6Path addLineToPoint:CGPointMake(11.94, 22.35)];
        [bezier6Path addCurveToPoint:CGPointMake(11.92, 22.44) controlPoint1:CGPointMake(11.94, 22.39) controlPoint2:CGPointMake(11.93, 22.42)];
        [bezier6Path addCurveToPoint:CGPointMake(11.87, 22.49) controlPoint1:CGPointMake(11.91, 22.46) controlPoint2:CGPointMake(11.89, 22.48)];
        [bezier6Path addCurveToPoint:CGPointMake(11.8, 22.51) controlPoint1:CGPointMake(11.84, 22.5) controlPoint2:CGPointMake(11.82, 22.51)];
        [bezier6Path addCurveToPoint:CGPointMake(11.71, 22.51) controlPoint1:CGPointMake(11.77, 22.51) controlPoint2:CGPointMake(11.75, 22.51)];
        [bezier6Path addLineToPoint:CGPointMake(10.93, 22.51)];
        [bezier6Path addLineToPoint:CGPointMake(10.93, 23.02)];
        [bezier6Path addLineToPoint:CGPointMake(11.45, 23.02)];
        [bezier6Path addCurveToPoint:CGPointMake(11.75, 23.04) controlPoint1:CGPointMake(11.58, 23.01) controlPoint2:CGPointMake(11.68, 23.02)];
        [bezier6Path closePath];
        bezier6Path.miterLimit = 4;

        [fillColor setFill];
        [bezier6Path fill];

        //// Bezier 7 Drawing
        UIBezierPath *bezier7Path = [UIBezierPath bezierPath];
        [bezier7Path moveToPoint:CGPointMake(14.91, 22.96)];
        [bezier7Path addCurveToPoint:CGPointMake(15.23, 23) controlPoint1:CGPointMake(15.04, 22.96) controlPoint2:CGPointMake(15.14, 22.97)];
        [bezier7Path addCurveToPoint:CGPointMake(15.44, 23.12) controlPoint1:CGPointMake(15.32, 23.03) controlPoint2:CGPointMake(15.39, 23.07)];
        [bezier7Path addCurveToPoint:CGPointMake(15.55, 23.32) controlPoint1:CGPointMake(15.49, 23.17) controlPoint2:CGPointMake(15.53, 23.24)];
        [bezier7Path addCurveToPoint:CGPointMake(15.59, 23.59) controlPoint1:CGPointMake(15.58, 23.4) controlPoint2:CGPointMake(15.59, 23.49)];
        [bezier7Path addCurveToPoint:CGPointMake(15.55, 23.85) controlPoint1:CGPointMake(15.59, 23.69) controlPoint2:CGPointMake(15.58, 23.78)];
        [bezier7Path addCurveToPoint:CGPointMake(15.42, 24.04) controlPoint1:CGPointMake(15.52, 23.93) controlPoint2:CGPointMake(15.48, 23.99)];
        [bezier7Path addCurveToPoint:CGPointMake(15.19, 24.16) controlPoint1:CGPointMake(15.36, 24.09) controlPoint2:CGPointMake(15.28, 24.13)];
        [bezier7Path addCurveToPoint:CGPointMake(14.83, 24.2) controlPoint1:CGPointMake(15.09, 24.19) controlPoint2:CGPointMake(14.97, 24.2)];
        [bezier7Path addCurveToPoint:CGPointMake(14.53, 24.17) controlPoint1:CGPointMake(14.72, 24.2) controlPoint2:CGPointMake(14.62, 24.19)];
        [bezier7Path addCurveToPoint:CGPointMake(14.3, 24.07) controlPoint1:CGPointMake(14.44, 24.15) controlPoint2:CGPointMake(14.36, 24.12)];
        [bezier7Path addCurveToPoint:CGPointMake(14.15, 23.9) controlPoint1:CGPointMake(14.23, 24.03) controlPoint2:CGPointMake(14.18, 23.97)];
        [bezier7Path addCurveToPoint:CGPointMake(14.1, 23.64) controlPoint1:CGPointMake(14.11, 23.83) controlPoint2:CGPointMake(14.1, 23.74)];
        [bezier7Path addLineToPoint:CGPointMake(14.1, 22.34)];
        [bezier7Path addCurveToPoint:CGPointMake(14.11, 22.28) controlPoint1:CGPointMake(14.1, 22.32) controlPoint2:CGPointMake(14.1, 22.3)];
        [bezier7Path addCurveToPoint:CGPointMake(14.14, 22.23) controlPoint1:CGPointMake(14.12, 22.26) controlPoint2:CGPointMake(14.13, 22.24)];
        [bezier7Path addCurveToPoint:CGPointMake(14.2, 22.19) controlPoint1:CGPointMake(14.16, 22.21) controlPoint2:CGPointMake(14.18, 22.2)];
        [bezier7Path addCurveToPoint:CGPointMake(14.29, 22.17) controlPoint1:CGPointMake(14.23, 22.18) controlPoint2:CGPointMake(14.26, 22.17)];
        [bezier7Path addCurveToPoint:CGPointMake(14.44, 22.22) controlPoint1:CGPointMake(14.35, 22.17) controlPoint2:CGPointMake(14.4, 22.19)];
        [bezier7Path addCurveToPoint:CGPointMake(14.49, 22.34) controlPoint1:CGPointMake(14.47, 22.25) controlPoint2:CGPointMake(14.49, 22.29)];
        [bezier7Path addLineToPoint:CGPointMake(14.49, 22.99)];
        [bezier7Path addCurveToPoint:CGPointMake(14.74, 22.97) controlPoint1:CGPointMake(14.58, 22.98) controlPoint2:CGPointMake(14.67, 22.97)];
        [bezier7Path addCurveToPoint:CGPointMake(14.91, 22.96) controlPoint1:CGPointMake(14.8, 22.96) controlPoint2:CGPointMake(14.86, 22.96)];
        [bezier7Path closePath];
        [bezier7Path moveToPoint:CGPointMake(15.2, 23.57)];
        [bezier7Path addCurveToPoint:CGPointMake(15.18, 23.42) controlPoint1:CGPointMake(15.2, 23.51) controlPoint2:CGPointMake(15.2, 23.46)];
        [bezier7Path addCurveToPoint:CGPointMake(15.12, 23.33) controlPoint1:CGPointMake(15.17, 23.38) controlPoint2:CGPointMake(15.15, 23.35)];
        [bezier7Path addCurveToPoint:CGPointMake(15.01, 23.29) controlPoint1:CGPointMake(15.09, 23.31) controlPoint2:CGPointMake(15.05, 23.29)];
        [bezier7Path addCurveToPoint:CGPointMake(14.83, 23.28) controlPoint1:CGPointMake(14.96, 23.28) controlPoint2:CGPointMake(14.91, 23.28)];
        [bezier7Path addCurveToPoint:CGPointMake(14.69, 23.28) controlPoint1:CGPointMake(14.78, 23.28) controlPoint2:CGPointMake(14.73, 23.28)];
        [bezier7Path addCurveToPoint:CGPointMake(14.6, 23.28) controlPoint1:CGPointMake(14.65, 23.28) controlPoint2:CGPointMake(14.63, 23.28)];
        [bezier7Path addCurveToPoint:CGPointMake(14.53, 23.29) controlPoint1:CGPointMake(14.58, 23.28) controlPoint2:CGPointMake(14.56, 23.28)];
        [bezier7Path addCurveToPoint:CGPointMake(14.47, 23.3) controlPoint1:CGPointMake(14.51, 23.29) controlPoint2:CGPointMake(14.49, 23.3)];
        [bezier7Path addLineToPoint:CGPointMake(14.47, 23.56)];
        [bezier7Path addCurveToPoint:CGPointMake(14.49, 23.7) controlPoint1:CGPointMake(14.47, 23.61) controlPoint2:CGPointMake(14.47, 23.66)];
        [bezier7Path addCurveToPoint:CGPointMake(14.54, 23.8) controlPoint1:CGPointMake(14.5, 23.74) controlPoint2:CGPointMake(14.52, 23.77)];
        [bezier7Path addCurveToPoint:CGPointMake(14.65, 23.86) controlPoint1:CGPointMake(14.57, 23.83) controlPoint2:CGPointMake(14.61, 23.85)];
        [bezier7Path addCurveToPoint:CGPointMake(14.82, 23.88) controlPoint1:CGPointMake(14.7, 23.87) controlPoint2:CGPointMake(14.75, 23.88)];
        [bezier7Path addCurveToPoint:CGPointMake(14.99, 23.87) controlPoint1:CGPointMake(14.88, 23.88) controlPoint2:CGPointMake(14.94, 23.88)];
        [bezier7Path addCurveToPoint:CGPointMake(15.1, 23.83) controlPoint1:CGPointMake(15.03, 23.86) controlPoint2:CGPointMake(15.07, 23.85)];
        [bezier7Path addCurveToPoint:CGPointMake(15.16, 23.74) controlPoint1:CGPointMake(15.13, 23.81) controlPoint2:CGPointMake(15.15, 23.78)];
        [bezier7Path addCurveToPoint:CGPointMake(15.2, 23.57) controlPoint1:CGPointMake(15.19, 23.69) controlPoint2:CGPointMake(15.2, 23.64)];
        [bezier7Path closePath];
        bezier7Path.miterLimit = 4;

        [fillColor setFill];
        [bezier7Path fill];

        //// Bezier 8 Drawing
        UIBezierPath *bezier8Path = [UIBezierPath bezierPath];
        [bezier8Path moveToPoint:CGPointMake(17.69, 23.65)];
        [bezier8Path addLineToPoint:CGPointMake(17.69, 23.65)];
        [bezier8Path addCurveToPoint:CGPointMake(17.64, 23.91) controlPoint1:CGPointMake(17.7, 23.75) controlPoint2:CGPointMake(17.68, 23.84)];
        [bezier8Path addCurveToPoint:CGPointMake(17.48, 24.08) controlPoint1:CGPointMake(17.6, 23.98) controlPoint2:CGPointMake(17.55, 24.04)];
        [bezier8Path addCurveToPoint:CGPointMake(17.24, 24.17) controlPoint1:CGPointMake(17.41, 24.12) controlPoint2:CGPointMake(17.33, 24.15)];
        [bezier8Path addCurveToPoint:CGPointMake(16.93, 24.2) controlPoint1:CGPointMake(17.15, 24.19) controlPoint2:CGPointMake(17.04, 24.2)];
        [bezier8Path addCurveToPoint:CGPointMake(16.62, 24.17) controlPoint1:CGPointMake(16.82, 24.2) controlPoint2:CGPointMake(16.71, 24.19)];
        [bezier8Path addCurveToPoint:CGPointMake(16.39, 24.08) controlPoint1:CGPointMake(16.53, 24.15) controlPoint2:CGPointMake(16.45, 24.12)];
        [bezier8Path addCurveToPoint:CGPointMake(16.24, 23.91) controlPoint1:CGPointMake(16.33, 24.04) controlPoint2:CGPointMake(16.28, 23.98)];
        [bezier8Path addCurveToPoint:CGPointMake(16.19, 23.67) controlPoint1:CGPointMake(16.2, 23.84) controlPoint2:CGPointMake(16.19, 23.76)];
        [bezier8Path addLineToPoint:CGPointMake(16.19, 22.7)];
        [bezier8Path addCurveToPoint:CGPointMake(16.39, 22.31) controlPoint1:CGPointMake(16.19, 22.53) controlPoint2:CGPointMake(16.26, 22.4)];
        [bezier8Path addCurveToPoint:CGPointMake(16.95, 22.18) controlPoint1:CGPointMake(16.52, 22.22) controlPoint2:CGPointMake(16.71, 22.18)];
        [bezier8Path addCurveToPoint:CGPointMake(17.26, 22.21) controlPoint1:CGPointMake(17.06, 22.18) controlPoint2:CGPointMake(17.16, 22.19)];
        [bezier8Path addCurveToPoint:CGPointMake(17.5, 22.31) controlPoint1:CGPointMake(17.35, 22.23) controlPoint2:CGPointMake(17.43, 22.27)];
        [bezier8Path addCurveToPoint:CGPointMake(17.65, 22.48) controlPoint1:CGPointMake(17.56, 22.35) controlPoint2:CGPointMake(17.61, 22.41)];
        [bezier8Path addCurveToPoint:CGPointMake(17.7, 22.71) controlPoint1:CGPointMake(17.69, 22.55) controlPoint2:CGPointMake(17.7, 22.62)];
        [bezier8Path addLineToPoint:CGPointMake(17.7, 23.65)];
        [bezier8Path addLineToPoint:CGPointMake(17.69, 23.65)];
        [bezier8Path closePath];
        [bezier8Path moveToPoint:CGPointMake(17.3, 22.72)];
        [bezier8Path addCurveToPoint:CGPointMake(17.21, 22.55) controlPoint1:CGPointMake(17.3, 22.65) controlPoint2:CGPointMake(17.27, 22.59)];
        [bezier8Path addCurveToPoint:CGPointMake(16.93, 22.49) controlPoint1:CGPointMake(17.15, 22.51) controlPoint2:CGPointMake(17.06, 22.49)];
        [bezier8Path addCurveToPoint:CGPointMake(16.66, 22.55) controlPoint1:CGPointMake(16.81, 22.49) controlPoint2:CGPointMake(16.72, 22.51)];
        [bezier8Path addCurveToPoint:CGPointMake(16.57, 22.7) controlPoint1:CGPointMake(16.6, 22.59) controlPoint2:CGPointMake(16.57, 22.64)];
        [bezier8Path addLineToPoint:CGPointMake(16.57, 23.65)];
        [bezier8Path addCurveToPoint:CGPointMake(16.66, 23.82) controlPoint1:CGPointMake(16.57, 23.73) controlPoint2:CGPointMake(16.6, 23.78)];
        [bezier8Path addCurveToPoint:CGPointMake(16.92, 23.87) controlPoint1:CGPointMake(16.72, 23.85) controlPoint2:CGPointMake(16.81, 23.87)];
        [bezier8Path addCurveToPoint:CGPointMake(17.19, 23.82) controlPoint1:CGPointMake(17.04, 23.87) controlPoint2:CGPointMake(17.12, 23.85)];
        [bezier8Path addCurveToPoint:CGPointMake(17.29, 23.65) controlPoint1:CGPointMake(17.25, 23.79) controlPoint2:CGPointMake(17.29, 23.73)];
        [bezier8Path addLineToPoint:CGPointMake(17.29, 22.72)];
        [bezier8Path addLineToPoint:CGPointMake(17.3, 22.72)];
        [bezier8Path closePath];
        bezier8Path.miterLimit = 4;

        [fillColor setFill];
        [bezier8Path fill];

        //// Bezier 9 Drawing
        UIBezierPath *bezier9Path = [UIBezierPath bezierPath];
        [bezier9Path moveToPoint:CGPointMake(19.56, 23.04)];
        [bezier9Path addCurveToPoint:CGPointMake(19.74, 23.13) controlPoint1:CGPointMake(19.63, 23.06) controlPoint2:CGPointMake(19.69, 23.09)];
        [bezier9Path addCurveToPoint:CGPointMake(19.83, 23.31) controlPoint1:CGPointMake(19.79, 23.17) controlPoint2:CGPointMake(19.82, 23.23)];
        [bezier9Path addCurveToPoint:CGPointMake(19.86, 23.59) controlPoint1:CGPointMake(19.85, 23.38) controlPoint2:CGPointMake(19.86, 23.48)];
        [bezier9Path addCurveToPoint:CGPointMake(19.82, 23.88) controlPoint1:CGPointMake(19.86, 23.71) controlPoint2:CGPointMake(19.85, 23.8)];
        [bezier9Path addCurveToPoint:CGPointMake(19.69, 24.07) controlPoint1:CGPointMake(19.8, 23.96) controlPoint2:CGPointMake(19.75, 24.02)];
        [bezier9Path addCurveToPoint:CGPointMake(19.44, 24.17) controlPoint1:CGPointMake(19.63, 24.11) controlPoint2:CGPointMake(19.55, 24.15)];
        [bezier9Path addCurveToPoint:CGPointMake(19.04, 24.2) controlPoint1:CGPointMake(19.34, 24.19) controlPoint2:CGPointMake(19.2, 24.2)];
        [bezier9Path addLineToPoint:CGPointMake(18.96, 24.2)];
        [bezier9Path addCurveToPoint:CGPointMake(18.76, 24.19) controlPoint1:CGPointMake(18.9, 24.2) controlPoint2:CGPointMake(18.83, 24.2)];
        [bezier9Path addCurveToPoint:CGPointMake(18.56, 24.16) controlPoint1:CGPointMake(18.69, 24.19) controlPoint2:CGPointMake(18.62, 24.17)];
        [bezier9Path addCurveToPoint:CGPointMake(18.4, 24.08) controlPoint1:CGPointMake(18.5, 24.14) controlPoint2:CGPointMake(18.45, 24.11)];
        [bezier9Path addCurveToPoint:CGPointMake(18.33, 23.93) controlPoint1:CGPointMake(18.36, 24.04) controlPoint2:CGPointMake(18.33, 23.99)];
        [bezier9Path addLineToPoint:CGPointMake(18.33, 23.92)];
        [bezier9Path addCurveToPoint:CGPointMake(18.38, 23.8) controlPoint1:CGPointMake(18.33, 23.87) controlPoint2:CGPointMake(18.35, 23.84)];
        [bezier9Path addCurveToPoint:CGPointMake(18.5, 23.75) controlPoint1:CGPointMake(18.41, 23.77) controlPoint2:CGPointMake(18.45, 23.75)];
        [bezier9Path addLineToPoint:CGPointMake(18.51, 23.75)];
        [bezier9Path addCurveToPoint:CGPointMake(18.6, 23.76) controlPoint1:CGPointMake(18.55, 23.75) controlPoint2:CGPointMake(18.58, 23.76)];
        [bezier9Path addCurveToPoint:CGPointMake(18.65, 23.78) controlPoint1:CGPointMake(18.62, 23.77) controlPoint2:CGPointMake(18.64, 23.78)];
        [bezier9Path addCurveToPoint:CGPointMake(18.7, 23.81) controlPoint1:CGPointMake(18.67, 23.79) controlPoint2:CGPointMake(18.68, 23.8)];
        [bezier9Path addCurveToPoint:CGPointMake(18.77, 23.84) controlPoint1:CGPointMake(18.71, 23.82) controlPoint2:CGPointMake(18.74, 23.83)];
        [bezier9Path addCurveToPoint:CGPointMake(18.89, 23.86) controlPoint1:CGPointMake(18.8, 23.85) controlPoint2:CGPointMake(18.84, 23.85)];
        [bezier9Path addCurveToPoint:CGPointMake(19.08, 23.87) controlPoint1:CGPointMake(18.94, 23.87) controlPoint2:CGPointMake(19, 23.87)];
        [bezier9Path addCurveToPoint:CGPointMake(19.27, 23.85) controlPoint1:CGPointMake(19.16, 23.87) controlPoint2:CGPointMake(19.22, 23.86)];
        [bezier9Path addCurveToPoint:CGPointMake(19.39, 23.8) controlPoint1:CGPointMake(19.32, 23.84) controlPoint2:CGPointMake(19.36, 23.82)];
        [bezier9Path addCurveToPoint:CGPointMake(19.45, 23.71) controlPoint1:CGPointMake(19.42, 23.78) controlPoint2:CGPointMake(19.44, 23.74)];
        [bezier9Path addCurveToPoint:CGPointMake(19.46, 23.58) controlPoint1:CGPointMake(19.46, 23.67) controlPoint2:CGPointMake(19.46, 23.63)];
        [bezier9Path addCurveToPoint:CGPointMake(19.43, 23.39) controlPoint1:CGPointMake(19.46, 23.49) controlPoint2:CGPointMake(19.45, 23.43)];
        [bezier9Path addCurveToPoint:CGPointMake(19.3, 23.33) controlPoint1:CGPointMake(19.41, 23.35) controlPoint2:CGPointMake(19.36, 23.33)];
        [bezier9Path addLineToPoint:CGPointMake(18.63, 23.33)];
        [bezier9Path addCurveToPoint:CGPointMake(18.49, 23.32) controlPoint1:CGPointMake(18.57, 23.33) controlPoint2:CGPointMake(18.52, 23.33)];
        [bezier9Path addCurveToPoint:CGPointMake(18.41, 23.29) controlPoint1:CGPointMake(18.46, 23.32) controlPoint2:CGPointMake(18.43, 23.3)];
        [bezier9Path addCurveToPoint:CGPointMake(18.37, 23.22) controlPoint1:CGPointMake(18.39, 23.27) controlPoint2:CGPointMake(18.38, 23.25)];
        [bezier9Path addCurveToPoint:CGPointMake(18.36, 23.1) controlPoint1:CGPointMake(18.36, 23.19) controlPoint2:CGPointMake(18.36, 23.15)];
        [bezier9Path addLineToPoint:CGPointMake(18.36, 22.36)];
        [bezier9Path addCurveToPoint:CGPointMake(18.41, 22.23) controlPoint1:CGPointMake(18.36, 22.3) controlPoint2:CGPointMake(18.38, 22.26)];
        [bezier9Path addCurveToPoint:CGPointMake(18.58, 22.19) controlPoint1:CGPointMake(18.44, 22.2) controlPoint2:CGPointMake(18.5, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(18.7, 22.19) controlPoint1:CGPointMake(18.6, 22.19) controlPoint2:CGPointMake(18.64, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(18.88, 22.19) controlPoint1:CGPointMake(18.75, 22.19) controlPoint2:CGPointMake(18.82, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.08, 22.19) controlPoint1:CGPointMake(18.95, 22.19) controlPoint2:CGPointMake(19.01, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.28, 22.19) controlPoint1:CGPointMake(19.15, 22.19) controlPoint2:CGPointMake(19.22, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.44, 22.19) controlPoint1:CGPointMake(19.34, 22.19) controlPoint2:CGPointMake(19.4, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.52, 22.19) controlPoint1:CGPointMake(19.48, 22.19) controlPoint2:CGPointMake(19.51, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.59, 22.2) controlPoint1:CGPointMake(19.54, 22.19) controlPoint2:CGPointMake(19.57, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.66, 22.22) controlPoint1:CGPointMake(19.62, 22.2) controlPoint2:CGPointMake(19.64, 22.21)];
        [bezier9Path addCurveToPoint:CGPointMake(19.72, 22.27) controlPoint1:CGPointMake(19.68, 22.23) controlPoint2:CGPointMake(19.7, 22.25)];
        [bezier9Path addCurveToPoint:CGPointMake(19.74, 22.35) controlPoint1:CGPointMake(19.74, 22.29) controlPoint2:CGPointMake(19.74, 22.32)];
        [bezier9Path addLineToPoint:CGPointMake(19.74, 22.35)];
        [bezier9Path addCurveToPoint:CGPointMake(19.72, 22.44) controlPoint1:CGPointMake(19.74, 22.39) controlPoint2:CGPointMake(19.73, 22.42)];
        [bezier9Path addCurveToPoint:CGPointMake(19.67, 22.49) controlPoint1:CGPointMake(19.71, 22.46) controlPoint2:CGPointMake(19.69, 22.48)];
        [bezier9Path addCurveToPoint:CGPointMake(19.6, 22.51) controlPoint1:CGPointMake(19.65, 22.5) controlPoint2:CGPointMake(19.63, 22.51)];
        [bezier9Path addCurveToPoint:CGPointMake(19.52, 22.51) controlPoint1:CGPointMake(19.57, 22.51) controlPoint2:CGPointMake(19.55, 22.51)];
        [bezier9Path addLineToPoint:CGPointMake(18.74, 22.51)];
        [bezier9Path addLineToPoint:CGPointMake(18.74, 23.02)];
        [bezier9Path addLineToPoint:CGPointMake(19.26, 23.02)];
        [bezier9Path addCurveToPoint:CGPointMake(19.56, 23.04) controlPoint1:CGPointMake(19.39, 23.01) controlPoint2:CGPointMake(19.49, 23.02)];
        [bezier9Path closePath];
        bezier9Path.miterLimit = 4;

        [fillColor setFill];
        [bezier9Path fill];

        //// Bezier 10 Drawing
        UIBezierPath *bezier10Path = [UIBezierPath bezierPath];
        [bezier10Path moveToPoint:CGPointMake(21.29, 22.17)];
        [bezier10Path addCurveToPoint:CGPointMake(21.66, 22.2) controlPoint1:CGPointMake(21.44, 22.17) controlPoint2:CGPointMake(21.56, 22.18)];
        [bezier10Path addCurveToPoint:CGPointMake(21.9, 22.3) controlPoint1:CGPointMake(21.76, 22.22) controlPoint2:CGPointMake(21.84, 22.25)];
        [bezier10Path addCurveToPoint:CGPointMake(22.04, 22.48) controlPoint1:CGPointMake(21.96, 22.35) controlPoint2:CGPointMake(22.01, 22.4)];
        [bezier10Path addCurveToPoint:CGPointMake(22.08, 22.75) controlPoint1:CGPointMake(22.07, 22.55) controlPoint2:CGPointMake(22.08, 22.64)];
        [bezier10Path addLineToPoint:CGPointMake(22.08, 22.76)];
        [bezier10Path addCurveToPoint:CGPointMake(22.05, 23.05) controlPoint1:CGPointMake(22.08, 22.87) controlPoint2:CGPointMake(22.07, 22.97)];
        [bezier10Path addCurveToPoint:CGPointMake(21.94, 23.23) controlPoint1:CGPointMake(22.03, 23.13) controlPoint2:CGPointMake(21.99, 23.19)];
        [bezier10Path addCurveToPoint:CGPointMake(21.74, 23.33) controlPoint1:CGPointMake(21.89, 23.28) controlPoint2:CGPointMake(21.82, 23.31)];
        [bezier10Path addCurveToPoint:CGPointMake(21.44, 23.36) controlPoint1:CGPointMake(21.66, 23.35) controlPoint2:CGPointMake(21.56, 23.36)];
        [bezier10Path addCurveToPoint:CGPointMake(21.18, 23.37) controlPoint1:CGPointMake(21.33, 23.36) controlPoint2:CGPointMake(21.25, 23.36)];
        [bezier10Path addCurveToPoint:CGPointMake(21.02, 23.4) controlPoint1:CGPointMake(21.11, 23.37) controlPoint2:CGPointMake(21.06, 23.39)];
        [bezier10Path addCurveToPoint:CGPointMake(20.94, 23.49) controlPoint1:CGPointMake(20.98, 23.42) controlPoint2:CGPointMake(20.95, 23.45)];
        [bezier10Path addCurveToPoint:CGPointMake(20.91, 23.68) controlPoint1:CGPointMake(20.92, 23.53) controlPoint2:CGPointMake(20.91, 23.6)];
        [bezier10Path addLineToPoint:CGPointMake(20.91, 23.86)];
        [bezier10Path addLineToPoint:CGPointMake(21.88, 23.86)];
        [bezier10Path addCurveToPoint:CGPointMake(21.95, 23.87) controlPoint1:CGPointMake(21.9, 23.86) controlPoint2:CGPointMake(21.93, 23.86)];
        [bezier10Path addCurveToPoint:CGPointMake(22.02, 23.9) controlPoint1:CGPointMake(21.97, 23.88) controlPoint2:CGPointMake(22, 23.89)];
        [bezier10Path addCurveToPoint:CGPointMake(22.07, 23.95) controlPoint1:CGPointMake(22.04, 23.91) controlPoint2:CGPointMake(22.06, 23.93)];
        [bezier10Path addCurveToPoint:CGPointMake(22.09, 24.02) controlPoint1:CGPointMake(22.08, 23.97) controlPoint2:CGPointMake(22.09, 23.99)];
        [bezier10Path addCurveToPoint:CGPointMake(22.07, 24.1) controlPoint1:CGPointMake(22.09, 24.05) controlPoint2:CGPointMake(22.09, 24.08)];
        [bezier10Path addCurveToPoint:CGPointMake(22.02, 24.15) controlPoint1:CGPointMake(22.06, 24.12) controlPoint2:CGPointMake(22.04, 24.14)];
        [bezier10Path addCurveToPoint:CGPointMake(21.95, 24.18) controlPoint1:CGPointMake(22, 24.16) controlPoint2:CGPointMake(21.98, 24.17)];
        [bezier10Path addCurveToPoint:CGPointMake(21.87, 24.19) controlPoint1:CGPointMake(21.92, 24.19) controlPoint2:CGPointMake(21.9, 24.19)];
        [bezier10Path addLineToPoint:CGPointMake(20.73, 24.19)];
        [bezier10Path addCurveToPoint:CGPointMake(20.56, 24.15) controlPoint1:CGPointMake(20.65, 24.19) controlPoint2:CGPointMake(20.59, 24.18)];
        [bezier10Path addCurveToPoint:CGPointMake(20.51, 24.02) controlPoint1:CGPointMake(20.53, 24.12) controlPoint2:CGPointMake(20.51, 24.08)];
        [bezier10Path addLineToPoint:CGPointMake(20.51, 23.62)];
        [bezier10Path addCurveToPoint:CGPointMake(20.55, 23.35) controlPoint1:CGPointMake(20.51, 23.51) controlPoint2:CGPointMake(20.52, 23.42)];
        [bezier10Path addCurveToPoint:CGPointMake(20.67, 23.18) controlPoint1:CGPointMake(20.58, 23.28) controlPoint2:CGPointMake(20.62, 23.22)];
        [bezier10Path addCurveToPoint:CGPointMake(20.87, 23.08) controlPoint1:CGPointMake(20.73, 23.13) controlPoint2:CGPointMake(20.79, 23.1)];
        [bezier10Path addCurveToPoint:CGPointMake(21.13, 23.05) controlPoint1:CGPointMake(20.95, 23.06) controlPoint2:CGPointMake(21.04, 23.05)];
        [bezier10Path addLineToPoint:CGPointMake(21.41, 23.04)];
        [bezier10Path addCurveToPoint:CGPointMake(21.54, 23.03) controlPoint1:CGPointMake(21.46, 23.04) controlPoint2:CGPointMake(21.51, 23.04)];
        [bezier10Path addCurveToPoint:CGPointMake(21.62, 22.99) controlPoint1:CGPointMake(21.57, 23.02) controlPoint2:CGPointMake(21.6, 23.01)];
        [bezier10Path addCurveToPoint:CGPointMake(21.67, 22.91) controlPoint1:CGPointMake(21.64, 22.97) controlPoint2:CGPointMake(21.66, 22.95)];
        [bezier10Path addCurveToPoint:CGPointMake(21.69, 22.79) controlPoint1:CGPointMake(21.68, 22.88) controlPoint2:CGPointMake(21.69, 22.84)];
        [bezier10Path addLineToPoint:CGPointMake(21.69, 22.78)];
        [bezier10Path addCurveToPoint:CGPointMake(21.67, 22.65) controlPoint1:CGPointMake(21.69, 22.73) controlPoint2:CGPointMake(21.68, 22.69)];
        [bezier10Path addCurveToPoint:CGPointMake(21.6, 22.57) controlPoint1:CGPointMake(21.66, 22.61) controlPoint2:CGPointMake(21.63, 22.59)];
        [bezier10Path addCurveToPoint:CGPointMake(21.47, 22.52) controlPoint1:CGPointMake(21.57, 22.55) controlPoint2:CGPointMake(21.53, 22.53)];
        [bezier10Path addCurveToPoint:CGPointMake(21.26, 22.51) controlPoint1:CGPointMake(21.41, 22.51) controlPoint2:CGPointMake(21.34, 22.51)];
        [bezier10Path addCurveToPoint:CGPointMake(21.07, 22.52) controlPoint1:CGPointMake(21.19, 22.51) controlPoint2:CGPointMake(21.13, 22.51)];
        [bezier10Path addCurveToPoint:CGPointMake(20.93, 22.55) controlPoint1:CGPointMake(21.01, 22.53) controlPoint2:CGPointMake(20.97, 22.54)];
        [bezier10Path addCurveToPoint:CGPointMake(20.83, 22.59) controlPoint1:CGPointMake(20.89, 22.56) controlPoint2:CGPointMake(20.86, 22.57)];
        [bezier10Path addCurveToPoint:CGPointMake(20.73, 22.61) controlPoint1:CGPointMake(20.8, 22.6) controlPoint2:CGPointMake(20.77, 22.61)];
        [bezier10Path addLineToPoint:CGPointMake(20.72, 22.61)];
        [bezier10Path addCurveToPoint:CGPointMake(20.6, 22.56) controlPoint1:CGPointMake(20.67, 22.61) controlPoint2:CGPointMake(20.63, 22.59)];
        [bezier10Path addCurveToPoint:CGPointMake(20.56, 22.44) controlPoint1:CGPointMake(20.57, 22.53) controlPoint2:CGPointMake(20.56, 22.49)];
        [bezier10Path addLineToPoint:CGPointMake(20.56, 22.43)];
        [bezier10Path addCurveToPoint:CGPointMake(20.62, 22.32) controlPoint1:CGPointMake(20.56, 22.39) controlPoint2:CGPointMake(20.58, 22.35)];
        [bezier10Path addCurveToPoint:CGPointMake(20.78, 22.25) controlPoint1:CGPointMake(20.66, 22.29) controlPoint2:CGPointMake(20.71, 22.26)];
        [bezier10Path addCurveToPoint:CGPointMake(21.01, 22.21) controlPoint1:CGPointMake(20.85, 22.23) controlPoint2:CGPointMake(20.92, 22.22)];
        [bezier10Path addCurveToPoint:CGPointMake(21.29, 22.17) controlPoint1:CGPointMake(21.1, 22.17) controlPoint2:CGPointMake(21.19, 22.17)];
        [bezier10Path closePath];
        bezier10Path.miterLimit = 4;

        [fillColor setFill];
        [bezier10Path fill];

        //// Bezier 11 Drawing
        UIBezierPath *bezier11Path = [UIBezierPath bezierPath];
        [bezier11Path moveToPoint:CGPointMake(25.63, 23.65)];
        [bezier11Path addCurveToPoint:CGPointMake(25.6, 23.88) controlPoint1:CGPointMake(25.63, 23.74) controlPoint2:CGPointMake(25.62, 23.81)];
        [bezier11Path addCurveToPoint:CGPointMake(25.49, 24.05) controlPoint1:CGPointMake(25.58, 23.95) controlPoint2:CGPointMake(25.54, 24.01)];
        [bezier11Path addCurveToPoint:CGPointMake(25.25, 24.16) controlPoint1:CGPointMake(25.43, 24.1) controlPoint2:CGPointMake(25.35, 24.13)];
        [bezier11Path addCurveToPoint:CGPointMake(24.85, 24.2) controlPoint1:CGPointMake(25.15, 24.18) controlPoint2:CGPointMake(25.01, 24.2)];
        [bezier11Path addCurveToPoint:CGPointMake(24.46, 24.16) controlPoint1:CGPointMake(24.69, 24.2) controlPoint2:CGPointMake(24.56, 24.19)];
        [bezier11Path addCurveToPoint:CGPointMake(24.23, 24.05) controlPoint1:CGPointMake(24.36, 24.13) controlPoint2:CGPointMake(24.29, 24.1)];
        [bezier11Path addCurveToPoint:CGPointMake(24.12, 23.88) controlPoint1:CGPointMake(24.18, 24) controlPoint2:CGPointMake(24.14, 23.94)];
        [bezier11Path addCurveToPoint:CGPointMake(24.09, 23.66) controlPoint1:CGPointMake(24.1, 23.81) controlPoint2:CGPointMake(24.09, 23.74)];
        [bezier11Path addCurveToPoint:CGPointMake(24.09, 23.49) controlPoint1:CGPointMake(24.09, 23.59) controlPoint2:CGPointMake(24.09, 23.54)];
        [bezier11Path addCurveToPoint:CGPointMake(24.12, 23.38) controlPoint1:CGPointMake(24.09, 23.45) controlPoint2:CGPointMake(24.1, 23.41)];
        [bezier11Path addCurveToPoint:CGPointMake(24.21, 23.3) controlPoint1:CGPointMake(24.14, 23.35) controlPoint2:CGPointMake(24.17, 23.32)];
        [bezier11Path addCurveToPoint:CGPointMake(24.38, 23.21) controlPoint1:CGPointMake(24.25, 23.27) controlPoint2:CGPointMake(24.31, 23.24)];
        [bezier11Path addCurveToPoint:CGPointMake(24.21, 23.14) controlPoint1:CGPointMake(24.31, 23.18) controlPoint2:CGPointMake(24.25, 23.16)];
        [bezier11Path addCurveToPoint:CGPointMake(24.12, 23.06) controlPoint1:CGPointMake(24.17, 23.12) controlPoint2:CGPointMake(24.14, 23.09)];
        [bezier11Path addCurveToPoint:CGPointMake(24.09, 22.94) controlPoint1:CGPointMake(24.1, 23.03) controlPoint2:CGPointMake(24.09, 22.99)];
        [bezier11Path addCurveToPoint:CGPointMake(24.08, 22.74) controlPoint1:CGPointMake(24.08, 22.89) controlPoint2:CGPointMake(24.08, 22.82)];
        [bezier11Path addCurveToPoint:CGPointMake(24.12, 22.47) controlPoint1:CGPointMake(24.08, 22.63) controlPoint2:CGPointMake(24.09, 22.54)];
        [bezier11Path addCurveToPoint:CGPointMake(24.25, 22.3) controlPoint1:CGPointMake(24.15, 22.4) controlPoint2:CGPointMake(24.19, 22.34)];
        [bezier11Path addCurveToPoint:CGPointMake(24.48, 22.21) controlPoint1:CGPointMake(24.31, 22.26) controlPoint2:CGPointMake(24.38, 22.23)];
        [bezier11Path addCurveToPoint:CGPointMake(24.83, 22.18) controlPoint1:CGPointMake(24.57, 22.19) controlPoint2:CGPointMake(24.69, 22.18)];
        [bezier11Path addCurveToPoint:CGPointMake(25.19, 22.21) controlPoint1:CGPointMake(24.97, 22.18) controlPoint2:CGPointMake(25.09, 22.19)];
        [bezier11Path addCurveToPoint:CGPointMake(25.43, 22.3) controlPoint1:CGPointMake(25.29, 22.23) controlPoint2:CGPointMake(25.37, 22.26)];
        [bezier11Path addCurveToPoint:CGPointMake(25.56, 22.47) controlPoint1:CGPointMake(25.49, 22.34) controlPoint2:CGPointMake(25.54, 22.4)];
        [bezier11Path addCurveToPoint:CGPointMake(25.6, 22.73) controlPoint1:CGPointMake(25.59, 22.54) controlPoint2:CGPointMake(25.6, 22.63)];
        [bezier11Path addCurveToPoint:CGPointMake(25.6, 22.93) controlPoint1:CGPointMake(25.6, 22.81) controlPoint2:CGPointMake(25.6, 22.88)];
        [bezier11Path addCurveToPoint:CGPointMake(25.57, 23.05) controlPoint1:CGPointMake(25.6, 22.98) controlPoint2:CGPointMake(25.59, 23.02)];
        [bezier11Path addCurveToPoint:CGPointMake(25.49, 23.13) controlPoint1:CGPointMake(25.55, 23.08) controlPoint2:CGPointMake(25.53, 23.11)];
        [bezier11Path addCurveToPoint:CGPointMake(25.33, 23.2) controlPoint1:CGPointMake(25.45, 23.15) controlPoint2:CGPointMake(25.4, 23.17)];
        [bezier11Path addCurveToPoint:CGPointMake(25.49, 23.28) controlPoint1:CGPointMake(25.4, 23.23) controlPoint2:CGPointMake(25.45, 23.26)];
        [bezier11Path addCurveToPoint:CGPointMake(25.57, 23.36) controlPoint1:CGPointMake(25.53, 23.3) controlPoint2:CGPointMake(25.56, 23.33)];
        [bezier11Path addCurveToPoint:CGPointMake(25.6, 23.47) controlPoint1:CGPointMake(25.59, 23.39) controlPoint2:CGPointMake(25.6, 23.43)];
        [bezier11Path addCurveToPoint:CGPointMake(25.63, 23.65) controlPoint1:CGPointMake(25.63, 23.51) controlPoint2:CGPointMake(25.63, 23.57)];
        [bezier11Path closePath];
        [bezier11Path moveToPoint:CGPointMake(25.25, 23.61)];
        [bezier11Path addCurveToPoint:CGPointMake(25.24, 23.58) controlPoint1:CGPointMake(25.25, 23.61) controlPoint2:CGPointMake(25.24, 23.6)];
        [bezier11Path addCurveToPoint:CGPointMake(25.19, 23.51) controlPoint1:CGPointMake(25.24, 23.56) controlPoint2:CGPointMake(25.22, 23.54)];
        [bezier11Path addCurveToPoint:CGPointMake(25.08, 23.42) controlPoint1:CGPointMake(25.17, 23.48) controlPoint2:CGPointMake(25.13, 23.45)];
        [bezier11Path addCurveToPoint:CGPointMake(24.88, 23.33) controlPoint1:CGPointMake(25.03, 23.39) controlPoint2:CGPointMake(24.96, 23.36)];
        [bezier11Path addCurveToPoint:CGPointMake(24.68, 23.43) controlPoint1:CGPointMake(24.79, 23.36) controlPoint2:CGPointMake(24.72, 23.4)];
        [bezier11Path addCurveToPoint:CGPointMake(24.57, 23.53) controlPoint1:CGPointMake(24.63, 23.46) controlPoint2:CGPointMake(24.6, 23.5)];
        [bezier11Path addCurveToPoint:CGPointMake(24.53, 23.61) controlPoint1:CGPointMake(24.55, 23.56) controlPoint2:CGPointMake(24.53, 23.59)];
        [bezier11Path addCurveToPoint:CGPointMake(24.52, 23.65) controlPoint1:CGPointMake(24.53, 23.63) controlPoint2:CGPointMake(24.52, 23.65)];
        [bezier11Path addLineToPoint:CGPointMake(24.52, 23.65)];
        [bezier11Path addCurveToPoint:CGPointMake(24.54, 23.75) controlPoint1:CGPointMake(24.52, 23.69) controlPoint2:CGPointMake(24.53, 23.73)];
        [bezier11Path addCurveToPoint:CGPointMake(24.6, 23.82) controlPoint1:CGPointMake(24.55, 23.78) controlPoint2:CGPointMake(24.57, 23.8)];
        [bezier11Path addCurveToPoint:CGPointMake(24.72, 23.86) controlPoint1:CGPointMake(24.63, 23.84) controlPoint2:CGPointMake(24.67, 23.85)];
        [bezier11Path addCurveToPoint:CGPointMake(24.91, 23.87) controlPoint1:CGPointMake(24.77, 23.87) controlPoint2:CGPointMake(24.83, 23.87)];
        [bezier11Path addCurveToPoint:CGPointMake(25.08, 23.86) controlPoint1:CGPointMake(24.98, 23.87) controlPoint2:CGPointMake(25.03, 23.87)];
        [bezier11Path addCurveToPoint:CGPointMake(25.19, 23.82) controlPoint1:CGPointMake(25.13, 23.85) controlPoint2:CGPointMake(25.16, 23.84)];
        [bezier11Path addCurveToPoint:CGPointMake(25.25, 23.75) controlPoint1:CGPointMake(25.21, 23.8) controlPoint2:CGPointMake(25.24, 23.78)];
        [bezier11Path addCurveToPoint:CGPointMake(25.27, 23.65) controlPoint1:CGPointMake(25.26, 23.72) controlPoint2:CGPointMake(25.27, 23.69)];
        [bezier11Path addLineToPoint:CGPointMake(25.27, 23.61)];
        [bezier11Path addLineToPoint:CGPointMake(25.25, 23.61)];
        [bezier11Path closePath];
        [bezier11Path moveToPoint:CGPointMake(24.88, 23.03)];
        [bezier11Path addCurveToPoint:CGPointMake(25.09, 22.98) controlPoint1:CGPointMake(24.97, 23.01) controlPoint2:CGPointMake(25.04, 22.99)];
        [bezier11Path addCurveToPoint:CGPointMake(25.2, 22.93) controlPoint1:CGPointMake(25.14, 22.96) controlPoint2:CGPointMake(25.17, 22.95)];
        [bezier11Path addCurveToPoint:CGPointMake(25.24, 22.84) controlPoint1:CGPointMake(25.22, 22.91) controlPoint2:CGPointMake(25.24, 22.88)];
        [bezier11Path addCurveToPoint:CGPointMake(25.24, 22.69) controlPoint1:CGPointMake(25.24, 22.81) controlPoint2:CGPointMake(25.24, 22.76)];
        [bezier11Path addCurveToPoint:CGPointMake(25.21, 22.58) controlPoint1:CGPointMake(25.24, 22.65) controlPoint2:CGPointMake(25.23, 22.61)];
        [bezier11Path addCurveToPoint:CGPointMake(25.14, 22.52) controlPoint1:CGPointMake(25.19, 22.55) controlPoint2:CGPointMake(25.17, 22.53)];
        [bezier11Path addCurveToPoint:CGPointMake(25.02, 22.5) controlPoint1:CGPointMake(25.11, 22.51) controlPoint2:CGPointMake(25.07, 22.5)];
        [bezier11Path addCurveToPoint:CGPointMake(24.87, 22.5) controlPoint1:CGPointMake(24.97, 22.5) controlPoint2:CGPointMake(24.92, 22.5)];
        [bezier11Path addCurveToPoint:CGPointMake(24.7, 22.51) controlPoint1:CGPointMake(24.8, 22.5) controlPoint2:CGPointMake(24.75, 22.5)];
        [bezier11Path addCurveToPoint:CGPointMake(24.59, 22.54) controlPoint1:CGPointMake(24.66, 22.51) controlPoint2:CGPointMake(24.62, 22.52)];
        [bezier11Path addCurveToPoint:CGPointMake(24.53, 22.61) controlPoint1:CGPointMake(24.56, 22.56) controlPoint2:CGPointMake(24.54, 22.58)];
        [bezier11Path addCurveToPoint:CGPointMake(24.51, 22.74) controlPoint1:CGPointMake(24.52, 22.64) controlPoint2:CGPointMake(24.51, 22.68)];
        [bezier11Path addCurveToPoint:CGPointMake(24.52, 22.86) controlPoint1:CGPointMake(24.51, 22.79) controlPoint2:CGPointMake(24.51, 22.83)];
        [bezier11Path addCurveToPoint:CGPointMake(24.56, 22.93) controlPoint1:CGPointMake(24.52, 22.89) controlPoint2:CGPointMake(24.54, 22.91)];
        [bezier11Path addCurveToPoint:CGPointMake(24.67, 22.98) controlPoint1:CGPointMake(24.58, 22.95) controlPoint2:CGPointMake(24.62, 22.96)];
        [bezier11Path addCurveToPoint:CGPointMake(24.88, 23.03) controlPoint1:CGPointMake(24.71, 22.99) controlPoint2:CGPointMake(24.78, 23)];
        [bezier11Path closePath];
        bezier11Path.miterLimit = 4;

        [fillColor setFill];
        [bezier11Path fill];

        //// Bezier 12 Drawing
        UIBezierPath *bezier12Path = [UIBezierPath bezierPath];
        [bezier12Path moveToPoint:CGPointMake(27.83, 23.65)];
        [bezier12Path addLineToPoint:CGPointMake(27.83, 23.65)];
        [bezier12Path addCurveToPoint:CGPointMake(27.77, 23.91) controlPoint1:CGPointMake(27.83, 23.75) controlPoint2:CGPointMake(27.81, 23.84)];
        [bezier12Path addCurveToPoint:CGPointMake(27.62, 24.08) controlPoint1:CGPointMake(27.73, 23.98) controlPoint2:CGPointMake(27.68, 24.04)];
        [bezier12Path addCurveToPoint:CGPointMake(27.38, 24.17) controlPoint1:CGPointMake(27.55, 24.12) controlPoint2:CGPointMake(27.47, 24.15)];
        [bezier12Path addCurveToPoint:CGPointMake(27.07, 24.2) controlPoint1:CGPointMake(27.29, 24.19) controlPoint2:CGPointMake(27.18, 24.2)];
        [bezier12Path addCurveToPoint:CGPointMake(26.76, 24.17) controlPoint1:CGPointMake(26.95, 24.2) controlPoint2:CGPointMake(26.85, 24.19)];
        [bezier12Path addCurveToPoint:CGPointMake(26.53, 24.08) controlPoint1:CGPointMake(26.67, 24.15) controlPoint2:CGPointMake(26.59, 24.12)];
        [bezier12Path addCurveToPoint:CGPointMake(26.38, 23.91) controlPoint1:CGPointMake(26.46, 24.04) controlPoint2:CGPointMake(26.41, 23.98)];
        [bezier12Path addCurveToPoint:CGPointMake(26.33, 23.67) controlPoint1:CGPointMake(26.35, 23.84) controlPoint2:CGPointMake(26.33, 23.76)];
        [bezier12Path addLineToPoint:CGPointMake(26.33, 22.7)];
        [bezier12Path addCurveToPoint:CGPointMake(26.53, 22.31) controlPoint1:CGPointMake(26.33, 22.53) controlPoint2:CGPointMake(26.39, 22.4)];
        [bezier12Path addCurveToPoint:CGPointMake(27.09, 22.18) controlPoint1:CGPointMake(26.66, 22.22) controlPoint2:CGPointMake(26.85, 22.18)];
        [bezier12Path addCurveToPoint:CGPointMake(27.4, 22.21) controlPoint1:CGPointMake(27.2, 22.18) controlPoint2:CGPointMake(27.3, 22.19)];
        [bezier12Path addCurveToPoint:CGPointMake(27.63, 22.31) controlPoint1:CGPointMake(27.49, 22.23) controlPoint2:CGPointMake(27.57, 22.27)];
        [bezier12Path addCurveToPoint:CGPointMake(27.78, 22.48) controlPoint1:CGPointMake(27.69, 22.35) controlPoint2:CGPointMake(27.74, 22.41)];
        [bezier12Path addCurveToPoint:CGPointMake(27.84, 22.71) controlPoint1:CGPointMake(27.82, 22.55) controlPoint2:CGPointMake(27.84, 22.62)];
        [bezier12Path addLineToPoint:CGPointMake(27.84, 23.65)];
        [bezier12Path addLineToPoint:CGPointMake(27.83, 23.65)];
        [bezier12Path closePath];
        [bezier12Path moveToPoint:CGPointMake(27.43, 22.72)];
        [bezier12Path addCurveToPoint:CGPointMake(27.34, 22.55) controlPoint1:CGPointMake(27.43, 22.65) controlPoint2:CGPointMake(27.4, 22.59)];
        [bezier12Path addCurveToPoint:CGPointMake(27.07, 22.49) controlPoint1:CGPointMake(27.28, 22.51) controlPoint2:CGPointMake(27.19, 22.49)];
        [bezier12Path addCurveToPoint:CGPointMake(26.8, 22.55) controlPoint1:CGPointMake(26.95, 22.49) controlPoint2:CGPointMake(26.86, 22.51)];
        [bezier12Path addCurveToPoint:CGPointMake(26.71, 22.7) controlPoint1:CGPointMake(26.74, 22.59) controlPoint2:CGPointMake(26.71, 22.64)];
        [bezier12Path addLineToPoint:CGPointMake(26.71, 23.65)];
        [bezier12Path addCurveToPoint:CGPointMake(26.8, 23.82) controlPoint1:CGPointMake(26.71, 23.73) controlPoint2:CGPointMake(26.74, 23.78)];
        [bezier12Path addCurveToPoint:CGPointMake(27.06, 23.87) controlPoint1:CGPointMake(26.86, 23.85) controlPoint2:CGPointMake(26.95, 23.87)];
        [bezier12Path addCurveToPoint:CGPointMake(27.33, 23.82) controlPoint1:CGPointMake(27.17, 23.87) controlPoint2:CGPointMake(27.27, 23.85)];
        [bezier12Path addCurveToPoint:CGPointMake(27.43, 23.65) controlPoint1:CGPointMake(27.4, 23.79) controlPoint2:CGPointMake(27.43, 23.73)];
        [bezier12Path addLineToPoint:CGPointMake(27.43, 22.72)];
        [bezier12Path closePath];
        bezier12Path.miterLimit = 4;

        [fillColor setFill];
        [bezier12Path fill];

        //// Bezier 13 Drawing
        UIBezierPath *bezier13Path = [UIBezierPath bezierPath];
        [bezier13Path moveToPoint:CGPointMake(29.85, 23.04)];
        [bezier13Path addCurveToPoint:CGPointMake(29.99, 23.08) controlPoint1:CGPointMake(29.9, 23.04) controlPoint2:CGPointMake(29.95, 23.05)];
        [bezier13Path addCurveToPoint:CGPointMake(30.05, 23.2) controlPoint1:CGPointMake(30.03, 23.1) controlPoint2:CGPointMake(30.05, 23.14)];
        [bezier13Path addCurveToPoint:CGPointMake(30, 23.33) controlPoint1:CGPointMake(30.05, 23.26) controlPoint2:CGPointMake(30.03, 23.3)];
        [bezier13Path addCurveToPoint:CGPointMake(29.87, 23.37) controlPoint1:CGPointMake(29.96, 23.36) controlPoint2:CGPointMake(29.92, 23.37)];
        [bezier13Path addLineToPoint:CGPointMake(29.8, 23.37)];
        [bezier13Path addLineToPoint:CGPointMake(29.8, 24.04)];
        [bezier13Path addCurveToPoint:CGPointMake(29.79, 24.09) controlPoint1:CGPointMake(29.8, 24.06) controlPoint2:CGPointMake(29.79, 24.08)];
        [bezier13Path addCurveToPoint:CGPointMake(29.75, 24.14) controlPoint1:CGPointMake(29.78, 24.11) controlPoint2:CGPointMake(29.77, 24.13)];
        [bezier13Path addCurveToPoint:CGPointMake(29.69, 24.18) controlPoint1:CGPointMake(29.73, 24.16) controlPoint2:CGPointMake(29.71, 24.17)];
        [bezier13Path addCurveToPoint:CGPointMake(29.6, 24.2) controlPoint1:CGPointMake(29.67, 24.19) controlPoint2:CGPointMake(29.63, 24.2)];
        [bezier13Path addCurveToPoint:CGPointMake(29.51, 24.18) controlPoint1:CGPointMake(29.56, 24.2) controlPoint2:CGPointMake(29.53, 24.2)];
        [bezier13Path addCurveToPoint:CGPointMake(29.45, 24.14) controlPoint1:CGPointMake(29.48, 24.17) controlPoint2:CGPointMake(29.47, 24.16)];
        [bezier13Path addCurveToPoint:CGPointMake(29.42, 24.09) controlPoint1:CGPointMake(29.43, 24.12) controlPoint2:CGPointMake(29.42, 24.11)];
        [bezier13Path addCurveToPoint:CGPointMake(29.41, 24.04) controlPoint1:CGPointMake(29.41, 24.07) controlPoint2:CGPointMake(29.41, 24.05)];
        [bezier13Path addLineToPoint:CGPointMake(29.41, 23.37)];
        [bezier13Path addLineToPoint:CGPointMake(28.64, 23.37)];
        [bezier13Path addCurveToPoint:CGPointMake(28.55, 23.35) controlPoint1:CGPointMake(28.59, 23.37) controlPoint2:CGPointMake(28.56, 23.36)];
        [bezier13Path addCurveToPoint:CGPointMake(28.53, 23.27) controlPoint1:CGPointMake(28.54, 23.33) controlPoint2:CGPointMake(28.53, 23.31)];
        [bezier13Path addLineToPoint:CGPointMake(28.53, 22.36)];
        [bezier13Path addCurveToPoint:CGPointMake(28.54, 22.3) controlPoint1:CGPointMake(28.53, 22.34) controlPoint2:CGPointMake(28.53, 22.32)];
        [bezier13Path addCurveToPoint:CGPointMake(28.57, 22.24) controlPoint1:CGPointMake(28.55, 22.28) controlPoint2:CGPointMake(28.56, 22.26)];
        [bezier13Path addCurveToPoint:CGPointMake(28.63, 22.2) controlPoint1:CGPointMake(28.58, 22.22) controlPoint2:CGPointMake(28.61, 22.21)];
        [bezier13Path addCurveToPoint:CGPointMake(28.72, 22.18) controlPoint1:CGPointMake(28.65, 22.19) controlPoint2:CGPointMake(28.68, 22.18)];
        [bezier13Path addCurveToPoint:CGPointMake(28.87, 22.23) controlPoint1:CGPointMake(28.79, 22.18) controlPoint2:CGPointMake(28.84, 22.2)];
        [bezier13Path addCurveToPoint:CGPointMake(28.92, 22.36) controlPoint1:CGPointMake(28.9, 22.26) controlPoint2:CGPointMake(28.92, 22.31)];
        [bezier13Path addLineToPoint:CGPointMake(28.92, 23.06)];
        [bezier13Path addLineToPoint:CGPointMake(29.41, 23.06)];
        [bezier13Path addLineToPoint:CGPointMake(29.41, 22.36)];
        [bezier13Path addCurveToPoint:CGPointMake(29.46, 22.24) controlPoint1:CGPointMake(29.41, 22.31) controlPoint2:CGPointMake(29.43, 22.27)];
        [bezier13Path addCurveToPoint:CGPointMake(29.61, 22.19) controlPoint1:CGPointMake(29.49, 22.21) controlPoint2:CGPointMake(29.54, 22.19)];
        [bezier13Path addCurveToPoint:CGPointMake(29.76, 22.24) controlPoint1:CGPointMake(29.67, 22.19) controlPoint2:CGPointMake(29.72, 22.21)];
        [bezier13Path addCurveToPoint:CGPointMake(29.81, 22.36) controlPoint1:CGPointMake(29.79, 22.27) controlPoint2:CGPointMake(29.81, 22.31)];
        [bezier13Path addLineToPoint:CGPointMake(29.81, 23.06)];
        [bezier13Path addLineToPoint:CGPointMake(29.85, 23.04)];
        [bezier13Path addLineToPoint:CGPointMake(29.85, 23.04)];
        [bezier13Path closePath];
        bezier13Path.miterLimit = 4;

        [fillColor setFill];
        [bezier13Path fill];

        //// Bezier 14 Drawing
        UIBezierPath *bezier14Path = [UIBezierPath bezierPath];
        [bezier14Path moveToPoint:CGPointMake(32.04, 23.04)];
        [bezier14Path addCurveToPoint:CGPointMake(32.17, 23.08) controlPoint1:CGPointMake(32.09, 23.04) controlPoint2:CGPointMake(32.14, 23.05)];
        [bezier14Path addCurveToPoint:CGPointMake(32.23, 23.2) controlPoint1:CGPointMake(32.21, 23.1) controlPoint2:CGPointMake(32.23, 23.14)];
        [bezier14Path addCurveToPoint:CGPointMake(32.17, 23.33) controlPoint1:CGPointMake(32.23, 23.26) controlPoint2:CGPointMake(32.21, 23.3)];
        [bezier14Path addCurveToPoint:CGPointMake(32.04, 23.37) controlPoint1:CGPointMake(32.13, 23.36) controlPoint2:CGPointMake(32.09, 23.37)];
        [bezier14Path addLineToPoint:CGPointMake(31.97, 23.37)];
        [bezier14Path addLineToPoint:CGPointMake(31.97, 24.04)];
        [bezier14Path addCurveToPoint:CGPointMake(31.96, 24.09) controlPoint1:CGPointMake(31.97, 24.06) controlPoint2:CGPointMake(31.96, 24.08)];
        [bezier14Path addCurveToPoint:CGPointMake(31.93, 24.14) controlPoint1:CGPointMake(31.95, 24.11) controlPoint2:CGPointMake(31.94, 24.13)];
        [bezier14Path addCurveToPoint:CGPointMake(31.87, 24.18) controlPoint1:CGPointMake(31.91, 24.16) controlPoint2:CGPointMake(31.89, 24.17)];
        [bezier14Path addCurveToPoint:CGPointMake(31.78, 24.2) controlPoint1:CGPointMake(31.85, 24.19) controlPoint2:CGPointMake(31.82, 24.2)];
        [bezier14Path addCurveToPoint:CGPointMake(31.69, 24.18) controlPoint1:CGPointMake(31.74, 24.2) controlPoint2:CGPointMake(31.71, 24.2)];
        [bezier14Path addCurveToPoint:CGPointMake(31.63, 24.14) controlPoint1:CGPointMake(31.67, 24.17) controlPoint2:CGPointMake(31.65, 24.16)];
        [bezier14Path addCurveToPoint:CGPointMake(31.6, 24.09) controlPoint1:CGPointMake(31.61, 24.12) controlPoint2:CGPointMake(31.6, 24.11)];
        [bezier14Path addCurveToPoint:CGPointMake(31.59, 24.04) controlPoint1:CGPointMake(31.59, 24.07) controlPoint2:CGPointMake(31.59, 24.05)];
        [bezier14Path addLineToPoint:CGPointMake(31.59, 23.37)];
        [bezier14Path addLineToPoint:CGPointMake(30.83, 23.37)];
        [bezier14Path addCurveToPoint:CGPointMake(30.74, 23.35) controlPoint1:CGPointMake(30.78, 23.37) controlPoint2:CGPointMake(30.75, 23.36)];
        [bezier14Path addCurveToPoint:CGPointMake(30.72, 23.27) controlPoint1:CGPointMake(30.72, 23.33) controlPoint2:CGPointMake(30.72, 23.31)];
        [bezier14Path addLineToPoint:CGPointMake(30.72, 22.36)];
        [bezier14Path addCurveToPoint:CGPointMake(30.73, 22.3) controlPoint1:CGPointMake(30.72, 22.34) controlPoint2:CGPointMake(30.72, 22.32)];
        [bezier14Path addCurveToPoint:CGPointMake(30.76, 22.24) controlPoint1:CGPointMake(30.74, 22.28) controlPoint2:CGPointMake(30.75, 22.26)];
        [bezier14Path addCurveToPoint:CGPointMake(30.82, 22.2) controlPoint1:CGPointMake(30.78, 22.22) controlPoint2:CGPointMake(30.79, 22.21)];
        [bezier14Path addCurveToPoint:CGPointMake(30.91, 22.18) controlPoint1:CGPointMake(30.85, 22.19) controlPoint2:CGPointMake(30.87, 22.18)];
        [bezier14Path addCurveToPoint:CGPointMake(31.06, 22.23) controlPoint1:CGPointMake(30.97, 22.18) controlPoint2:CGPointMake(31.03, 22.2)];
        [bezier14Path addCurveToPoint:CGPointMake(31.11, 22.36) controlPoint1:CGPointMake(31.1, 22.26) controlPoint2:CGPointMake(31.11, 22.31)];
        [bezier14Path addLineToPoint:CGPointMake(31.11, 23.06)];
        [bezier14Path addLineToPoint:CGPointMake(31.6, 23.06)];
        [bezier14Path addLineToPoint:CGPointMake(31.6, 22.36)];
        [bezier14Path addCurveToPoint:CGPointMake(31.65, 22.24) controlPoint1:CGPointMake(31.6, 22.31) controlPoint2:CGPointMake(31.62, 22.27)];
        [bezier14Path addCurveToPoint:CGPointMake(31.8, 22.19) controlPoint1:CGPointMake(31.68, 22.21) controlPoint2:CGPointMake(31.73, 22.19)];
        [bezier14Path addCurveToPoint:CGPointMake(31.95, 22.24) controlPoint1:CGPointMake(31.86, 22.19) controlPoint2:CGPointMake(31.91, 22.21)];
        [bezier14Path addCurveToPoint:CGPointMake(32, 22.36) controlPoint1:CGPointMake(31.98, 22.27) controlPoint2:CGPointMake(32, 22.31)];
        [bezier14Path addLineToPoint:CGPointMake(32, 23.06)];
        [bezier14Path addLineToPoint:CGPointMake(32.04, 23.04)];
        [bezier14Path addLineToPoint:CGPointMake(32.04, 23.04)];
        [bezier14Path closePath];
        bezier14Path.miterLimit = 4;

        [fillColor setFill];
        [bezier14Path fill];

        //// Bezier 15 Drawing
        UIBezierPath *bezier15Path = [UIBezierPath bezierPath];
        [bezier15Path moveToPoint:CGPointMake(35.08, 22.96)];
        [bezier15Path addCurveToPoint:CGPointMake(35.4, 23) controlPoint1:CGPointMake(35.21, 22.96) controlPoint2:CGPointMake(35.32, 22.97)];
        [bezier15Path addCurveToPoint:CGPointMake(35.61, 23.12) controlPoint1:CGPointMake(35.49, 23.03) controlPoint2:CGPointMake(35.56, 23.07)];
        [bezier15Path addCurveToPoint:CGPointMake(35.72, 23.32) controlPoint1:CGPointMake(35.66, 23.17) controlPoint2:CGPointMake(35.7, 23.24)];
        [bezier15Path addCurveToPoint:CGPointMake(35.76, 23.59) controlPoint1:CGPointMake(35.74, 23.4) controlPoint2:CGPointMake(35.76, 23.49)];
        [bezier15Path addCurveToPoint:CGPointMake(35.72, 23.85) controlPoint1:CGPointMake(35.76, 23.69) controlPoint2:CGPointMake(35.74, 23.78)];
        [bezier15Path addCurveToPoint:CGPointMake(35.59, 24.04) controlPoint1:CGPointMake(35.69, 23.93) controlPoint2:CGPointMake(35.65, 23.99)];
        [bezier15Path addCurveToPoint:CGPointMake(35.36, 24.16) controlPoint1:CGPointMake(35.53, 24.09) controlPoint2:CGPointMake(35.45, 24.13)];
        [bezier15Path addCurveToPoint:CGPointMake(35, 24.2) controlPoint1:CGPointMake(35.26, 24.19) controlPoint2:CGPointMake(35.14, 24.2)];
        [bezier15Path addCurveToPoint:CGPointMake(34.71, 24.17) controlPoint1:CGPointMake(34.9, 24.2) controlPoint2:CGPointMake(34.79, 24.19)];
        [bezier15Path addCurveToPoint:CGPointMake(34.47, 24.07) controlPoint1:CGPointMake(34.62, 24.15) controlPoint2:CGPointMake(34.54, 24.12)];
        [bezier15Path addCurveToPoint:CGPointMake(34.32, 23.9) controlPoint1:CGPointMake(34.4, 24.03) controlPoint2:CGPointMake(34.35, 23.97)];
        [bezier15Path addCurveToPoint:CGPointMake(34.27, 23.64) controlPoint1:CGPointMake(34.29, 23.83) controlPoint2:CGPointMake(34.27, 23.74)];
        [bezier15Path addLineToPoint:CGPointMake(34.27, 22.34)];
        [bezier15Path addCurveToPoint:CGPointMake(34.28, 22.28) controlPoint1:CGPointMake(34.27, 22.32) controlPoint2:CGPointMake(34.27, 22.3)];
        [bezier15Path addCurveToPoint:CGPointMake(34.32, 22.23) controlPoint1:CGPointMake(34.29, 22.26) controlPoint2:CGPointMake(34.3, 22.24)];
        [bezier15Path addCurveToPoint:CGPointMake(34.38, 22.19) controlPoint1:CGPointMake(34.34, 22.21) controlPoint2:CGPointMake(34.35, 22.2)];
        [bezier15Path addCurveToPoint:CGPointMake(34.47, 22.17) controlPoint1:CGPointMake(34.4, 22.18) controlPoint2:CGPointMake(34.44, 22.17)];
        [bezier15Path addCurveToPoint:CGPointMake(34.62, 22.22) controlPoint1:CGPointMake(34.53, 22.17) controlPoint2:CGPointMake(34.59, 22.19)];
        [bezier15Path addCurveToPoint:CGPointMake(34.67, 22.34) controlPoint1:CGPointMake(34.65, 22.25) controlPoint2:CGPointMake(34.67, 22.29)];
        [bezier15Path addLineToPoint:CGPointMake(34.67, 22.99)];
        [bezier15Path addCurveToPoint:CGPointMake(34.92, 22.97) controlPoint1:CGPointMake(34.76, 22.98) controlPoint2:CGPointMake(34.85, 22.97)];
        [bezier15Path addCurveToPoint:CGPointMake(35.08, 22.96) controlPoint1:CGPointMake(34.97, 22.96) controlPoint2:CGPointMake(35.03, 22.96)];
        [bezier15Path closePath];
        [bezier15Path moveToPoint:CGPointMake(35.37, 23.57)];
        [bezier15Path addCurveToPoint:CGPointMake(35.35, 23.42) controlPoint1:CGPointMake(35.37, 23.51) controlPoint2:CGPointMake(35.36, 23.46)];
        [bezier15Path addCurveToPoint:CGPointMake(35.29, 23.33) controlPoint1:CGPointMake(35.34, 23.38) controlPoint2:CGPointMake(35.32, 23.35)];
        [bezier15Path addCurveToPoint:CGPointMake(35.18, 23.29) controlPoint1:CGPointMake(35.26, 23.31) controlPoint2:CGPointMake(35.22, 23.29)];
        [bezier15Path addCurveToPoint:CGPointMake(35, 23.28) controlPoint1:CGPointMake(35.13, 23.28) controlPoint2:CGPointMake(35.07, 23.28)];
        [bezier15Path addCurveToPoint:CGPointMake(34.86, 23.28) controlPoint1:CGPointMake(34.94, 23.28) controlPoint2:CGPointMake(34.9, 23.28)];
        [bezier15Path addCurveToPoint:CGPointMake(34.77, 23.28) controlPoint1:CGPointMake(34.82, 23.28) controlPoint2:CGPointMake(34.79, 23.28)];
        [bezier15Path addCurveToPoint:CGPointMake(34.7, 23.29) controlPoint1:CGPointMake(34.75, 23.28) controlPoint2:CGPointMake(34.72, 23.28)];
        [bezier15Path addCurveToPoint:CGPointMake(34.63, 23.3) controlPoint1:CGPointMake(34.68, 23.29) controlPoint2:CGPointMake(34.66, 23.3)];
        [bezier15Path addLineToPoint:CGPointMake(34.63, 23.56)];
        [bezier15Path addCurveToPoint:CGPointMake(34.65, 23.7) controlPoint1:CGPointMake(34.63, 23.61) controlPoint2:CGPointMake(34.64, 23.66)];
        [bezier15Path addCurveToPoint:CGPointMake(34.71, 23.8) controlPoint1:CGPointMake(34.66, 23.74) controlPoint2:CGPointMake(34.68, 23.77)];
        [bezier15Path addCurveToPoint:CGPointMake(34.82, 23.86) controlPoint1:CGPointMake(34.74, 23.83) controlPoint2:CGPointMake(34.77, 23.85)];
        [bezier15Path addCurveToPoint:CGPointMake(34.99, 23.88) controlPoint1:CGPointMake(34.87, 23.87) controlPoint2:CGPointMake(34.92, 23.88)];
        [bezier15Path addCurveToPoint:CGPointMake(35.15, 23.87) controlPoint1:CGPointMake(35.05, 23.88) controlPoint2:CGPointMake(35.11, 23.88)];
        [bezier15Path addCurveToPoint:CGPointMake(35.26, 23.83) controlPoint1:CGPointMake(35.2, 23.86) controlPoint2:CGPointMake(35.23, 23.85)];
        [bezier15Path addCurveToPoint:CGPointMake(35.33, 23.74) controlPoint1:CGPointMake(35.29, 23.81) controlPoint2:CGPointMake(35.31, 23.78)];
        [bezier15Path addCurveToPoint:CGPointMake(35.37, 23.57) controlPoint1:CGPointMake(35.36, 23.69) controlPoint2:CGPointMake(35.37, 23.64)];
        [bezier15Path closePath];
        bezier15Path.miterLimit = 4;

        [fillColor setFill];
        [bezier15Path fill];

        //// Bezier 16 Drawing
        UIBezierPath *bezier16Path = [UIBezierPath bezierPath];
        [bezier16Path moveToPoint:CGPointMake(37.69, 23.04)];
        [bezier16Path addCurveToPoint:CGPointMake(37.83, 23.08) controlPoint1:CGPointMake(37.74, 23.04) controlPoint2:CGPointMake(37.79, 23.05)];
        [bezier16Path addCurveToPoint:CGPointMake(37.89, 23.2) controlPoint1:CGPointMake(37.87, 23.1) controlPoint2:CGPointMake(37.89, 23.14)];
        [bezier16Path addCurveToPoint:CGPointMake(37.84, 23.33) controlPoint1:CGPointMake(37.89, 23.26) controlPoint2:CGPointMake(37.87, 23.3)];
        [bezier16Path addCurveToPoint:CGPointMake(37.71, 23.37) controlPoint1:CGPointMake(37.8, 23.36) controlPoint2:CGPointMake(37.76, 23.37)];
        [bezier16Path addLineToPoint:CGPointMake(37.65, 23.37)];
        [bezier16Path addLineToPoint:CGPointMake(37.65, 24.04)];
        [bezier16Path addCurveToPoint:CGPointMake(37.64, 24.09) controlPoint1:CGPointMake(37.65, 24.06) controlPoint2:CGPointMake(37.64, 24.08)];
        [bezier16Path addCurveToPoint:CGPointMake(37.6, 24.14) controlPoint1:CGPointMake(37.63, 24.11) controlPoint2:CGPointMake(37.62, 24.13)];
        [bezier16Path addCurveToPoint:CGPointMake(37.54, 24.18) controlPoint1:CGPointMake(37.58, 24.16) controlPoint2:CGPointMake(37.56, 24.17)];
        [bezier16Path addCurveToPoint:CGPointMake(37.45, 24.2) controlPoint1:CGPointMake(37.52, 24.19) controlPoint2:CGPointMake(37.48, 24.2)];
        [bezier16Path addCurveToPoint:CGPointMake(37.36, 24.18) controlPoint1:CGPointMake(37.41, 24.2) controlPoint2:CGPointMake(37.38, 24.2)];
        [bezier16Path addCurveToPoint:CGPointMake(37.3, 24.14) controlPoint1:CGPointMake(37.34, 24.17) controlPoint2:CGPointMake(37.32, 24.16)];
        [bezier16Path addCurveToPoint:CGPointMake(37.27, 24.09) controlPoint1:CGPointMake(37.29, 24.12) controlPoint2:CGPointMake(37.28, 24.11)];
        [bezier16Path addCurveToPoint:CGPointMake(37.26, 24.04) controlPoint1:CGPointMake(37.26, 24.07) controlPoint2:CGPointMake(37.26, 24.05)];
        [bezier16Path addLineToPoint:CGPointMake(37.26, 23.37)];
        [bezier16Path addLineToPoint:CGPointMake(36.5, 23.37)];
        [bezier16Path addCurveToPoint:CGPointMake(36.41, 23.35) controlPoint1:CGPointMake(36.45, 23.37) controlPoint2:CGPointMake(36.42, 23.36)];
        [bezier16Path addCurveToPoint:CGPointMake(36.39, 23.27) controlPoint1:CGPointMake(36.39, 23.33) controlPoint2:CGPointMake(36.39, 23.31)];
        [bezier16Path addLineToPoint:CGPointMake(36.39, 22.36)];
        [bezier16Path addCurveToPoint:CGPointMake(36.4, 22.3) controlPoint1:CGPointMake(36.39, 22.34) controlPoint2:CGPointMake(36.4, 22.32)];
        [bezier16Path addCurveToPoint:CGPointMake(36.44, 22.24) controlPoint1:CGPointMake(36.41, 22.28) controlPoint2:CGPointMake(36.42, 22.26)];
        [bezier16Path addCurveToPoint:CGPointMake(36.5, 22.2) controlPoint1:CGPointMake(36.45, 22.22) controlPoint2:CGPointMake(36.47, 22.21)];
        [bezier16Path addCurveToPoint:CGPointMake(36.59, 22.18) controlPoint1:CGPointMake(36.53, 22.19) controlPoint2:CGPointMake(36.56, 22.18)];
        [bezier16Path addCurveToPoint:CGPointMake(36.74, 22.23) controlPoint1:CGPointMake(36.66, 22.18) controlPoint2:CGPointMake(36.71, 22.2)];
        [bezier16Path addCurveToPoint:CGPointMake(36.79, 22.36) controlPoint1:CGPointMake(36.77, 22.26) controlPoint2:CGPointMake(36.79, 22.31)];
        [bezier16Path addLineToPoint:CGPointMake(36.79, 23.06)];
        [bezier16Path addLineToPoint:CGPointMake(37.28, 23.06)];
        [bezier16Path addLineToPoint:CGPointMake(37.28, 22.36)];
        [bezier16Path addCurveToPoint:CGPointMake(37.33, 22.24) controlPoint1:CGPointMake(37.28, 22.31) controlPoint2:CGPointMake(37.29, 22.27)];
        [bezier16Path addCurveToPoint:CGPointMake(37.48, 22.19) controlPoint1:CGPointMake(37.36, 22.21) controlPoint2:CGPointMake(37.41, 22.19)];
        [bezier16Path addCurveToPoint:CGPointMake(37.63, 22.24) controlPoint1:CGPointMake(37.54, 22.19) controlPoint2:CGPointMake(37.59, 22.21)];
        [bezier16Path addCurveToPoint:CGPointMake(37.68, 22.36) controlPoint1:CGPointMake(37.66, 22.27) controlPoint2:CGPointMake(37.68, 22.31)];
        [bezier16Path addLineToPoint:CGPointMake(37.68, 23.06)];
        [bezier16Path addLineToPoint:CGPointMake(37.69, 23.04)];
        [bezier16Path addLineToPoint:CGPointMake(37.69, 23.04)];
        [bezier16Path closePath];
        bezier16Path.miterLimit = 4;

        [fillColor setFill];
        [bezier16Path fill];

        //// Bezier 17 Drawing
        UIBezierPath *bezier17Path = [UIBezierPath bezierPath];
        [bezier17Path moveToPoint:CGPointMake(40.05, 23.65)];
        [bezier17Path addLineToPoint:CGPointMake(40.05, 23.65)];
        [bezier17Path addCurveToPoint:CGPointMake(40, 23.91) controlPoint1:CGPointMake(40.05, 23.75) controlPoint2:CGPointMake(40.04, 23.84)];
        [bezier17Path addCurveToPoint:CGPointMake(39.84, 24.08) controlPoint1:CGPointMake(39.96, 23.98) controlPoint2:CGPointMake(39.91, 24.04)];
        [bezier17Path addCurveToPoint:CGPointMake(39.6, 24.17) controlPoint1:CGPointMake(39.77, 24.12) controlPoint2:CGPointMake(39.69, 24.15)];
        [bezier17Path addCurveToPoint:CGPointMake(39.29, 24.2) controlPoint1:CGPointMake(39.51, 24.19) controlPoint2:CGPointMake(39.4, 24.2)];
        [bezier17Path addCurveToPoint:CGPointMake(38.98, 24.17) controlPoint1:CGPointMake(39.18, 24.2) controlPoint2:CGPointMake(39.07, 24.19)];
        [bezier17Path addCurveToPoint:CGPointMake(38.74, 24.08) controlPoint1:CGPointMake(38.88, 24.15) controlPoint2:CGPointMake(38.81, 24.12)];
        [bezier17Path addCurveToPoint:CGPointMake(38.59, 23.91) controlPoint1:CGPointMake(38.68, 24.04) controlPoint2:CGPointMake(38.63, 23.98)];
        [bezier17Path addCurveToPoint:CGPointMake(38.54, 23.67) controlPoint1:CGPointMake(38.56, 23.84) controlPoint2:CGPointMake(38.54, 23.76)];
        [bezier17Path addLineToPoint:CGPointMake(38.54, 22.7)];
        [bezier17Path addCurveToPoint:CGPointMake(38.74, 22.31) controlPoint1:CGPointMake(38.54, 22.53) controlPoint2:CGPointMake(38.6, 22.4)];
        [bezier17Path addCurveToPoint:CGPointMake(39.3, 22.18) controlPoint1:CGPointMake(38.87, 22.22) controlPoint2:CGPointMake(39.06, 22.18)];
        [bezier17Path addCurveToPoint:CGPointMake(39.61, 22.21) controlPoint1:CGPointMake(39.41, 22.18) controlPoint2:CGPointMake(39.51, 22.19)];
        [bezier17Path addCurveToPoint:CGPointMake(39.84, 22.31) controlPoint1:CGPointMake(39.7, 22.23) controlPoint2:CGPointMake(39.78, 22.27)];
        [bezier17Path addCurveToPoint:CGPointMake(39.99, 22.48) controlPoint1:CGPointMake(39.9, 22.35) controlPoint2:CGPointMake(39.95, 22.41)];
        [bezier17Path addCurveToPoint:CGPointMake(40.04, 22.71) controlPoint1:CGPointMake(40.03, 22.55) controlPoint2:CGPointMake(40.04, 22.62)];
        [bezier17Path addLineToPoint:CGPointMake(40.04, 23.65)];
        [bezier17Path addLineToPoint:CGPointMake(40.05, 23.65)];
        [bezier17Path closePath];
        [bezier17Path moveToPoint:CGPointMake(39.66, 22.72)];
        [bezier17Path addCurveToPoint:CGPointMake(39.57, 22.55) controlPoint1:CGPointMake(39.66, 22.65) controlPoint2:CGPointMake(39.63, 22.59)];
        [bezier17Path addCurveToPoint:CGPointMake(39.3, 22.49) controlPoint1:CGPointMake(39.51, 22.51) controlPoint2:CGPointMake(39.42, 22.49)];
        [bezier17Path addCurveToPoint:CGPointMake(39.03, 22.55) controlPoint1:CGPointMake(39.18, 22.49) controlPoint2:CGPointMake(39.09, 22.51)];
        [bezier17Path addCurveToPoint:CGPointMake(38.94, 22.7) controlPoint1:CGPointMake(38.97, 22.59) controlPoint2:CGPointMake(38.94, 22.64)];
        [bezier17Path addLineToPoint:CGPointMake(38.94, 23.65)];
        [bezier17Path addCurveToPoint:CGPointMake(39.03, 23.82) controlPoint1:CGPointMake(38.94, 23.73) controlPoint2:CGPointMake(38.97, 23.78)];
        [bezier17Path addCurveToPoint:CGPointMake(39.29, 23.87) controlPoint1:CGPointMake(39.09, 23.85) controlPoint2:CGPointMake(39.17, 23.87)];
        [bezier17Path addCurveToPoint:CGPointMake(39.56, 23.82) controlPoint1:CGPointMake(39.4, 23.87) controlPoint2:CGPointMake(39.5, 23.85)];
        [bezier17Path addCurveToPoint:CGPointMake(39.66, 23.65) controlPoint1:CGPointMake(39.62, 23.79) controlPoint2:CGPointMake(39.66, 23.73)];
        [bezier17Path addLineToPoint:CGPointMake(39.66, 22.72)];
        [bezier17Path closePath];
        bezier17Path.miterLimit = 4;

        [fillColor setFill];
        [bezier17Path fill];

        //// Bezier 18 Drawing
        UIBezierPath *bezier18Path = [UIBezierPath bezierPath];
        [bezier18Path moveToPoint:CGPointMake(42.2, 23.59)];
        [bezier18Path addCurveToPoint:CGPointMake(42.16, 23.88) controlPoint1:CGPointMake(42.2, 23.71) controlPoint2:CGPointMake(42.19, 23.8)];
        [bezier18Path addCurveToPoint:CGPointMake(42.03, 24.07) controlPoint1:CGPointMake(42.14, 23.96) controlPoint2:CGPointMake(42.09, 24.02)];
        [bezier18Path addCurveToPoint:CGPointMake(41.78, 24.17) controlPoint1:CGPointMake(41.97, 24.12) controlPoint2:CGPointMake(41.89, 24.15)];
        [bezier18Path addCurveToPoint:CGPointMake(41.38, 24.2) controlPoint1:CGPointMake(41.68, 24.19) controlPoint2:CGPointMake(41.54, 24.2)];
        [bezier18Path addLineToPoint:CGPointMake(41.36, 24.2)];
        [bezier18Path addCurveToPoint:CGPointMake(41.23, 24.2) controlPoint1:CGPointMake(41.32, 24.2) controlPoint2:CGPointMake(41.28, 24.2)];
        [bezier18Path addCurveToPoint:CGPointMake(41.08, 24.19) controlPoint1:CGPointMake(41.18, 24.2) controlPoint2:CGPointMake(41.13, 24.2)];
        [bezier18Path addCurveToPoint:CGPointMake(40.93, 24.16) controlPoint1:CGPointMake(41.03, 24.18) controlPoint2:CGPointMake(40.98, 24.18)];
        [bezier18Path addCurveToPoint:CGPointMake(40.8, 24.11) controlPoint1:CGPointMake(40.88, 24.15) controlPoint2:CGPointMake(40.84, 24.13)];
        [bezier18Path addCurveToPoint:CGPointMake(40.71, 24.03) controlPoint1:CGPointMake(40.76, 24.09) controlPoint2:CGPointMake(40.73, 24.06)];
        [bezier18Path addCurveToPoint:CGPointMake(40.67, 23.92) controlPoint1:CGPointMake(40.69, 24) controlPoint2:CGPointMake(40.67, 23.96)];
        [bezier18Path addLineToPoint:CGPointMake(40.67, 23.91)];
        [bezier18Path addCurveToPoint:CGPointMake(40.73, 23.79) controlPoint1:CGPointMake(40.67, 23.86) controlPoint2:CGPointMake(40.69, 23.82)];
        [bezier18Path addCurveToPoint:CGPointMake(40.85, 23.75) controlPoint1:CGPointMake(40.77, 23.76) controlPoint2:CGPointMake(40.8, 23.75)];
        [bezier18Path addLineToPoint:CGPointMake(40.86, 23.75)];
        [bezier18Path addCurveToPoint:CGPointMake(40.92, 23.75) controlPoint1:CGPointMake(40.89, 23.75) controlPoint2:CGPointMake(40.91, 23.75)];
        [bezier18Path addCurveToPoint:CGPointMake(40.96, 23.76) controlPoint1:CGPointMake(40.94, 23.76) controlPoint2:CGPointMake(40.95, 23.76)];
        [bezier18Path addCurveToPoint:CGPointMake(40.99, 23.78) controlPoint1:CGPointMake(40.97, 23.77) controlPoint2:CGPointMake(40.98, 23.77)];
        [bezier18Path addCurveToPoint:CGPointMake(41.02, 23.8) controlPoint1:CGPointMake(41, 23.79) controlPoint2:CGPointMake(41.01, 23.79)];
        [bezier18Path addLineToPoint:CGPointMake(41.02, 23.8)];
        [bezier18Path addCurveToPoint:CGPointMake(41.07, 23.83) controlPoint1:CGPointMake(41.03, 23.81) controlPoint2:CGPointMake(41.05, 23.82)];
        [bezier18Path addCurveToPoint:CGPointMake(41.13, 23.85) controlPoint1:CGPointMake(41.08, 23.84) controlPoint2:CGPointMake(41.11, 23.84)];
        [bezier18Path addCurveToPoint:CGPointMake(41.23, 23.86) controlPoint1:CGPointMake(41.16, 23.86) controlPoint2:CGPointMake(41.19, 23.86)];
        [bezier18Path addCurveToPoint:CGPointMake(41.4, 23.87) controlPoint1:CGPointMake(41.27, 23.86) controlPoint2:CGPointMake(41.33, 23.87)];
        [bezier18Path addLineToPoint:CGPointMake(41.42, 23.87)];
        [bezier18Path addCurveToPoint:CGPointMake(41.61, 23.85) controlPoint1:CGPointMake(41.5, 23.87) controlPoint2:CGPointMake(41.56, 23.86)];
        [bezier18Path addCurveToPoint:CGPointMake(41.73, 23.8) controlPoint1:CGPointMake(41.66, 23.84) controlPoint2:CGPointMake(41.7, 23.82)];
        [bezier18Path addCurveToPoint:CGPointMake(41.79, 23.71) controlPoint1:CGPointMake(41.76, 23.78) controlPoint2:CGPointMake(41.78, 23.74)];
        [bezier18Path addCurveToPoint:CGPointMake(41.8, 23.58) controlPoint1:CGPointMake(41.8, 23.67) controlPoint2:CGPointMake(41.8, 23.63)];
        [bezier18Path addCurveToPoint:CGPointMake(41.77, 23.39) controlPoint1:CGPointMake(41.8, 23.49) controlPoint2:CGPointMake(41.79, 23.42)];
        [bezier18Path addCurveToPoint:CGPointMake(41.64, 23.33) controlPoint1:CGPointMake(41.75, 23.35) controlPoint2:CGPointMake(41.7, 23.33)];
        [bezier18Path addLineToPoint:CGPointMake(41.22, 23.33)];
        [bezier18Path addCurveToPoint:CGPointMake(41.15, 23.32) controlPoint1:CGPointMake(41.19, 23.33) controlPoint2:CGPointMake(41.17, 23.33)];
        [bezier18Path addCurveToPoint:CGPointMake(41.09, 23.3) controlPoint1:CGPointMake(41.13, 23.32) controlPoint2:CGPointMake(41.11, 23.31)];
        [bezier18Path addCurveToPoint:CGPointMake(41.04, 23.25) controlPoint1:CGPointMake(41.07, 23.29) controlPoint2:CGPointMake(41.06, 23.27)];
        [bezier18Path addCurveToPoint:CGPointMake(41.03, 23.17) controlPoint1:CGPointMake(41.03, 23.23) controlPoint2:CGPointMake(41.03, 23.2)];
        [bezier18Path addCurveToPoint:CGPointMake(41.09, 23.04) controlPoint1:CGPointMake(41.03, 23.11) controlPoint2:CGPointMake(41.05, 23.07)];
        [bezier18Path addCurveToPoint:CGPointMake(41.22, 23) controlPoint1:CGPointMake(41.13, 23.02) controlPoint2:CGPointMake(41.17, 23)];
        [bezier18Path addLineToPoint:CGPointMake(41.62, 23)];
        [bezier18Path addCurveToPoint:CGPointMake(41.7, 22.99) controlPoint1:CGPointMake(41.65, 23) controlPoint2:CGPointMake(41.68, 23)];
        [bezier18Path addCurveToPoint:CGPointMake(41.76, 22.95) controlPoint1:CGPointMake(41.72, 22.98) controlPoint2:CGPointMake(41.74, 22.97)];
        [bezier18Path addCurveToPoint:CGPointMake(41.8, 22.88) controlPoint1:CGPointMake(41.77, 22.93) controlPoint2:CGPointMake(41.79, 22.91)];
        [bezier18Path addCurveToPoint:CGPointMake(41.81, 22.76) controlPoint1:CGPointMake(41.81, 22.85) controlPoint2:CGPointMake(41.81, 22.81)];
        [bezier18Path addCurveToPoint:CGPointMake(41.8, 22.63) controlPoint1:CGPointMake(41.81, 22.71) controlPoint2:CGPointMake(41.81, 22.66)];
        [bezier18Path addCurveToPoint:CGPointMake(41.75, 22.54) controlPoint1:CGPointMake(41.79, 22.59) controlPoint2:CGPointMake(41.78, 22.56)];
        [bezier18Path addCurveToPoint:CGPointMake(41.64, 22.49) controlPoint1:CGPointMake(41.73, 22.52) controlPoint2:CGPointMake(41.69, 22.5)];
        [bezier18Path addCurveToPoint:CGPointMake(41.44, 22.48) controlPoint1:CGPointMake(41.59, 22.48) controlPoint2:CGPointMake(41.52, 22.48)];
        [bezier18Path addLineToPoint:CGPointMake(41.42, 22.48)];
        [bezier18Path addCurveToPoint:CGPointMake(41.25, 22.49) controlPoint1:CGPointMake(41.37, 22.48) controlPoint2:CGPointMake(41.31, 22.48)];
        [bezier18Path addCurveToPoint:CGPointMake(41.11, 22.53) controlPoint1:CGPointMake(41.19, 22.5) controlPoint2:CGPointMake(41.14, 22.51)];
        [bezier18Path addCurveToPoint:CGPointMake(41.07, 22.55) controlPoint1:CGPointMake(41.09, 22.54) controlPoint2:CGPointMake(41.08, 22.55)];
        [bezier18Path addCurveToPoint:CGPointMake(41.03, 22.57) controlPoint1:CGPointMake(41.05, 22.56) controlPoint2:CGPointMake(41.04, 22.57)];
        [bezier18Path addCurveToPoint:CGPointMake(40.99, 22.58) controlPoint1:CGPointMake(41.01, 22.58) controlPoint2:CGPointMake(41, 22.58)];
        [bezier18Path addCurveToPoint:CGPointMake(40.93, 22.58) controlPoint1:CGPointMake(40.97, 22.58) controlPoint2:CGPointMake(40.95, 22.58)];
        [bezier18Path addLineToPoint:CGPointMake(40.92, 22.58)];
        [bezier18Path addCurveToPoint:CGPointMake(40.79, 22.53) controlPoint1:CGPointMake(40.87, 22.58) controlPoint2:CGPointMake(40.83, 22.56)];
        [bezier18Path addCurveToPoint:CGPointMake(40.74, 22.42) controlPoint1:CGPointMake(40.76, 22.5) controlPoint2:CGPointMake(40.74, 22.46)];
        [bezier18Path addLineToPoint:CGPointMake(40.74, 22.42)];
        [bezier18Path addCurveToPoint:CGPointMake(40.78, 22.3) controlPoint1:CGPointMake(40.74, 22.37) controlPoint2:CGPointMake(40.76, 22.33)];
        [bezier18Path addCurveToPoint:CGPointMake(40.9, 22.21) controlPoint1:CGPointMake(40.81, 22.26) controlPoint2:CGPointMake(40.85, 22.24)];
        [bezier18Path addCurveToPoint:CGPointMake(41.1, 22.15) controlPoint1:CGPointMake(40.96, 22.19) controlPoint2:CGPointMake(41.02, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(41.4, 22.13) controlPoint1:CGPointMake(41.19, 22.14) controlPoint2:CGPointMake(41.29, 22.13)];
        [bezier18Path addCurveToPoint:CGPointMake(41.77, 22.15) controlPoint1:CGPointMake(41.54, 22.13) controlPoint2:CGPointMake(41.67, 22.14)];
        [bezier18Path addCurveToPoint:CGPointMake(42.02, 22.23) controlPoint1:CGPointMake(41.87, 22.17) controlPoint2:CGPointMake(41.95, 22.19)];
        [bezier18Path addCurveToPoint:CGPointMake(42.15, 22.4) controlPoint1:CGPointMake(42.08, 22.27) controlPoint2:CGPointMake(42.12, 22.33)];
        [bezier18Path addCurveToPoint:CGPointMake(42.19, 22.68) controlPoint1:CGPointMake(42.17, 22.47) controlPoint2:CGPointMake(42.19, 22.57)];
        [bezier18Path addCurveToPoint:CGPointMake(42.18, 22.84) controlPoint1:CGPointMake(42.19, 22.74) controlPoint2:CGPointMake(42.19, 22.79)];
        [bezier18Path addCurveToPoint:CGPointMake(42.16, 22.96) controlPoint1:CGPointMake(42.17, 22.88) controlPoint2:CGPointMake(42.17, 22.92)];
        [bezier18Path addCurveToPoint:CGPointMake(42.12, 23.05) controlPoint1:CGPointMake(42.15, 22.99) controlPoint2:CGPointMake(42.14, 23.02)];
        [bezier18Path addCurveToPoint:CGPointMake(42.07, 23.12) controlPoint1:CGPointMake(42.11, 23.08) controlPoint2:CGPointMake(42.09, 23.1)];
        [bezier18Path addCurveToPoint:CGPointMake(42.11, 23.17) controlPoint1:CGPointMake(42.09, 23.13) controlPoint2:CGPointMake(42.1, 23.15)];
        [bezier18Path addCurveToPoint:CGPointMake(42.15, 23.25) controlPoint1:CGPointMake(42.12, 23.19) controlPoint2:CGPointMake(42.14, 23.22)];
        [bezier18Path addCurveToPoint:CGPointMake(42.18, 23.37) controlPoint1:CGPointMake(42.16, 23.28) controlPoint2:CGPointMake(42.17, 23.32)];
        [bezier18Path addCurveToPoint:CGPointMake(42.2, 23.59) controlPoint1:CGPointMake(42.19, 23.46) controlPoint2:CGPointMake(42.2, 23.52)];
        [bezier18Path closePath];
        bezier18Path.miterLimit = 4;

        [fillColor setFill];
        [bezier18Path fill];
    }
}

//// Group 5
{
    //// Group 6
    {
        //// Group 7
        {
            //// Group 8
            {
                //// Group 9
                {
                    //// Bezier 19 Drawing
                    UIBezierPath *bezier19Path = [UIBezierPath bezierPath];
                    [bezier19Path moveToPoint:CGPointMake(39.38, 7.97)];
                    [bezier19Path addLineToPoint:CGPointMake(38.51, 7.97)];
                    bezier19Path.miterLimit = 4;

                    [fillColor5 setFill];
                    [bezier19Path fill];

                    //// Bezier 20 Drawing
                    UIBezierPath *bezier20Path = [UIBezierPath bezierPath];
                    [bezier20Path moveToPoint:CGPointMake(32.6, 7.97)];
                    [bezier20Path addLineToPoint:CGPointMake(31.74, 7.97)];
                    bezier20Path.miterLimit = 4;

                    [fillColor5 setFill];
                    [bezier20Path fill];

                    //// Bezier 21 Drawing
                    UIBezierPath *bezier21Path = [UIBezierPath bezierPath];
                    [bezier21Path moveToPoint:CGPointMake(30.36, 7.97)];
                    [bezier21Path addLineToPoint:CGPointMake(31.74, 7.97)];
                    bezier21Path.miterLimit = 4;

                    [fillColor5 setFill];
                    [bezier21Path fill];

                    //// Bezier 22 Drawing
                    UIBezierPath *bezier22Path = [UIBezierPath bezierPath];
                    [bezier22Path moveToPoint:CGPointMake(39.38, 7.97)];
                    [bezier22Path addLineToPoint:CGPointMake(40.75, 7.97)];
                    bezier22Path.miterLimit = 4;

                    [fillColor5 setFill];
                    [bezier22Path fill];
                }
            }

            //// Rectangle 2 Drawing
            UIBezierPath *rectangle2Path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(29.68, 7.95, 11.75, 7.8) cornerRadius:1];
            [strokeColor setStroke];
            rectangle2Path.lineWidth = 1.1;
            [rectangle2Path stroke];
        }
    }

    //// Bezier 23 Drawing
    UIBezierPath *bezier23Path = [UIBezierPath bezierPath];
    [bezier23Path moveToPoint:CGPointMake(36.03, 12.3)];
    [bezier23Path addLineToPoint:CGPointMake(36.03, 13.05)];
    [bezier23Path addCurveToPoint:CGPointMake(35.8, 13.28) controlPoint1:CGPointMake(36.03, 13.18) controlPoint2:CGPointMake(35.93, 13.28)];
    [bezier23Path addLineToPoint:CGPointMake(35.33, 13.28)];
    [bezier23Path addCurveToPoint:CGPointMake(35.1, 13.05) controlPoint1:CGPointMake(35.2, 13.28) controlPoint2:CGPointMake(35.1, 13.18)];
    [bezier23Path addLineToPoint:CGPointMake(35.1, 12.31)];
    [bezier23Path addCurveToPoint:CGPointMake(34.58, 11.45) controlPoint1:CGPointMake(34.79, 12.15) controlPoint2:CGPointMake(34.58, 11.83)];
    [bezier23Path addCurveToPoint:CGPointMake(35.56, 10.47) controlPoint1:CGPointMake(34.58, 10.91) controlPoint2:CGPointMake(35.02, 10.47)];
    [bezier23Path addCurveToPoint:CGPointMake(36.53, 11.45) controlPoint1:CGPointMake(36.1, 10.47) controlPoint2:CGPointMake(36.53, 10.91)];
    [bezier23Path addCurveToPoint:CGPointMake(36.03, 12.3) controlPoint1:CGPointMake(36.53, 11.82) controlPoint2:CGPointMake(36.33, 12.13)];
    [bezier23Path closePath];
    bezier23Path.miterLimit = 4;

    [fillColor14 setFill];
    [bezier23Path fill];

    //// Bezier 24 Drawing
    UIBezierPath *bezier24Path = [UIBezierPath bezierPath];
    [bezier24Path moveToPoint:CGPointMake(31.68, 7.81)];
    [bezier24Path addLineToPoint:CGPointMake(31.68, 7.4)];
    [bezier24Path addCurveToPoint:CGPointMake(35.55, 3.71) controlPoint1:CGPointMake(31.68, 5.3) controlPoint2:CGPointMake(33.35, 3.71)];
    [bezier24Path addLineToPoint:CGPointMake(35.56, 3.71)];
    [bezier24Path addCurveToPoint:CGPointMake(39.43, 7.4) controlPoint1:CGPointMake(37.77, 3.71) controlPoint2:CGPointMake(39.43, 5.3)];
    [bezier24Path addLineToPoint:CGPointMake(39.43, 7.81)];
    [strokeColor setStroke];
    bezier24Path.lineWidth = 1.1;
    [bezier24Path stroke];
}
}
}

- (void)drawIc_card_visaCanvas {
    //// Color Declarations
    UIColor *fillColor = [UIColor colorWithRed:0.647 green:0.647 blue:0.647 alpha:1];
    UIColor *fillColor2 = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1];
    UIColor *fillColor15 = [UIColor colorWithRed:0.03 green:0.261 blue:0.537 alpha:1];
    UIColor *fillColor16 = [UIColor colorWithRed:0.925 green:0.65 blue:0.243 alpha:1];

    //// Group
    {
        //// Group 2
        {
            //// Bezier Drawing
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(43.77, 0)];
            [bezierPath addLineToPoint:CGPointMake(2.23, 0)];
            [bezierPath addCurveToPoint:CGPointMake(0, 2.22) controlPoint1:CGPointMake(1, 0) controlPoint2:CGPointMake(0, 0.99)];
            [bezierPath addLineToPoint:CGPointMake(0, 3.33)];
            [bezierPath addLineToPoint:CGPointMake(0, 26.67)];
            [bezierPath addLineToPoint:CGPointMake(0, 27.79)];
            [bezierPath addCurveToPoint:CGPointMake(2.23, 30) controlPoint1:CGPointMake(0, 29.01) controlPoint2:CGPointMake(1, 30)];
            [bezierPath addLineToPoint:CGPointMake(43.77, 30)];
            [bezierPath addCurveToPoint:CGPointMake(46, 27.79) controlPoint1:CGPointMake(45, 30) controlPoint2:CGPointMake(46, 29.01)];
            [bezierPath addLineToPoint:CGPointMake(46, 2.22)];
            [bezierPath addCurveToPoint:CGPointMake(43.77, 0) controlPoint1:CGPointMake(46, 0.99) controlPoint2:CGPointMake(45, 0)];
            [bezierPath closePath];
            bezierPath.miterLimit = 4;

            [fillColor setFill];
            [bezierPath fill];

            //// Rectangle Drawing
            UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.55, 0.57, 44.9, 28.35) cornerRadius:1.6];
            [fillColor2 setFill];
            [rectanglePath fill];
        }

        //// Bezier 2 Drawing
        UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint:CGPointMake(4.71, 16.18)];
        [bezier2Path addCurveToPoint:CGPointMake(4.04, 15.51) controlPoint1:CGPointMake(4.34, 16.18) controlPoint2:CGPointMake(4.04, 15.88)];
        [bezier2Path addLineToPoint:CGPointMake(4.04, 12.21)];
        [bezier2Path addCurveToPoint:CGPointMake(4.71, 11.54) controlPoint1:CGPointMake(4.04, 11.84) controlPoint2:CGPointMake(4.34, 11.54)];
        [bezier2Path addLineToPoint:CGPointMake(10.29, 11.54)];
        [bezier2Path addCurveToPoint:CGPointMake(10.96, 12.21) controlPoint1:CGPointMake(10.66, 11.54) controlPoint2:CGPointMake(10.96, 11.84)];
        [bezier2Path addLineToPoint:CGPointMake(10.96, 15.51)];
        [bezier2Path addCurveToPoint:CGPointMake(10.29, 16.18) controlPoint1:CGPointMake(10.96, 15.88) controlPoint2:CGPointMake(10.66, 16.18)];
        [bezier2Path addLineToPoint:CGPointMake(4.71, 16.18)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint:CGPointMake(4.71, 11.89)];
        [bezier2Path addCurveToPoint:CGPointMake(4.39, 12.21) controlPoint1:CGPointMake(4.53, 11.89) controlPoint2:CGPointMake(4.39, 12.04)];
        [bezier2Path addLineToPoint:CGPointMake(4.39, 15.51)];
        [bezier2Path addCurveToPoint:CGPointMake(4.71, 15.83) controlPoint1:CGPointMake(4.39, 15.69) controlPoint2:CGPointMake(4.54, 15.83)];
        [bezier2Path addLineToPoint:CGPointMake(10.29, 15.83)];
        [bezier2Path addCurveToPoint:CGPointMake(10.61, 15.51) controlPoint1:CGPointMake(10.47, 15.83) controlPoint2:CGPointMake(10.61, 15.68)];
        [bezier2Path addLineToPoint:CGPointMake(10.61, 12.21)];
        [bezier2Path addCurveToPoint:CGPointMake(10.29, 11.89) controlPoint1:CGPointMake(10.61, 12.03) controlPoint2:CGPointMake(10.47, 11.89)];
        [bezier2Path addLineToPoint:CGPointMake(4.71, 11.89)];
        [bezier2Path closePath];
        bezier2Path.miterLimit = 4;

        [fillColor setFill];
        [bezier2Path fill];

        //// Group 3
        {
            //// Group 4
            {
                //// Bezier 3 Drawing
                UIBezierPath *bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint:CGPointMake(5.38, 23.04)];
        [bezier3Path addCurveToPoint:CGPointMake(5.52, 23.08) controlPoint1:CGPointMake(5.43, 23.04) controlPoint2:CGPointMake(5.48, 23.05)];
        [bezier3Path addCurveToPoint:CGPointMake(5.58, 23.2) controlPoint1:CGPointMake(5.55, 23.1) controlPoint2:CGPointMake(5.57, 23.14)];
        [bezier3Path addCurveToPoint:CGPointMake(5.52, 23.33) controlPoint1:CGPointMake(5.58, 23.26) controlPoint2:CGPointMake(5.56, 23.3)];
        [bezier3Path addCurveToPoint:CGPointMake(5.39, 23.37) controlPoint1:CGPointMake(5.48, 23.36) controlPoint2:CGPointMake(5.44, 23.37)];
        [bezier3Path addLineToPoint:CGPointMake(5.32, 23.37)];
        [bezier3Path addLineToPoint:CGPointMake(5.32, 24.04)];
        [bezier3Path addCurveToPoint:CGPointMake(5.31, 24.09) controlPoint1:CGPointMake(5.32, 24.06) controlPoint2:CGPointMake(5.32, 24.08)];
        [bezier3Path addCurveToPoint:CGPointMake(5.28, 24.14) controlPoint1:CGPointMake(5.3, 24.11) controlPoint2:CGPointMake(5.29, 24.13)];
        [bezier3Path addCurveToPoint:CGPointMake(5.22, 24.18) controlPoint1:CGPointMake(5.26, 24.16) controlPoint2:CGPointMake(5.24, 24.17)];
        [bezier3Path addCurveToPoint:CGPointMake(5.13, 24.2) controlPoint1:CGPointMake(5.2, 24.19) controlPoint2:CGPointMake(5.16, 24.2)];
        [bezier3Path addCurveToPoint:CGPointMake(5.04, 24.18) controlPoint1:CGPointMake(5.1, 24.2) controlPoint2:CGPointMake(5.07, 24.2)];
        [bezier3Path addCurveToPoint:CGPointMake(4.98, 24.14) controlPoint1:CGPointMake(5.01, 24.17) controlPoint2:CGPointMake(4.99, 24.16)];
        [bezier3Path addCurveToPoint:CGPointMake(4.94, 24.09) controlPoint1:CGPointMake(4.96, 24.12) controlPoint2:CGPointMake(4.95, 24.11)];
        [bezier3Path addCurveToPoint:CGPointMake(4.93, 24.04) controlPoint1:CGPointMake(4.93, 24.07) controlPoint2:CGPointMake(4.93, 24.05)];
        [bezier3Path addLineToPoint:CGPointMake(4.93, 23.37)];
        [bezier3Path addLineToPoint:CGPointMake(4.16, 23.37)];
        [bezier3Path addCurveToPoint:CGPointMake(4.07, 23.35) controlPoint1:CGPointMake(4.11, 23.37) controlPoint2:CGPointMake(4.08, 23.36)];
        [bezier3Path addCurveToPoint:CGPointMake(4.05, 23.27) controlPoint1:CGPointMake(4.06, 23.33) controlPoint2:CGPointMake(4.05, 23.31)];
        [bezier3Path addLineToPoint:CGPointMake(4.05, 22.36)];
        [bezier3Path addCurveToPoint:CGPointMake(4.06, 22.3) controlPoint1:CGPointMake(4.05, 22.34) controlPoint2:CGPointMake(4.05, 22.32)];
        [bezier3Path addCurveToPoint:CGPointMake(4.09, 22.24) controlPoint1:CGPointMake(4.06, 22.28) controlPoint2:CGPointMake(4.08, 22.26)];
        [bezier3Path addCurveToPoint:CGPointMake(4.15, 22.2) controlPoint1:CGPointMake(4.1, 22.22) controlPoint2:CGPointMake(4.12, 22.21)];
        [bezier3Path addCurveToPoint:CGPointMake(4.24, 22.18) controlPoint1:CGPointMake(4.17, 22.19) controlPoint2:CGPointMake(4.2, 22.18)];
        [bezier3Path addCurveToPoint:CGPointMake(4.39, 22.23) controlPoint1:CGPointMake(4.31, 22.18) controlPoint2:CGPointMake(4.36, 22.2)];
        [bezier3Path addCurveToPoint:CGPointMake(4.44, 22.36) controlPoint1:CGPointMake(4.42, 22.26) controlPoint2:CGPointMake(4.44, 22.31)];
        [bezier3Path addLineToPoint:CGPointMake(4.44, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(4.93, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(4.93, 22.36)];
        [bezier3Path addCurveToPoint:CGPointMake(4.98, 22.24) controlPoint1:CGPointMake(4.93, 22.31) controlPoint2:CGPointMake(4.95, 22.27)];
        [bezier3Path addCurveToPoint:CGPointMake(5.12, 22.19) controlPoint1:CGPointMake(5.01, 22.21) controlPoint2:CGPointMake(5.06, 22.19)];
        [bezier3Path addCurveToPoint:CGPointMake(5.27, 22.24) controlPoint1:CGPointMake(5.19, 22.19) controlPoint2:CGPointMake(5.24, 22.21)];
        [bezier3Path addCurveToPoint:CGPointMake(5.32, 22.36) controlPoint1:CGPointMake(5.3, 22.27) controlPoint2:CGPointMake(5.32, 22.31)];
        [bezier3Path addLineToPoint:CGPointMake(5.32, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(5.37, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(5.38, 23.06)];
        [bezier3Path addLineToPoint:CGPointMake(5.38, 23.04)];
        [bezier3Path closePath];
        bezier3Path.miterLimit = 4;

        [fillColor setFill];
        [bezier3Path fill];

        //// Bezier 4 Drawing
        UIBezierPath *bezier4Path = [UIBezierPath bezierPath];
        [bezier4Path moveToPoint:CGPointMake(7.69, 23.59)];
        [bezier4Path addCurveToPoint:CGPointMake(7.65, 23.88) controlPoint1:CGPointMake(7.69, 23.71) controlPoint2:CGPointMake(7.68, 23.8)];
        [bezier4Path addCurveToPoint:CGPointMake(7.52, 24.07) controlPoint1:CGPointMake(7.63, 23.96) controlPoint2:CGPointMake(7.58, 24.02)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 24.17) controlPoint1:CGPointMake(7.46, 24.12) controlPoint2:CGPointMake(7.38, 24.15)];
        [bezier4Path addCurveToPoint:CGPointMake(6.87, 24.2) controlPoint1:CGPointMake(7.16, 24.19) controlPoint2:CGPointMake(7.03, 24.2)];
        [bezier4Path addLineToPoint:CGPointMake(6.85, 24.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.72, 24.2) controlPoint1:CGPointMake(6.81, 24.2) controlPoint2:CGPointMake(6.77, 24.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.57, 24.19) controlPoint1:CGPointMake(6.67, 24.2) controlPoint2:CGPointMake(6.62, 24.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.43, 24.16) controlPoint1:CGPointMake(6.52, 24.18) controlPoint2:CGPointMake(6.47, 24.18)];
        [bezier4Path addCurveToPoint:CGPointMake(6.3, 24.11) controlPoint1:CGPointMake(6.38, 24.15) controlPoint2:CGPointMake(6.34, 24.13)];
        [bezier4Path addCurveToPoint:CGPointMake(6.21, 24.03) controlPoint1:CGPointMake(6.26, 24.09) controlPoint2:CGPointMake(6.23, 24.06)];
        [bezier4Path addCurveToPoint:CGPointMake(6.17, 23.92) controlPoint1:CGPointMake(6.19, 24) controlPoint2:CGPointMake(6.17, 23.96)];
        [bezier4Path addLineToPoint:CGPointMake(6.17, 23.91)];
        [bezier4Path addCurveToPoint:CGPointMake(6.23, 23.79) controlPoint1:CGPointMake(6.17, 23.86) controlPoint2:CGPointMake(6.19, 23.82)];
        [bezier4Path addCurveToPoint:CGPointMake(6.35, 23.75) controlPoint1:CGPointMake(6.27, 23.76) controlPoint2:CGPointMake(6.31, 23.75)];
        [bezier4Path addLineToPoint:CGPointMake(6.36, 23.75)];
        [bezier4Path addCurveToPoint:CGPointMake(6.42, 23.75) controlPoint1:CGPointMake(6.39, 23.75) controlPoint2:CGPointMake(6.41, 23.75)];
        [bezier4Path addCurveToPoint:CGPointMake(6.46, 23.76) controlPoint1:CGPointMake(6.44, 23.76) controlPoint2:CGPointMake(6.45, 23.76)];
        [bezier4Path addCurveToPoint:CGPointMake(6.49, 23.78) controlPoint1:CGPointMake(6.47, 23.77) controlPoint2:CGPointMake(6.48, 23.77)];
        [bezier4Path addCurveToPoint:CGPointMake(6.52, 23.8) controlPoint1:CGPointMake(6.5, 23.79) controlPoint2:CGPointMake(6.51, 23.79)];
        [bezier4Path addLineToPoint:CGPointMake(6.52, 23.8)];
        [bezier4Path addCurveToPoint:CGPointMake(6.56, 23.83) controlPoint1:CGPointMake(6.53, 23.81) controlPoint2:CGPointMake(6.55, 23.82)];
        [bezier4Path addCurveToPoint:CGPointMake(6.62, 23.85) controlPoint1:CGPointMake(6.57, 23.84) controlPoint2:CGPointMake(6.6, 23.84)];
        [bezier4Path addCurveToPoint:CGPointMake(6.72, 23.86) controlPoint1:CGPointMake(6.65, 23.86) controlPoint2:CGPointMake(6.68, 23.86)];
        [bezier4Path addCurveToPoint:CGPointMake(6.88, 23.87) controlPoint1:CGPointMake(6.76, 23.86) controlPoint2:CGPointMake(6.82, 23.87)];
        [bezier4Path addLineToPoint:CGPointMake(6.9, 23.87)];
        [bezier4Path addCurveToPoint:CGPointMake(7.09, 23.85) controlPoint1:CGPointMake(6.98, 23.87) controlPoint2:CGPointMake(7.05, 23.86)];
        [bezier4Path addCurveToPoint:CGPointMake(7.21, 23.8) controlPoint1:CGPointMake(7.14, 23.84) controlPoint2:CGPointMake(7.18, 23.82)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 23.71) controlPoint1:CGPointMake(7.24, 23.78) controlPoint2:CGPointMake(7.26, 23.74)];
        [bezier4Path addCurveToPoint:CGPointMake(7.29, 23.58) controlPoint1:CGPointMake(7.28, 23.67) controlPoint2:CGPointMake(7.29, 23.63)];
        [bezier4Path addCurveToPoint:CGPointMake(7.25, 23.39) controlPoint1:CGPointMake(7.29, 23.49) controlPoint2:CGPointMake(7.28, 23.42)];
        [bezier4Path addCurveToPoint:CGPointMake(7.12, 23.33) controlPoint1:CGPointMake(7.23, 23.35) controlPoint2:CGPointMake(7.19, 23.33)];
        [bezier4Path addLineToPoint:CGPointMake(6.7, 23.33)];
        [bezier4Path addCurveToPoint:CGPointMake(6.63, 23.32) controlPoint1:CGPointMake(6.68, 23.33) controlPoint2:CGPointMake(6.65, 23.33)];
        [bezier4Path addCurveToPoint:CGPointMake(6.57, 23.3) controlPoint1:CGPointMake(6.61, 23.32) controlPoint2:CGPointMake(6.58, 23.31)];
        [bezier4Path addCurveToPoint:CGPointMake(6.53, 23.25) controlPoint1:CGPointMake(6.55, 23.29) controlPoint2:CGPointMake(6.54, 23.27)];
        [bezier4Path addCurveToPoint:CGPointMake(6.51, 23.17) controlPoint1:CGPointMake(6.52, 23.23) controlPoint2:CGPointMake(6.51, 23.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.57, 23.04) controlPoint1:CGPointMake(6.51, 23.11) controlPoint2:CGPointMake(6.53, 23.07)];
        [bezier4Path addCurveToPoint:CGPointMake(6.7, 23) controlPoint1:CGPointMake(6.61, 23.02) controlPoint2:CGPointMake(6.65, 23)];
        [bezier4Path addLineToPoint:CGPointMake(7.1, 23)];
        [bezier4Path addCurveToPoint:CGPointMake(7.18, 22.99) controlPoint1:CGPointMake(7.13, 23) controlPoint2:CGPointMake(7.15, 23)];
        [bezier4Path addCurveToPoint:CGPointMake(7.24, 22.95) controlPoint1:CGPointMake(7.2, 22.98) controlPoint2:CGPointMake(7.22, 22.97)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 22.88) controlPoint1:CGPointMake(7.25, 22.93) controlPoint2:CGPointMake(7.27, 22.91)];
        [bezier4Path addCurveToPoint:CGPointMake(7.28, 22.76) controlPoint1:CGPointMake(7.28, 22.85) controlPoint2:CGPointMake(7.28, 22.81)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 22.63) controlPoint1:CGPointMake(7.28, 22.71) controlPoint2:CGPointMake(7.28, 22.66)];
        [bezier4Path addCurveToPoint:CGPointMake(7.22, 22.54) controlPoint1:CGPointMake(7.27, 22.59) controlPoint2:CGPointMake(7.25, 22.56)];
        [bezier4Path addCurveToPoint:CGPointMake(7.11, 22.49) controlPoint1:CGPointMake(7.2, 22.52) controlPoint2:CGPointMake(7.16, 22.5)];
        [bezier4Path addCurveToPoint:CGPointMake(6.92, 22.5) controlPoint1:CGPointMake(7.07, 22.5) controlPoint2:CGPointMake(7, 22.5)];
        [bezier4Path addLineToPoint:CGPointMake(6.9, 22.5)];
        [bezier4Path addCurveToPoint:CGPointMake(6.73, 22.51) controlPoint1:CGPointMake(6.85, 22.5) controlPoint2:CGPointMake(6.79, 22.5)];
        [bezier4Path addCurveToPoint:CGPointMake(6.59, 22.55) controlPoint1:CGPointMake(6.67, 22.52) controlPoint2:CGPointMake(6.62, 22.53)];
        [bezier4Path addCurveToPoint:CGPointMake(6.54, 22.57) controlPoint1:CGPointMake(6.57, 22.56) controlPoint2:CGPointMake(6.56, 22.57)];
        [bezier4Path addCurveToPoint:CGPointMake(6.5, 22.59) controlPoint1:CGPointMake(6.53, 22.58) controlPoint2:CGPointMake(6.51, 22.59)];
        [bezier4Path addCurveToPoint:CGPointMake(6.47, 22.61) controlPoint1:CGPointMake(6.5, 22.6) controlPoint2:CGPointMake(6.48, 22.6)];
        [bezier4Path addCurveToPoint:CGPointMake(6.41, 22.61) controlPoint1:CGPointMake(6.45, 22.61) controlPoint2:CGPointMake(6.44, 22.61)];
        [bezier4Path addLineToPoint:CGPointMake(6.4, 22.61)];
        [bezier4Path addCurveToPoint:CGPointMake(6.28, 22.56) controlPoint1:CGPointMake(6.35, 22.61) controlPoint2:CGPointMake(6.31, 22.59)];
        [bezier4Path addCurveToPoint:CGPointMake(6.23, 22.45) controlPoint1:CGPointMake(6.24, 22.53) controlPoint2:CGPointMake(6.23, 22.49)];
        [bezier4Path addLineToPoint:CGPointMake(6.23, 22.45)];
        [bezier4Path addCurveToPoint:CGPointMake(6.27, 22.33) controlPoint1:CGPointMake(6.23, 22.4) controlPoint2:CGPointMake(6.25, 22.36)];
        [bezier4Path addCurveToPoint:CGPointMake(6.39, 22.24) controlPoint1:CGPointMake(6.3, 22.29) controlPoint2:CGPointMake(6.34, 22.27)];
        [bezier4Path addCurveToPoint:CGPointMake(6.59, 22.18) controlPoint1:CGPointMake(6.44, 22.22) controlPoint2:CGPointMake(6.51, 22.2)];
        [bezier4Path addCurveToPoint:CGPointMake(6.9, 22.16) controlPoint1:CGPointMake(6.68, 22.17) controlPoint2:CGPointMake(6.78, 22.16)];
        [bezier4Path addCurveToPoint:CGPointMake(7.27, 22.18) controlPoint1:CGPointMake(7.04, 22.16) controlPoint2:CGPointMake(7.17, 22.17)];
        [bezier4Path addCurveToPoint:CGPointMake(7.52, 22.26) controlPoint1:CGPointMake(7.37, 22.2) controlPoint2:CGPointMake(7.45, 22.22)];
        [bezier4Path addCurveToPoint:CGPointMake(7.65, 22.43) controlPoint1:CGPointMake(7.58, 22.3) controlPoint2:CGPointMake(7.63, 22.36)];
        [bezier4Path addCurveToPoint:CGPointMake(7.69, 22.71) controlPoint1:CGPointMake(7.68, 22.5) controlPoint2:CGPointMake(7.69, 22.6)];
        [bezier4Path addCurveToPoint:CGPointMake(7.68, 22.87) controlPoint1:CGPointMake(7.69, 22.77) controlPoint2:CGPointMake(7.69, 22.82)];
        [bezier4Path addCurveToPoint:CGPointMake(7.66, 22.99) controlPoint1:CGPointMake(7.67, 22.91) controlPoint2:CGPointMake(7.67, 22.95)];
        [bezier4Path addCurveToPoint:CGPointMake(7.62, 23.08) controlPoint1:CGPointMake(7.65, 23.02) controlPoint2:CGPointMake(7.64, 23.05)];
        [bezier4Path addCurveToPoint:CGPointMake(7.57, 23.15) controlPoint1:CGPointMake(7.6, 23.11) controlPoint2:CGPointMake(7.59, 23.13)];
        [bezier4Path addCurveToPoint:CGPointMake(7.62, 23.2) controlPoint1:CGPointMake(7.59, 23.16) controlPoint2:CGPointMake(7.6, 23.18)];
        [bezier4Path addCurveToPoint:CGPointMake(7.66, 23.28) controlPoint1:CGPointMake(7.64, 23.22) controlPoint2:CGPointMake(7.65, 23.25)];
        [bezier4Path addCurveToPoint:CGPointMake(7.69, 23.4) controlPoint1:CGPointMake(7.67, 23.31) controlPoint2:CGPointMake(7.68, 23.35)];
        [bezier4Path addCurveToPoint:CGPointMake(7.69, 23.59) controlPoint1:CGPointMake(7.68, 23.46) controlPoint2:CGPointMake(7.69, 23.52)];
        [bezier4Path closePath];
        bezier4Path.miterLimit = 4;

        [fillColor setFill];
        [bezier4Path fill];

        //// Bezier 5 Drawing
        UIBezierPath *bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint:CGPointMake(9.88, 23.65)];
        [bezier5Path addLineToPoint:CGPointMake(9.88, 23.65)];
        [bezier5Path addCurveToPoint:CGPointMake(9.84, 23.91) controlPoint1:CGPointMake(9.89, 23.75) controlPoint2:CGPointMake(9.87, 23.84)];
        [bezier5Path addCurveToPoint:CGPointMake(9.68, 24.08) controlPoint1:CGPointMake(9.8, 23.98) controlPoint2:CGPointMake(9.75, 24.04)];
        [bezier5Path addCurveToPoint:CGPointMake(9.44, 24.17) controlPoint1:CGPointMake(9.61, 24.12) controlPoint2:CGPointMake(9.53, 24.15)];
        [bezier5Path addCurveToPoint:CGPointMake(9.13, 24.2) controlPoint1:CGPointMake(9.35, 24.19) controlPoint2:CGPointMake(9.24, 24.2)];
        [bezier5Path addCurveToPoint:CGPointMake(8.82, 24.17) controlPoint1:CGPointMake(9.01, 24.2) controlPoint2:CGPointMake(8.91, 24.19)];
        [bezier5Path addCurveToPoint:CGPointMake(8.58, 24.08) controlPoint1:CGPointMake(8.73, 24.15) controlPoint2:CGPointMake(8.65, 24.12)];
        [bezier5Path addCurveToPoint:CGPointMake(8.43, 23.91) controlPoint1:CGPointMake(8.52, 24.04) controlPoint2:CGPointMake(8.47, 23.98)];
        [bezier5Path addCurveToPoint:CGPointMake(8.38, 23.67) controlPoint1:CGPointMake(8.4, 23.84) controlPoint2:CGPointMake(8.38, 23.76)];
        [bezier5Path addLineToPoint:CGPointMake(8.38, 22.7)];
        [bezier5Path addCurveToPoint:CGPointMake(8.58, 22.31) controlPoint1:CGPointMake(8.38, 22.53) controlPoint2:CGPointMake(8.45, 22.4)];
        [bezier5Path addCurveToPoint:CGPointMake(9.14, 22.18) controlPoint1:CGPointMake(8.71, 22.22) controlPoint2:CGPointMake(8.9, 22.18)];
        [bezier5Path addCurveToPoint:CGPointMake(9.45, 22.21) controlPoint1:CGPointMake(9.25, 22.18) controlPoint2:CGPointMake(9.36, 22.19)];
        [bezier5Path addCurveToPoint:CGPointMake(9.68, 22.31) controlPoint1:CGPointMake(9.54, 22.23) controlPoint2:CGPointMake(9.62, 22.27)];
        [bezier5Path addCurveToPoint:CGPointMake(9.83, 22.48) controlPoint1:CGPointMake(9.75, 22.35) controlPoint2:CGPointMake(9.8, 22.41)];
        [bezier5Path addCurveToPoint:CGPointMake(9.88, 22.71) controlPoint1:CGPointMake(9.86, 22.55) controlPoint2:CGPointMake(9.88, 22.62)];
        [bezier5Path addLineToPoint:CGPointMake(9.88, 23.65)];
        [bezier5Path closePath];
        [bezier5Path moveToPoint:CGPointMake(9.49, 22.72)];
        [bezier5Path addCurveToPoint:CGPointMake(9.4, 22.55) controlPoint1:CGPointMake(9.49, 22.65) controlPoint2:CGPointMake(9.46, 22.59)];
        [bezier5Path addCurveToPoint:CGPointMake(9.13, 22.49) controlPoint1:CGPointMake(9.34, 22.51) controlPoint2:CGPointMake(9.25, 22.49)];
        [bezier5Path addCurveToPoint:CGPointMake(8.86, 22.55) controlPoint1:CGPointMake(9.01, 22.49) controlPoint2:CGPointMake(8.92, 22.51)];
        [bezier5Path addCurveToPoint:CGPointMake(8.77, 22.7) controlPoint1:CGPointMake(8.8, 22.59) controlPoint2:CGPointMake(8.77, 22.64)];
        [bezier5Path addLineToPoint:CGPointMake(8.77, 23.65)];
        [bezier5Path addCurveToPoint:CGPointMake(8.86, 23.82) controlPoint1:CGPointMake(8.77, 23.73) controlPoint2:CGPointMake(8.8, 23.78)];
        [bezier5Path addCurveToPoint:CGPointMake(9.13, 23.87) controlPoint1:CGPointMake(8.92, 23.85) controlPoint2:CGPointMake(9.01, 23.87)];
        [bezier5Path addCurveToPoint:CGPointMake(9.4, 23.82) controlPoint1:CGPointMake(9.24, 23.87) controlPoint2:CGPointMake(9.33, 23.85)];
        [bezier5Path addCurveToPoint:CGPointMake(9.5, 23.65) controlPoint1:CGPointMake(9.47, 23.79) controlPoint2:CGPointMake(9.5, 23.73)];
        [bezier5Path addLineToPoint:CGPointMake(9.5, 22.72)];
        [bezier5Path addLineToPoint:CGPointMake(9.49, 22.72)];
        [bezier5Path closePath];
        bezier5Path.miterLimit = 4;

        [fillColor setFill];
        [bezier5Path fill];

        //// Bezier 6 Drawing
        UIBezierPath *bezier6Path = [UIBezierPath bezierPath];
        [bezier6Path moveToPoint:CGPointMake(11.75, 23.04)];
        [bezier6Path addCurveToPoint:CGPointMake(11.93, 23.13) controlPoint1:CGPointMake(11.82, 23.06) controlPoint2:CGPointMake(11.88, 23.09)];
        [bezier6Path addCurveToPoint:CGPointMake(12.03, 23.31) controlPoint1:CGPointMake(11.98, 23.17) controlPoint2:CGPointMake(12.01, 23.23)];
        [bezier6Path addCurveToPoint:CGPointMake(12.06, 23.59) controlPoint1:CGPointMake(12.05, 23.38) controlPoint2:CGPointMake(12.06, 23.48)];
        [bezier6Path addCurveToPoint:CGPointMake(12.02, 23.88) controlPoint1:CGPointMake(12.06, 23.71) controlPoint2:CGPointMake(12.05, 23.8)];
        [bezier6Path addCurveToPoint:CGPointMake(11.89, 24.07) controlPoint1:CGPointMake(12, 23.96) controlPoint2:CGPointMake(11.95, 24.02)];
        [bezier6Path addCurveToPoint:CGPointMake(11.64, 24.17) controlPoint1:CGPointMake(11.83, 24.11) controlPoint2:CGPointMake(11.75, 24.15)];
        [bezier6Path addCurveToPoint:CGPointMake(11.24, 24.2) controlPoint1:CGPointMake(11.54, 24.19) controlPoint2:CGPointMake(11.4, 24.2)];
        [bezier6Path addLineToPoint:CGPointMake(11.15, 24.2)];
        [bezier6Path addCurveToPoint:CGPointMake(10.95, 24.19) controlPoint1:CGPointMake(11.09, 24.2) controlPoint2:CGPointMake(11.02, 24.2)];
        [bezier6Path addCurveToPoint:CGPointMake(10.75, 24.16) controlPoint1:CGPointMake(10.88, 24.19) controlPoint2:CGPointMake(10.81, 24.17)];
        [bezier6Path addCurveToPoint:CGPointMake(10.59, 24.08) controlPoint1:CGPointMake(10.69, 24.14) controlPoint2:CGPointMake(10.64, 24.11)];
        [bezier6Path addCurveToPoint:CGPointMake(10.52, 23.93) controlPoint1:CGPointMake(10.55, 24.04) controlPoint2:CGPointMake(10.52, 23.99)];
        [bezier6Path addLineToPoint:CGPointMake(10.52, 23.92)];
        [bezier6Path addCurveToPoint:CGPointMake(10.57, 23.8) controlPoint1:CGPointMake(10.52, 23.87) controlPoint2:CGPointMake(10.54, 23.84)];
        [bezier6Path addCurveToPoint:CGPointMake(10.69, 23.75) controlPoint1:CGPointMake(10.6, 23.77) controlPoint2:CGPointMake(10.65, 23.75)];
        [bezier6Path addLineToPoint:CGPointMake(10.69, 23.75)];
        [bezier6Path addCurveToPoint:CGPointMake(10.78, 23.76) controlPoint1:CGPointMake(10.73, 23.75) controlPoint2:CGPointMake(10.76, 23.76)];
        [bezier6Path addCurveToPoint:CGPointMake(10.83, 23.78) controlPoint1:CGPointMake(10.8, 23.77) controlPoint2:CGPointMake(10.82, 23.78)];
        [bezier6Path addCurveToPoint:CGPointMake(10.88, 23.81) controlPoint1:CGPointMake(10.85, 23.79) controlPoint2:CGPointMake(10.86, 23.8)];
        [bezier6Path addCurveToPoint:CGPointMake(10.95, 23.84) controlPoint1:CGPointMake(10.9, 23.82) controlPoint2:CGPointMake(10.92, 23.83)];
        [bezier6Path addCurveToPoint:CGPointMake(11.07, 23.86) controlPoint1:CGPointMake(10.98, 23.85) controlPoint2:CGPointMake(11.02, 23.85)];
        [bezier6Path addCurveToPoint:CGPointMake(11.26, 23.87) controlPoint1:CGPointMake(11.12, 23.87) controlPoint2:CGPointMake(11.18, 23.87)];
        [bezier6Path addCurveToPoint:CGPointMake(11.45, 23.85) controlPoint1:CGPointMake(11.34, 23.87) controlPoint2:CGPointMake(11.4, 23.86)];
        [bezier6Path addCurveToPoint:CGPointMake(11.57, 23.8) controlPoint1:CGPointMake(11.5, 23.84) controlPoint2:CGPointMake(11.54, 23.82)];
        [bezier6Path addCurveToPoint:CGPointMake(11.63, 23.71) controlPoint1:CGPointMake(11.6, 23.78) controlPoint2:CGPointMake(11.62, 23.74)];
        [bezier6Path addCurveToPoint:CGPointMake(11.65, 23.58) controlPoint1:CGPointMake(11.64, 23.67) controlPoint2:CGPointMake(11.65, 23.63)];
        [bezier6Path addCurveToPoint:CGPointMake(11.61, 23.39) controlPoint1:CGPointMake(11.65, 23.49) controlPoint2:CGPointMake(11.64, 23.43)];
        [bezier6Path addCurveToPoint:CGPointMake(11.48, 23.33) controlPoint1:CGPointMake(11.59, 23.35) controlPoint2:CGPointMake(11.54, 23.33)];
        [bezier6Path addLineToPoint:CGPointMake(10.82, 23.33)];
        [bezier6Path addCurveToPoint:CGPointMake(10.68, 23.32) controlPoint1:CGPointMake(10.76, 23.33) controlPoint2:CGPointMake(10.72, 23.33)];
        [bezier6Path addCurveToPoint:CGPointMake(10.6, 23.29) controlPoint1:CGPointMake(10.65, 23.32) controlPoint2:CGPointMake(10.62, 23.3)];
        [bezier6Path addCurveToPoint:CGPointMake(10.56, 23.22) controlPoint1:CGPointMake(10.58, 23.27) controlPoint2:CGPointMake(10.57, 23.25)];
        [bezier6Path addCurveToPoint:CGPointMake(10.55, 23.1) controlPoint1:CGPointMake(10.55, 23.19) controlPoint2:CGPointMake(10.55, 23.15)];
        [bezier6Path addLineToPoint:CGPointMake(10.55, 22.36)];
        [bezier6Path addCurveToPoint:CGPointMake(10.6, 22.23) controlPoint1:CGPointMake(10.55, 22.3) controlPoint2:CGPointMake(10.57, 22.26)];
        [bezier6Path addCurveToPoint:CGPointMake(10.77, 22.19) controlPoint1:CGPointMake(10.63, 22.2) controlPoint2:CGPointMake(10.69, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(10.89, 22.19) controlPoint1:CGPointMake(10.79, 22.19) controlPoint2:CGPointMake(10.83, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.07, 22.19) controlPoint1:CGPointMake(10.94, 22.19) controlPoint2:CGPointMake(11, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.28, 22.19) controlPoint1:CGPointMake(11.13, 22.19) controlPoint2:CGPointMake(11.2, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.48, 22.19) controlPoint1:CGPointMake(11.35, 22.19) controlPoint2:CGPointMake(11.42, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.64, 22.19) controlPoint1:CGPointMake(11.54, 22.19) controlPoint2:CGPointMake(11.59, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.72, 22.19) controlPoint1:CGPointMake(11.68, 22.19) controlPoint2:CGPointMake(11.71, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.79, 22.2) controlPoint1:CGPointMake(11.74, 22.19) controlPoint2:CGPointMake(11.76, 22.19)];
        [bezier6Path addCurveToPoint:CGPointMake(11.86, 22.22) controlPoint1:CGPointMake(11.81, 22.2) controlPoint2:CGPointMake(11.84, 22.21)];
        [bezier6Path addCurveToPoint:CGPointMake(11.92, 22.27) controlPoint1:CGPointMake(11.88, 22.23) controlPoint2:CGPointMake(11.9, 22.25)];
        [bezier6Path addCurveToPoint:CGPointMake(11.94, 22.35) controlPoint1:CGPointMake(11.93, 22.29) controlPoint2:CGPointMake(11.94, 22.32)];
        [bezier6Path addLineToPoint:CGPointMake(11.94, 22.35)];
        [bezier6Path addCurveToPoint:CGPointMake(11.92, 22.44) controlPoint1:CGPointMake(11.94, 22.39) controlPoint2:CGPointMake(11.93, 22.42)];
        [bezier6Path addCurveToPoint:CGPointMake(11.87, 22.49) controlPoint1:CGPointMake(11.91, 22.46) controlPoint2:CGPointMake(11.89, 22.48)];
        [bezier6Path addCurveToPoint:CGPointMake(11.8, 22.51) controlPoint1:CGPointMake(11.84, 22.5) controlPoint2:CGPointMake(11.82, 22.51)];
        [bezier6Path addCurveToPoint:CGPointMake(11.71, 22.51) controlPoint1:CGPointMake(11.77, 22.51) controlPoint2:CGPointMake(11.75, 22.51)];
        [bezier6Path addLineToPoint:CGPointMake(10.93, 22.51)];
        [bezier6Path addLineToPoint:CGPointMake(10.93, 23.02)];
        [bezier6Path addLineToPoint:CGPointMake(11.45, 23.02)];
        [bezier6Path addCurveToPoint:CGPointMake(11.75, 23.04) controlPoint1:CGPointMake(11.58, 23.01) controlPoint2:CGPointMake(11.68, 23.02)];
        [bezier6Path closePath];
        bezier6Path.miterLimit = 4;

        [fillColor setFill];
        [bezier6Path fill];

        //// Bezier 7 Drawing
        UIBezierPath *bezier7Path = [UIBezierPath bezierPath];
        [bezier7Path moveToPoint:CGPointMake(14.91, 22.96)];
        [bezier7Path addCurveToPoint:CGPointMake(15.23, 23) controlPoint1:CGPointMake(15.04, 22.96) controlPoint2:CGPointMake(15.14, 22.97)];
        [bezier7Path addCurveToPoint:CGPointMake(15.44, 23.12) controlPoint1:CGPointMake(15.32, 23.03) controlPoint2:CGPointMake(15.39, 23.07)];
        [bezier7Path addCurveToPoint:CGPointMake(15.55, 23.32) controlPoint1:CGPointMake(15.49, 23.17) controlPoint2:CGPointMake(15.53, 23.24)];
        [bezier7Path addCurveToPoint:CGPointMake(15.59, 23.59) controlPoint1:CGPointMake(15.58, 23.4) controlPoint2:CGPointMake(15.59, 23.49)];
        [bezier7Path addCurveToPoint:CGPointMake(15.55, 23.85) controlPoint1:CGPointMake(15.59, 23.69) controlPoint2:CGPointMake(15.58, 23.78)];
        [bezier7Path addCurveToPoint:CGPointMake(15.42, 24.04) controlPoint1:CGPointMake(15.52, 23.93) controlPoint2:CGPointMake(15.48, 23.99)];
        [bezier7Path addCurveToPoint:CGPointMake(15.19, 24.16) controlPoint1:CGPointMake(15.36, 24.09) controlPoint2:CGPointMake(15.28, 24.13)];
        [bezier7Path addCurveToPoint:CGPointMake(14.83, 24.2) controlPoint1:CGPointMake(15.09, 24.19) controlPoint2:CGPointMake(14.97, 24.2)];
        [bezier7Path addCurveToPoint:CGPointMake(14.53, 24.17) controlPoint1:CGPointMake(14.72, 24.2) controlPoint2:CGPointMake(14.62, 24.19)];
        [bezier7Path addCurveToPoint:CGPointMake(14.3, 24.07) controlPoint1:CGPointMake(14.44, 24.15) controlPoint2:CGPointMake(14.36, 24.12)];
        [bezier7Path addCurveToPoint:CGPointMake(14.15, 23.9) controlPoint1:CGPointMake(14.23, 24.03) controlPoint2:CGPointMake(14.18, 23.97)];
        [bezier7Path addCurveToPoint:CGPointMake(14.1, 23.64) controlPoint1:CGPointMake(14.11, 23.83) controlPoint2:CGPointMake(14.1, 23.74)];
        [bezier7Path addLineToPoint:CGPointMake(14.1, 22.34)];
        [bezier7Path addCurveToPoint:CGPointMake(14.11, 22.28) controlPoint1:CGPointMake(14.1, 22.32) controlPoint2:CGPointMake(14.1, 22.3)];
        [bezier7Path addCurveToPoint:CGPointMake(14.14, 22.23) controlPoint1:CGPointMake(14.12, 22.26) controlPoint2:CGPointMake(14.13, 22.24)];
        [bezier7Path addCurveToPoint:CGPointMake(14.2, 22.19) controlPoint1:CGPointMake(14.16, 22.21) controlPoint2:CGPointMake(14.18, 22.2)];
        [bezier7Path addCurveToPoint:CGPointMake(14.29, 22.17) controlPoint1:CGPointMake(14.23, 22.18) controlPoint2:CGPointMake(14.26, 22.17)];
        [bezier7Path addCurveToPoint:CGPointMake(14.44, 22.22) controlPoint1:CGPointMake(14.35, 22.17) controlPoint2:CGPointMake(14.4, 22.19)];
        [bezier7Path addCurveToPoint:CGPointMake(14.49, 22.34) controlPoint1:CGPointMake(14.47, 22.25) controlPoint2:CGPointMake(14.49, 22.29)];
        [bezier7Path addLineToPoint:CGPointMake(14.49, 22.99)];
        [bezier7Path addCurveToPoint:CGPointMake(14.74, 22.97) controlPoint1:CGPointMake(14.58, 22.98) controlPoint2:CGPointMake(14.67, 22.97)];
        [bezier7Path addCurveToPoint:CGPointMake(14.91, 22.96) controlPoint1:CGPointMake(14.8, 22.96) controlPoint2:CGPointMake(14.86, 22.96)];
        [bezier7Path closePath];
        [bezier7Path moveToPoint:CGPointMake(15.2, 23.57)];
        [bezier7Path addCurveToPoint:CGPointMake(15.18, 23.42) controlPoint1:CGPointMake(15.2, 23.51) controlPoint2:CGPointMake(15.2, 23.46)];
        [bezier7Path addCurveToPoint:CGPointMake(15.12, 23.33) controlPoint1:CGPointMake(15.17, 23.38) controlPoint2:CGPointMake(15.15, 23.35)];
        [bezier7Path addCurveToPoint:CGPointMake(15.01, 23.29) controlPoint1:CGPointMake(15.09, 23.31) controlPoint2:CGPointMake(15.05, 23.29)];
        [bezier7Path addCurveToPoint:CGPointMake(14.83, 23.28) controlPoint1:CGPointMake(14.96, 23.28) controlPoint2:CGPointMake(14.91, 23.28)];
        [bezier7Path addCurveToPoint:CGPointMake(14.69, 23.28) controlPoint1:CGPointMake(14.78, 23.28) controlPoint2:CGPointMake(14.73, 23.28)];
        [bezier7Path addCurveToPoint:CGPointMake(14.6, 23.28) controlPoint1:CGPointMake(14.65, 23.28) controlPoint2:CGPointMake(14.63, 23.28)];
        [bezier7Path addCurveToPoint:CGPointMake(14.53, 23.29) controlPoint1:CGPointMake(14.58, 23.28) controlPoint2:CGPointMake(14.56, 23.28)];
        [bezier7Path addCurveToPoint:CGPointMake(14.47, 23.3) controlPoint1:CGPointMake(14.51, 23.29) controlPoint2:CGPointMake(14.49, 23.3)];
        [bezier7Path addLineToPoint:CGPointMake(14.47, 23.56)];
        [bezier7Path addCurveToPoint:CGPointMake(14.49, 23.7) controlPoint1:CGPointMake(14.47, 23.61) controlPoint2:CGPointMake(14.47, 23.66)];
        [bezier7Path addCurveToPoint:CGPointMake(14.54, 23.8) controlPoint1:CGPointMake(14.5, 23.74) controlPoint2:CGPointMake(14.52, 23.77)];
        [bezier7Path addCurveToPoint:CGPointMake(14.65, 23.86) controlPoint1:CGPointMake(14.57, 23.83) controlPoint2:CGPointMake(14.61, 23.85)];
        [bezier7Path addCurveToPoint:CGPointMake(14.82, 23.88) controlPoint1:CGPointMake(14.7, 23.87) controlPoint2:CGPointMake(14.75, 23.88)];
        [bezier7Path addCurveToPoint:CGPointMake(14.99, 23.87) controlPoint1:CGPointMake(14.88, 23.88) controlPoint2:CGPointMake(14.94, 23.88)];
        [bezier7Path addCurveToPoint:CGPointMake(15.1, 23.83) controlPoint1:CGPointMake(15.03, 23.86) controlPoint2:CGPointMake(15.07, 23.85)];
        [bezier7Path addCurveToPoint:CGPointMake(15.16, 23.74) controlPoint1:CGPointMake(15.13, 23.81) controlPoint2:CGPointMake(15.15, 23.78)];
        [bezier7Path addCurveToPoint:CGPointMake(15.2, 23.57) controlPoint1:CGPointMake(15.19, 23.69) controlPoint2:CGPointMake(15.2, 23.64)];
        [bezier7Path closePath];
        bezier7Path.miterLimit = 4;

        [fillColor setFill];
        [bezier7Path fill];

        //// Bezier 8 Drawing
        UIBezierPath *bezier8Path = [UIBezierPath bezierPath];
        [bezier8Path moveToPoint:CGPointMake(17.69, 23.65)];
        [bezier8Path addLineToPoint:CGPointMake(17.69, 23.65)];
        [bezier8Path addCurveToPoint:CGPointMake(17.64, 23.91) controlPoint1:CGPointMake(17.7, 23.75) controlPoint2:CGPointMake(17.68, 23.84)];
        [bezier8Path addCurveToPoint:CGPointMake(17.48, 24.08) controlPoint1:CGPointMake(17.6, 23.98) controlPoint2:CGPointMake(17.55, 24.04)];
        [bezier8Path addCurveToPoint:CGPointMake(17.24, 24.17) controlPoint1:CGPointMake(17.41, 24.12) controlPoint2:CGPointMake(17.33, 24.15)];
        [bezier8Path addCurveToPoint:CGPointMake(16.93, 24.2) controlPoint1:CGPointMake(17.15, 24.19) controlPoint2:CGPointMake(17.04, 24.2)];
        [bezier8Path addCurveToPoint:CGPointMake(16.62, 24.17) controlPoint1:CGPointMake(16.82, 24.2) controlPoint2:CGPointMake(16.71, 24.19)];
        [bezier8Path addCurveToPoint:CGPointMake(16.39, 24.08) controlPoint1:CGPointMake(16.53, 24.15) controlPoint2:CGPointMake(16.45, 24.12)];
        [bezier8Path addCurveToPoint:CGPointMake(16.24, 23.91) controlPoint1:CGPointMake(16.33, 24.04) controlPoint2:CGPointMake(16.28, 23.98)];
        [bezier8Path addCurveToPoint:CGPointMake(16.19, 23.67) controlPoint1:CGPointMake(16.2, 23.84) controlPoint2:CGPointMake(16.19, 23.76)];
        [bezier8Path addLineToPoint:CGPointMake(16.19, 22.7)];
        [bezier8Path addCurveToPoint:CGPointMake(16.39, 22.31) controlPoint1:CGPointMake(16.19, 22.53) controlPoint2:CGPointMake(16.26, 22.4)];
        [bezier8Path addCurveToPoint:CGPointMake(16.95, 22.18) controlPoint1:CGPointMake(16.52, 22.22) controlPoint2:CGPointMake(16.71, 22.18)];
        [bezier8Path addCurveToPoint:CGPointMake(17.26, 22.21) controlPoint1:CGPointMake(17.06, 22.18) controlPoint2:CGPointMake(17.16, 22.19)];
        [bezier8Path addCurveToPoint:CGPointMake(17.5, 22.31) controlPoint1:CGPointMake(17.35, 22.23) controlPoint2:CGPointMake(17.43, 22.27)];
        [bezier8Path addCurveToPoint:CGPointMake(17.65, 22.48) controlPoint1:CGPointMake(17.56, 22.35) controlPoint2:CGPointMake(17.61, 22.41)];
        [bezier8Path addCurveToPoint:CGPointMake(17.7, 22.71) controlPoint1:CGPointMake(17.69, 22.55) controlPoint2:CGPointMake(17.7, 22.62)];
        [bezier8Path addLineToPoint:CGPointMake(17.7, 23.65)];
        [bezier8Path addLineToPoint:CGPointMake(17.69, 23.65)];
        [bezier8Path closePath];
        [bezier8Path moveToPoint:CGPointMake(17.3, 22.72)];
        [bezier8Path addCurveToPoint:CGPointMake(17.21, 22.55) controlPoint1:CGPointMake(17.3, 22.65) controlPoint2:CGPointMake(17.27, 22.59)];
        [bezier8Path addCurveToPoint:CGPointMake(16.93, 22.49) controlPoint1:CGPointMake(17.15, 22.51) controlPoint2:CGPointMake(17.06, 22.49)];
        [bezier8Path addCurveToPoint:CGPointMake(16.66, 22.55) controlPoint1:CGPointMake(16.81, 22.49) controlPoint2:CGPointMake(16.72, 22.51)];
        [bezier8Path addCurveToPoint:CGPointMake(16.57, 22.7) controlPoint1:CGPointMake(16.6, 22.59) controlPoint2:CGPointMake(16.57, 22.64)];
        [bezier8Path addLineToPoint:CGPointMake(16.57, 23.65)];
        [bezier8Path addCurveToPoint:CGPointMake(16.66, 23.82) controlPoint1:CGPointMake(16.57, 23.73) controlPoint2:CGPointMake(16.6, 23.78)];
        [bezier8Path addCurveToPoint:CGPointMake(16.92, 23.87) controlPoint1:CGPointMake(16.72, 23.85) controlPoint2:CGPointMake(16.81, 23.87)];
        [bezier8Path addCurveToPoint:CGPointMake(17.19, 23.82) controlPoint1:CGPointMake(17.04, 23.87) controlPoint2:CGPointMake(17.12, 23.85)];
        [bezier8Path addCurveToPoint:CGPointMake(17.29, 23.65) controlPoint1:CGPointMake(17.25, 23.79) controlPoint2:CGPointMake(17.29, 23.73)];
        [bezier8Path addLineToPoint:CGPointMake(17.29, 22.72)];
        [bezier8Path addLineToPoint:CGPointMake(17.3, 22.72)];
        [bezier8Path closePath];
        bezier8Path.miterLimit = 4;

        [fillColor setFill];
        [bezier8Path fill];

        //// Bezier 9 Drawing
        UIBezierPath *bezier9Path = [UIBezierPath bezierPath];
        [bezier9Path moveToPoint:CGPointMake(19.56, 23.04)];
        [bezier9Path addCurveToPoint:CGPointMake(19.74, 23.13) controlPoint1:CGPointMake(19.63, 23.06) controlPoint2:CGPointMake(19.69, 23.09)];
        [bezier9Path addCurveToPoint:CGPointMake(19.83, 23.31) controlPoint1:CGPointMake(19.79, 23.17) controlPoint2:CGPointMake(19.82, 23.23)];
        [bezier9Path addCurveToPoint:CGPointMake(19.86, 23.59) controlPoint1:CGPointMake(19.85, 23.38) controlPoint2:CGPointMake(19.86, 23.48)];
        [bezier9Path addCurveToPoint:CGPointMake(19.82, 23.88) controlPoint1:CGPointMake(19.86, 23.71) controlPoint2:CGPointMake(19.85, 23.8)];
        [bezier9Path addCurveToPoint:CGPointMake(19.69, 24.07) controlPoint1:CGPointMake(19.8, 23.96) controlPoint2:CGPointMake(19.75, 24.02)];
        [bezier9Path addCurveToPoint:CGPointMake(19.44, 24.17) controlPoint1:CGPointMake(19.63, 24.11) controlPoint2:CGPointMake(19.55, 24.15)];
        [bezier9Path addCurveToPoint:CGPointMake(19.04, 24.2) controlPoint1:CGPointMake(19.34, 24.19) controlPoint2:CGPointMake(19.2, 24.2)];
        [bezier9Path addLineToPoint:CGPointMake(18.96, 24.2)];
        [bezier9Path addCurveToPoint:CGPointMake(18.76, 24.19) controlPoint1:CGPointMake(18.9, 24.2) controlPoint2:CGPointMake(18.83, 24.2)];
        [bezier9Path addCurveToPoint:CGPointMake(18.56, 24.16) controlPoint1:CGPointMake(18.69, 24.19) controlPoint2:CGPointMake(18.62, 24.17)];
        [bezier9Path addCurveToPoint:CGPointMake(18.4, 24.08) controlPoint1:CGPointMake(18.5, 24.14) controlPoint2:CGPointMake(18.45, 24.11)];
        [bezier9Path addCurveToPoint:CGPointMake(18.33, 23.93) controlPoint1:CGPointMake(18.36, 24.04) controlPoint2:CGPointMake(18.33, 23.99)];
        [bezier9Path addLineToPoint:CGPointMake(18.33, 23.92)];
        [bezier9Path addCurveToPoint:CGPointMake(18.38, 23.8) controlPoint1:CGPointMake(18.33, 23.87) controlPoint2:CGPointMake(18.35, 23.84)];
        [bezier9Path addCurveToPoint:CGPointMake(18.5, 23.75) controlPoint1:CGPointMake(18.41, 23.77) controlPoint2:CGPointMake(18.45, 23.75)];
        [bezier9Path addLineToPoint:CGPointMake(18.51, 23.75)];
        [bezier9Path addCurveToPoint:CGPointMake(18.6, 23.76) controlPoint1:CGPointMake(18.55, 23.75) controlPoint2:CGPointMake(18.58, 23.76)];
        [bezier9Path addCurveToPoint:CGPointMake(18.65, 23.78) controlPoint1:CGPointMake(18.62, 23.77) controlPoint2:CGPointMake(18.64, 23.78)];
        [bezier9Path addCurveToPoint:CGPointMake(18.7, 23.81) controlPoint1:CGPointMake(18.67, 23.79) controlPoint2:CGPointMake(18.68, 23.8)];
        [bezier9Path addCurveToPoint:CGPointMake(18.77, 23.84) controlPoint1:CGPointMake(18.71, 23.82) controlPoint2:CGPointMake(18.74, 23.83)];
        [bezier9Path addCurveToPoint:CGPointMake(18.89, 23.86) controlPoint1:CGPointMake(18.8, 23.85) controlPoint2:CGPointMake(18.84, 23.85)];
        [bezier9Path addCurveToPoint:CGPointMake(19.08, 23.87) controlPoint1:CGPointMake(18.94, 23.87) controlPoint2:CGPointMake(19, 23.87)];
        [bezier9Path addCurveToPoint:CGPointMake(19.27, 23.85) controlPoint1:CGPointMake(19.16, 23.87) controlPoint2:CGPointMake(19.22, 23.86)];
        [bezier9Path addCurveToPoint:CGPointMake(19.39, 23.8) controlPoint1:CGPointMake(19.32, 23.84) controlPoint2:CGPointMake(19.36, 23.82)];
        [bezier9Path addCurveToPoint:CGPointMake(19.45, 23.71) controlPoint1:CGPointMake(19.42, 23.78) controlPoint2:CGPointMake(19.44, 23.74)];
        [bezier9Path addCurveToPoint:CGPointMake(19.46, 23.58) controlPoint1:CGPointMake(19.46, 23.67) controlPoint2:CGPointMake(19.46, 23.63)];
        [bezier9Path addCurveToPoint:CGPointMake(19.43, 23.39) controlPoint1:CGPointMake(19.46, 23.49) controlPoint2:CGPointMake(19.45, 23.43)];
        [bezier9Path addCurveToPoint:CGPointMake(19.3, 23.33) controlPoint1:CGPointMake(19.41, 23.35) controlPoint2:CGPointMake(19.36, 23.33)];
        [bezier9Path addLineToPoint:CGPointMake(18.63, 23.33)];
        [bezier9Path addCurveToPoint:CGPointMake(18.49, 23.32) controlPoint1:CGPointMake(18.57, 23.33) controlPoint2:CGPointMake(18.52, 23.33)];
        [bezier9Path addCurveToPoint:CGPointMake(18.41, 23.29) controlPoint1:CGPointMake(18.46, 23.32) controlPoint2:CGPointMake(18.43, 23.3)];
        [bezier9Path addCurveToPoint:CGPointMake(18.37, 23.22) controlPoint1:CGPointMake(18.39, 23.27) controlPoint2:CGPointMake(18.38, 23.25)];
        [bezier9Path addCurveToPoint:CGPointMake(18.36, 23.1) controlPoint1:CGPointMake(18.36, 23.19) controlPoint2:CGPointMake(18.36, 23.15)];
        [bezier9Path addLineToPoint:CGPointMake(18.36, 22.36)];
        [bezier9Path addCurveToPoint:CGPointMake(18.41, 22.23) controlPoint1:CGPointMake(18.36, 22.3) controlPoint2:CGPointMake(18.38, 22.26)];
        [bezier9Path addCurveToPoint:CGPointMake(18.58, 22.19) controlPoint1:CGPointMake(18.44, 22.2) controlPoint2:CGPointMake(18.5, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(18.7, 22.19) controlPoint1:CGPointMake(18.6, 22.19) controlPoint2:CGPointMake(18.64, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(18.88, 22.19) controlPoint1:CGPointMake(18.75, 22.19) controlPoint2:CGPointMake(18.82, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.08, 22.19) controlPoint1:CGPointMake(18.95, 22.19) controlPoint2:CGPointMake(19.01, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.28, 22.19) controlPoint1:CGPointMake(19.15, 22.19) controlPoint2:CGPointMake(19.22, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.44, 22.19) controlPoint1:CGPointMake(19.34, 22.19) controlPoint2:CGPointMake(19.4, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.52, 22.19) controlPoint1:CGPointMake(19.48, 22.19) controlPoint2:CGPointMake(19.51, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.59, 22.2) controlPoint1:CGPointMake(19.54, 22.19) controlPoint2:CGPointMake(19.57, 22.19)];
        [bezier9Path addCurveToPoint:CGPointMake(19.66, 22.22) controlPoint1:CGPointMake(19.62, 22.2) controlPoint2:CGPointMake(19.64, 22.21)];
        [bezier9Path addCurveToPoint:CGPointMake(19.72, 22.27) controlPoint1:CGPointMake(19.68, 22.23) controlPoint2:CGPointMake(19.7, 22.25)];
        [bezier9Path addCurveToPoint:CGPointMake(19.74, 22.35) controlPoint1:CGPointMake(19.74, 22.29) controlPoint2:CGPointMake(19.74, 22.32)];
        [bezier9Path addLineToPoint:CGPointMake(19.74, 22.35)];
        [bezier9Path addCurveToPoint:CGPointMake(19.72, 22.44) controlPoint1:CGPointMake(19.74, 22.39) controlPoint2:CGPointMake(19.73, 22.42)];
        [bezier9Path addCurveToPoint:CGPointMake(19.67, 22.49) controlPoint1:CGPointMake(19.71, 22.46) controlPoint2:CGPointMake(19.69, 22.48)];
        [bezier9Path addCurveToPoint:CGPointMake(19.6, 22.51) controlPoint1:CGPointMake(19.65, 22.5) controlPoint2:CGPointMake(19.63, 22.51)];
        [bezier9Path addCurveToPoint:CGPointMake(19.52, 22.51) controlPoint1:CGPointMake(19.57, 22.51) controlPoint2:CGPointMake(19.55, 22.51)];
        [bezier9Path addLineToPoint:CGPointMake(18.74, 22.51)];
        [bezier9Path addLineToPoint:CGPointMake(18.74, 23.02)];
        [bezier9Path addLineToPoint:CGPointMake(19.26, 23.02)];
        [bezier9Path addCurveToPoint:CGPointMake(19.56, 23.04) controlPoint1:CGPointMake(19.39, 23.01) controlPoint2:CGPointMake(19.49, 23.02)];
        [bezier9Path closePath];
        bezier9Path.miterLimit = 4;

        [fillColor setFill];
        [bezier9Path fill];

        //// Bezier 10 Drawing
        UIBezierPath *bezier10Path = [UIBezierPath bezierPath];
        [bezier10Path moveToPoint:CGPointMake(21.29, 22.17)];
        [bezier10Path addCurveToPoint:CGPointMake(21.66, 22.2) controlPoint1:CGPointMake(21.44, 22.17) controlPoint2:CGPointMake(21.56, 22.18)];
        [bezier10Path addCurveToPoint:CGPointMake(21.9, 22.3) controlPoint1:CGPointMake(21.76, 22.22) controlPoint2:CGPointMake(21.84, 22.25)];
        [bezier10Path addCurveToPoint:CGPointMake(22.04, 22.48) controlPoint1:CGPointMake(21.96, 22.35) controlPoint2:CGPointMake(22.01, 22.4)];
        [bezier10Path addCurveToPoint:CGPointMake(22.08, 22.75) controlPoint1:CGPointMake(22.07, 22.55) controlPoint2:CGPointMake(22.08, 22.64)];
        [bezier10Path addLineToPoint:CGPointMake(22.08, 22.76)];
        [bezier10Path addCurveToPoint:CGPointMake(22.05, 23.05) controlPoint1:CGPointMake(22.08, 22.87) controlPoint2:CGPointMake(22.07, 22.97)];
        [bezier10Path addCurveToPoint:CGPointMake(21.94, 23.23) controlPoint1:CGPointMake(22.03, 23.13) controlPoint2:CGPointMake(21.99, 23.19)];
        [bezier10Path addCurveToPoint:CGPointMake(21.74, 23.33) controlPoint1:CGPointMake(21.89, 23.28) controlPoint2:CGPointMake(21.82, 23.31)];
        [bezier10Path addCurveToPoint:CGPointMake(21.44, 23.36) controlPoint1:CGPointMake(21.66, 23.35) controlPoint2:CGPointMake(21.56, 23.36)];
        [bezier10Path addCurveToPoint:CGPointMake(21.18, 23.37) controlPoint1:CGPointMake(21.33, 23.36) controlPoint2:CGPointMake(21.25, 23.36)];
        [bezier10Path addCurveToPoint:CGPointMake(21.02, 23.4) controlPoint1:CGPointMake(21.11, 23.37) controlPoint2:CGPointMake(21.06, 23.39)];
        [bezier10Path addCurveToPoint:CGPointMake(20.94, 23.49) controlPoint1:CGPointMake(20.98, 23.42) controlPoint2:CGPointMake(20.95, 23.45)];
        [bezier10Path addCurveToPoint:CGPointMake(20.91, 23.68) controlPoint1:CGPointMake(20.92, 23.53) controlPoint2:CGPointMake(20.91, 23.6)];
        [bezier10Path addLineToPoint:CGPointMake(20.91, 23.86)];
        [bezier10Path addLineToPoint:CGPointMake(21.88, 23.86)];
        [bezier10Path addCurveToPoint:CGPointMake(21.95, 23.87) controlPoint1:CGPointMake(21.9, 23.86) controlPoint2:CGPointMake(21.93, 23.86)];
        [bezier10Path addCurveToPoint:CGPointMake(22.02, 23.9) controlPoint1:CGPointMake(21.97, 23.88) controlPoint2:CGPointMake(22, 23.89)];
        [bezier10Path addCurveToPoint:CGPointMake(22.07, 23.95) controlPoint1:CGPointMake(22.04, 23.91) controlPoint2:CGPointMake(22.06, 23.93)];
        [bezier10Path addCurveToPoint:CGPointMake(22.09, 24.02) controlPoint1:CGPointMake(22.08, 23.97) controlPoint2:CGPointMake(22.09, 23.99)];
        [bezier10Path addCurveToPoint:CGPointMake(22.07, 24.1) controlPoint1:CGPointMake(22.09, 24.05) controlPoint2:CGPointMake(22.09, 24.08)];
        [bezier10Path addCurveToPoint:CGPointMake(22.02, 24.15) controlPoint1:CGPointMake(22.06, 24.12) controlPoint2:CGPointMake(22.04, 24.14)];
        [bezier10Path addCurveToPoint:CGPointMake(21.95, 24.18) controlPoint1:CGPointMake(22, 24.16) controlPoint2:CGPointMake(21.98, 24.17)];
        [bezier10Path addCurveToPoint:CGPointMake(21.87, 24.19) controlPoint1:CGPointMake(21.92, 24.19) controlPoint2:CGPointMake(21.9, 24.19)];
        [bezier10Path addLineToPoint:CGPointMake(20.73, 24.19)];
        [bezier10Path addCurveToPoint:CGPointMake(20.56, 24.15) controlPoint1:CGPointMake(20.65, 24.19) controlPoint2:CGPointMake(20.59, 24.18)];
        [bezier10Path addCurveToPoint:CGPointMake(20.51, 24.02) controlPoint1:CGPointMake(20.53, 24.12) controlPoint2:CGPointMake(20.51, 24.08)];
        [bezier10Path addLineToPoint:CGPointMake(20.51, 23.62)];
        [bezier10Path addCurveToPoint:CGPointMake(20.55, 23.35) controlPoint1:CGPointMake(20.51, 23.51) controlPoint2:CGPointMake(20.52, 23.42)];
        [bezier10Path addCurveToPoint:CGPointMake(20.67, 23.18) controlPoint1:CGPointMake(20.58, 23.28) controlPoint2:CGPointMake(20.62, 23.22)];
        [bezier10Path addCurveToPoint:CGPointMake(20.87, 23.08) controlPoint1:CGPointMake(20.73, 23.13) controlPoint2:CGPointMake(20.79, 23.1)];
        [bezier10Path addCurveToPoint:CGPointMake(21.13, 23.05) controlPoint1:CGPointMake(20.95, 23.06) controlPoint2:CGPointMake(21.04, 23.05)];
        [bezier10Path addLineToPoint:CGPointMake(21.41, 23.04)];
        [bezier10Path addCurveToPoint:CGPointMake(21.54, 23.03) controlPoint1:CGPointMake(21.46, 23.04) controlPoint2:CGPointMake(21.51, 23.04)];
        [bezier10Path addCurveToPoint:CGPointMake(21.62, 22.99) controlPoint1:CGPointMake(21.57, 23.02) controlPoint2:CGPointMake(21.6, 23.01)];
        [bezier10Path addCurveToPoint:CGPointMake(21.67, 22.91) controlPoint1:CGPointMake(21.64, 22.97) controlPoint2:CGPointMake(21.66, 22.95)];
        [bezier10Path addCurveToPoint:CGPointMake(21.69, 22.79) controlPoint1:CGPointMake(21.68, 22.88) controlPoint2:CGPointMake(21.69, 22.84)];
        [bezier10Path addLineToPoint:CGPointMake(21.69, 22.78)];
        [bezier10Path addCurveToPoint:CGPointMake(21.67, 22.65) controlPoint1:CGPointMake(21.69, 22.73) controlPoint2:CGPointMake(21.68, 22.69)];
        [bezier10Path addCurveToPoint:CGPointMake(21.6, 22.57) controlPoint1:CGPointMake(21.66, 22.61) controlPoint2:CGPointMake(21.63, 22.59)];
        [bezier10Path addCurveToPoint:CGPointMake(21.47, 22.52) controlPoint1:CGPointMake(21.57, 22.55) controlPoint2:CGPointMake(21.53, 22.53)];
        [bezier10Path addCurveToPoint:CGPointMake(21.26, 22.51) controlPoint1:CGPointMake(21.41, 22.51) controlPoint2:CGPointMake(21.34, 22.51)];
        [bezier10Path addCurveToPoint:CGPointMake(21.07, 22.52) controlPoint1:CGPointMake(21.19, 22.51) controlPoint2:CGPointMake(21.13, 22.51)];
        [bezier10Path addCurveToPoint:CGPointMake(20.93, 22.55) controlPoint1:CGPointMake(21.01, 22.53) controlPoint2:CGPointMake(20.97, 22.54)];
        [bezier10Path addCurveToPoint:CGPointMake(20.83, 22.59) controlPoint1:CGPointMake(20.89, 22.56) controlPoint2:CGPointMake(20.86, 22.57)];
        [bezier10Path addCurveToPoint:CGPointMake(20.73, 22.61) controlPoint1:CGPointMake(20.8, 22.6) controlPoint2:CGPointMake(20.77, 22.61)];
        [bezier10Path addLineToPoint:CGPointMake(20.72, 22.61)];
        [bezier10Path addCurveToPoint:CGPointMake(20.6, 22.56) controlPoint1:CGPointMake(20.67, 22.61) controlPoint2:CGPointMake(20.63, 22.59)];
        [bezier10Path addCurveToPoint:CGPointMake(20.56, 22.44) controlPoint1:CGPointMake(20.57, 22.53) controlPoint2:CGPointMake(20.56, 22.49)];
        [bezier10Path addLineToPoint:CGPointMake(20.56, 22.43)];
        [bezier10Path addCurveToPoint:CGPointMake(20.62, 22.32) controlPoint1:CGPointMake(20.56, 22.39) controlPoint2:CGPointMake(20.58, 22.35)];
        [bezier10Path addCurveToPoint:CGPointMake(20.78, 22.25) controlPoint1:CGPointMake(20.66, 22.29) controlPoint2:CGPointMake(20.71, 22.26)];
        [bezier10Path addCurveToPoint:CGPointMake(21.01, 22.21) controlPoint1:CGPointMake(20.85, 22.23) controlPoint2:CGPointMake(20.92, 22.22)];
        [bezier10Path addCurveToPoint:CGPointMake(21.29, 22.17) controlPoint1:CGPointMake(21.1, 22.17) controlPoint2:CGPointMake(21.19, 22.17)];
        [bezier10Path closePath];
        bezier10Path.miterLimit = 4;

        [fillColor setFill];
        [bezier10Path fill];

        //// Bezier 11 Drawing
        UIBezierPath *bezier11Path = [UIBezierPath bezierPath];
        [bezier11Path moveToPoint:CGPointMake(25.63, 23.65)];
        [bezier11Path addCurveToPoint:CGPointMake(25.6, 23.88) controlPoint1:CGPointMake(25.63, 23.74) controlPoint2:CGPointMake(25.62, 23.81)];
        [bezier11Path addCurveToPoint:CGPointMake(25.49, 24.05) controlPoint1:CGPointMake(25.58, 23.95) controlPoint2:CGPointMake(25.54, 24.01)];
        [bezier11Path addCurveToPoint:CGPointMake(25.25, 24.16) controlPoint1:CGPointMake(25.43, 24.1) controlPoint2:CGPointMake(25.35, 24.13)];
        [bezier11Path addCurveToPoint:CGPointMake(24.85, 24.2) controlPoint1:CGPointMake(25.15, 24.18) controlPoint2:CGPointMake(25.01, 24.2)];
        [bezier11Path addCurveToPoint:CGPointMake(24.46, 24.16) controlPoint1:CGPointMake(24.69, 24.2) controlPoint2:CGPointMake(24.56, 24.19)];
        [bezier11Path addCurveToPoint:CGPointMake(24.23, 24.05) controlPoint1:CGPointMake(24.36, 24.13) controlPoint2:CGPointMake(24.29, 24.1)];
        [bezier11Path addCurveToPoint:CGPointMake(24.12, 23.88) controlPoint1:CGPointMake(24.18, 24) controlPoint2:CGPointMake(24.14, 23.94)];
        [bezier11Path addCurveToPoint:CGPointMake(24.09, 23.66) controlPoint1:CGPointMake(24.1, 23.81) controlPoint2:CGPointMake(24.09, 23.74)];
        [bezier11Path addCurveToPoint:CGPointMake(24.09, 23.49) controlPoint1:CGPointMake(24.09, 23.59) controlPoint2:CGPointMake(24.09, 23.54)];
        [bezier11Path addCurveToPoint:CGPointMake(24.12, 23.38) controlPoint1:CGPointMake(24.09, 23.45) controlPoint2:CGPointMake(24.1, 23.41)];
        [bezier11Path addCurveToPoint:CGPointMake(24.21, 23.3) controlPoint1:CGPointMake(24.14, 23.35) controlPoint2:CGPointMake(24.17, 23.32)];
        [bezier11Path addCurveToPoint:CGPointMake(24.38, 23.21) controlPoint1:CGPointMake(24.25, 23.27) controlPoint2:CGPointMake(24.31, 23.24)];
        [bezier11Path addCurveToPoint:CGPointMake(24.21, 23.14) controlPoint1:CGPointMake(24.31, 23.18) controlPoint2:CGPointMake(24.25, 23.16)];
        [bezier11Path addCurveToPoint:CGPointMake(24.12, 23.06) controlPoint1:CGPointMake(24.17, 23.12) controlPoint2:CGPointMake(24.14, 23.09)];
        [bezier11Path addCurveToPoint:CGPointMake(24.09, 22.94) controlPoint1:CGPointMake(24.1, 23.03) controlPoint2:CGPointMake(24.09, 22.99)];
        [bezier11Path addCurveToPoint:CGPointMake(24.08, 22.74) controlPoint1:CGPointMake(24.08, 22.89) controlPoint2:CGPointMake(24.08, 22.82)];
        [bezier11Path addCurveToPoint:CGPointMake(24.12, 22.47) controlPoint1:CGPointMake(24.08, 22.63) controlPoint2:CGPointMake(24.09, 22.54)];
        [bezier11Path addCurveToPoint:CGPointMake(24.25, 22.3) controlPoint1:CGPointMake(24.15, 22.4) controlPoint2:CGPointMake(24.19, 22.34)];
        [bezier11Path addCurveToPoint:CGPointMake(24.48, 22.21) controlPoint1:CGPointMake(24.31, 22.26) controlPoint2:CGPointMake(24.38, 22.23)];
        [bezier11Path addCurveToPoint:CGPointMake(24.83, 22.18) controlPoint1:CGPointMake(24.57, 22.19) controlPoint2:CGPointMake(24.69, 22.18)];
        [bezier11Path addCurveToPoint:CGPointMake(25.19, 22.21) controlPoint1:CGPointMake(24.97, 22.18) controlPoint2:CGPointMake(25.09, 22.19)];
        [bezier11Path addCurveToPoint:CGPointMake(25.43, 22.3) controlPoint1:CGPointMake(25.29, 22.23) controlPoint2:CGPointMake(25.37, 22.26)];
        [bezier11Path addCurveToPoint:CGPointMake(25.56, 22.47) controlPoint1:CGPointMake(25.49, 22.34) controlPoint2:CGPointMake(25.54, 22.4)];
        [bezier11Path addCurveToPoint:CGPointMake(25.6, 22.73) controlPoint1:CGPointMake(25.59, 22.54) controlPoint2:CGPointMake(25.6, 22.63)];
        [bezier11Path addCurveToPoint:CGPointMake(25.6, 22.93) controlPoint1:CGPointMake(25.6, 22.81) controlPoint2:CGPointMake(25.6, 22.88)];
        [bezier11Path addCurveToPoint:CGPointMake(25.57, 23.05) controlPoint1:CGPointMake(25.6, 22.98) controlPoint2:CGPointMake(25.59, 23.02)];
        [bezier11Path addCurveToPoint:CGPointMake(25.49, 23.13) controlPoint1:CGPointMake(25.55, 23.08) controlPoint2:CGPointMake(25.53, 23.11)];
        [bezier11Path addCurveToPoint:CGPointMake(25.33, 23.2) controlPoint1:CGPointMake(25.45, 23.15) controlPoint2:CGPointMake(25.4, 23.17)];
        [bezier11Path addCurveToPoint:CGPointMake(25.49, 23.28) controlPoint1:CGPointMake(25.4, 23.23) controlPoint2:CGPointMake(25.45, 23.26)];
        [bezier11Path addCurveToPoint:CGPointMake(25.57, 23.36) controlPoint1:CGPointMake(25.53, 23.3) controlPoint2:CGPointMake(25.56, 23.33)];
        [bezier11Path addCurveToPoint:CGPointMake(25.6, 23.47) controlPoint1:CGPointMake(25.59, 23.39) controlPoint2:CGPointMake(25.6, 23.43)];
        [bezier11Path addCurveToPoint:CGPointMake(25.63, 23.65) controlPoint1:CGPointMake(25.63, 23.51) controlPoint2:CGPointMake(25.63, 23.57)];
        [bezier11Path closePath];
        [bezier11Path moveToPoint:CGPointMake(25.25, 23.61)];
        [bezier11Path addCurveToPoint:CGPointMake(25.24, 23.58) controlPoint1:CGPointMake(25.25, 23.61) controlPoint2:CGPointMake(25.24, 23.6)];
        [bezier11Path addCurveToPoint:CGPointMake(25.19, 23.51) controlPoint1:CGPointMake(25.24, 23.56) controlPoint2:CGPointMake(25.22, 23.54)];
        [bezier11Path addCurveToPoint:CGPointMake(25.08, 23.42) controlPoint1:CGPointMake(25.17, 23.48) controlPoint2:CGPointMake(25.13, 23.45)];
        [bezier11Path addCurveToPoint:CGPointMake(24.88, 23.33) controlPoint1:CGPointMake(25.03, 23.39) controlPoint2:CGPointMake(24.96, 23.36)];
        [bezier11Path addCurveToPoint:CGPointMake(24.68, 23.43) controlPoint1:CGPointMake(24.79, 23.36) controlPoint2:CGPointMake(24.72, 23.4)];
        [bezier11Path addCurveToPoint:CGPointMake(24.57, 23.53) controlPoint1:CGPointMake(24.63, 23.46) controlPoint2:CGPointMake(24.6, 23.5)];
        [bezier11Path addCurveToPoint:CGPointMake(24.53, 23.61) controlPoint1:CGPointMake(24.55, 23.56) controlPoint2:CGPointMake(24.53, 23.59)];
        [bezier11Path addCurveToPoint:CGPointMake(24.52, 23.65) controlPoint1:CGPointMake(24.53, 23.63) controlPoint2:CGPointMake(24.52, 23.65)];
        [bezier11Path addLineToPoint:CGPointMake(24.52, 23.65)];
        [bezier11Path addCurveToPoint:CGPointMake(24.54, 23.75) controlPoint1:CGPointMake(24.52, 23.69) controlPoint2:CGPointMake(24.53, 23.73)];
        [bezier11Path addCurveToPoint:CGPointMake(24.6, 23.82) controlPoint1:CGPointMake(24.55, 23.78) controlPoint2:CGPointMake(24.57, 23.8)];
        [bezier11Path addCurveToPoint:CGPointMake(24.72, 23.86) controlPoint1:CGPointMake(24.63, 23.84) controlPoint2:CGPointMake(24.67, 23.85)];
        [bezier11Path addCurveToPoint:CGPointMake(24.91, 23.87) controlPoint1:CGPointMake(24.77, 23.87) controlPoint2:CGPointMake(24.83, 23.87)];
        [bezier11Path addCurveToPoint:CGPointMake(25.08, 23.86) controlPoint1:CGPointMake(24.98, 23.87) controlPoint2:CGPointMake(25.03, 23.87)];
        [bezier11Path addCurveToPoint:CGPointMake(25.19, 23.82) controlPoint1:CGPointMake(25.13, 23.85) controlPoint2:CGPointMake(25.16, 23.84)];
        [bezier11Path addCurveToPoint:CGPointMake(25.25, 23.75) controlPoint1:CGPointMake(25.21, 23.8) controlPoint2:CGPointMake(25.24, 23.78)];
        [bezier11Path addCurveToPoint:CGPointMake(25.27, 23.65) controlPoint1:CGPointMake(25.26, 23.72) controlPoint2:CGPointMake(25.27, 23.69)];
        [bezier11Path addLineToPoint:CGPointMake(25.27, 23.61)];
        [bezier11Path addLineToPoint:CGPointMake(25.25, 23.61)];
        [bezier11Path closePath];
        [bezier11Path moveToPoint:CGPointMake(24.88, 23.03)];
        [bezier11Path addCurveToPoint:CGPointMake(25.09, 22.98) controlPoint1:CGPointMake(24.97, 23.01) controlPoint2:CGPointMake(25.04, 22.99)];
        [bezier11Path addCurveToPoint:CGPointMake(25.2, 22.93) controlPoint1:CGPointMake(25.14, 22.96) controlPoint2:CGPointMake(25.17, 22.95)];
        [bezier11Path addCurveToPoint:CGPointMake(25.24, 22.84) controlPoint1:CGPointMake(25.22, 22.91) controlPoint2:CGPointMake(25.24, 22.88)];
        [bezier11Path addCurveToPoint:CGPointMake(25.24, 22.69) controlPoint1:CGPointMake(25.24, 22.81) controlPoint2:CGPointMake(25.24, 22.76)];
        [bezier11Path addCurveToPoint:CGPointMake(25.21, 22.58) controlPoint1:CGPointMake(25.24, 22.65) controlPoint2:CGPointMake(25.23, 22.61)];
        [bezier11Path addCurveToPoint:CGPointMake(25.14, 22.52) controlPoint1:CGPointMake(25.19, 22.55) controlPoint2:CGPointMake(25.17, 22.53)];
        [bezier11Path addCurveToPoint:CGPointMake(25.02, 22.5) controlPoint1:CGPointMake(25.11, 22.51) controlPoint2:CGPointMake(25.07, 22.5)];
        [bezier11Path addCurveToPoint:CGPointMake(24.87, 22.5) controlPoint1:CGPointMake(24.97, 22.5) controlPoint2:CGPointMake(24.92, 22.5)];
        [bezier11Path addCurveToPoint:CGPointMake(24.7, 22.51) controlPoint1:CGPointMake(24.8, 22.5) controlPoint2:CGPointMake(24.75, 22.5)];
        [bezier11Path addCurveToPoint:CGPointMake(24.59, 22.54) controlPoint1:CGPointMake(24.66, 22.51) controlPoint2:CGPointMake(24.62, 22.52)];
        [bezier11Path addCurveToPoint:CGPointMake(24.53, 22.61) controlPoint1:CGPointMake(24.56, 22.56) controlPoint2:CGPointMake(24.54, 22.58)];
        [bezier11Path addCurveToPoint:CGPointMake(24.51, 22.74) controlPoint1:CGPointMake(24.52, 22.64) controlPoint2:CGPointMake(24.51, 22.68)];
        [bezier11Path addCurveToPoint:CGPointMake(24.52, 22.86) controlPoint1:CGPointMake(24.51, 22.79) controlPoint2:CGPointMake(24.51, 22.83)];
        [bezier11Path addCurveToPoint:CGPointMake(24.56, 22.93) controlPoint1:CGPointMake(24.52, 22.89) controlPoint2:CGPointMake(24.54, 22.91)];
        [bezier11Path addCurveToPoint:CGPointMake(24.67, 22.98) controlPoint1:CGPointMake(24.58, 22.95) controlPoint2:CGPointMake(24.62, 22.96)];
        [bezier11Path addCurveToPoint:CGPointMake(24.88, 23.03) controlPoint1:CGPointMake(24.71, 22.99) controlPoint2:CGPointMake(24.78, 23)];
        [bezier11Path closePath];
        bezier11Path.miterLimit = 4;

        [fillColor setFill];
        [bezier11Path fill];

        //// Bezier 12 Drawing
        UIBezierPath *bezier12Path = [UIBezierPath bezierPath];
        [bezier12Path moveToPoint:CGPointMake(27.83, 23.65)];
        [bezier12Path addLineToPoint:CGPointMake(27.83, 23.65)];
        [bezier12Path addCurveToPoint:CGPointMake(27.77, 23.91) controlPoint1:CGPointMake(27.83, 23.75) controlPoint2:CGPointMake(27.81, 23.84)];
        [bezier12Path addCurveToPoint:CGPointMake(27.62, 24.08) controlPoint1:CGPointMake(27.73, 23.98) controlPoint2:CGPointMake(27.68, 24.04)];
        [bezier12Path addCurveToPoint:CGPointMake(27.38, 24.17) controlPoint1:CGPointMake(27.55, 24.12) controlPoint2:CGPointMake(27.47, 24.15)];
        [bezier12Path addCurveToPoint:CGPointMake(27.07, 24.2) controlPoint1:CGPointMake(27.29, 24.19) controlPoint2:CGPointMake(27.18, 24.2)];
        [bezier12Path addCurveToPoint:CGPointMake(26.76, 24.17) controlPoint1:CGPointMake(26.95, 24.2) controlPoint2:CGPointMake(26.85, 24.19)];
        [bezier12Path addCurveToPoint:CGPointMake(26.53, 24.08) controlPoint1:CGPointMake(26.67, 24.15) controlPoint2:CGPointMake(26.59, 24.12)];
        [bezier12Path addCurveToPoint:CGPointMake(26.38, 23.91) controlPoint1:CGPointMake(26.46, 24.04) controlPoint2:CGPointMake(26.41, 23.98)];
        [bezier12Path addCurveToPoint:CGPointMake(26.33, 23.67) controlPoint1:CGPointMake(26.35, 23.84) controlPoint2:CGPointMake(26.33, 23.76)];
        [bezier12Path addLineToPoint:CGPointMake(26.33, 22.7)];
        [bezier12Path addCurveToPoint:CGPointMake(26.53, 22.31) controlPoint1:CGPointMake(26.33, 22.53) controlPoint2:CGPointMake(26.39, 22.4)];
        [bezier12Path addCurveToPoint:CGPointMake(27.09, 22.18) controlPoint1:CGPointMake(26.66, 22.22) controlPoint2:CGPointMake(26.85, 22.18)];
        [bezier12Path addCurveToPoint:CGPointMake(27.4, 22.21) controlPoint1:CGPointMake(27.2, 22.18) controlPoint2:CGPointMake(27.3, 22.19)];
        [bezier12Path addCurveToPoint:CGPointMake(27.63, 22.31) controlPoint1:CGPointMake(27.49, 22.23) controlPoint2:CGPointMake(27.57, 22.27)];
        [bezier12Path addCurveToPoint:CGPointMake(27.78, 22.48) controlPoint1:CGPointMake(27.69, 22.35) controlPoint2:CGPointMake(27.74, 22.41)];
        [bezier12Path addCurveToPoint:CGPointMake(27.84, 22.71) controlPoint1:CGPointMake(27.82, 22.55) controlPoint2:CGPointMake(27.84, 22.62)];
        [bezier12Path addLineToPoint:CGPointMake(27.84, 23.65)];
        [bezier12Path addLineToPoint:CGPointMake(27.83, 23.65)];
        [bezier12Path closePath];
        [bezier12Path moveToPoint:CGPointMake(27.43, 22.72)];
        [bezier12Path addCurveToPoint:CGPointMake(27.34, 22.55) controlPoint1:CGPointMake(27.43, 22.65) controlPoint2:CGPointMake(27.4, 22.59)];
        [bezier12Path addCurveToPoint:CGPointMake(27.07, 22.49) controlPoint1:CGPointMake(27.28, 22.51) controlPoint2:CGPointMake(27.19, 22.49)];
        [bezier12Path addCurveToPoint:CGPointMake(26.8, 22.55) controlPoint1:CGPointMake(26.95, 22.49) controlPoint2:CGPointMake(26.86, 22.51)];
        [bezier12Path addCurveToPoint:CGPointMake(26.71, 22.7) controlPoint1:CGPointMake(26.74, 22.59) controlPoint2:CGPointMake(26.71, 22.64)];
        [bezier12Path addLineToPoint:CGPointMake(26.71, 23.65)];
        [bezier12Path addCurveToPoint:CGPointMake(26.8, 23.82) controlPoint1:CGPointMake(26.71, 23.73) controlPoint2:CGPointMake(26.74, 23.78)];
        [bezier12Path addCurveToPoint:CGPointMake(27.06, 23.87) controlPoint1:CGPointMake(26.86, 23.85) controlPoint2:CGPointMake(26.95, 23.87)];
        [bezier12Path addCurveToPoint:CGPointMake(27.33, 23.82) controlPoint1:CGPointMake(27.17, 23.87) controlPoint2:CGPointMake(27.27, 23.85)];
        [bezier12Path addCurveToPoint:CGPointMake(27.43, 23.65) controlPoint1:CGPointMake(27.4, 23.79) controlPoint2:CGPointMake(27.43, 23.73)];
        [bezier12Path addLineToPoint:CGPointMake(27.43, 22.72)];
        [bezier12Path closePath];
        bezier12Path.miterLimit = 4;

        [fillColor setFill];
        [bezier12Path fill];

        //// Bezier 13 Drawing
        UIBezierPath *bezier13Path = [UIBezierPath bezierPath];
        [bezier13Path moveToPoint:CGPointMake(29.85, 23.04)];
        [bezier13Path addCurveToPoint:CGPointMake(29.99, 23.08) controlPoint1:CGPointMake(29.9, 23.04) controlPoint2:CGPointMake(29.95, 23.05)];
        [bezier13Path addCurveToPoint:CGPointMake(30.05, 23.2) controlPoint1:CGPointMake(30.03, 23.1) controlPoint2:CGPointMake(30.05, 23.14)];
        [bezier13Path addCurveToPoint:CGPointMake(30, 23.33) controlPoint1:CGPointMake(30.05, 23.26) controlPoint2:CGPointMake(30.03, 23.3)];
        [bezier13Path addCurveToPoint:CGPointMake(29.87, 23.37) controlPoint1:CGPointMake(29.96, 23.36) controlPoint2:CGPointMake(29.92, 23.37)];
        [bezier13Path addLineToPoint:CGPointMake(29.8, 23.37)];
        [bezier13Path addLineToPoint:CGPointMake(29.8, 24.04)];
        [bezier13Path addCurveToPoint:CGPointMake(29.79, 24.09) controlPoint1:CGPointMake(29.8, 24.06) controlPoint2:CGPointMake(29.79, 24.08)];
        [bezier13Path addCurveToPoint:CGPointMake(29.75, 24.14) controlPoint1:CGPointMake(29.78, 24.11) controlPoint2:CGPointMake(29.77, 24.13)];
        [bezier13Path addCurveToPoint:CGPointMake(29.69, 24.18) controlPoint1:CGPointMake(29.73, 24.16) controlPoint2:CGPointMake(29.71, 24.17)];
        [bezier13Path addCurveToPoint:CGPointMake(29.6, 24.2) controlPoint1:CGPointMake(29.67, 24.19) controlPoint2:CGPointMake(29.63, 24.2)];
        [bezier13Path addCurveToPoint:CGPointMake(29.51, 24.18) controlPoint1:CGPointMake(29.56, 24.2) controlPoint2:CGPointMake(29.53, 24.2)];
        [bezier13Path addCurveToPoint:CGPointMake(29.45, 24.14) controlPoint1:CGPointMake(29.48, 24.17) controlPoint2:CGPointMake(29.47, 24.16)];
        [bezier13Path addCurveToPoint:CGPointMake(29.42, 24.09) controlPoint1:CGPointMake(29.43, 24.12) controlPoint2:CGPointMake(29.42, 24.11)];
        [bezier13Path addCurveToPoint:CGPointMake(29.41, 24.04) controlPoint1:CGPointMake(29.41, 24.07) controlPoint2:CGPointMake(29.41, 24.05)];
        [bezier13Path addLineToPoint:CGPointMake(29.41, 23.37)];
        [bezier13Path addLineToPoint:CGPointMake(28.64, 23.37)];
        [bezier13Path addCurveToPoint:CGPointMake(28.55, 23.35) controlPoint1:CGPointMake(28.59, 23.37) controlPoint2:CGPointMake(28.56, 23.36)];
        [bezier13Path addCurveToPoint:CGPointMake(28.53, 23.27) controlPoint1:CGPointMake(28.54, 23.33) controlPoint2:CGPointMake(28.53, 23.31)];
        [bezier13Path addLineToPoint:CGPointMake(28.53, 22.36)];
        [bezier13Path addCurveToPoint:CGPointMake(28.54, 22.3) controlPoint1:CGPointMake(28.53, 22.34) controlPoint2:CGPointMake(28.53, 22.32)];
        [bezier13Path addCurveToPoint:CGPointMake(28.57, 22.24) controlPoint1:CGPointMake(28.55, 22.28) controlPoint2:CGPointMake(28.56, 22.26)];
        [bezier13Path addCurveToPoint:CGPointMake(28.63, 22.2) controlPoint1:CGPointMake(28.58, 22.22) controlPoint2:CGPointMake(28.61, 22.21)];
        [bezier13Path addCurveToPoint:CGPointMake(28.72, 22.18) controlPoint1:CGPointMake(28.65, 22.19) controlPoint2:CGPointMake(28.68, 22.18)];
        [bezier13Path addCurveToPoint:CGPointMake(28.87, 22.23) controlPoint1:CGPointMake(28.79, 22.18) controlPoint2:CGPointMake(28.84, 22.2)];
        [bezier13Path addCurveToPoint:CGPointMake(28.92, 22.36) controlPoint1:CGPointMake(28.9, 22.26) controlPoint2:CGPointMake(28.92, 22.31)];
        [bezier13Path addLineToPoint:CGPointMake(28.92, 23.06)];
        [bezier13Path addLineToPoint:CGPointMake(29.41, 23.06)];
        [bezier13Path addLineToPoint:CGPointMake(29.41, 22.36)];
        [bezier13Path addCurveToPoint:CGPointMake(29.46, 22.24) controlPoint1:CGPointMake(29.41, 22.31) controlPoint2:CGPointMake(29.43, 22.27)];
        [bezier13Path addCurveToPoint:CGPointMake(29.61, 22.19) controlPoint1:CGPointMake(29.49, 22.21) controlPoint2:CGPointMake(29.54, 22.19)];
        [bezier13Path addCurveToPoint:CGPointMake(29.76, 22.24) controlPoint1:CGPointMake(29.67, 22.19) controlPoint2:CGPointMake(29.72, 22.21)];
        [bezier13Path addCurveToPoint:CGPointMake(29.81, 22.36) controlPoint1:CGPointMake(29.79, 22.27) controlPoint2:CGPointMake(29.81, 22.31)];
        [bezier13Path addLineToPoint:CGPointMake(29.81, 23.06)];
        [bezier13Path addLineToPoint:CGPointMake(29.85, 23.04)];
        [bezier13Path addLineToPoint:CGPointMake(29.85, 23.04)];
        [bezier13Path closePath];
        bezier13Path.miterLimit = 4;

        [fillColor setFill];
        [bezier13Path fill];

        //// Bezier 14 Drawing
        UIBezierPath *bezier14Path = [UIBezierPath bezierPath];
        [bezier14Path moveToPoint:CGPointMake(32.04, 23.04)];
        [bezier14Path addCurveToPoint:CGPointMake(32.17, 23.08) controlPoint1:CGPointMake(32.09, 23.04) controlPoint2:CGPointMake(32.14, 23.05)];
        [bezier14Path addCurveToPoint:CGPointMake(32.23, 23.2) controlPoint1:CGPointMake(32.21, 23.1) controlPoint2:CGPointMake(32.23, 23.14)];
        [bezier14Path addCurveToPoint:CGPointMake(32.17, 23.33) controlPoint1:CGPointMake(32.23, 23.26) controlPoint2:CGPointMake(32.21, 23.3)];
        [bezier14Path addCurveToPoint:CGPointMake(32.04, 23.37) controlPoint1:CGPointMake(32.13, 23.36) controlPoint2:CGPointMake(32.09, 23.37)];
        [bezier14Path addLineToPoint:CGPointMake(31.97, 23.37)];
        [bezier14Path addLineToPoint:CGPointMake(31.97, 24.04)];
        [bezier14Path addCurveToPoint:CGPointMake(31.96, 24.09) controlPoint1:CGPointMake(31.97, 24.06) controlPoint2:CGPointMake(31.96, 24.08)];
        [bezier14Path addCurveToPoint:CGPointMake(31.93, 24.14) controlPoint1:CGPointMake(31.95, 24.11) controlPoint2:CGPointMake(31.94, 24.13)];
        [bezier14Path addCurveToPoint:CGPointMake(31.87, 24.18) controlPoint1:CGPointMake(31.91, 24.16) controlPoint2:CGPointMake(31.89, 24.17)];
        [bezier14Path addCurveToPoint:CGPointMake(31.78, 24.2) controlPoint1:CGPointMake(31.85, 24.19) controlPoint2:CGPointMake(31.82, 24.2)];
        [bezier14Path addCurveToPoint:CGPointMake(31.69, 24.18) controlPoint1:CGPointMake(31.74, 24.2) controlPoint2:CGPointMake(31.71, 24.2)];
        [bezier14Path addCurveToPoint:CGPointMake(31.63, 24.14) controlPoint1:CGPointMake(31.67, 24.17) controlPoint2:CGPointMake(31.65, 24.16)];
        [bezier14Path addCurveToPoint:CGPointMake(31.6, 24.09) controlPoint1:CGPointMake(31.61, 24.12) controlPoint2:CGPointMake(31.6, 24.11)];
        [bezier14Path addCurveToPoint:CGPointMake(31.59, 24.04) controlPoint1:CGPointMake(31.59, 24.07) controlPoint2:CGPointMake(31.59, 24.05)];
        [bezier14Path addLineToPoint:CGPointMake(31.59, 23.37)];
        [bezier14Path addLineToPoint:CGPointMake(30.83, 23.37)];
        [bezier14Path addCurveToPoint:CGPointMake(30.74, 23.35) controlPoint1:CGPointMake(30.78, 23.37) controlPoint2:CGPointMake(30.75, 23.36)];
        [bezier14Path addCurveToPoint:CGPointMake(30.72, 23.27) controlPoint1:CGPointMake(30.72, 23.33) controlPoint2:CGPointMake(30.72, 23.31)];
        [bezier14Path addLineToPoint:CGPointMake(30.72, 22.36)];
        [bezier14Path addCurveToPoint:CGPointMake(30.73, 22.3) controlPoint1:CGPointMake(30.72, 22.34) controlPoint2:CGPointMake(30.72, 22.32)];
        [bezier14Path addCurveToPoint:CGPointMake(30.76, 22.24) controlPoint1:CGPointMake(30.74, 22.28) controlPoint2:CGPointMake(30.75, 22.26)];
        [bezier14Path addCurveToPoint:CGPointMake(30.82, 22.2) controlPoint1:CGPointMake(30.78, 22.22) controlPoint2:CGPointMake(30.79, 22.21)];
        [bezier14Path addCurveToPoint:CGPointMake(30.91, 22.18) controlPoint1:CGPointMake(30.85, 22.19) controlPoint2:CGPointMake(30.87, 22.18)];
        [bezier14Path addCurveToPoint:CGPointMake(31.06, 22.23) controlPoint1:CGPointMake(30.97, 22.18) controlPoint2:CGPointMake(31.03, 22.2)];
        [bezier14Path addCurveToPoint:CGPointMake(31.11, 22.36) controlPoint1:CGPointMake(31.1, 22.26) controlPoint2:CGPointMake(31.11, 22.31)];
        [bezier14Path addLineToPoint:CGPointMake(31.11, 23.06)];
        [bezier14Path addLineToPoint:CGPointMake(31.6, 23.06)];
        [bezier14Path addLineToPoint:CGPointMake(31.6, 22.36)];
        [bezier14Path addCurveToPoint:CGPointMake(31.65, 22.24) controlPoint1:CGPointMake(31.6, 22.31) controlPoint2:CGPointMake(31.62, 22.27)];
        [bezier14Path addCurveToPoint:CGPointMake(31.8, 22.19) controlPoint1:CGPointMake(31.68, 22.21) controlPoint2:CGPointMake(31.73, 22.19)];
        [bezier14Path addCurveToPoint:CGPointMake(31.95, 22.24) controlPoint1:CGPointMake(31.86, 22.19) controlPoint2:CGPointMake(31.91, 22.21)];
        [bezier14Path addCurveToPoint:CGPointMake(32, 22.36) controlPoint1:CGPointMake(31.98, 22.27) controlPoint2:CGPointMake(32, 22.31)];
        [bezier14Path addLineToPoint:CGPointMake(32, 23.06)];
        [bezier14Path addLineToPoint:CGPointMake(32.04, 23.04)];
        [bezier14Path addLineToPoint:CGPointMake(32.04, 23.04)];
        [bezier14Path closePath];
        bezier14Path.miterLimit = 4;

        [fillColor setFill];
        [bezier14Path fill];

        //// Bezier 15 Drawing
        UIBezierPath *bezier15Path = [UIBezierPath bezierPath];
        [bezier15Path moveToPoint:CGPointMake(35.08, 22.96)];
        [bezier15Path addCurveToPoint:CGPointMake(35.4, 23) controlPoint1:CGPointMake(35.21, 22.96) controlPoint2:CGPointMake(35.32, 22.97)];
        [bezier15Path addCurveToPoint:CGPointMake(35.61, 23.12) controlPoint1:CGPointMake(35.49, 23.03) controlPoint2:CGPointMake(35.56, 23.07)];
        [bezier15Path addCurveToPoint:CGPointMake(35.72, 23.32) controlPoint1:CGPointMake(35.66, 23.17) controlPoint2:CGPointMake(35.7, 23.24)];
        [bezier15Path addCurveToPoint:CGPointMake(35.76, 23.59) controlPoint1:CGPointMake(35.74, 23.4) controlPoint2:CGPointMake(35.76, 23.49)];
        [bezier15Path addCurveToPoint:CGPointMake(35.72, 23.85) controlPoint1:CGPointMake(35.76, 23.69) controlPoint2:CGPointMake(35.74, 23.78)];
        [bezier15Path addCurveToPoint:CGPointMake(35.59, 24.04) controlPoint1:CGPointMake(35.69, 23.93) controlPoint2:CGPointMake(35.65, 23.99)];
        [bezier15Path addCurveToPoint:CGPointMake(35.36, 24.16) controlPoint1:CGPointMake(35.53, 24.09) controlPoint2:CGPointMake(35.45, 24.13)];
        [bezier15Path addCurveToPoint:CGPointMake(35, 24.2) controlPoint1:CGPointMake(35.26, 24.19) controlPoint2:CGPointMake(35.14, 24.2)];
        [bezier15Path addCurveToPoint:CGPointMake(34.71, 24.17) controlPoint1:CGPointMake(34.9, 24.2) controlPoint2:CGPointMake(34.79, 24.19)];
        [bezier15Path addCurveToPoint:CGPointMake(34.47, 24.07) controlPoint1:CGPointMake(34.62, 24.15) controlPoint2:CGPointMake(34.54, 24.12)];
        [bezier15Path addCurveToPoint:CGPointMake(34.32, 23.9) controlPoint1:CGPointMake(34.4, 24.03) controlPoint2:CGPointMake(34.35, 23.97)];
        [bezier15Path addCurveToPoint:CGPointMake(34.27, 23.64) controlPoint1:CGPointMake(34.29, 23.83) controlPoint2:CGPointMake(34.27, 23.74)];
        [bezier15Path addLineToPoint:CGPointMake(34.27, 22.34)];
        [bezier15Path addCurveToPoint:CGPointMake(34.28, 22.28) controlPoint1:CGPointMake(34.27, 22.32) controlPoint2:CGPointMake(34.27, 22.3)];
        [bezier15Path addCurveToPoint:CGPointMake(34.32, 22.23) controlPoint1:CGPointMake(34.29, 22.26) controlPoint2:CGPointMake(34.3, 22.24)];
        [bezier15Path addCurveToPoint:CGPointMake(34.38, 22.19) controlPoint1:CGPointMake(34.34, 22.21) controlPoint2:CGPointMake(34.35, 22.2)];
        [bezier15Path addCurveToPoint:CGPointMake(34.47, 22.17) controlPoint1:CGPointMake(34.4, 22.18) controlPoint2:CGPointMake(34.44, 22.17)];
        [bezier15Path addCurveToPoint:CGPointMake(34.62, 22.22) controlPoint1:CGPointMake(34.53, 22.17) controlPoint2:CGPointMake(34.59, 22.19)];
        [bezier15Path addCurveToPoint:CGPointMake(34.67, 22.34) controlPoint1:CGPointMake(34.65, 22.25) controlPoint2:CGPointMake(34.67, 22.29)];
        [bezier15Path addLineToPoint:CGPointMake(34.67, 22.99)];
        [bezier15Path addCurveToPoint:CGPointMake(34.92, 22.97) controlPoint1:CGPointMake(34.76, 22.98) controlPoint2:CGPointMake(34.85, 22.97)];
        [bezier15Path addCurveToPoint:CGPointMake(35.08, 22.96) controlPoint1:CGPointMake(34.97, 22.96) controlPoint2:CGPointMake(35.03, 22.96)];
        [bezier15Path closePath];
        [bezier15Path moveToPoint:CGPointMake(35.37, 23.57)];
        [bezier15Path addCurveToPoint:CGPointMake(35.35, 23.42) controlPoint1:CGPointMake(35.37, 23.51) controlPoint2:CGPointMake(35.36, 23.46)];
        [bezier15Path addCurveToPoint:CGPointMake(35.29, 23.33) controlPoint1:CGPointMake(35.34, 23.38) controlPoint2:CGPointMake(35.32, 23.35)];
        [bezier15Path addCurveToPoint:CGPointMake(35.18, 23.29) controlPoint1:CGPointMake(35.26, 23.31) controlPoint2:CGPointMake(35.22, 23.29)];
        [bezier15Path addCurveToPoint:CGPointMake(35, 23.28) controlPoint1:CGPointMake(35.13, 23.28) controlPoint2:CGPointMake(35.07, 23.28)];
        [bezier15Path addCurveToPoint:CGPointMake(34.86, 23.28) controlPoint1:CGPointMake(34.94, 23.28) controlPoint2:CGPointMake(34.9, 23.28)];
        [bezier15Path addCurveToPoint:CGPointMake(34.77, 23.28) controlPoint1:CGPointMake(34.82, 23.28) controlPoint2:CGPointMake(34.79, 23.28)];
        [bezier15Path addCurveToPoint:CGPointMake(34.7, 23.29) controlPoint1:CGPointMake(34.75, 23.28) controlPoint2:CGPointMake(34.72, 23.28)];
        [bezier15Path addCurveToPoint:CGPointMake(34.63, 23.3) controlPoint1:CGPointMake(34.68, 23.29) controlPoint2:CGPointMake(34.66, 23.3)];
        [bezier15Path addLineToPoint:CGPointMake(34.63, 23.56)];
        [bezier15Path addCurveToPoint:CGPointMake(34.65, 23.7) controlPoint1:CGPointMake(34.63, 23.61) controlPoint2:CGPointMake(34.64, 23.66)];
        [bezier15Path addCurveToPoint:CGPointMake(34.71, 23.8) controlPoint1:CGPointMake(34.66, 23.74) controlPoint2:CGPointMake(34.68, 23.77)];
        [bezier15Path addCurveToPoint:CGPointMake(34.82, 23.86) controlPoint1:CGPointMake(34.74, 23.83) controlPoint2:CGPointMake(34.77, 23.85)];
        [bezier15Path addCurveToPoint:CGPointMake(34.99, 23.88) controlPoint1:CGPointMake(34.87, 23.87) controlPoint2:CGPointMake(34.92, 23.88)];
        [bezier15Path addCurveToPoint:CGPointMake(35.15, 23.87) controlPoint1:CGPointMake(35.05, 23.88) controlPoint2:CGPointMake(35.11, 23.88)];
        [bezier15Path addCurveToPoint:CGPointMake(35.26, 23.83) controlPoint1:CGPointMake(35.2, 23.86) controlPoint2:CGPointMake(35.23, 23.85)];
        [bezier15Path addCurveToPoint:CGPointMake(35.33, 23.74) controlPoint1:CGPointMake(35.29, 23.81) controlPoint2:CGPointMake(35.31, 23.78)];
        [bezier15Path addCurveToPoint:CGPointMake(35.37, 23.57) controlPoint1:CGPointMake(35.36, 23.69) controlPoint2:CGPointMake(35.37, 23.64)];
        [bezier15Path closePath];
        bezier15Path.miterLimit = 4;

        [fillColor setFill];
        [bezier15Path fill];

        //// Bezier 16 Drawing
        UIBezierPath *bezier16Path = [UIBezierPath bezierPath];
        [bezier16Path moveToPoint:CGPointMake(37.69, 23.04)];
        [bezier16Path addCurveToPoint:CGPointMake(37.83, 23.08) controlPoint1:CGPointMake(37.74, 23.04) controlPoint2:CGPointMake(37.79, 23.05)];
        [bezier16Path addCurveToPoint:CGPointMake(37.89, 23.2) controlPoint1:CGPointMake(37.87, 23.1) controlPoint2:CGPointMake(37.89, 23.14)];
        [bezier16Path addCurveToPoint:CGPointMake(37.84, 23.33) controlPoint1:CGPointMake(37.89, 23.26) controlPoint2:CGPointMake(37.87, 23.3)];
        [bezier16Path addCurveToPoint:CGPointMake(37.71, 23.37) controlPoint1:CGPointMake(37.8, 23.36) controlPoint2:CGPointMake(37.76, 23.37)];
        [bezier16Path addLineToPoint:CGPointMake(37.65, 23.37)];
        [bezier16Path addLineToPoint:CGPointMake(37.65, 24.04)];
        [bezier16Path addCurveToPoint:CGPointMake(37.64, 24.09) controlPoint1:CGPointMake(37.65, 24.06) controlPoint2:CGPointMake(37.64, 24.08)];
        [bezier16Path addCurveToPoint:CGPointMake(37.6, 24.14) controlPoint1:CGPointMake(37.63, 24.11) controlPoint2:CGPointMake(37.62, 24.13)];
        [bezier16Path addCurveToPoint:CGPointMake(37.54, 24.18) controlPoint1:CGPointMake(37.58, 24.16) controlPoint2:CGPointMake(37.56, 24.17)];
        [bezier16Path addCurveToPoint:CGPointMake(37.45, 24.2) controlPoint1:CGPointMake(37.52, 24.19) controlPoint2:CGPointMake(37.48, 24.2)];
        [bezier16Path addCurveToPoint:CGPointMake(37.36, 24.18) controlPoint1:CGPointMake(37.41, 24.2) controlPoint2:CGPointMake(37.38, 24.2)];
        [bezier16Path addCurveToPoint:CGPointMake(37.3, 24.14) controlPoint1:CGPointMake(37.34, 24.17) controlPoint2:CGPointMake(37.32, 24.16)];
        [bezier16Path addCurveToPoint:CGPointMake(37.27, 24.09) controlPoint1:CGPointMake(37.29, 24.12) controlPoint2:CGPointMake(37.28, 24.11)];
        [bezier16Path addCurveToPoint:CGPointMake(37.26, 24.04) controlPoint1:CGPointMake(37.26, 24.07) controlPoint2:CGPointMake(37.26, 24.05)];
        [bezier16Path addLineToPoint:CGPointMake(37.26, 23.37)];
        [bezier16Path addLineToPoint:CGPointMake(36.5, 23.37)];
        [bezier16Path addCurveToPoint:CGPointMake(36.41, 23.35) controlPoint1:CGPointMake(36.45, 23.37) controlPoint2:CGPointMake(36.42, 23.36)];
        [bezier16Path addCurveToPoint:CGPointMake(36.39, 23.27) controlPoint1:CGPointMake(36.39, 23.33) controlPoint2:CGPointMake(36.39, 23.31)];
        [bezier16Path addLineToPoint:CGPointMake(36.39, 22.36)];
        [bezier16Path addCurveToPoint:CGPointMake(36.4, 22.3) controlPoint1:CGPointMake(36.39, 22.34) controlPoint2:CGPointMake(36.4, 22.32)];
        [bezier16Path addCurveToPoint:CGPointMake(36.44, 22.24) controlPoint1:CGPointMake(36.41, 22.28) controlPoint2:CGPointMake(36.42, 22.26)];
        [bezier16Path addCurveToPoint:CGPointMake(36.5, 22.2) controlPoint1:CGPointMake(36.45, 22.22) controlPoint2:CGPointMake(36.47, 22.21)];
        [bezier16Path addCurveToPoint:CGPointMake(36.59, 22.18) controlPoint1:CGPointMake(36.53, 22.19) controlPoint2:CGPointMake(36.56, 22.18)];
        [bezier16Path addCurveToPoint:CGPointMake(36.74, 22.23) controlPoint1:CGPointMake(36.66, 22.18) controlPoint2:CGPointMake(36.71, 22.2)];
        [bezier16Path addCurveToPoint:CGPointMake(36.79, 22.36) controlPoint1:CGPointMake(36.77, 22.26) controlPoint2:CGPointMake(36.79, 22.31)];
        [bezier16Path addLineToPoint:CGPointMake(36.79, 23.06)];
        [bezier16Path addLineToPoint:CGPointMake(37.28, 23.06)];
        [bezier16Path addLineToPoint:CGPointMake(37.28, 22.36)];
        [bezier16Path addCurveToPoint:CGPointMake(37.33, 22.24) controlPoint1:CGPointMake(37.28, 22.31) controlPoint2:CGPointMake(37.29, 22.27)];
        [bezier16Path addCurveToPoint:CGPointMake(37.48, 22.19) controlPoint1:CGPointMake(37.36, 22.21) controlPoint2:CGPointMake(37.41, 22.19)];
        [bezier16Path addCurveToPoint:CGPointMake(37.63, 22.24) controlPoint1:CGPointMake(37.54, 22.19) controlPoint2:CGPointMake(37.59, 22.21)];
        [bezier16Path addCurveToPoint:CGPointMake(37.68, 22.36) controlPoint1:CGPointMake(37.66, 22.27) controlPoint2:CGPointMake(37.68, 22.31)];
        [bezier16Path addLineToPoint:CGPointMake(37.68, 23.06)];
        [bezier16Path addLineToPoint:CGPointMake(37.69, 23.04)];
        [bezier16Path addLineToPoint:CGPointMake(37.69, 23.04)];
        [bezier16Path closePath];
        bezier16Path.miterLimit = 4;

        [fillColor setFill];
        [bezier16Path fill];

        //// Bezier 17 Drawing
        UIBezierPath *bezier17Path = [UIBezierPath bezierPath];
        [bezier17Path moveToPoint:CGPointMake(40.05, 23.65)];
        [bezier17Path addLineToPoint:CGPointMake(40.05, 23.65)];
        [bezier17Path addCurveToPoint:CGPointMake(40, 23.91) controlPoint1:CGPointMake(40.05, 23.75) controlPoint2:CGPointMake(40.04, 23.84)];
        [bezier17Path addCurveToPoint:CGPointMake(39.84, 24.08) controlPoint1:CGPointMake(39.96, 23.98) controlPoint2:CGPointMake(39.91, 24.04)];
        [bezier17Path addCurveToPoint:CGPointMake(39.6, 24.17) controlPoint1:CGPointMake(39.77, 24.12) controlPoint2:CGPointMake(39.69, 24.15)];
        [bezier17Path addCurveToPoint:CGPointMake(39.29, 24.2) controlPoint1:CGPointMake(39.51, 24.19) controlPoint2:CGPointMake(39.4, 24.2)];
        [bezier17Path addCurveToPoint:CGPointMake(38.98, 24.17) controlPoint1:CGPointMake(39.18, 24.2) controlPoint2:CGPointMake(39.07, 24.19)];
        [bezier17Path addCurveToPoint:CGPointMake(38.74, 24.08) controlPoint1:CGPointMake(38.88, 24.15) controlPoint2:CGPointMake(38.81, 24.12)];
        [bezier17Path addCurveToPoint:CGPointMake(38.59, 23.91) controlPoint1:CGPointMake(38.68, 24.04) controlPoint2:CGPointMake(38.63, 23.98)];
        [bezier17Path addCurveToPoint:CGPointMake(38.54, 23.67) controlPoint1:CGPointMake(38.56, 23.84) controlPoint2:CGPointMake(38.54, 23.76)];
        [bezier17Path addLineToPoint:CGPointMake(38.54, 22.7)];
        [bezier17Path addCurveToPoint:CGPointMake(38.74, 22.31) controlPoint1:CGPointMake(38.54, 22.53) controlPoint2:CGPointMake(38.6, 22.4)];
        [bezier17Path addCurveToPoint:CGPointMake(39.3, 22.18) controlPoint1:CGPointMake(38.87, 22.22) controlPoint2:CGPointMake(39.06, 22.18)];
        [bezier17Path addCurveToPoint:CGPointMake(39.61, 22.21) controlPoint1:CGPointMake(39.41, 22.18) controlPoint2:CGPointMake(39.51, 22.19)];
        [bezier17Path addCurveToPoint:CGPointMake(39.84, 22.31) controlPoint1:CGPointMake(39.7, 22.23) controlPoint2:CGPointMake(39.78, 22.27)];
        [bezier17Path addCurveToPoint:CGPointMake(39.99, 22.48) controlPoint1:CGPointMake(39.9, 22.35) controlPoint2:CGPointMake(39.95, 22.41)];
        [bezier17Path addCurveToPoint:CGPointMake(40.04, 22.71) controlPoint1:CGPointMake(40.03, 22.55) controlPoint2:CGPointMake(40.04, 22.62)];
        [bezier17Path addLineToPoint:CGPointMake(40.04, 23.65)];
        [bezier17Path addLineToPoint:CGPointMake(40.05, 23.65)];
        [bezier17Path closePath];
        [bezier17Path moveToPoint:CGPointMake(39.66, 22.72)];
        [bezier17Path addCurveToPoint:CGPointMake(39.57, 22.55) controlPoint1:CGPointMake(39.66, 22.65) controlPoint2:CGPointMake(39.63, 22.59)];
        [bezier17Path addCurveToPoint:CGPointMake(39.3, 22.49) controlPoint1:CGPointMake(39.51, 22.51) controlPoint2:CGPointMake(39.42, 22.49)];
        [bezier17Path addCurveToPoint:CGPointMake(39.03, 22.55) controlPoint1:CGPointMake(39.18, 22.49) controlPoint2:CGPointMake(39.09, 22.51)];
        [bezier17Path addCurveToPoint:CGPointMake(38.94, 22.7) controlPoint1:CGPointMake(38.97, 22.59) controlPoint2:CGPointMake(38.94, 22.64)];
        [bezier17Path addLineToPoint:CGPointMake(38.94, 23.65)];
        [bezier17Path addCurveToPoint:CGPointMake(39.03, 23.82) controlPoint1:CGPointMake(38.94, 23.73) controlPoint2:CGPointMake(38.97, 23.78)];
        [bezier17Path addCurveToPoint:CGPointMake(39.29, 23.87) controlPoint1:CGPointMake(39.09, 23.85) controlPoint2:CGPointMake(39.17, 23.87)];
        [bezier17Path addCurveToPoint:CGPointMake(39.56, 23.82) controlPoint1:CGPointMake(39.4, 23.87) controlPoint2:CGPointMake(39.5, 23.85)];
        [bezier17Path addCurveToPoint:CGPointMake(39.66, 23.65) controlPoint1:CGPointMake(39.62, 23.79) controlPoint2:CGPointMake(39.66, 23.73)];
        [bezier17Path addLineToPoint:CGPointMake(39.66, 22.72)];
        [bezier17Path closePath];
        bezier17Path.miterLimit = 4;

        [fillColor setFill];
        [bezier17Path fill];

        //// Bezier 18 Drawing
        UIBezierPath *bezier18Path = [UIBezierPath bezierPath];
        [bezier18Path moveToPoint:CGPointMake(42.2, 23.59)];
        [bezier18Path addCurveToPoint:CGPointMake(42.16, 23.88) controlPoint1:CGPointMake(42.2, 23.71) controlPoint2:CGPointMake(42.19, 23.8)];
        [bezier18Path addCurveToPoint:CGPointMake(42.03, 24.07) controlPoint1:CGPointMake(42.14, 23.96) controlPoint2:CGPointMake(42.09, 24.02)];
        [bezier18Path addCurveToPoint:CGPointMake(41.78, 24.17) controlPoint1:CGPointMake(41.97, 24.12) controlPoint2:CGPointMake(41.89, 24.15)];
        [bezier18Path addCurveToPoint:CGPointMake(41.38, 24.2) controlPoint1:CGPointMake(41.68, 24.19) controlPoint2:CGPointMake(41.54, 24.2)];
        [bezier18Path addLineToPoint:CGPointMake(41.36, 24.2)];
        [bezier18Path addCurveToPoint:CGPointMake(41.23, 24.2) controlPoint1:CGPointMake(41.32, 24.2) controlPoint2:CGPointMake(41.28, 24.2)];
        [bezier18Path addCurveToPoint:CGPointMake(41.08, 24.19) controlPoint1:CGPointMake(41.18, 24.2) controlPoint2:CGPointMake(41.13, 24.2)];
        [bezier18Path addCurveToPoint:CGPointMake(40.93, 24.16) controlPoint1:CGPointMake(41.03, 24.18) controlPoint2:CGPointMake(40.98, 24.18)];
        [bezier18Path addCurveToPoint:CGPointMake(40.8, 24.11) controlPoint1:CGPointMake(40.88, 24.15) controlPoint2:CGPointMake(40.84, 24.13)];
        [bezier18Path addCurveToPoint:CGPointMake(40.71, 24.03) controlPoint1:CGPointMake(40.76, 24.09) controlPoint2:CGPointMake(40.73, 24.06)];
        [bezier18Path addCurveToPoint:CGPointMake(40.67, 23.92) controlPoint1:CGPointMake(40.69, 24) controlPoint2:CGPointMake(40.67, 23.96)];
        [bezier18Path addLineToPoint:CGPointMake(40.67, 23.91)];
        [bezier18Path addCurveToPoint:CGPointMake(40.73, 23.79) controlPoint1:CGPointMake(40.67, 23.86) controlPoint2:CGPointMake(40.69, 23.82)];
        [bezier18Path addCurveToPoint:CGPointMake(40.85, 23.75) controlPoint1:CGPointMake(40.77, 23.76) controlPoint2:CGPointMake(40.8, 23.75)];
        [bezier18Path addLineToPoint:CGPointMake(40.86, 23.75)];
        [bezier18Path addCurveToPoint:CGPointMake(40.92, 23.75) controlPoint1:CGPointMake(40.89, 23.75) controlPoint2:CGPointMake(40.91, 23.75)];
        [bezier18Path addCurveToPoint:CGPointMake(40.96, 23.76) controlPoint1:CGPointMake(40.94, 23.76) controlPoint2:CGPointMake(40.95, 23.76)];
        [bezier18Path addCurveToPoint:CGPointMake(40.99, 23.78) controlPoint1:CGPointMake(40.97, 23.77) controlPoint2:CGPointMake(40.98, 23.77)];
        [bezier18Path addCurveToPoint:CGPointMake(41.02, 23.8) controlPoint1:CGPointMake(41, 23.79) controlPoint2:CGPointMake(41.01, 23.79)];
        [bezier18Path addLineToPoint:CGPointMake(41.02, 23.8)];
        [bezier18Path addCurveToPoint:CGPointMake(41.07, 23.83) controlPoint1:CGPointMake(41.03, 23.81) controlPoint2:CGPointMake(41.05, 23.82)];
        [bezier18Path addCurveToPoint:CGPointMake(41.13, 23.85) controlPoint1:CGPointMake(41.08, 23.84) controlPoint2:CGPointMake(41.11, 23.84)];
        [bezier18Path addCurveToPoint:CGPointMake(41.23, 23.86) controlPoint1:CGPointMake(41.16, 23.86) controlPoint2:CGPointMake(41.19, 23.86)];
        [bezier18Path addCurveToPoint:CGPointMake(41.4, 23.87) controlPoint1:CGPointMake(41.27, 23.86) controlPoint2:CGPointMake(41.33, 23.87)];
        [bezier18Path addLineToPoint:CGPointMake(41.42, 23.87)];
        [bezier18Path addCurveToPoint:CGPointMake(41.61, 23.85) controlPoint1:CGPointMake(41.5, 23.87) controlPoint2:CGPointMake(41.56, 23.86)];
        [bezier18Path addCurveToPoint:CGPointMake(41.73, 23.8) controlPoint1:CGPointMake(41.66, 23.84) controlPoint2:CGPointMake(41.7, 23.82)];
        [bezier18Path addCurveToPoint:CGPointMake(41.79, 23.71) controlPoint1:CGPointMake(41.76, 23.78) controlPoint2:CGPointMake(41.78, 23.74)];
        [bezier18Path addCurveToPoint:CGPointMake(41.8, 23.58) controlPoint1:CGPointMake(41.8, 23.67) controlPoint2:CGPointMake(41.8, 23.63)];
        [bezier18Path addCurveToPoint:CGPointMake(41.77, 23.39) controlPoint1:CGPointMake(41.8, 23.49) controlPoint2:CGPointMake(41.79, 23.42)];
        [bezier18Path addCurveToPoint:CGPointMake(41.64, 23.33) controlPoint1:CGPointMake(41.75, 23.35) controlPoint2:CGPointMake(41.7, 23.33)];
        [bezier18Path addLineToPoint:CGPointMake(41.22, 23.33)];
        [bezier18Path addCurveToPoint:CGPointMake(41.15, 23.32) controlPoint1:CGPointMake(41.19, 23.33) controlPoint2:CGPointMake(41.17, 23.33)];
        [bezier18Path addCurveToPoint:CGPointMake(41.09, 23.3) controlPoint1:CGPointMake(41.13, 23.32) controlPoint2:CGPointMake(41.11, 23.31)];
        [bezier18Path addCurveToPoint:CGPointMake(41.04, 23.25) controlPoint1:CGPointMake(41.07, 23.29) controlPoint2:CGPointMake(41.06, 23.27)];
        [bezier18Path addCurveToPoint:CGPointMake(41.03, 23.17) controlPoint1:CGPointMake(41.03, 23.23) controlPoint2:CGPointMake(41.03, 23.2)];
        [bezier18Path addCurveToPoint:CGPointMake(41.09, 23.04) controlPoint1:CGPointMake(41.03, 23.11) controlPoint2:CGPointMake(41.05, 23.07)];
        [bezier18Path addCurveToPoint:CGPointMake(41.22, 23) controlPoint1:CGPointMake(41.13, 23.02) controlPoint2:CGPointMake(41.17, 23)];
        [bezier18Path addLineToPoint:CGPointMake(41.62, 23)];
        [bezier18Path addCurveToPoint:CGPointMake(41.7, 22.99) controlPoint1:CGPointMake(41.65, 23) controlPoint2:CGPointMake(41.68, 23)];
        [bezier18Path addCurveToPoint:CGPointMake(41.76, 22.95) controlPoint1:CGPointMake(41.72, 22.98) controlPoint2:CGPointMake(41.74, 22.97)];
        [bezier18Path addCurveToPoint:CGPointMake(41.8, 22.88) controlPoint1:CGPointMake(41.77, 22.93) controlPoint2:CGPointMake(41.79, 22.91)];
        [bezier18Path addCurveToPoint:CGPointMake(41.81, 22.76) controlPoint1:CGPointMake(41.81, 22.85) controlPoint2:CGPointMake(41.81, 22.81)];
        [bezier18Path addCurveToPoint:CGPointMake(41.8, 22.63) controlPoint1:CGPointMake(41.81, 22.71) controlPoint2:CGPointMake(41.81, 22.66)];
        [bezier18Path addCurveToPoint:CGPointMake(41.75, 22.54) controlPoint1:CGPointMake(41.79, 22.59) controlPoint2:CGPointMake(41.78, 22.56)];
        [bezier18Path addCurveToPoint:CGPointMake(41.64, 22.49) controlPoint1:CGPointMake(41.73, 22.52) controlPoint2:CGPointMake(41.69, 22.5)];
        [bezier18Path addCurveToPoint:CGPointMake(41.44, 22.48) controlPoint1:CGPointMake(41.59, 22.48) controlPoint2:CGPointMake(41.52, 22.48)];
        [bezier18Path addLineToPoint:CGPointMake(41.42, 22.48)];
        [bezier18Path addCurveToPoint:CGPointMake(41.25, 22.49) controlPoint1:CGPointMake(41.37, 22.48) controlPoint2:CGPointMake(41.31, 22.48)];
        [bezier18Path addCurveToPoint:CGPointMake(41.11, 22.53) controlPoint1:CGPointMake(41.19, 22.5) controlPoint2:CGPointMake(41.14, 22.51)];
        [bezier18Path addCurveToPoint:CGPointMake(41.07, 22.55) controlPoint1:CGPointMake(41.09, 22.54) controlPoint2:CGPointMake(41.08, 22.55)];
        [bezier18Path addCurveToPoint:CGPointMake(41.03, 22.57) controlPoint1:CGPointMake(41.05, 22.56) controlPoint2:CGPointMake(41.04, 22.57)];
        [bezier18Path addCurveToPoint:CGPointMake(40.99, 22.58) controlPoint1:CGPointMake(41.01, 22.58) controlPoint2:CGPointMake(41, 22.58)];
        [bezier18Path addCurveToPoint:CGPointMake(40.93, 22.58) controlPoint1:CGPointMake(40.97, 22.58) controlPoint2:CGPointMake(40.95, 22.58)];
        [bezier18Path addLineToPoint:CGPointMake(40.92, 22.58)];
        [bezier18Path addCurveToPoint:CGPointMake(40.79, 22.53) controlPoint1:CGPointMake(40.87, 22.58) controlPoint2:CGPointMake(40.83, 22.56)];
        [bezier18Path addCurveToPoint:CGPointMake(40.74, 22.42) controlPoint1:CGPointMake(40.76, 22.5) controlPoint2:CGPointMake(40.74, 22.46)];
        [bezier18Path addLineToPoint:CGPointMake(40.74, 22.42)];
        [bezier18Path addCurveToPoint:CGPointMake(40.78, 22.3) controlPoint1:CGPointMake(40.74, 22.37) controlPoint2:CGPointMake(40.76, 22.33)];
        [bezier18Path addCurveToPoint:CGPointMake(40.9, 22.21) controlPoint1:CGPointMake(40.81, 22.26) controlPoint2:CGPointMake(40.85, 22.24)];
        [bezier18Path addCurveToPoint:CGPointMake(41.1, 22.15) controlPoint1:CGPointMake(40.96, 22.19) controlPoint2:CGPointMake(41.02, 22.17)];
        [bezier18Path addCurveToPoint:CGPointMake(41.4, 22.13) controlPoint1:CGPointMake(41.19, 22.14) controlPoint2:CGPointMake(41.29, 22.13)];
        [bezier18Path addCurveToPoint:CGPointMake(41.77, 22.15) controlPoint1:CGPointMake(41.54, 22.13) controlPoint2:CGPointMake(41.67, 22.14)];
        [bezier18Path addCurveToPoint:CGPointMake(42.02, 22.23) controlPoint1:CGPointMake(41.87, 22.17) controlPoint2:CGPointMake(41.95, 22.19)];
        [bezier18Path addCurveToPoint:CGPointMake(42.15, 22.4) controlPoint1:CGPointMake(42.08, 22.27) controlPoint2:CGPointMake(42.12, 22.33)];
        [bezier18Path addCurveToPoint:CGPointMake(42.19, 22.68) controlPoint1:CGPointMake(42.17, 22.47) controlPoint2:CGPointMake(42.19, 22.57)];
        [bezier18Path addCurveToPoint:CGPointMake(42.18, 22.84) controlPoint1:CGPointMake(42.19, 22.74) controlPoint2:CGPointMake(42.19, 22.79)];
        [bezier18Path addCurveToPoint:CGPointMake(42.16, 22.96) controlPoint1:CGPointMake(42.17, 22.88) controlPoint2:CGPointMake(42.17, 22.92)];
        [bezier18Path addCurveToPoint:CGPointMake(42.12, 23.05) controlPoint1:CGPointMake(42.15, 22.99) controlPoint2:CGPointMake(42.14, 23.02)];
        [bezier18Path addCurveToPoint:CGPointMake(42.07, 23.12) controlPoint1:CGPointMake(42.11, 23.08) controlPoint2:CGPointMake(42.09, 23.1)];
        [bezier18Path addCurveToPoint:CGPointMake(42.11, 23.17) controlPoint1:CGPointMake(42.09, 23.13) controlPoint2:CGPointMake(42.1, 23.15)];
        [bezier18Path addCurveToPoint:CGPointMake(42.15, 23.25) controlPoint1:CGPointMake(42.12, 23.19) controlPoint2:CGPointMake(42.14, 23.22)];
        [bezier18Path addCurveToPoint:CGPointMake(42.18, 23.37) controlPoint1:CGPointMake(42.16, 23.28) controlPoint2:CGPointMake(42.17, 23.32)];
        [bezier18Path addCurveToPoint:CGPointMake(42.2, 23.59) controlPoint1:CGPointMake(42.19, 23.46) controlPoint2:CGPointMake(42.2, 23.52)];
        [bezier18Path closePath];
        bezier18Path.miterLimit = 4;

        [fillColor setFill];
        [bezier18Path fill];
    }
}

//// Group 5
{
    //// Bezier 19 Drawing
    UIBezierPath *bezier19Path = [UIBezierPath bezierPath];
    [bezier19Path moveToPoint:CGPointMake(25.73, 12.12)];
    [bezier19Path addLineToPoint:CGPointMake(27.04, 3.98)];
    [bezier19Path addLineToPoint:CGPointMake(29.14, 3.98)];
    [bezier19Path addLineToPoint:CGPointMake(27.83, 12.12)];
    [bezier19Path addLineToPoint:CGPointMake(25.73, 12.12)];
    [bezier19Path closePath];
    bezier19Path.miterLimit = 4;

    [fillColor15 setFill];
    [bezier19Path fill];

    //// Group 6
    {
        //// Bezier 20 Drawing
        UIBezierPath *bezier20Path = [UIBezierPath bezierPath];
        [bezier20Path moveToPoint:CGPointMake(35.45, 4.19)];
        [bezier20Path addCurveToPoint:CGPointMake(33.57, 3.85) controlPoint1:CGPointMake(35.03, 4.03) controlPoint2:CGPointMake(34.38, 3.85)];
        [bezier20Path addCurveToPoint:CGPointMake(30.02, 6.53) controlPoint1:CGPointMake(31.5, 3.85) controlPoint2:CGPointMake(30.03, 4.95)];
        [bezier20Path addCurveToPoint:CGPointMake(31.85, 8.74) controlPoint1:CGPointMake(30, 7.7) controlPoint2:CGPointMake(31.05, 8.35)];
        [bezier20Path addCurveToPoint:CGPointMake(32.94, 9.75) controlPoint1:CGPointMake(32.67, 9.14) controlPoint2:CGPointMake(32.94, 9.39)];
        [bezier20Path addCurveToPoint:CGPointMake(31.68, 10.54) controlPoint1:CGPointMake(32.94, 10.3) controlPoint2:CGPointMake(32.28, 10.54)];
        [bezier20Path addCurveToPoint:CGPointMake(29.7, 10.12) controlPoint1:CGPointMake(30.84, 10.54) controlPoint2:CGPointMake(30.39, 10.42)];
        [bezier20Path addLineToPoint:CGPointMake(29.43, 9.99)];
        [bezier20Path addLineToPoint:CGPointMake(29.14, 11.81)];
        [bezier20Path addCurveToPoint:CGPointMake(31.48, 12.24) controlPoint1:CGPointMake(29.63, 12.04) controlPoint2:CGPointMake(30.54, 12.24)];
        [bezier20Path addCurveToPoint:CGPointMake(35.14, 9.46) controlPoint1:CGPointMake(33.69, 12.24) controlPoint2:CGPointMake(35.12, 11.15)];
        [bezier20Path addCurveToPoint:CGPointMake(33.38, 7.25) controlPoint1:CGPointMake(35.15, 8.53) controlPoint2:CGPointMake(34.59, 7.83)];
        [bezier20Path addCurveToPoint:CGPointMake(32.2, 6.24) controlPoint1:CGPointMake(32.65, 6.87) controlPoint2:CGPointMake(32.19, 6.62)];
        [bezier20Path addCurveToPoint:CGPointMake(33.4, 5.54) controlPoint1:CGPointMake(32.2, 5.9) controlPoint2:CGPointMake(32.58, 5.54)];
        [bezier20Path addCurveToPoint:CGPointMake(34.98, 5.85) controlPoint1:CGPointMake(34.09, 5.53) controlPoint2:CGPointMake(34.59, 5.69)];
        [bezier20Path addLineToPoint:CGPointMake(35.17, 5.94)];
        [bezier20Path addLineToPoint:CGPointMake(35.45, 4.19)];
        [bezier20Path closePath];
        bezier20Path.miterLimit = 4;

        [fillColor15 setFill];
        [bezier20Path fill];

        //// Bezier 21 Drawing
        UIBezierPath *bezier21Path = [UIBezierPath bezierPath];
        [bezier21Path moveToPoint:CGPointMake(38.25, 9.24)];
        [bezier21Path addCurveToPoint:CGPointMake(39.09, 6.97) controlPoint1:CGPointMake(38.42, 8.77) controlPoint2:CGPointMake(39.09, 6.97)];
        [bezier21Path addCurveToPoint:CGPointMake(39.37, 6.19) controlPoint1:CGPointMake(39.07, 6.99) controlPoint2:CGPointMake(39.26, 6.5)];
        [bezier21Path addLineToPoint:CGPointMake(39.51, 6.89)];
        [bezier21Path addCurveToPoint:CGPointMake(40, 9.24) controlPoint1:CGPointMake(39.51, 6.89) controlPoint2:CGPointMake(39.91, 8.83)];
        [bezier21Path addLineToPoint:CGPointMake(38.25, 9.24)];
        [bezier21Path closePath];
        [bezier21Path moveToPoint:CGPointMake(40.83, 3.99)];
        [bezier21Path addLineToPoint:CGPointMake(39.2, 3.99)];
        [bezier21Path addCurveToPoint:CGPointMake(38.1, 4.66) controlPoint1:CGPointMake(38.7, 3.99) controlPoint2:CGPointMake(38.33, 4.14)];
        [bezier21Path addLineToPoint:CGPointMake(34.98, 12.12)];
        [bezier21Path addLineToPoint:CGPointMake(37.19, 12.12)];
        [bezier21Path addCurveToPoint:CGPointMake(37.63, 10.9) controlPoint1:CGPointMake(37.19, 12.12) controlPoint2:CGPointMake(37.55, 11.11)];
        [bezier21Path addCurveToPoint:CGPointMake(40.32, 10.91) controlPoint1:CGPointMake(37.87, 10.9) controlPoint2:CGPointMake(40.02, 10.91)];
        [bezier21Path addCurveToPoint:CGPointMake(40.57, 12.13) controlPoint1:CGPointMake(40.38, 11.19) controlPoint2:CGPointMake(40.57, 12.13)];
        [bezier21Path addLineToPoint:CGPointMake(42.52, 12.13)];
        [bezier21Path addLineToPoint:CGPointMake(40.83, 3.99)];
        [bezier21Path closePath];
        bezier21Path.miterLimit = 4;

        [fillColor15 setFill];
        [bezier21Path fill];

        //// Bezier 22 Drawing
        UIBezierPath *bezier22Path = [UIBezierPath bezierPath];
        [bezier22Path moveToPoint:CGPointMake(23.96, 3.99)];
        [bezier22Path addLineToPoint:CGPointMake(21.9, 9.54)];
        [bezier22Path addLineToPoint:CGPointMake(21.68, 8.41)];
        [bezier22Path addCurveToPoint:CGPointMake(18.78, 5) controlPoint1:CGPointMake(21.3, 7.11) controlPoint2:CGPointMake(20.11, 5.7)];
        [bezier22Path addLineToPoint:CGPointMake(20.66, 12.12)];
        [bezier22Path addLineToPoint:CGPointMake(22.88, 12.12)];
        [bezier22Path addLineToPoint:CGPointMake(26.19, 4)];
        [bezier22Path addLineToPoint:CGPointMake(23.96, 4)];
        [bezier22Path addLineToPoint:CGPointMake(23.96, 3.99)];
        [bezier22Path closePath];
        bezier22Path.miterLimit = 4;

        [fillColor15 setFill];
        [bezier22Path fill];

        //// Bezier 23 Drawing
        UIBezierPath *bezier23Path = [UIBezierPath bezierPath];
        [bezier23Path moveToPoint:CGPointMake(20, 3.99)];
        [bezier23Path addLineToPoint:CGPointMake(16.61, 3.99)];
        [bezier23Path addLineToPoint:CGPointMake(16.58, 4.16)];
        [bezier23Path addCurveToPoint:CGPointMake(21.69, 8.42) controlPoint1:CGPointMake(19.22, 4.83) controlPoint2:CGPointMake(20.96, 6.46)];
        [bezier23Path addLineToPoint:CGPointMake(20.96, 4.68)];
        [bezier23Path addCurveToPoint:CGPointMake(20, 3.99) controlPoint1:CGPointMake(20.83, 4.16) controlPoint2:CGPointMake(20.45, 4)];
        [bezier23Path closePath];
        bezier23Path.miterLimit = 4;

        [fillColor16 setFill];
        [bezier23Path fill];
    }
}
}
}

@end