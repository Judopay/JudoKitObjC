//
//  JPCardInputField.m
//  InputFieldTest
//
//  Created by Mihai Petrenco on 12/10/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import "JPCardNumberField.h"
#import "UIColor+Judo.h"

typedef NS_ENUM(NSInteger, JPCardType) {
    JPCardTypeUnknown,
    JPCardTypeAMEX,
    JPCardTypeVisa,
    JPCardTypeMaestro,
    JPCardTypeMastercard
};

@interface JPCardNumberField ()
@property (nonatomic, strong) UIImageView *cardLogoImageView;
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation JPCardNumberField

@dynamic stackView;

//------------------------------------------------------------------------------------
# pragma mark - Initializers
//------------------------------------------------------------------------------------

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupCardNumberViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCardNumberViews];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupCardNumberViews];
    }
    return self;
}

//------------------------------------------------------------------------------------
# pragma mark - View Model Configuration
//------------------------------------------------------------------------------------

- (void)configureWithViewModel:(JPAddCardInputFieldViewModel *)viewModel {
    
    [self placeholderWithText:viewModel.placeholder
                        color:UIColor.jpPlaceholderColor
                      andFont:[UIFont systemFontOfSize:16.0]];
    self.text = viewModel.text;
    
    if (viewModel.errorText) {
        [self displayErrorWithText:viewModel.errorText];
    } else {
        [self clearError];
    }
}

//------------------------------------------------------------------------------------
# pragma mark - Public Methods
//------------------------------------------------------------------------------------
- (void)setCardType:(JPCardType)type {
    self.cardLogoImageView.image = [UIImage imageNamed:@"visa"];
    [UIView animateWithDuration:0.3 animations:^{
        self.cardLogoImageView.alpha = type == JPCardTypeUnknown ? 0.0 : 1.0;
    }];
}

//------------------------------------------------------------------------------------
#pragma mark - Layout Setup
//------------------------------------------------------------------------------------

- (void)setupCardNumberViews {
    self.delegate = self;
    [self.cardLogoImageView.widthAnchor constraintEqualToConstant:50.0].active = YES;
    [self.stackView addArrangedSubview:self.cardLogoImageView];
}

//------------------------------------------------------------------------------------
#pragma mark - Lazy Properties
//------------------------------------------------------------------------------------

- (UIImageView *)cardLogoImageView {
    if (!_cardLogoImageView) {
        _cardLogoImageView = [UIImageView new];
        _cardLogoImageView.alpha = 0.0;
        _cardLogoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _cardLogoImageView;
}

//------------------------------------------------------------------------------------
#pragma mark - JPTextField Delegate Conformance
//------------------------------------------------------------------------------------

- (BOOL)textField:(JPTextField *)inputField shouldChangeText:(NSString *)text {
    [self.cardNumberDelegate cardNumberField:self shouldEditWithInput:text];
    return NO;
}

- (void)textField:(JPTextField *)inputField didChangeText:(NSString *)text {
    [self.cardNumberDelegate cardNumberField:self didEditWithInput:text];
}

@end
