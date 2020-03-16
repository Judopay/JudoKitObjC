//
//  JPTransactionStatusView.m
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

#import "JPTransactionStatusView.h"
#import "NSString+Additions.h"
#import "UIStackView+Additions.h"

@interface JPTransactionStatusView ()

@property (nonatomic, strong) UILabel *_Nullable titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *_Nullable activityIndicatorView;
@property (nonatomic, strong) UIButton *_Nullable retryButton;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation JPTransactionStatusView

#pragma mark - Constants

const float kStatusViewContainerHorizontalPadding = 60.0f;
const float kStatusViewContainerHeight = 170.0f;
const float kStatusViewContainerRadius = 20.0f;
const float kStatusViewStackSpacing = 20.0f;
const float kStatusViewStackHorizontalPadding = 35.0f;
const float kStatusViewRetryButtonWidth = 200.0f;
const float kStatusViewRetryButtonHeight = 45.0f;
const float kStatusViewRetryButtonRadius = 4.0f;

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
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.titleLabel.font = theme.headline;
    self.titleLabel.textColor = theme.jpBlackColor;
    self.containerView.backgroundColor = theme.jpWhiteColor;
    self.activityIndicatorView.color = theme.jpBlackColor;
    self.retryButton.backgroundColor = theme.jpBlackColor;
    self.retryButton.titleLabel.font = theme.title;
}

#pragma mark - Public methods

- (void)changeToTransactionStatus:(JPTransactionStatus)status {

    self.retryButton.hidden = (status != JPTransactionStatusTimeout);
    self.activityIndicatorView.hidden = !self.retryButton.hidden;

    switch (status) {
        case JPTransactionStatusPending:
            self.titleLabel.text = @"transaction_pending".localized;
            break;
        case JPTransactionStatusPendingDelayed:
            self.titleLabel.text = @"transaction_delayed".localized;
            break;
        case JPTransactionStatusTimeout:
            self.titleLabel.text = @"transaction_timeout".localized;
            break;
    }
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];

    [self addSubview:self.containerView];

    NSArray *containerConstraints = @[
        [self.containerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                         constant:kStatusViewContainerHorizontalPadding],
        [self.containerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                          constant:-kStatusViewContainerHorizontalPadding],
        [self.containerView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.containerView.heightAnchor constraintEqualToConstant:kStatusViewContainerHeight],
    ];

    [NSLayoutConstraint activateConstraints:containerConstraints];

    UIStackView *stackView = [UIStackView verticalStackViewWithSpacing:kStatusViewStackSpacing];
    stackView.alignment = UIStackViewAlignmentCenter;
    [stackView addArrangedSubview:self.activityIndicatorView];
    [stackView addArrangedSubview:self.titleLabel];
    [stackView addArrangedSubview:self.retryButton];

    [self.containerView addSubview:stackView];

    NSArray *constraints = @[
        [self.retryButton.widthAnchor constraintEqualToConstant:kStatusViewRetryButtonWidth],
        [self.retryButton.heightAnchor constraintEqualToConstant:kStatusViewRetryButtonHeight],
        [stackView.centerYAnchor constraintEqualToAnchor:self.containerView.centerYAnchor],
        [stackView.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor
                                                constant:kStatusViewStackHorizontalPadding],
        [stackView.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor
                                                 constant:-kStatusViewStackHorizontalPadding],
    ];

    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - Lazy properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        _containerView.layer.cornerRadius = kStatusViewContainerRadius;
    }
    return _containerView;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        _activityIndicatorView.hidesWhenStopped = YES;
        [_activityIndicatorView startAnimating];
    }
    return _activityIndicatorView;
}

- (UIButton *)retryButton {
    if (!_retryButton) {
        _retryButton = [UIButton new];
        _retryButton.translatesAutoresizingMaskIntoConstraints = NO;
        _retryButton.layer.cornerRadius = kStatusViewRetryButtonRadius;
        [_retryButton setTitle:@"retry".localized forState:UIControlStateNormal];
        [_retryButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    }
    return _retryButton;
}

@end
