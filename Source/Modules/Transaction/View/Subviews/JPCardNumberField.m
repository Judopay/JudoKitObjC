//
//  JPCardNumberField.m
//  JudoKitObjC
//
//  Copyright (c) 2019 Alternative Payments Ltd
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JPCardNumberField.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"
#import "UIImage+Additions.h"

@interface JPCardNumberField ()
@property (nonatomic, strong) UIImageView *cardLogoImageView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) JPTheme *theme;
@end

@implementation JPCardNumberField

@dynamic stackView;

#pragma mark - Initializers

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

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.theme = theme;
    [super applyTheme:theme];
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPTransactionNumberInputViewModel *)viewModel {

    self.type = viewModel.type;

    [self setCardNetwork:viewModel.cardNetwork];

    self.placeholderFont = (viewModel.errorText) ? self.theme.body : self.theme.headlineLight;
    self.placeholder = viewModel.placeholder;

    self.text = viewModel.text;

    if (viewModel.errorText) {
        [self displayErrorWithText:viewModel.errorText];
        return;
    }

    [self clearError];
}

#pragma mark - Public Methods

- (void)setCardNetwork:(CardNetwork)network {

    UIImage *cardIcon = [UIImage imageForCardNetwork:network];
    cardIcon.accessibilityLabel = @"CardNumberCardTypeIcon";
    if (cardIcon)
        self.cardLogoImageView.image = cardIcon;

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3
        animations:^{
            weakSelf.cardLogoImageView.alpha = (cardIcon) ? 1.0 : 0.0;
        }
        completion:^(BOOL finished) {
            if (!cardIcon)
                weakSelf.cardLogoImageView.image = cardIcon;
        }];
}

#pragma mark - Layout Setup

- (void)setupCardNumberViews {
    [self.cardLogoImageView.widthAnchor constraintEqualToConstant:50.0].active = YES;
    [self.stackView addArrangedSubview:self.cardLogoImageView];
}

#pragma mark - Lazy Properties

- (UIImageView *)cardLogoImageView {
    if (!_cardLogoImageView) {
        _cardLogoImageView = [UIImageView new];
        _cardLogoImageView.alpha = 0.0;
        _cardLogoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _cardLogoImageView;
}

@end
