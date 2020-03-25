//
//  JPCardCustomizationTitleCell.m
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

#import "JPCardCustomizationTitleCell.h"
#import "JPCardCustomizationViewModel.h"
#import "JPTheme.h"
#import "UIView+Additions.h"

@interface JPCardCustomizationTitleCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation JPCardCustomizationTitleCell

#pragma mark - Constants

const float kTitleLabelHorizontalPadding = 20.0f;
const float kTitleLabelVerticalPadding = 10.0f;

#pragma mark - Initializers

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.titleLabel.font = theme.largeTitle;
    self.titleLabel.textColor = theme.jpBlackColor;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPCardCustomizationViewModel *)viewModel {
    if ([viewModel isKindOfClass:JPCardCustomizationTitleModel.class]) {
        JPCardCustomizationTitleModel *headerModel = (JPCardCustomizationTitleModel *)viewModel;
        self.titleLabel.text = headerModel.title;
    }
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.titleLabel];

    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor
                                                  constant:kTitleLabelVerticalPadding],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor
                                                     constant:-kTitleLabelVerticalPadding],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                      constant:kTitleLabelHorizontalPadding],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                       constant:-kTitleLabelHorizontalPadding]
    ]];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

@end
