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
#import "UIColor+Judo.h"
#import "NSString+Localize.h"

@interface TransactionStatusView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UIButton *retryButton;

@end

@implementation TransactionStatusView

#pragma mark - Initializers

+ (instancetype)viewWithStatus:(IDEALStatus)status {
    return [[TransactionStatusView alloc] initWithStatus:status];
}

- (instancetype)initWithStatus:(IDEALStatus)status {
    if (self = [super init]) {
        [self setupLayout];
        [self setupViewsForStatus:status];
    }
    return self;
}

#pragma mark - Public methods

- (void)didChangeToStatus:(IDEALStatus)status {
    [self setupViewsForStatus:status];
}

#pragma mark - User actions

- (void)didTapRetryButton:(id)sender {
    [self.delegate retryTransaction];
}

#pragma mark - Layout setup methods

- (void)setupLayout {
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
            return @"transaction_failed".localized;
            
        case IDEALStatusPending:
            return @"transaction_pending".localized;
            
        case IDEALStatusSuccess:
            return @"transaction_success".localized;
    }
}

- (UIImage *)imageForStatus:(IDEALStatus)status {
    NSBundle *bundle = [NSBundle bundleForClass:TransactionStatusView.class];
    NSString *iconBundlePath = [bundle pathForResource:@"icons" ofType:@"bundle"];
    NSBundle *iconBundle = [NSBundle bundleWithPath:iconBundlePath];
    
    NSString *resourceName;
    
    switch (status) {
        case IDEALStatusFailed:
            resourceName = @"error-icon";
            break;
        case IDEALStatusSuccess:
            resourceName = @"checkmark-icon";
            break;
        case IDEALStatusPending:
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
    }
    return _titleLabel;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
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
        [_retryButton setTitle:@"Retry" forState:UIControlStateNormal];
        [_retryButton setBackgroundColor:UIColor.errorRed];
        _retryButton.layer.cornerRadius = 5.0f;
    }
    return _retryButton;
}

@end
