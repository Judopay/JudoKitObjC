//
//  UIFont+Additions.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/11/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "UIFont+Additions.h"

@implementation UIFont (Additions)

+ (UIFont *)defaultTextFont {
    return [UIFont systemFontOfSize:16.0];
}

+ (UIFont *)smallTextFont {
    return [UIFont systemFontOfSize:14.0];
}

+ (UIFont *)errorTextFont {
    return [UIFont systemFontOfSize:10.0];
}

+ (UIFont *)smallButtonTitleFont {
    return [UIFont systemFontOfSize:14.0 weight:UIFontWeightSemibold];
}

+ (UIFont *)largetButtonTitleFont {
    return [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
}

+ (UIFont *)subtitleTextFont {
    return [UIFont systemFontOfSize:11.3];
}

@end
