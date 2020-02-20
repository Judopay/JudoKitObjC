//
//  JPLoadingView.m
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

#import "JPLoadingView.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"
#import "UIStackView+Additions.h"
#import "UIView+Additions.h"

@interface JPLoadingView ()
@property (nonatomic, strong) UIView *loadingContainerView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation JPLoadingView

#pragma mark - Initializers

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super initWithFrame:CGRectZero]) {
        self.titleLabel.text = title;
        [self setupViews];
    }
    return self;
}

#pragma mark - Public methods

- (void)startLoading {
    self.hidden = NO;
    [self.activityIndicatorView startAnimating];
}

- (void)stopLoading {
    self.hidden = YES;
    [self.activityIndicatorView stopAnimating];
}

#pragma mark - Layout setup

- (void)setupViews {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self addSubview:self.loadingContainerView];

    UIStackView *stackView = [UIStackView verticalStackViewWithSpacing:0.0];
    stackView.distribution = UIStackViewDistributionFillEqually;
    [self.loadingContainerView addSubview:stackView];

    [NSLayoutConstraint activateConstraints:@[
        [self.loadingContainerView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.loadingContainerView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.loadingContainerView.heightAnchor constraintEqualToConstant:150.0],
        [self.loadingContainerView.widthAnchor constraintEqualToConstant:200.0]
    ]];

    [stackView pinToAnchors:AnchorTypeLeading | AnchorTypeTrailing
                    forView:self.loadingContainerView];

    [stackView pinToAnchors:AnchorTypeTop | AnchorTypeBottom
                    forView:self.loadingContainerView
                withPadding:30.0];

    [stackView addArrangedSubview:self.activityIndicatorView];
    [stackView addArrangedSubview:self.titleLabel];
}

#pragma mark - Lazy properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColor.jpBlackColor;
        _titleLabel.font = UIFont.title;
    }
    return _titleLabel;
}

- (UIView *)loadingContainerView {
    if (!_loadingContainerView) {
        _loadingContainerView = [UIView new];
        _loadingContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        _loadingContainerView.backgroundColor = UIColor.whiteColor;
        _loadingContainerView.layer.cornerRadius = 10.0;
        _loadingContainerView.layer.shadowColor = UIColor.jpBlackColor.CGColor;
        _loadingContainerView.layer.shadowOpacity = 0.5;
        _loadingContainerView.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _loadingContainerView;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.color = UIColor.jpBlackColor;
    }
    return _activityIndicatorView;
}

@end
