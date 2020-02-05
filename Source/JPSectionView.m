//
//  JPSectionView.m
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

#import "JPSectionView.h"
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"

@interface JPSectionView ()
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIView *selectorView;
@end

@implementation JPSectionView

static const CGFloat imageHeight = 25.0f;
static const CGFloat selectorPadding = 4.0f;
static const CGFloat sectionHeight = 64.0f;
static const CGFloat horizontalPadding = 24.0f;

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupLayout];
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

#pragma mark - Public methods

- (void)addSectionWithImage:(UIImage *)image
                   andTitle:(NSString *)title {

    UIImageView *imageView = [self configuredImageViewFromImage:image];

    UILabel *label = [self configuredLabelWithText:title];
    label.hidden = (self.mainStackView.subviews.count != 0);

    UIStackView *stackView = [self configuredStackView];
    [stackView addArrangedSubview:imageView];
    [stackView addArrangedSubview:label];

    [self.mainStackView addArrangedSubview:stackView];

    self.contentWidth += imageView.image.size.width;

    if (!label.isHidden) {
        CGFloat labelWidth = [self labelWidthFromString:title];
        self.contentWidth += labelWidth - 20;
    }

    self.scrollView.contentSize = CGSizeMake(self.contentWidth, sectionHeight);
    self.backgroundView.frame = CGRectMake(0, 0, self.contentWidth, sectionHeight);
    self.mainStackView.frame = CGRectMake(horizontalPadding,
                                          0,
                                          self.contentWidth - (horizontalPadding * 2),
                                          sectionHeight);

    if (self.mainStackView.subviews.count == 1) {
        CGFloat width = self.contentWidth - 5;
        CGFloat height = sectionHeight - (selectorPadding * 2);
        self.selectorView.frame = CGRectMake(selectorPadding, selectorPadding, width, height);
    }
}

- (void)removeSections {
    for (UIStackView *stackView in self.mainStackView.subviews) {
        self.contentWidth = 0;
        [stackView removeFromSuperview];
    }
}

#pragma mark - User action handlers

- (void)onTapHandler:(UITapGestureRecognizer *)sender {

    int index = [self identifyIndexForGestureRecognizer:sender withOffset:0];
    if (index != -1) {
        [self handleSelectedSectionAtIndex:index];
        return;
    };

    index = [self identifyIndexForGestureRecognizer:sender withOffset:35];
    if (index != -1) {
        [self handleSelectedSectionAtIndex:index];
        return;
    };

    index = [self identifyIndexForGestureRecognizer:sender withOffset:-35];
    if (index != -1)
        [self handleSelectedSectionAtIndex:index];
}

- (int)identifyIndexForGestureRecognizer:(UITapGestureRecognizer *)recognizer
                              withOffset:(CGFloat)offset {

    CGPoint tapLocation = [recognizer locationInView:recognizer.view];
    CGPoint viewCoordinates = CGPointMake(tapLocation.x + offset, tapLocation.y);
    UIView *selectedView = [recognizer.view hitTest:viewCoordinates withEvent:nil];

    int index = 0;
    for (UIStackView *stackView in self.mainStackView.arrangedSubviews) {
        if (stackView == selectedView)
            return index;
        index++;
    }
    return -1;
}

- (void)handleSelectedSectionAtIndex:(int)index {
    UIStackView *selectedStackView = self.mainStackView.arrangedSubviews[index];
    UILabel *selectedLabel = selectedStackView.subviews[1];

    [self hideLabelsExceptLabel:selectedLabel];
    [self view:selectedLabel shouldHide:NO];

    [self.delegate sectionView:self didSelectSectionAtIndex:index];

    [self moveSelectorToView:selectedStackView];
}

#pragma mark - Helper methods

- (void)moveSelectorToView:(UIView *)view {
    CGFloat xPosition = view.frame.origin.x + selectorPadding;
    CGFloat yPosition = selectorPadding;
    CGFloat width = view.bounds.size.width + 35;
    CGFloat height = sectionHeight - (selectorPadding * 2);

    [UIView animateWithDuration:0.3
                     animations:^{
                         self.selectorView.frame = CGRectMake(xPosition, yPosition, width, height);
                     }];
}

- (void)view:(UIView *)view shouldHide:(BOOL)shouldHide {
    [UIView animateWithDuration:0.3
                     animations:^{
                         view.hidden = shouldHide;
                     }];
}

- (void)hideLabelsExceptLabel:(UILabel *)selectedLabel {
    for (UIStackView *stackView in self.mainStackView.arrangedSubviews) {
        UILabel *label = stackView.arrangedSubviews[1];
        if (!label.isHidden && label != selectedLabel) {
            [self view:label shouldHide:YES];
        }
    }
}

- (UIImageView *)configuredImageViewFromImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    CGFloat aspectRatio = imageView.image.size.width / imageView.image.size.height;

    [NSLayoutConstraint activateConstraints:@[
        [imageView.heightAnchor constraintEqualToConstant:imageHeight],
        [imageView.widthAnchor constraintEqualToAnchor:imageView.heightAnchor
                                            multiplier:aspectRatio],
    ]];

    return imageView;
}

- (UILabel *)configuredLabelWithText:(NSString *)text {
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = UIColor.jpBlackColor;
    label.font = UIFont.headline;
    label.contentMode = UIViewContentModeScaleAspectFit;
    return label;
}

- (UIStackView *)configuredStackView {
    UIStackView *stackView = [UIStackView new];
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 4.0f;
    return stackView;
}

- (CGFloat)labelWidthFromString:(NSString *)string {
    NSDictionary *textAttributes = @{NSFontAttributeName : UIFont.headline};
    return [string sizeWithAttributes:textAttributes].width;
}

#pragma mark - Layout setup

- (void)setupLayout {
    [self setupViews];
    [self setupConstraints];
    [self registerGestureRecognizers];
}

- (void)setupViews {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.backgroundView];
    [self.scrollView addSubview:self.selectorView];
    [self.scrollView addSubview:self.mainStackView];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
    ]];
}

- (void)registerGestureRecognizers {
    UITapGestureRecognizer *tapRecognizer;
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(onTapHandler:)];
    [self.mainStackView addGestureRecognizer:tapRecognizer];
}

#pragma mark - Lazy properties

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.contentInset = UIEdgeInsetsMake(0, horizontalPadding, 0, horizontalPadding);
        _scrollView.contentOffset = CGPointMake(-horizontalPadding, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.layer.cornerRadius = 14.0;
        _backgroundView.backgroundColor = UIColor.jpLightGrayColor;
    }
    return _backgroundView;
}

- (UIStackView *)mainStackView {
    if (!_mainStackView) {
        _mainStackView = [UIStackView new];
        _mainStackView.distribution = UIStackViewDistributionEqualSpacing;
    }
    return _mainStackView;
}

- (UIView *)selectorView {
    if (!_selectorView) {
        _selectorView = [UIView new];
        _selectorView.frame = CGRectMake(0, 0, 100, sectionHeight);
        _selectorView.backgroundColor = UIColor.whiteColor;
        _selectorView.layer.cornerRadius = 10.0f;
        _selectorView.layer.shadowRadius = 1.0f;
        _selectorView.layer.shadowOffset = CGSizeMake(0, 2);
        _selectorView.layer.shadowOpacity = 1.0f;
        _selectorView.layer.shadowColor = UIColor.jpGrayColor.CGColor;
    }
    return _selectorView;
}

@end
