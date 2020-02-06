//
//  JPInputField.h
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import "JPAddCardViewModel.h"
#import <UIKit/UIKit.h>

@class JPTextField;

@protocol JPTextFieldDelegate <NSObject>
- (BOOL)textField:(JPTextField *)inputField shouldChangeText:(NSString *)text;
@end

@interface JPTextField : UIView

@property (nonatomic, assign) JPInputType type;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, weak) id<JPTextFieldDelegate> delegate;

/**
 * Convenience method for setting an attributed placeholder
 *
 * @param text - the string contents of the placeholder
 * @param color - the color of the placeholder
 * @param font - the font of the placeholder
 */
- (void)placeholderWithText:(NSString *)text
                      color:(UIColor *)color
                    andFont:(UIFont *)font;

- (void)displayErrorWithText:(NSString *)text;
- (void)clearError;

@end

@interface JPTextField (UITextFieldDelegate) <UITextFieldDelegate>

@end
