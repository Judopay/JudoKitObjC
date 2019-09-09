//
//  NSBundle+Additions.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 9/9/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "NSBundle+Additions.h"
#import "JudoKit.h"

@implementation NSBundle (Additions)
    
+ (instancetype)frameworkBundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [NSBundle bundleForClass:[JudoKit class]];
    });
    return bundle;
}
    
+ (instancetype)stringsBundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            NSString *podPath = [NSBundle.frameworkBundle pathForResource:@"JudoKitObjC"
                                                                   ofType:@"bundle"];
            bundle = [NSBundle bundleWithPath:podPath];
        });
    return bundle;
}
@end
