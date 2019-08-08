//
//  FloatingTextField.m
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

#import "FloatingTextField.h"
#import "NSString+TextDirection.h"
#import <math.h>

static CGFloat const kFloatingLabelShowAnimationDuration = 0.3f;
static CGFloat const kFloatingLabelHideAnimationDuration = 0.3f;

@interface FloatingTextField ()
@property (nonatomic, assign) BOOL isFloatingLabelFontDefault;
@property (nonatomic, strong, readwrite) UILabel *floatingLabel;
@end

@implementation FloatingTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.floatingLabel = [UILabel new];
    self.floatingLabel.alpha = 0.0f;
    [self addSubview:self.floatingLabel];

    // some basic default fonts/colors
    self.floatingLabelFont = [self defaultFloatingLabelFont];
    self.floatingLabel.font = self.floatingLabelFont;
    self.floatingLabelTextColor = [UIColor grayColor];
    self.floatingLabel.textColor = self.floatingLabelTextColor;
    self.animateEvenIfNotFirstResponder = NO;
    self.floatingLabelShowAnimationDuration = kFloatingLabelShowAnimationDuration;
    self.floatingLabelHideAnimationDuration = kFloatingLabelHideAnimationDuration;
    [self setFloatingLabelText:self.placeholder];

    self.adjustsClearButtonRect = YES;
    self.isFloatingLabelFontDefault = YES;
}

#pragma mark -

- (UIFont *)defaultFloatingLabelFont {
    UIFont *textFieldFont = nil;

    if (!textFieldFont && self.attributedPlaceholder && self.attributedPlaceholder.length > 0) {
        textFieldFont = [self.attributedPlaceholder attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont && self.attributedText && self.attributedText.length > 0) {
        textFieldFont = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont) {
        textFieldFont = self.font;
    }

    return [UIFont fontWithName:textFieldFont.fontName size:roundf(textFieldFont.pointSize * 0.7f)];
}

- (void)updateDefaultFloatingLabelFont {
    UIFont *derivedFont = [self defaultFloatingLabelFont];

    if (self.isFloatingLabelFontDefault) {
        self.floatingLabelFont = derivedFont;
    } else {
        // dont apply to the label, just store for future use where floatingLabelFont may be reset to nil
        self.floatingLabelFont = derivedFont;
    }
}

- (UIColor *)labelActiveColor {
    if (self.floatingLabelActiveTextColor) {
        return self.floatingLabelActiveTextColor;
    } else if ([self respondsToSelector:@selector(tintColor)]) {
        return [self performSelector:@selector(tintColor)];
    }
    return [UIColor blueColor];
}

- (void)setFloatingLabelFont:(UIFont *)floatingLabelFont {
    if (floatingLabelFont != nil) {
        _floatingLabelFont = floatingLabelFont;
    }
    _floatingLabel.font = _floatingLabelFont ? _floatingLabelFont : [self defaultFloatingLabelFont];
    self.isFloatingLabelFontDefault = floatingLabelFont == nil;
    [self setFloatingLabelText:self.placeholder];
    [self invalidateIntrinsicContentSize];
}

- (void)showFloatingLabel:(BOOL)animated {
    void (^showBlock)(void) = ^{
        self->_floatingLabel.alpha = 1.0f;
        self->_floatingLabel.frame = CGRectMake(self->_floatingLabel.frame.origin.x,
                                                self->_floatingLabelYPadding,
                                                self->_floatingLabel.frame.size.width,
                                                self->_floatingLabel.frame.size.height);
    };

    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelShowAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    } else {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated {
    void (^hideBlock)(void) = ^{
        self->_floatingLabel.alpha = 0.0f;
        self->_floatingLabel.frame = CGRectMake(self->_floatingLabel.frame.origin.x,
                                                self->_floatingLabel.font.lineHeight + self->_placeholderYPadding,
                                                self->_floatingLabel.frame.size.width,
                                                self->_floatingLabel.frame.size.height);
    };

    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelHideAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    } else {
        hideBlock();
    }
}

- (void)setLabelOriginForTextAlignment {
    CGRect textRect = [self textRectForBounds:self.bounds];

    CGFloat originX = textRect.origin.x;

    if (self.textAlignment == NSTextAlignmentCenter) {
        originX = textRect.origin.x + (textRect.size.width / 2) - (_floatingLabel.frame.size.width / 2);
    } else if (self.textAlignment == NSTextAlignmentRight) {
        originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
    } else if (self.textAlignment == NSTextAlignmentNatural) {
        JPTextDirection baseDirection = [_floatingLabel.text getBaseDirection];
        if (baseDirection == JPTextDirectionRightToLeft) {
            originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
        }
    }

    _floatingLabel.frame = CGRectMake(originX + _floatingLabelXPadding, _floatingLabel.frame.origin.y,
                                      _floatingLabel.frame.size.width, _floatingLabel.frame.size.height);
}

- (void)setFloatingLabelText:(NSString *)text {
    _floatingLabel.text = text;
    [self setNeedsLayout];
}

#pragma mark - UITextField

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self updateDefaultFloatingLabelFont];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self updateDefaultFloatingLabelFont];
}

- (CGSize)intrinsicContentSize {
    CGSize textFieldIntrinsicContentSize = [super intrinsicContentSize];
    [_floatingLabel sizeToFit];
    return CGSizeMake(textFieldIntrinsicContentSize.width,
                      textFieldIntrinsicContentSize.height + _floatingLabelYPadding + _floatingLabel.bounds.size.height);
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    [self setFloatingLabelText:placeholder];
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    [super setAttributedPlaceholder:attributedPlaceholder];
    [self setFloatingLabelText:attributedPlaceholder.string];
    [self updateDefaultFloatingLabelFont];
}

- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle {
    [super setPlaceholder:placeholder];
    [self setFloatingLabelText:floatingTitle];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline) {
        rect = [self insetRectForBounds:rect];
    }
    return CGRectIntegral(rect);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline) {
        rect = [self insetRectForBounds:rect];
    }
    return CGRectIntegral(rect);
}

- (CGRect)insetRectForBounds:(CGRect)rect {
    CGFloat topInset = ceilf(_floatingLabel.bounds.size.height + _placeholderYPadding);
    topInset = fmin(topInset, self.maxTopInset);
    return CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect rect = [super clearButtonRectForBounds:bounds];
    if (0 != self.adjustsClearButtonRect && _floatingLabel.text.length // for when there is no floating title label text
        && ([self.text length] || self.keepBaseline)) {
        CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
        topInset = fmin(topInset, self.maxTopInset);
        rect = CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
    }
    return CGRectIntegral(rect);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds:bounds];

    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
    topInset = fmin(topInset, self.maxTopInset);
    rect = CGRectOffset(rect, 0, topInset / 2.0f);

    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {

    CGRect rect = [super rightViewRectForBounds:bounds];

    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
    topInset = fmin(topInset, self.maxTopInset);
    rect = CGRectOffset(rect, 0, topInset / 2.0f);

    return rect;
}

- (CGFloat)maxTopInset {
    return fmax(0, floorf(self.bounds.size.height - self.font.lineHeight - 4.0f));
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsLayout];
}

- (void)setAlwaysShowFloatingLabel:(BOOL)alwaysShowFloatingLabel {
    _alwaysShowFloatingLabel = alwaysShowFloatingLabel;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self setLabelOriginForTextAlignment];

    CGSize floatingLabelSize = [_floatingLabel sizeThatFits:_floatingLabel.superview.bounds.size];

    _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                      _floatingLabel.frame.origin.y,
                                      floatingLabelSize.width,
                                      floatingLabelSize.height);

    BOOL firstResponder = self.isFirstResponder;
    _floatingLabel.textColor = (firstResponder && self.text && self.text.length > 0 ? self.labelActiveColor : self.floatingLabelTextColor);
    if ((!self.text || 0 == [self.text length]) && !self.alwaysShowFloatingLabel) {
        [self hideFloatingLabel:firstResponder];
    } else {
        [self showFloatingLabel:firstResponder];
    }
}

@end
