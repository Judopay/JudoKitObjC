//
//  JPTracking.m
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

#import "JPTracking.h"
#import "JPInputField.h"
#import "FloatingTextField.h"
#import "JPTrackedField.h"
#import "JPFieldTracking.h"

@interface JPTracking()

@property (nonnull, nonatomic, strong) JPFieldTracking *fieldTracking;

@end

@implementation JPTracking

+ (nonnull JPTracking *)sharedInstance {
    static JPTracking *sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
  
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [self new];
        sharedInstance.fieldTracking = [JPFieldTracking new];
    });
    
    return sharedInstance;
}

- (void)textFieldDidBeginEditing:(nonnull JPInputField *)textField {
    [self.fieldTracking textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(nonnull JPInputField *)textField {
    [self.fieldTracking textFieldDidEndEditing:textField];
}

- (void)didChangeInputText:(nonnull JPInputField *)textField {
    [self.fieldTracking didChangeInputText:textField];
}

- (void)applicationDidBecomeActive:(nonnull UIApplication *)application {
    NSLog(@"Active");
}

- (void)push {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.fieldTracking.trackingAsDictionary options:0 error:&error];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", json);
}

@end
