//
//  JPPaymentMethodsView.m
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

#import "JPPaymentMethodsView.h"
#import "JPPaymentMethodsHeaderView.h"
#import "UIColor+Judo.h"
#import "UIImage+Icons.h"
#import "UIView+Additions.h"
#import "UIView+SafeAnchors.h"

@implementation JPPaymentMethodsView

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Layout setup

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.tableView];
    [self addSubview:self.headerView];
    [self addSubview:self.judoHeadlineImageView];
}

- (void)setupConstraints {
    [self.tableView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.tableView.leftAnchor constraintEqualToAnchor:self.safeLeftAnchor].active = YES;
    [self.tableView.rightAnchor constraintEqualToAnchor:self.safeRightAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.judoHeadlineImageView.topAnchor].active = YES;

    self.judoHeadlineHeightConstraint = [self.judoHeadlineImageView.heightAnchor constraintEqualToConstant:20.0f];
    self.judoHeadlineHeightConstraint.active = YES;

    [self.judoHeadlineImageView.leftAnchor constraintEqualToAnchor:self.safeLeftAnchor].active = YES;
    [self.judoHeadlineImageView.rightAnchor constraintEqualToAnchor:self.safeRightAnchor].active = YES;
    [self.judoHeadlineImageView.bottomAnchor constraintEqualToAnchor:self.safeBottomAnchor].active = YES;
}

#pragma mark - Lazy properties

- (JPPaymentMethodsHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [JPPaymentMethodsHeaderView new];
        _headerView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 400);
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.contentInset = UIEdgeInsetsMake(320, 0, 0, 0);
    }
    return _tableView;
}

- (UIImageView *)judoHeadlineImageView {
    if (!_judoHeadlineImageView) {
        UIImage *logoImage = [UIImage imageWithIconName:@"judo-headline"];
        _judoHeadlineImageView = [[UIImageView alloc] initWithImage:logoImage];
        _judoHeadlineImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _judoHeadlineImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _judoHeadlineImageView;
}

@end
