//
//  TransactionStatusView.m
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

#import "TransactionStatusView.h"
#import "NSString+Localize.h"
#import "UIColor+Judo.h"

@interface TransactionStatusView ()

@property (nonatomic, strong) JPTheme *theme;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UIButton *retryButton;

@end

@implementation TransactionStatusView

#pragma mark - Initializers

+ (instancetype)viewWithStatus:(IDEALStatus)status andTheme:(JPTheme *)theme {
    return [[TransactionStatusView alloc] initWithStatus:status andTheme:theme];
}

- (instancetype)initWithStatus:(IDEALStatus)status andTheme:(JPTheme *)theme {
    if (self = [super init]) {
        self.theme = theme;
        [self setupLayout];
        [self setupViewsForStatus:status];
    }
    return self;
}

#pragma mark - Public methods

- (void)changeStatusTo:(IDEALStatus)status {
    [self setupViewsForStatus:status];
}

#pragma mark - User actions

- (void)didTapRetryButton:(id)sender {
    [self.delegate statusViewRetryButtonDidTap:(self)];
}

#pragma mark - Layout setup methods

- (void)setupLayout {
    self.backgroundColor = self.theme.judoLoadingBackgroundColor;

    UIStackView *horizontalStackView = [UIStackView new];
    [horizontalStackView setAxis:UILayoutConstraintAxisHorizontal];
    horizontalStackView.spacing = 10.0f;
    [horizontalStackView addArrangedSubview:self.statusImageView];
    [horizontalStackView addArrangedSubview:self.activityIndicatorView];
    [horizontalStackView addArrangedSubview:self.titleLabel];

    UIStackView *verticalStackView = [UIStackView new];
    verticalStackView.translatesAutoresizingMaskIntoConstraints = NO;
    verticalStackView.spacing = 10.0f;
    [verticalStackView setAxis:UILayoutConstraintAxisVertical];
    [verticalStackView addArrangedSubview:horizontalStackView];
    [verticalStackView addArrangedSubview:self.retryButton];

    [self addSubview:verticalStackView];

    NSArray *constraints = @[
        [verticalStackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [verticalStackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.statusImageView.heightAnchor constraintEqualToConstant:30],
        [self.statusImageView.widthAnchor constraintEqualToConstant:30],
    ];

    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupViewsForStatus:(IDEALStatus)status {
    self.titleLabel.text = [self titleForStatus:status];
    self.statusImageView.image = [self imageForStatus:status];
    self.retryButton.hidden = (status != IDEALStatusFailed);

    if (status == IDEALStatusPending) {
        [self.activityIndicatorView startAnimating];
    } else {
        [self.activityIndicatorView stopAnimating];
    }
}

- (NSString *)titleForStatus:(IDEALStatus)status {
    switch (status) {
        case IDEALStatusFailed:
            return self.theme.idealTransactionFailedTitle;

        case IDEALStatusPending:
            return self.theme.idealTransactionPendingTitle;

        case IDEALStatusSuccess:
            return self.theme.idealTransactionSuccessTitle;
    }
}

- (UIImage *)imageForStatus:(IDEALStatus)status {
    NSBundle *bundle = [NSBundle bundleForClass:TransactionStatusView.class];
    NSString *iconBundlePath = [bundle pathForResource:@"icons" ofType:@"bundle"];
    NSBundle *iconBundle = [NSBundle bundleWithPath:iconBundlePath];

    NSString *resourceName;
    self.statusImageView.hidden = NO;

    switch (status) {
        case IDEALStatusFailed:
            resourceName = @"error-icon";
            break;
        case IDEALStatusSuccess:
            resourceName = @"checkmark-icon";
            break;
        case IDEALStatusPending:
            self.statusImageView.hidden = YES;
            return nil;
    }

    NSString *iconFilePath = [iconBundle pathForResource:resourceName
                                                  ofType:@"png"];
    return [UIImage imageWithContentsOfFile:iconFilePath];
}

#pragma mark - Lazy intantiated properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textColor = self.theme.judoTextColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = self.theme.judoTextFont;
    }
    return _titleLabel;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.theme.judoActivityIndicatorType];
        _activityIndicatorView.color = self.theme.judoActivityIndicatorColor;
        _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        _activityIndicatorView.hidesWhenStopped = YES;
    }
    return _activityIndicatorView;
}

- (UIImageView *)statusImageView {
    if (!_statusImageView) {
        _statusImageView = [UIImageView new];
        _statusImageView.contentMode = UIViewContentModeScaleAspectFit;
        _statusImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _statusImageView;
}

- (UIButton *)retryButton {
    if (!_retryButton) {
        _retryButton = [UIButton new];
        _retryButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_retryButton setTitle:self.theme.judoIDEALRetryButtonTitle forState:UIControlStateNormal];
        [_retryButton setTitleColor:self.theme.judoButtonTitleColor forState:UIControlStateNormal];
        [_retryButton setBackgroundColor:self.theme.judoButtonColor];
        _retryButton.layer.cornerRadius = 5.0f;
        [_retryButton addTarget:self
                         action:@selector(didTapRetryButton:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryButton;
}

@end
