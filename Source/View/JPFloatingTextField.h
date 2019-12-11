//
//  JPFloatingTextField.h
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPFloatingTextField : UITextField

- (void)displayFloatingLabelWithText:(NSString *)text color:(UIColor *)color;
- (void)hideFloatingLabel;

@end
