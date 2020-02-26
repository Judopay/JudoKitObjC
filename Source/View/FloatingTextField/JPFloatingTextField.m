//
//  JPFloatingTextField.m
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

#import "JPFloatingTextField.h"
#import "UIFont+Additions.h"

@interface JPFloatingTextField ()
@property (nonatomic, strong) UILabel *floatingLabel;
@property (nonatomic, strong) NSLayoutConstraint *floatingLabelCenterYConstraint;
@end

@implementation JPFloatingTextField

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Methods

- (void)displayFloatingLabelWithText:(NSString *)text color:(UIColor *)color {
    self.floatingLabel.text = text;
    self.floatingLabel.textColor = color;
    [self transformToNewFontSize:14.0 frameOffset:-4 alphaValue:1.0 andConstraintConstant:-15.0];
}

- (void)hideFloatingLabel {
    [self transformToNewFontSize:16.0 frameOffset:3 alphaValue:0.0 andConstraintConstant:0.0];
}

#pragma mark - View layout

- (void)setupViews {
    [self addSubview:self.floatingLabel];
    NSArray *constraints = @[
        [self.floatingLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.floatingLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        self.floatingLabelCenterYConstraint,
    ];

    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - Internal logic

- (void)transformToNewFontSize:(CGFloat)fontSize
                   frameOffset:(CGFloat)frameOffset
                    alphaValue:(CGFloat)alphaValue
         andConstraintConstant:(CGFloat)constant {

    UIFont *oldFont = self.font;
    self.font = [UIFont systemFontOfSize:fontSize];
    CGFloat scale = oldFont.pointSize / self.font.pointSize;

    if (scale == 1) {
        return;
    }

    [self layoutIfNeeded];

    CGPoint oldOrigin = self.frame.origin;

    CGAffineTransform oldTransform = self.transform;
    self.transform = CGAffineTransformScale(self.transform, scale, scale);

    CGPoint newOrigin = self.frame.origin;
    self.frame = CGRectMake(oldOrigin.x, oldOrigin.y + frameOffset, self.frame.size.width, self.frame.size.height);

    self.floatingLabelCenterYConstraint.constant = constant;

    CGFloat yOffset = (scale > 1) ? 5.0 : -5.0;
    CGFloat yOrigin = newOrigin.y + yOffset;

    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(newOrigin.x, yOrigin, self.frame.size.width, self.frame.size.height);
                         self.transform = oldTransform;
                         self.floatingLabel.alpha = alphaValue;
                         [self layoutIfNeeded];
                     }];
}

#pragma mark - Lazy properties

- (UILabel *)floatingLabel {
    if (!_floatingLabel) {
        _floatingLabel = [UILabel new];
        _floatingLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _floatingLabel.font = UIFont.caption;
        _floatingLabel.alpha = 0.0f;
        _floatingLabel.textColor = [UIColor colorWithRed:226 / 255.0
                                                   green:25 / 255.0
                                                    blue:0 / 255.0
                                                   alpha:1.0];
    }
    return _floatingLabel;
}

- (NSLayoutConstraint *)floatingLabelCenterYConstraint {
    if (!_floatingLabelCenterYConstraint) {
        _floatingLabelCenterYConstraint = [self.floatingLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
    }
    return _floatingLabelCenterYConstraint;
}

@end
