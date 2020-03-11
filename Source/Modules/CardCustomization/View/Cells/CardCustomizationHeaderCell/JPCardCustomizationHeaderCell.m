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
@property (nonatomic, strong) JPTheme *theme;
@end

@implementation JPCardCustomizationHeaderCell

#pragma mark - Constants

const float kHeaderCardAnchorConstants = 20.0f;
const float kHeaderCardAspectRatio = 0.583;

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.theme = theme;
}

#pragma mark - Initializers

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPCardCustomizationViewModel *)viewModel {
    if ([viewModel isKindOfClass:JPCardCustomizationHeaderModel.class]) {
        JPCardCustomizationHeaderModel *headerModel = (JPCardCustomizationHeaderModel *)viewModel;
        [self.cardView applyTheme:self.theme];
        [self.cardView configureWithCustomizationModel:headerModel];
    }
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.cardView];

    [self setupConstraints];
}

- (void)setupConstraints {
    NSArray *constraints = @[
        [self.cardView.topAnchor constraintEqualToAnchor:self.topAnchor
                                                constant:kHeaderCardAnchorConstants],
        [self.cardView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor
                                                   constant:-kHeaderCardAnchorConstants],
        [self.cardView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                    constant:kHeaderCardAnchorConstants],
        [self.cardView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                     constant:-kHeaderCardAnchorConstants],
        [self.cardView.heightAnchor constraintEqualToAnchor:self.cardView.widthAnchor
                                                 multiplier:kHeaderCardAspectRatio],
    ];

    [NSLayoutConstraint activateConstraints:constraints
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
