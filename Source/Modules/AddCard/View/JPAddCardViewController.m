//
//  JPAddCardViewController.m
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

#import "JPAddCardViewController.h"
#import "JPAddCardView.h"

@interface JPAddCardViewController()
@property (nonatomic, strong) JPAddCardView* addCardView;
@end

@implementation JPAddCardViewController

#pragma mark - View lifecycle

- (void)loadView {
    self.addCardView = [JPAddCardView new];
    self.view = self.addCardView;
    [self addTargets];
}

- (void)addTargets {
    
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(onCancelButtonTap)];
    [self.addCardView.backgroundView addGestureRecognizer:tapGesture];
    
    [self.addCardView.cancelButton addTarget:self
                                      action:@selector(onCancelButtonTap)
                            forControlEvents:UIControlEventTouchUpInside];
    
    [self.addCardView.scanCardButton addTarget:self
                                        action:@selector(onScanCardButtonTap)
                              forControlEvents:UIControlEventTouchUpInside];
    
    [self.addCardView.addCardButton addTarget:self
                                       action:@selector(onAddCardButtonTap)
                             forControlEvents:UIControlEventTouchUpInside];
}

- (void)onCancelButtonTap {
    //TODO: Implement cancel functionality
}

- (void)onScanCardButtonTap {
    //TODO: Implement scan card functionality
}

- (void)onAddCardButtonTap {
    //TODO: Implement add card functionality
}

@end
