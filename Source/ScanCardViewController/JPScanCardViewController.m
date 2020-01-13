//
//  JPScanCardViewController.h
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

#import "JPScanCardViewController.h"
#import "UIStackView+Additions.h"
#import "UIFont+Additions.h"
#import "UIImage+Icons.h"
#import "UIView+SafeAnchors.h"
#import "NSString+Additions.h"

@interface JPScanCardViewController ()
@property (nonatomic, strong) PayCardsRecognizer *recognizer;
@end

@implementation JPScanCardViewController

#pragma mark - Initializers

- (instancetype)initWithRecognizerDelegate:(id<PayCardsRecognizerPlatformDelegate>)delegate {
    if (self = [super init]) {
        [self setupViews];
        self.recognizer = [[PayCardsRecognizer alloc] initWithDelegate:delegate
                                                            resultMode:PayCardsRecognizerResultModeAsync
                                                             container:self.containerView
                                                            frameColor:UIColor.whiteColor];
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.recognizer startCamera];
        [self.containerView bringSubviewToFront:self.labelStackView];
        [self.containerView bringSubviewToFront:self.backButton];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.recognizer stopCamera];
    [super viewWillDisappear:animated];
}

#pragma mark - User Actions

- (void)onBackButtonTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Layout Setup

- (void)setupViews {
    self.view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.containerView];
    
    [self.labelStackView addArrangedSubview:self.titleLabel];
    [self.labelStackView addArrangedSubview:self.subtitleLabel];
    
    [self.containerView addSubview:self.labelStackView];
    [self.containerView addSubview:self.backButton];
    
    [self.containerView.topAnchor constraintEqualToAnchor:self.view.safeTopAnchor constant:25].active = YES;
    [self.containerView.leftAnchor constraintEqualToAnchor:self.view.safeLeftAnchor].active = YES;
    [self.containerView.rightAnchor constraintEqualToAnchor:self.view.safeRightAnchor].active = YES;
    [self.containerView.bottomAnchor constraintEqualToAnchor:self.view.safeBottomAnchor constant:-25].active = YES;
    
    [self.labelStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.labelStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
}

#pragma mark - Lazy Properties

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _containerView;
}

- (UIStackView *)labelStackView {
    if (!_labelStackView) {
        _labelStackView = [UIStackView verticalStackViewWithSpacing:0.0];
        _labelStackView.alignment = UIStackViewAlignmentCenter;
    }
    return _labelStackView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"scan_card_message_title".localized;
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.font = UIFont.largeTitle;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel new];
        _subtitleLabel.text = @"scan_card_message_subtitle".localized;
        _subtitleLabel.textColor = UIColor.whiteColor;
        _subtitleLabel.font = UIFont.body;
    }
    return _subtitleLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 25, 22, 22)];
        UIImage *backIcon = [UIImage imageWithIconName:@"back-icon"];
        UIImage *templatedIcon = [backIcon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_backButton setImage:templatedIcon forState:UIControlStateNormal];
        [_backButton setTintColor:UIColor.whiteColor];
        [_backButton addTarget:self action:@selector(onBackButtonTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
