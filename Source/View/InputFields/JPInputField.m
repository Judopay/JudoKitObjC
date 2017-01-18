//
//  JPInputField.m
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

#import "JPInputField.h"

#import "JPTheme.h"

#import "FloatingTextField.h"
#import "CardLogoView.h"

@interface JPInputField ()

@property (nonatomic, strong, readwrite) NSString *hintLabelText;

@property (nonatomic, strong) UIView *logoContainerView;

@property (nonatomic, strong) UIView *redBlock;
    
@property (nonatomic, strong) UILabel *hintLabel;

@property (nonatomic) BOOL hasRedblockBeenLaidout;

@end

@implementation JPInputField

- (instancetype)initWithTheme:(JPTheme *)theme {
	self = [super init];
	if (self) {
        self.theme = theme;
        [self setupView];
	}
	return self;
}

- (void)setupView {
    self.hasRedblockBeenLaidout = NO;
    
    self.backgroundColor = self.theme.judoInputFieldBackgroundColor;
    self.clipsToBounds = YES;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.textField.delegate = self;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self addSubview:self.textField];
    [self addSubview:self.redBlock];
    
    self.hintLabel = [UILabel new];
    self.hintLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.hintLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.hintLabel];
    
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.textColor = self.theme.judoInputFieldTextColor;
    self.textField.tintColor = self.theme.tintColor;
    self.textField.font = [UIFont boldSystemFontOfSize:16];
    [self.textField addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[text(40)]" options:NSLayoutFormatAlignAllBaseline metrics:nil views:@{@"text":self.textField}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[hintLabel]|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:@{@"hintLabel":self.hintLabel}]];
    
    [self setActive:false];
    
    [self.textField setPlaceholder:[self title] floatingTitle:[self title]];
    
    if ([self containsLogo]) {
        UIView *logoView = [self logoView];
        logoView.frame = CGRectMake(0, 0, 46, 30);
        [self addSubview:self.logoContainerView];
        self.logoContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        self.logoContainerView.clipsToBounds = YES;
        self.logoContainerView.layer.cornerRadius = 2;
        [self.logoContainerView addSubview:logoView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(3.5)-[logo(30)]" options:NSLayoutFormatAlignAllBaseline metrics:nil views:@{@"logo":self.logoContainerView}]];

        
        [self.logoContainerView addConstraint:[NSLayoutConstraint constraintWithItem:self.logoContainerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0]];
    }

    NSString *visualFormat = [self containsLogo] ? @"|-13-[text][logo(46)]-13-|" : @"|-13-[text]-13-|";
    
    NSDictionary *views = @{@"text": self.textField, @"logo": self.logoContainerView};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:NSLayoutFormatDirectionLeftToRight metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-13-[hintLabel]-13-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"hintLabel":self.hintLabel}]];
}
   
- (void)layoutSubviews {
    if (!self.hasRedblockBeenLaidout) {
        [super layoutSubviews];
        [self redBlockAsUnactive];
        self.hasRedblockBeenLaidout = YES;
    }
}
    
- (void)errorAnimation:(BOOL)showRedBlock {
    void (^blockAnimation)(BOOL) = ^void(BOOL didFinish) {
        CAKeyframeAnimation *contentViewAnimation = [CAKeyframeAnimation animation];
        contentViewAnimation.keyPath = @"position.x";
        contentViewAnimation.values = @[@0, @10, @(-8), @6, @(-4), @2, @0];
        contentViewAnimation.keyTimes = @[@0, @(1 / 11.0), @(3 / 11.0), @(5 / 11.0), @(7 / 11.0), @(9 / 11.0), @1];
        contentViewAnimation.duration = 0.4;
        contentViewAnimation.additive = YES;
        
        [self.layer addAnimation:contentViewAnimation forKey:@"wiggle"];
        
        [self layoutIfNeeded];
    };
    
    if (showRedBlock) {
        [self redBlockAsError];
        [UIView animateWithDuration:0.2 animations:^{
            [self redBlockAsError];
            self.textField.textColor = self.theme.judoErrorColor;
            self.hintLabel.textColor = self.theme.judoErrorColor;
        } completion:blockAnimation];
    } else {
        blockAnimation(YES);
    }
}

- (void)updateCardLogo {
    CardLogoView *logoView = [self logoView];
    logoView.frame = CGRectMake(0, 0, 46, 30);
    CardLogoView *oldLogoView = self.logoContainerView.subviews.firstObject;
    if (oldLogoView.type != logoView.type) {
        [UIView transitionFromView:oldLogoView toView:logoView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromBottom completion:nil];
    }
}

- (void)setActive:(BOOL)active {
    self.textField.alpha = active ? 1.0f : 0.5f;
    self.logoContainerView.alpha = active ? 1.0f : 0.5f;
    self.hintLabel.text = @"";
    
    if (active) {
        [self redBlockAsActive];
    }
    else {
        [self redBlockAsUnactive];
    }
}

- (void)dismissError {
    if ([self.theme.judoErrorColor isEqual:self.redBlock.backgroundColor]) {
        [self setActive:YES];
        self.hintLabel.textColor = self.theme.judoTextColor;
        self.textField.textColor = self.theme.judoTextColor;
        self.hintLabel.text = @"";
        [self layoutIfNeeded];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self setActive:YES];
    [self.delegate judoPayInputDidChangeText:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self setActive:(textField.text.length > 0)];
}

- (BOOL)isValid {
    return false;
}

- (void)didChangeInputText {
    [self.delegate judoPayInputDidChangeText:self];
}

- (void)textFieldDidChangeValue:(UITextField *)textField {
    [self dismissError];
}

- (NSAttributedString *)placeHolder {
    return [NSAttributedString new];
}

- (BOOL)containsLogo {
    return NO;
}

- (CardLogoView *)logoView {
    return nil;
}

- (NSString *)title {
    return @"";
}

- (CGFloat)titleWidth {
    return 50.0f;
}

- (NSString *)hintLabelText {
    return @"";
}

- (void)displayHint:(NSString *)message {
    self.hintLabel.text = message;
    self.hintLabel.textColor = self.theme.judoTextColor;
}

- (void)displayError:(NSString *)message {
    self.hintLabel.text = message;
    self.hintLabel.textColor = self.theme.judoErrorColor;
}

- (void)setRedBlockFrameAndBackgroundColor:(CGFloat)height backgroundColor:(UIColor *)backgroundColor {
    self.redBlock.backgroundColor = backgroundColor;
    self.redBlock.frame = CGRectMake(13.0f, self.frame.size.height - 22, self.frame.size.width - 26.0f, height);
}

- (void)redBlockAsError {
    [self setRedBlockFrameAndBackgroundColor:2.0f backgroundColor:self.theme.judoErrorColor];
}

- (void)redBlockAsUnactive {
    UIColor *backgroundColor = [[UIColor alloc] initWithRed:0.67f green:0.67f blue:0.67f alpha:0.5f];
    [self setRedBlockFrameAndBackgroundColor:0.5f backgroundColor:backgroundColor];
}

- (void)redBlockAsActive {
    UIColor *backgroundColor = [[UIColor alloc] initWithRed:0.67f green:0.67f blue:0.67f alpha:1.0f];
    [self setRedBlockFrameAndBackgroundColor:0.5f backgroundColor:backgroundColor];
}

#pragma mark - Lazy Loading

- (FloatingTextField *)textField {
    if (!_textField) {
        _textField = [FloatingTextField new];
        _textField.keepBaseline = YES;
        _textField.floatingLabelFont = [UIFont systemFontOfSize:12.0f];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _textField;
}

- (UIView *)redBlock {
    if (!_redBlock) {
        _redBlock = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
        _redBlock.backgroundColor = self.theme.judoErrorColor;
    }
    return _redBlock;
}

- (UIView *)logoContainerView {
    if (!_logoContainerView) {
        _logoContainerView = [UIView new];
        _logoContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _logoContainerView;
}

@end
