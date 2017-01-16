//
//  JPFieldTracking.m
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

#import "JPFieldTracking.h"
#import "JPTrackedField.h"
#import "JPFieldMetaDataGenerator.h"

@interface JPFieldTracking()

@property (nonnull, nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<JPTrackedField *> *> *completedFields;
@property (nonnull, nonatomic, strong) NSMutableDictionary<NSString *, JPTrackedField *> *activeFields;

@end

@implementation JPFieldTracking

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.completedFields = [NSMutableDictionary new];
        self.activeFields = [NSMutableDictionary new];
    }
    
    return self;
}

- (void)textFieldDidBeginEditing:(nonnull JPField *)textField {
    JPTrackedField *field = [self getField:textField];
    
    field.name = textField.name;
    field.whenFocused = [self dateToString:textField.dateOfAction];
    
    [self.activeFields setObject:field forKey:field.name];
}

- (void)textFieldDidEndEditing:(nonnull JPField *)textField {
    JPTrackedField *field = [self getField:textField];
    
    field.whenBlured = [self dateToString:textField.dateOfAction];
    field.isConsideredValid = textField.isConsideredValid;
    
    //Ship off to the completed array.
    [self moveActiveFieldToCompleted:field];
}

- (void)didChangeInputText:(nonnull JPField *)textField {
    JPTrackedField *field = [self getField:textField];
    
    if ((field.currentLength == 0 || !field.whenEditingBegan) && textField.value.length > 0) {
        field.whenEditingBegan = [self dateToString:textField.dateOfAction];
    }
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"/ "];
    NSString *textMinusWhitespace = [[textField.value componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    
    NSInteger previousTextLength = field.currentLength;
    NSInteger currentTextLength = textMinusWhitespace.length;
    
    NSInteger differenceInLength = currentTextLength - previousTextLength;
    
    if (differenceInLength > 1 || differenceInLength < -1) {
        [field.whenPasted addObject:[self dateToString:textField.dateOfAction]];
    }
    
    field.totalKeystrokes += ABS(differenceInLength);
    field.currentLength = currentTextLength;
    
    [self.activeFields setObject:field forKey:field.name];
}
   
- (nonnull NSDictionary<NSString *, id> *)trackingAsDictionary {
    return [JPFieldMetaDataGenerator generateAsDictionary:self.completedFields];
}

- (void)moveActiveFieldToCompleted:(JPTrackedField *)trackingField {
    NSMutableArray<JPTrackedField *> *completedFields = [self.completedFields valueForKey:trackingField.name] ? : [NSMutableArray new];
    [completedFields addObject:trackingField];
    
    [self.completedFields setObject:completedFields forKey:trackingField.name];
    [self.activeFields removeObjectForKey:trackingField.name];
}
    
- (nonnull JPTrackedField *)getField:(nonnull JPField *)textField{
    JPTrackedField *field = [self.activeFields valueForKey:textField.name];
    
    if (!field) {
        field = [JPTrackedField new];
        field.name = textField.name;
        field.currentLength = textField.value.length;
    }
    
    return field;
}

- (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    dateFormat.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    dateFormat.locale =  [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    return [dateFormat stringFromDate:date];
}

@end
