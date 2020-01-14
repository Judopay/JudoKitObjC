//
//  IssueNumberInputField.m
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

#import "IssueNumberInputField.h"
#import "FloatingTextField.h"
#import "JPTheme.h"
#import "NSString+Additions.h"
#import "NSString+Validation.h"

@implementation IssueNumberInputField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *oldString = textField.text;
    NSString *newString = [oldString stringByReplacingCharactersInRange:range withString:string];

    if (!newString.length) {
        return YES;
    }

    if (!newString.isNumeric) {
        return NO;
    }

    return [newString isNumeric] && newString.length <= 3;
}

#pragma mark - Superclass methods

- (BOOL)isValid {
    return self.textField.text.length > 0 && self.textField.text.length < 4;
}

- (void)textFieldDidChangeValue:(UITextField *)textField {
    [super textFieldDidChangeValue:textField];

    [self didChangeInputText];

    [self.delegate issueNumberInputDidEnterCode:self withIssueNumber:self.textField.text];
}

- (NSAttributedString *)placeholder {
    return [[NSAttributedString alloc] initWithString:self.title attributes:@{NSForegroundColorAttributeName : [self.theme judoPlaceholderTextColor]}];
}

- (NSString *)title {
    return @"issue_number_label".localized;
}

- (NSString *)hintLabelText {
    return @"issue_number_front_of_card".localized;
}

@end
