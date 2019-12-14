//
//  JPFloatingTextField.m
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

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
    [self.floatingLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.floatingLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    self.floatingLabelCenterYConstraint = [self.floatingLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
    self.floatingLabelCenterYConstraint.active = YES;
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

    [self setNeedsUpdateConstraints];
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
        _floatingLabel.font = UIFont.errorTextFont;
        _floatingLabel.alpha = 0.0f;
        _floatingLabel.textColor = [UIColor colorWithRed:226 / 255.0
                                                   green:25 / 255.0
                                                    blue:0 / 255.0
                                                   alpha:1.0];
    }
    return _floatingLabel;
}
@end
