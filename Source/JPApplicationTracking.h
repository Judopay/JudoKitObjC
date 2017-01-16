//
//  JPApplicationTracking.h
//  JudoKitObjC
//
//  Created by Ashley Barrett on 16/01/2017.
//  Copyright © 2017 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPApplicationTracking : NSObject
    
- (void)applictionDidResume:(nonnull NSDate *)dateResumed;
- (nonnull NSDictionary<NSString *, id> *)trackingAsDictionary;
    
@end
