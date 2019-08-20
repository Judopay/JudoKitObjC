//
//  LoadingView.m
//  JudoKitObjC
//
//  Copyright (c) 2016 Alternative Payments Ltd
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

#import "LoadingView.h"
#import "JPTheme.h"

@interface LoadingView ()

@property (nonatomic, strong) UIView *blockView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong, readwrite) UILabel *actionLabel;

@end

@implementation LoadingView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = self.theme.judoLoadingBackgroundColor;

    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.alpha = 0.0f;

    self.blockView.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.actionLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.blockView.backgroundColor = self.theme.judoLoadingBlockViewColor;
    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.actionLabel.textColor = self.theme.judoTextColor;

    self.blockView.clipsToBounds = true;
    self.blockView.layer.cornerRadius = 5.0f;

    [self addSubview:self.blockView];

    [self.blockView addSubview:self.activityIndicatorView];
    [self.blockView addSubview:self.actionLabel];

    [self.blockView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-<=30-[activity]-25-[label]-<=30-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"activity" : self.activityIndicatorView, @"label" : self.actionLabel}]];

    [self.blockView addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.blockView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];

    [self.blockView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.blockView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-<=30-[block(>=270)]-<=30-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:@{@"block" : self.blockView}]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.blockView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:110.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.blockView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

- (void)startAnimating {
    [self.activityIndicatorView startAnimating];
    self.alpha = 1.0f;
}

- (void)stopAnimating {
    [self.activityIndicatorView stopAnimating];
    self.alpha = 0.0f;
}

- (void)setTheme:(JPTheme *)theme {
    if (_theme == theme) {
        return;
    }
    _theme = theme;
    self.backgroundColor = self.theme.judoLoadingBackgroundColor;
    self.blockView.backgroundColor = self.theme.judoLoadingBlockViewColor;
    self.actionLabel.textColor = self.theme.judoTextColor;
}

#pragma mark - Lazy Loading

- (UIView *)blockView {
    if (!_blockView) {
        _blockView = [UIView new];
    }
    return _blockView;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [UIActivityIndicatorView new];
    }
    return _activityIndicatorView;
}

- (UILabel *)actionLabel {
    if (!_actionLabel) {
        _actionLabel = [UILabel new];
    }
    return _actionLabel;
}

@end
