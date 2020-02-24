//
//  JPCardCustomizationPatternCell.h
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 2/21/20.
//  Copyright © 2020 Judo Payments. All rights reserved.
//

#import "JPCardCustomizationViewModel.h"
#import <UIKit/UIKit.h>

@interface JPCardCustomizationPatternCell : UICollectionViewCell

/**
 * A static method which returns the current cell's identifier
 *
 * @returns an NSString representing the cell identifier
 */
+ (NSString *)cellIdentifier;

/**
 * A method which configures the JPCardCustomizationPatternCell based on a provided view model;
 *
 * @param viewModel - a JPCardCustomizationPatternModel object that defines the color and image of the cell
 */
- (void)configureWithViewModel:(JPCardCustomizationPatternModel *)viewModel;

@end
