//
//  JPPaymentMethodsSelectionCell.m
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

#import "JPPaymentMethodsSelectionCell.h"
#import "JPPaymentMethodsCell.h"
#import "UIColor+Judo.h"
#import "UIView+Additions.h"

@interface JPPaymentMethodsSelectionCell ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation JPPaymentMethodsSelectionCell

- (void)configureWithViewModel:(JPPaymentMethodsModel *)viewModel {
    [self setupViews];
    [self setupConstraints];
}

- (void)setupViews {
    //TODO: Implement custom Payment Method Selection view;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.containerView];
}

- (void)setupConstraints {
    [self.containerView pinToAnchors:AnchorTypeTop | AnchorTypeBottom forView:self withPadding:24.0];
    [self.containerView pinToAnchors:AnchorTypeLeading forView:self withPadding:20.0];
    [self.containerView pinToAnchors:AnchorTypeTrailing forView:self withPadding:-20.0];
    [self.containerView.heightAnchor constraintEqualToConstant:64.0].active = YES;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        _containerView.backgroundColor = UIColor.jpContentBackgroundColor;
        _containerView.layer.cornerRadius = 14.0f;
    }
    return _containerView;
}

@end
