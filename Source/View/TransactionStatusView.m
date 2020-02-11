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
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation TransactionStatusView

#pragma mark - Initializers

+ (instancetype)viewWithStatus:(IDEALStatus)status
                      subtitle:(NSString *)subtitle
                      andTheme:(JPTheme *)theme {

    return [[TransactionStatusView alloc] initWithStatus:status
                                                subtitle:subtitle
                                                andTheme:theme];
}

- (instancetype)initWithStatus:(IDEALStatus)status
                      subtitle:(NSString *)subtitle
                      andTheme:(JPTheme *)theme {

    if (self = [super init]) {
        self.theme = theme;
        [self setupLayout];
        [self applyTheme];
        [self setupViewsForStatus:status andSubtitle:subtitle];
    }
    return self;
}

#pragma mark - Public methods

- (void)changeStatusTo:(IDEALStatus)status
           andSubtitle:(NSString *)subtitle {

    [self setupViewsForStatus:status andSubtitle:subtitle];
}

#pragma mark - User actions

- (void)didTapRetryButton:(id)sender {
    [self.delegate statusView:self buttonDidTapWithRetry:YES];
}

- (void)didTapCloseButton:(id)sender {
    [self.delegate statusView:self buttonDidTapWithRetry:NO];
}

#pragma mark - Layout setup methods

- (void)applyTheme {
    self.backgroundColor = self.theme.judoBackgroundColor;

    self.titleLabel.textColor = self.theme.judoTextColor;
    self.titleLabel.font = self.theme.judoLabelFont;

    self.subtitleLabel.textColor = self.theme.judoTextColor;
    self.subtitleLabel.font = self.theme.judoLabelFont;

    self.activityIndicatorView.color = self.theme.judoActivityIndicatorColor;
    self.actionButton.backgroundColor = self.theme.judoButtonBackgroundColor;
    self.actionButton.titleLabel.font = self.theme.judoButtonTitleFont;
    [self.actionButton setTitleColor:self.theme.judoButtonTitleColor forState:UIControlStateNormal];
}

- (void)setupLayout {

    UIStackView *titleStackView = [UIStackView new];
    [titleStackView setAxis:UILayoutConstraintAxisVertical];
    titleStackView.spacing = 10.0f;
    [titleStackView addArrangedSubview:self.statusImageView];
    [titleStackView addArrangedSubview:self.activityIndicatorView];
    [titleStackView addArrangedSubview:self.titleLabel];
    [titleStackView addArrangedSubview:self.subtitleLabel];

    UIStackView *verticalStackView = [UIStackView new];
    verticalStackView.translatesAutoresizingMaskIntoConstraints = NO;
    verticalStackView.spacing = 30.0f;
    [verticalStackView setAxis:UILayoutConstraintAxisVertical];
    [verticalStackView addArrangedSubview:titleStackView];
    [verticalStackView addArrangedSubview:self.actionButton];

    [self addSubview:verticalStackView];

    NSArray *constraints = @[
        [verticalStackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [verticalStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                        constant:30.0],
        [verticalStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                         constant:-30.0],
        [self.statusImageView.heightAnchor constraintEqualToConstant:30]
    ];

    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupViewsForStatus:(IDEALStatus)status
                andSubtitle:(NSString *)subtitle {

    self.titleLabel.text = [self titleForStatus:status];
    self.subtitleLabel.text = subtitle;
    self.statusImageView.image = [self imageForStatus:status];
    [self setupButtonForStatus:status];

    if (status == IDEALStatusPending || status == IDEALStatusPendingDelay) {
        [self.activityIndicatorView startAnimating];
    } else {
        [self.activityIndicatorView stopAnimating];
    }
}

- (void)setupButtonForStatus:(IDEALStatus)status {

    self.actionButton.hidden = NO;

    if (status == IDEALStatusSuccess || status == IDEALStatusFailed || status == IDEALStatusTimeout) {

        [self.actionButton setTitle:@"close".localized
                           forState:UIControlStateNormal];

        [self.actionButton addTarget:self
                              action:@selector(didTapCloseButton:)
                    forControlEvents:UIControlEventTouchUpInside];

        return;
    }

    if (status == IDEALStatusError) {

        [self.actionButton setTitle:@"retry".localized
                           forState:UIControlStateNormal];

        [self.actionButton addTarget:self
                              action:@selector(didTapRetryButton:)
                    forControlEvents:UIControlEventTouchUpInside];

        return;
    }

    self.actionButton.hidden = YES;
}

- (NSString *)titleForStatus:(IDEALStatus)status {
    switch (status) {
        case IDEALStatusFailed:
            return @"ideal_transaction_failed".localized;

        case IDEALStatusPending:
            return @"ideal_transaction_pending".localized;

        case IDEALStatusPendingDelay:
            return @"ideal_transaction_pending_delay".localized;

        case IDEALStatusTimeout:
            return @"ideal_transaction_timeout".localized;

        case IDEALStatusError:
            return @"ideal_transaction_error".localized;

        case IDEALStatusSuccess:
            return @"ideal_transaction_success".localized;
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
        case IDEALStatusTimeout:
        case IDEALStatusError:
            resourceName = @"error-icon";
            break;
        case IDEALStatusSuccess:
            resourceName = @"checkmark-icon";
            break;
        default:
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
        _titleLabel.numberOfLines = 0;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel new];
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleLabel.numberOfLines = 0;
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subtitleLabel;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.theme.judoActivityIndicatorType];
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

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton new];
        _actionButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_actionButton setTitle:@"retry".localized forState:UIControlStateNormal];
        _actionButton.layer.cornerRadius = 5.0f;
    }
    return _actionButton;
}

@end
