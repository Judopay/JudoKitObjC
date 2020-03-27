//
//  JPSliderPresentationController.m
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

#import "JPSliderPresentationController.h"

@interface JPSliderPresentationController ()
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation JPSliderPresentationController

- (void)presentationTransitionWillBegin {
    [self addDimmingView];

    id<UIViewControllerTransitionCoordinator> presentedCoordinator;
    presentedCoordinator = self.presentedViewController.transitionCoordinator;

    __weak typeof(self) weakSelf = self;
    [presentedCoordinator
        animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            weakSelf.dimmingView.alpha = 1.0;
        }
                        completion:nil];
}

- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> presentedCoordinator;
    presentedCoordinator = self.presentedViewController.transitionCoordinator;

    __weak typeof(self) weakSelf = self;
    [presentedCoordinator
        animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            weakSelf.dimmingView.alpha = 0.0;
        }
                        completion:nil];
}

- (void)addDimmingView {
    [self.containerView addSubview:self.dimmingView];
    [self.dimmingView.topAnchor constraintEqualToAnchor:self.containerView.topAnchor].active = YES;
    [self.dimmingView.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor].active = YES;
    [self.dimmingView.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor].active = YES;
    [self.dimmingView.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor].active = YES;
}

#pragma mark - Lazy instantiated properties

- (UIView *)dimmingView {
    if (!_dimmingView) {
        _dimmingView = [UIView new];
        _dimmingView.translatesAutoresizingMaskIntoConstraints = NO;
        _dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        _dimmingView.alpha = 0.0;
    }
    return _dimmingView;
}

@end
