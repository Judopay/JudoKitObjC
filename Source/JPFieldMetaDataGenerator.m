//
//  JPFieldMetaDataGenerator.m
//  JudoKitObjC
//
//  Created by Ashley Barrett on 12/01/2017.
//  Copyright © 2017 Judo Payments. All rights reserved.
//

#import "JPFieldMetaDataGenerator.h"

@implementation JPFieldMetaDataGenerator

+ (nonnull NSDictionary<NSString *, id> *)generateAsDictionary:(nonnull NSDictionary<NSString *, NSArray<JPTrackedField *> *> *)fieldSessions; {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
     
     if (fieldSessions && fieldSessions.count > 0) {
         NSInteger totalKeyStrokes = 0;
         NSMutableArray<NSDictionary<NSString *, id> *> *fieldMetadata = [NSMutableArray new];
         
         for (NSString *completedFieldsKey in fieldSessions) {
             NSArray<JPTrackedField *> *completedFields = [fieldSessions valueForKey:completedFieldsKey];
         
             NSMutableArray<NSString *> *pastedFields = [NSMutableArray new];
             NSMutableArray<NSDictionary<NSString *, id> *> *sessions = [NSMutableArray new];
         
             for (JPTrackedField *field in completedFields) {
                if (field.whenPasted && field.whenPasted.count > 0) {
                    [pastedFields addObjectsFromArray:field.whenPasted];
                }
         
                [sessions addObject:@{@"timeStarted" : [self valueOrNSNull:field.whenFocused],@"timeEdited" : [self valueOrNSNull:field.whenEditingBegan],@"timeEnded" : [self valueOrNSNull:field.whenBlured], @"valid" : field.isConsideredValid ? @YES : @NO}];
         
                totalKeyStrokes += field.totalKeystrokes;
             }
         
             [fieldMetadata addObject:@{ @"field" : completedFieldsKey, @"sessions" : sessions, @"pasted" : pastedFields }];
         }
         
         [dictionary setObject:@(totalKeyStrokes) forKey:@"totalKeystrokes"];
         [dictionary setObject:fieldMetadata forKey:@"fieldMetaData"];
     }
     
     return [dictionary copy];
}
    
+ (nonnull id)valueOrNSNull:(nullable NSString *)string {
    return string ? string : [NSNull null];
}
    
@end
