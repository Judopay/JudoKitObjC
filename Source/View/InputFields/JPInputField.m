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

@property (nonatomic, strong) UIView *borderBottom;

@property (nonatomic, strong) UILabel *hintLabel;

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
    self.backgroundColor = self.theme.judoInputFieldBackgroundColor;
    self.clipsToBounds = YES;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.textField.delegate = self;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.borderBottom = [UIView new];
    self.borderBottom.translatesAutoresizingMaskIntoConstraints = NO;
    self.borderBottom.backgroundColor = [[UIColor alloc] initWithRed:0.67f green:0.67f blue:0.67f alpha:1.0f];
    
    self.hintLabel = [UILabel new];
    self.hintLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.hintLabel.font = [UIFont systemFontOfSize:12];
    self.hintLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.hintLabel.numberOfLines = 2;
    
    [self addSubview:self.textField];
    [self addSubview:self.borderBottom];
    [self addSubview:self.hintLabel];
    
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.textColor = self.theme.judoInputFieldTextColor;
    self.textField.tintColor = self.theme.tintColor;
    self.textField.font = [UIFont boldSystemFontOfSize:16];
    [self.textField addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];

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
    }
    
    //self.backgroundColor = [UIColor blueColor];
    //self.textField.backgroundColor = [UIColor greenColor];
    
    [self setUpConstraints];
}

- (void)setUpConstraints {
    [self addConstraint:@"H:|-13-[borderBottom]-13-|" option:NSLayoutFormatDirectionLeftToRight];
    [self addConstraint:@"H:|-13-[hintLabel]-13-|" option:NSLayoutFormatDirectionLeftToRight];
    [self addConstraint: [self containsLogo] ? @"H:|-13-[text][logo(46)]-13-|" : @"H:|-13-[text]-13-|" option:NSLayoutFormatDirectionLeftToRight];
    
    [self addConstraint:@"V:|[text]-8-[borderBottom(0.5)]-5-[hintLabel(15)]|" option:0];
    if ([self containsLogo]) {
        [self addConstraint:@"V:|-5-[logo(30)]|" option:0];
    }
}

- (void)addConstraint:(NSString *)vfl option:(NSLayoutFormatOptions)option {
    NSMutableDictionary *views = [@{ @"text" : self.textField, @"borderBottom" : self.borderBottom, @"hintLabel" : self.hintLabel } mutableCopy];
    
    if ([self containsLogo]) {
        [views setObject:self.logoContainerView forKey:@"logo"];
    }
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:option metrics:nil views:[views copy]]];
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
        [UIView animateWithDuration:0.2 animations:^{
            [self setBorderBottomAsError];
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
    self.borderBottom.alpha = active ? 1.0f : 0.5f;
}

- (void)dismissError {
    if (self.borderBottom.bounds.origin.y < self.bounds.size.height) {
        [UIView animateWithDuration:0.4 animations:^{
            [self setBorderBottomAsNormal];
        } completion:^(BOOL finished) {
            [self layoutIfNeeded];
        }];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self setActive:YES];
    [self.delegate judoPayInputDidChangeText:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self setActive:(textField.text.length > 0)];
    [self.delegate judoInputEditingDidEnd:self];
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

- (void)setBorderBottomAsError {
    self.borderBottom.frame = CGRectMake(self.borderBottom.frame.origin.x, self.borderBottom.frame.origin.y, self.borderBottom.frame.size.width, 2.0f);
    self.borderBottom.backgroundColor = self.theme.judoErrorColor;
    self.textField.textColor = self.theme.judoErrorColor;
}

- (void)setBorderBottomAsNormal {
    self.borderBottom.frame = CGRectMake(self.borderBottom.frame.origin.x, self.borderBottom.frame.origin.y, self.borderBottom.frame.size.width, 0.5f);
    self.borderBottom.backgroundColor = [[UIColor alloc] initWithRed:0.67f green:0.67f blue:0.67f alpha:1.0f];
    self.textField.textColor = self.theme.judoTextColor;}

- (void)setErrorHintText:(NSString *)message {
    self.hintLabel.text = message;
    self.hintLabel.textColor = self.theme.judoErrorColor;
}

- (void)setHintText:(NSString *)message {
    self.hintLabel.text = message;
    self.hintLabel.textColor = self.theme.judoTextColor;
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

- (UIView *)logoContainerView {
    if (!_logoContainerView) {
        _logoContainerView = [UIView new];
        _logoContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _logoContainerView;
}

@end
