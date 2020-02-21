//
//  JPCardCustomizationPatternCell.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 2/21/20.
//  Copyright © 2020 Judo Payments. All rights reserved.
//

#import "JPCardCustomizationPatternCell.h"
#import "UIColor+Additions.h"

@implementation JPCardCustomizationPatternCell

+ (NSString *)cellIdentifier {
    return @"JPCardCustomizationPatternCell";
}

- (void)configureWithViewModel:(JPCardCustomizationPatternModel *)viewModel {
    self.layer.cornerRadius = 2.0;
    self.backgroundColor = viewModel.pattern.color;
}

@end
