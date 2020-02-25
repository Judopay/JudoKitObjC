//
//  JPCardCustomizationTextInputCell.m
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

#import "JPCardCustomizationTextInputCell.h"
#import "JPCardCustomizationViewModel.h"
#import "JPInputField.h"
#import "NSString+Additions.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"
#import "UIView+Additions.h"

@implementation JPCardCustomizationTextInputCell

#pragma mark - Constants

const float kInputFieldTopPadding = 32.0f;
const float kInputFieldBottomPadding = 16.0f;
const float kInputFieldHorizontalPadding = 24.0f;
const float kInputFieldHeight = 44.0f;

#pragma mark - Initializers

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPCardCustomizationViewModel *)viewModel {
    if ([viewModel isKindOfClass:JPCardCustomizationTextInputModel.class]) {
        JPCardCustomizationTextInputModel *inputModel;
        inputModel = (JPCardCustomizationTextInputModel *)viewModel;
        self.inputField.text = inputModel.text;
        [self.inputField clearError];
    }
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.inputField];
    [self setupConstraints];
}

- (void)setupConstraints {
    NSArray *constraints = @[
        [self.inputField.topAnchor constraintEqualToAnchor:self.topAnchor
                                                  constant:kInputFieldTopPadding],
        [self.inputField.bottomAnchor constraintEqualToAnchor:self.bottomAnchor
                                                     constant:-kInputFieldBottomPadding],
        [self.inputField.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                      constant:kInputFieldHorizontalPadding],
        [self.inputField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                       constant:-kInputFieldHorizontalPadding],
        [self.inputField.heightAnchor constraintEqualToConstant:kInputFieldHeight],
    ];

    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - Lazy properties

- (JPInputField *)inputField {
    if (!_inputField) {
        _inputField = [JPInputField new];
        _inputField.translatesAutoresizingMaskIntoConstraints = NO;
        _inputField.font = UIFont.headlineLight;
        _inputField.textColor = UIColor.jpBlackColor;
        [_inputField placeholderWithText:@"enter_card_title".localized
                                   color:UIColor.jpDarkGrayColor
                                 andFont:UIFont.headlineLight];
    }
    return _inputField;
}

@end
