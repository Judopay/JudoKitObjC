//
//  JPPaymentMethodsCardHeaderView.m
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

#import "JPPaymentMethodsCardHeaderView.h"
#import "JPCardView.h"
#import "JPPaymentMethodsViewModel.h"

@interface JPPaymentMethodsCardHeaderView ()
@property (nonatomic, strong) JPCardView *cardView;
@end

@implementation JPPaymentMethodsCardHeaderView

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    [self.cardView configureWithViewModel:viewModel];
}

#pragma mark - Layout Setup

- (void)setupViews {
    [self addSubview:self.cardView];
    [self.cardView.topAnchor constraintEqualToAnchor:self.topAnchor constant:100.0].active = YES;
    [self.cardView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-30.0].active = YES;
    [self.cardView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.cardView.widthAnchor constraintEqualToAnchor:self.cardView.heightAnchor multiplier:1.715].active = YES;
}

#pragma mark - Lazy Properties

- (JPCardView *)cardView {
    if (!_cardView) {
        _cardView = [JPCardView new];
        _cardView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
        _cardView.layer.shadowRadius = 1.0;
        _cardView.layer.shadowOffset = CGSizeMake(0, 1);
        _cardView.layer.shadowOpacity = 1.0;
    }
    return _cardView;
}

@end
