//
//  JPInputField.m
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import "JPTextField.h"
#import "JPFloatingTextField.h"
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"
#import "UITextField+Additions.h"

@interface JPTextField ()
@property (nonatomic, strong) JPFloatingTextField *floatingTextField;
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation JPTextField

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

- (void)placeholderWithText:(NSString *)text color:(UIColor *)color andFont:(UIFont *)font {
    [self.floatingTextField placeholderWithText:text color:color andFont:font];
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

#pragma mark - User Actions

- (void)displayErrorWithText:(NSString *)text {
    self.floatingTextField.textColor = UIColor.jpErrorColor;
    [self.floatingTextField displayFloatingLabelWithText:text
                                                   color:UIColor.jpErrorColor];
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
    self.backgroundColor = UIColor.jpTextFieldBackgroundColor;
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
        _floatingTextField.font = UIFont.defaultTextFont;
        _floatingTextField.textColor = UIColor.jpTextColor;
        [_floatingTextField placeholderWithText:@""
                                          color:UIColor.jpPlaceholderColor
                                        andFont:UIFont.defaultTextFont];

        [_floatingTextField addTarget:self
                               action:@selector(didChangeText)
                     forControlEvents:UIControlEventEditingChanged];

        _floatingTextField.delegate = self;
    }
    return _floatingTextField;
}

- (void)didChangeText {
    [self.delegate textField:self didChangeText:self.floatingTextField.text];
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _stackView;
}

@end

@implementation JPTextField (UITextFieldDelegate)

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return [self.delegate textField:self shouldChangeText:newString];
}

@end
