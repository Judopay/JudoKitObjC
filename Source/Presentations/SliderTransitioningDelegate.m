//
//  SliderTransitioningDelegate.m
//  TransitionDemo
//
//  Created by Mihai Petrenco on 12/5/19.
//  Copyright © 2019 Mihai Petrenco. All rights reserved.
//

#import "SliderTransitioningDelegate.h"
#import "SliderPresentationController.h"

@implementation SliderTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    return [[SliderPresentationController alloc] initWithPresentedViewController:presented
                                                        presentingViewController:presenting];
}

@end
