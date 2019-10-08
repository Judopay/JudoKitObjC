//
//  NSBundle+Additions.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 9/9/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (Additions)

+ (instancetype)frameworkBundle;
+ (instancetype)stringsBundle;

@end

NS_ASSUME_NONNULL_END
