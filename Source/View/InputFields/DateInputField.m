//
//  DateInputField.m
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

#import "DateInputField.h"

#import "FloatingTextField.h"
#import "JPTheme.h"
#import "NSError+Judo.h"
#import "NSDate+Judo.h"
#import "NSString+Validation.h"

@interface DateInputField ()

@property (nonatomic, assign, readonly) NSInteger currentYear;
@property (nonatomic, assign, readonly) NSInteger currentMonth;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation DateInputField

#pragma mark - Superclass methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string { //!OCLINT
    
    if (self.textField != textField) {
        return YES;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newString.length == 0) {
        return YES;
    } else if (newString.length == 1) {
        return [newString isEqualToString:@"0"] || [newString isEqualToString:@"1"];
    } else if (newString.length == 2) {
        
        if (string.length != 0) {
            if (!string.isNumeric) {
                return NO;
            }
            
            if (newString.integerValue <= 0 || newString.integerValue > 12) {
                return NO;
            }
            
            self.textField.text = [newString stringByAppendingString:@"/"];
            return NO;
        }
        
        self.textField.text = [newString substringToIndex:1];
        
        return NO;
        
    } else if (newString.length == 3) {
        return [newString characterAtIndex:2] == '/';
    } else if (newString.length == 4) {
        NSInteger deciYear = ([[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate new]] - 2000) / 10.0;
        
        NSString *lastNumberString = [newString substringFromIndex:3];
        
        if (!lastNumberString.isNumeric) {
            return NO;
        }
        
        NSInteger lastNumber = [lastNumberString integerValue];
        
        if (self.isStartDate) {
            return lastNumber == deciYear || lastNumber == deciYear - 1;
        }
        
        return lastNumber == deciYear || lastNumber == deciYear + 1;
        
    } else if (newString.length == 5) {
        
        NSString *lastNumberString = [newString substringFromIndex:4];
        
        if (!lastNumberString.isNumeric) {
            return NO;
        }
        
        return YES;
    }
    [self.delegate dateInput:self didFailWithError:[NSError judoInputMismatchErrorWithMessage:nil]];
    return NO;
}

- (BOOL)isValid {
    
    if (self.textField.text.length != 5) {
        return NO;
    }
    
    NSDate *beginningOfMonthDate =[self.dateFormatter dateFromString:self.textField.text];
    
    if (!beginningOfMonthDate) {
        return false;
    }
    
    if (self.isStartDate) {
        NSDate *minimumDate = [[NSDate new] dateByAddingYears:-10];
        return [beginningOfMonthDate compare:[NSDate new]] == NSOrderedAscending && [beginningOfMonthDate compare:minimumDate] == NSOrderedDescending;
    }
    NSDate *endOfMonthDate = [beginningOfMonthDate endOfMonthDate];
    NSDate *maximumDate = [[NSDate new] dateByAddingYears:10];
    return [endOfMonthDate compare:[NSDate new]] == NSOrderedDescending && [endOfMonthDate compare:maximumDate] == NSOrderedAscending;
}

- (void)textFieldDidChangeValue:(UITextField *)textField {
    [super textFieldDidChangeValue:textField];
    
    [self didChangeInputText];
    
    if (textField.text.length != 5) {
        return; // BAIL
    }
    
    if (![self.dateFormatter dateFromString:textField.text]) {
        return; // BAIL
    }
    
    if (self.isValid) {
        [self.delegate dateInput:self didFindValidDate:textField.text];
    } else {
        NSString *errorMessage = @"Check expiry date";
        if (self.isStartDate) {
            errorMessage = @"Check start date";
        }
        [self.delegate dateInput:self didFailWithError:[NSError judoInputMismatchErrorWithMessage:errorMessage]];
    }
    
}

- (NSAttributedString *)placeholder {
    return [[NSAttributedString alloc] initWithString:self.title attributes:@{NSForegroundColorAttributeName:self.theme.judoPlaceholderTextColor}];
}

- (NSString *)title {
    return self.isStartDate ? @"Start date" : @"Expiry date";
}

- (NSString *)hintLabelText {
    return @"MM/YY";
}

#pragma mark - Lazy Loading

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"MM/yy";
    }
    return _dateFormatter;
}

- (NSInteger)currentYear {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate new]];
}

- (NSInteger)currentMonth {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate new]];
}

#pragma mark - Setters

- (void)setIsStartDate:(BOOL)isStartDate {
    if (_isStartDate == isStartDate) {
        return; //BAIL
    }
    _isStartDate = isStartDate;
    [self.textField setPlaceholder:self.title floatingTitle:self.title];
}

@end
