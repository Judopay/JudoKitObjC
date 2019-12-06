//
//  SliderPresentationController.m
//  TransitionDemo
//
//  Created by Mihai Petrenco on 12/5/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import "SliderPresentationController.h"

@interface SliderPresentationController()
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation SliderPresentationController

- (void)presentationTransitionWillBegin {
    [self addDimmingView];
    
    id<UIViewControllerTransitionCoordinator> presentedCoordinator;
    presentedCoordinator = self.presentedViewController.transitionCoordinator;
    
    [presentedCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 1.0;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> presentedCoordinator;
    presentedCoordinator = self.presentedViewController.transitionCoordinator;
    
    [presentedCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.0;
    } completion:nil];
}

- (void)addDimmingView {
    [self.containerView addSubview:self.dimmingView];
    [self.dimmingView.topAnchor constraintEqualToAnchor:self.containerView.topAnchor].active = YES;
    [self.dimmingView.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor].active = YES;
    [self.dimmingView.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor].active = YES;
    [self.dimmingView.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor].active = YES;
}

# pragma mark - Lazy instantiated properties

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
