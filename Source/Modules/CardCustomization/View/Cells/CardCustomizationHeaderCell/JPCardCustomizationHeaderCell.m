//
//  JPCardCustomizationHeaderCell.m
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

#import "JPCardCustomizationHeaderCell.h"
#import "JPCardCustomizationViewModel.h"
#import "JPCardView.h"
#import "NSLayoutConstraint+Additions.h"
#import "UIView+Additions.h"

@interface JPCardCustomizationHeaderCell ()
@property (nonatomic, strong) JPCardView *cardView;
@end

@implementation JPCardCustomizationHeaderCell

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPCardCustomizationViewModel *)viewModel {
    [self setupViews];
    if (![viewModel isKindOfClass:JPCardCustomizationHeaderModel.class]) {
        return;
    }
    JPCardCustomizationHeaderModel *headerModel = (JPCardCustomizationHeaderModel *)viewModel;
    [self.cardView configureWithCustomizationModel:headerModel];
}

#pragma mark - Layout Setup

- (void)setupViews {

    [self removeAllSubviews];

    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.cardView];
    [NSLayoutConstraint activateConstraints:@[
        [self.cardView.topAnchor constraintEqualToAnchor:self.topAnchor
                                                constant:20],
        [self.cardView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor
                                                   constant:-20],
        [self.cardView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                    constant:20.0],
        [self.cardView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                     constant:-20.0],
        [self.cardView.heightAnchor constraintEqualToAnchor:self.cardView.widthAnchor
                                                 multiplier:0.583],
    ]
                               withPriority:999];
}

#pragma mark - Lazy Properties

- (JPCardView *)cardView {
    if (!_cardView) {
        _cardView = [JPCardView new];
        _cardView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardView.layer.shadowColor = UIColor.grayColor.CGColor;
        _cardView.layer.shadowRadius = 10.0;
        _cardView.layer.shadowOffset = CGSizeMake(0, 4);
        _cardView.layer.shadowOpacity = 1.0;
    }
    return _cardView;
}

@end
