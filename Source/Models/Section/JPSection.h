//
//  JPSection.h
//  section-builder
//
//  Created by Mihai Petrenco on 3/16/20.
//  Copyright © 2020 JudoPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPSection : NSObject

@property (nonatomic, strong) UIImage *_Nonnull image;
@property (nonatomic, strong) NSString *_Nullable title;

+ (nonnull instancetype)sectionWithImage:(nonnull UIImage *)image
                                andTitle:(nullable NSString *)title;


- (nonnull instancetype)initWithImage:(nonnull UIImage *)image
                             andTitle:(nullable NSString *)title;

@end

