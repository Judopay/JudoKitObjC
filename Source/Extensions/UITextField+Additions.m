//
//  UITextField+Additions.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/2/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "UITextField+Additions.h"

@implementation UITextField (Additions)

- (void)placeholderWithText:(NSString *)text color:(UIColor *)color andFont:(UIFont *)font {
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text
                                                                 attributes:@{
                                                                     NSForegroundColorAttributeName : color,
                                                                     NSFontAttributeName : font
                                                                 }];
}

@end
