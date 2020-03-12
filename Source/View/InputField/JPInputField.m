//
//  JPInputField.m
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

#import "JPInputField.h"
#import "JPFloatingTextField.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"
#import "UITextField+Additions.h"

@interface JPInputField ()
@property (nonatomic, strong) JPTheme *theme;
@property (nonatomic, strong) JPFloatingTextField *floatingTextField;
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation JPInputField

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

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.theme = theme;
    self.textColor = theme.jpBlackColor;
    self.font = theme.headlineLight;
    self.placeholderFont = theme.headlineLight;
    self.placeholderColor = theme.jpDarkGrayColor;
    [self.floatingTextField applyTheme:theme];
}

#pragma mark - Property setters

- (void)setText:(NSString *)text {
    _text = text;
    self.floatingTextField.text = text;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.floatingTextField.textColor = textColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.floatingTextField.font = font;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    self.floatingTextField.placeholderFont = placeholderFont;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.floatingTextField.placeholderColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    UIColor *color = self.placeholderColor ? self.placeholderColor : UIColor.jpRedColor;
    UIFont *font = self.placeholderFont ? self.placeholderFont : UIFont.caption;
    [self.floatingTextField placeholderWithText:placeholder color:color andFont:font];
}

- (void)setInputView:(UIView *)inputView {
    _inputView = inputView;
    self.floatingTextField.inputView = inputView;
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    self.floatingTextField.enabled = enabled;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    self.floatingTextField.keyboardType = keyboardType;
}

- (void)setReturnType:(UIReturnKeyType)returnType {
    _returnType = returnType;
    self.floatingTextField.returnKeyType = returnType;
}

#pragma mark - User Actions

- (void)displayErrorWithText:(NSString *)text {
    self.floatingTextField.textColor = self.theme.jpRedColor;
    [self.floatingTextField displayFloatingLabelWithText:text];
}

- (void)clearError {
    self.floatingTextField.textColor = self.textColor;
    [self.floatingTextField hideFloatingLabel];
}

- (BOOL)becomeFirstResponder {
    return [self.floatingTextField becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [self.floatingTextField resignFirstResponder];
}

#pragma mark - Layout setup

- (void)setupViews {

    self.layer.cornerRadius = 6.0f;
    self.backgroundColor = UIColor.jpLightGrayColor;
    self.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:self.stackView];
    [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:14.0].active = YES;
    [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-14.0].active = YES;
    [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.0].active = YES;
    [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0].active = YES;

    [self.stackView addArrangedSubview:self.floatingTextField];
}

- (JPFloatingTextField *)floatingTextField {
    if (!_floatingTextField) {
        _floatingTextField = [JPFloatingTextField new];
        _floatingTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _floatingTextField.font = UIFont.headlineLight;
        _floatingTextField.delegate = self;
    }
    return _floatingTextField;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _stackView;
}

@end

@implementation JPInputField (UITextFieldDelegate)

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return [self.delegate inputField:self shouldChangeText:newString];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
