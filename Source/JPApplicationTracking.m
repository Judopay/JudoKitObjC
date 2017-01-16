//
//  JPApplicationTracking.m
//  JudoKitObjC
//
//  Created by Ashley Barrett on 16/01/2017.
//  Copyright © 2017 Judo Payments. All rights reserved.
//

#import "JPApplicationTracking.h"

@interface JPApplicationTracking()
    
@property (nonnull, nonatomic, strong) NSMutableArray<NSString *> *whenResumed;
    
@end

@implementation JPApplicationTracking

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.whenResumed = [NSMutableArray new];
    }
    
    return self;
}
    
- (void)applictionDidResume:(nonnull NSDate *)dateResumed {
    [self.whenResumed addObject:[self dateToString:dateResumed]];
}
  
- (nonnull NSDictionary<NSString *, id> *)trackingAsDictionary {
    NSMutableDictionary<NSString *, id> *dictionary = [NSMutableDictionary new];
    [dictionary setValue:self.whenResumed forKey:@"appResumed"];
    return dictionary;
}
    
- (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    dateFormat.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    dateFormat.locale =  [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    return [dateFormat stringFromDate:date];
}
    
@end
