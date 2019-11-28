//
//  JPAddCardViewController.m
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

#import "JPAddCardViewController.h"
#import "RoundedCornerView.h"

@interface JPAddCardViewController()

@property (nonatomic, strong) RoundedCornerView *bottomSlider;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *scanCardButton;
@property (nonatomic, strong) UITextField *cardInputTextField;
@property (nonatomic, strong) UITextField *cardholderNameTextField;
@property (nonatomic, strong) UITextField *expirationDateTextField;
@property (nonatomic, strong) UITextField *lastDigitsTextField;
@property (nonatomic, strong) UIButton *addCardButton;
@property (nonatomic, strong) UIImageView *lockImageView;
@property (nonatomic, strong) UILabel *securityMessageLabel;

@end

@implementation JPAddCardViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [self setupViews];
    [self setupConstraints];
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.view addSubview:self.bottomSlider];
    [self setupSliderContents];
}

- (void)setupSliderContents {
    
    
    
}

#pragma mark - Constraint Setup

- (void)setupConstraints {
    [self setupBottomSliderConstraints];
}

- (void)setupBottomSliderConstraints {
    NSArray *constraints = @[
        [_bottomSlider.topAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [_bottomSlider.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_bottomSlider.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_bottomSlider.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ];
    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - Lazily instantiated properties

- (UIView *)bottomSlider {
    if (!_bottomSlider) {
        UIRectCorner corners = UIRectCornerTopRight | UIRectCornerTopLeft;
        _bottomSlider = [[RoundedCornerView alloc] initWithRadius:10
                                                       forCorners:corners];
        _bottomSlider.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomSlider.backgroundColor = UIColor.whiteColor;
    }
    return _bottomSlider;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        _cancelButton.titleLabel.font = [UIFont fontWithName:@"SF-Pro-Display-Semibold" size:14.0];
        [_cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    return _cancelButton;
}

- (UIButton *)scanCardButton {
    if (!_scanCardButton) {
        _scanCardButton = [UIButton new];
        _scanCardButton.translatesAutoresizingMaskIntoConstraints = NO;
        _scanCardButton.titleLabel.font = [UIFont fontWithName:@"SF-Pro-Display-Semibold" size:14.0];
    }
    return _scanCardButton;
}

@end
