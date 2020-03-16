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
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"

@interface JPSectionView ()
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIView *selectorView;
@property (nonatomic, strong) JPTheme *theme;
@end

@implementation JPSectionView

#pragma mark - Constants

const float kAnimationDuration = 0.3f;
const float kImageHeight = 25.0f;
const float kSelectorPadding = 4.0f;
const float kSectionHeight = 64.0f;
const float kHorizontalPadding = 24.0f;
const float kStackViewSpacing = 4.0f;
const float kContentPadding = 50.0f;
const float kBackgroundViewCornerRadius = 14.0;
const float kSelectorViewCornerRadius = 10.0f;

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

- (void)applyTheme:(JPTheme *)theme {
    self.theme = theme;
}

- (void)addSectionWithImage:(UIImage *)image
                   andTitle:(NSString *)title {

    UIStackView *stackView = [self stackViewFromImage:image andString:title];
    [self.mainStackView addArrangedSubview:stackView];

    CGFloat scrollViewWidth = [self contentWidthForStackView:stackView];
    self.contentWidth += scrollViewWidth;

    if (self.contentWidth <= UIScreen.mainScreen.bounds.size.width) {
        [self layoutUnscrollableContent];
        return;
    }

    [self layoutScrollableContent];
}

- (void)removeSections {
    for (UIStackView *stackView in self.mainStackView.subviews) {
        self.contentWidth = 0;
        [stackView removeFromSuperview];
    }
}

- (void)changeSelectedSectionToIndex:(NSUInteger)index {
    UIStackView *selectedStackView = self.mainStackView.arrangedSubviews[index];
    UILabel *selectedLabel = selectedStackView.subviews.lastObject;

    [self hideLabelsExceptLabel:selectedLabel withDuration:0.0];
    [self view:selectedLabel shouldHide:NO withDuration:0.0];

    [self moveSelectorToView:selectedStackView];
}

#pragma mark - User action handlers

- (void)onTapHandler:(UITapGestureRecognizer *)sender {

    int index = [self identifyIndexForGestureRecognizer:sender withOffset:0];
    if (index != -1) {
        [self handleSelectedSectionAtIndex:index];
        return;
    };

    index = [self identifyIndexForGestureRecognizer:sender withOffset:kHorizontalPadding];
    if (index != -1) {
        [self handleSelectedSectionAtIndex:index];
        return;
    };

    index = [self identifyIndexForGestureRecognizer:sender withOffset:-kHorizontalPadding];
    if (index != -1)
        [self handleSelectedSectionAtIndex:index];
}

#pragma mark - Helper methods

- (void)setInitialSelectorPosition {
    UIStackView *firstSection = self.mainStackView.subviews.firstObject;
    UIImageView *imageView = firstSection.subviews.firstObject;
    UILabel *label = firstSection.subviews.lastObject;

    CGFloat width = imageView.frame.size.width;

    if (!label.isHidden) {
        CGFloat labelWidth = [self labelWidthFromString:label.text];
        width += labelWidth - kHorizontalPadding;
    }

    CGFloat height = kSectionHeight - (kSelectorPadding * 2);

    CGFloat xPosition = kSelectorPadding;

    if (self.contentWidth <= UIScreen.mainScreen.bounds.size.width) {
        xPosition += kHorizontalPadding;
    }

    if (self.mainStackView.subviews.count == 2) {
        xPosition += kHorizontalPadding;
        width += kHorizontalPadding * 2 + kSelectorPadding / 2;
    }

    self.selectorView.frame = CGRectMake(xPosition, kSelectorPadding, width, height);
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
    UILabel *selectedLabel = selectedStackView.subviews.lastObject;

    [self hideLabelsExceptLabel:selectedLabel withDuration:kAnimationDuration];
    [self view:selectedLabel shouldHide:NO withDuration:kAnimationDuration];

    [self.delegate sectionView:self didSelectSectionAtIndex:index];

    [self moveSelectorToView:selectedStackView];
}

- (CGFloat)contentWidthForStackView:(UIStackView *)stackView {

    UIImageView *imageView = stackView.subviews.firstObject;
    UILabel *label = stackView.subviews.lastObject;

    CGFloat contentWidth = imageView.image.size.width;

    if (!label.isHidden) {
        CGFloat labelWidth = [self labelWidthFromString:label.text];
        contentWidth += labelWidth - kHorizontalPadding;
    }

    return contentWidth;
}

- (void)moveSelectorToView:(UIView *)view {

    int longCharacterStrings = 0;
    for (UIView *view in self.mainStackView.subviews) {
        UILabel *label = view.subviews.lastObject;
        if (label.text.length > 5) {
            longCharacterStrings++;
        }
    }

    CGFloat xPosition = view.frame.origin.x + kSelectorPadding;
    CGFloat yPosition = kSelectorPadding;
    CGFloat width = view.bounds.size.width + kHorizontalPadding * 2 - kSelectorPadding * 2;
    CGFloat height = kSectionHeight - (kSelectorPadding * 2);

    if (self.scrollView.contentSize.width <= UIScreen.mainScreen.bounds.size.width) {
        xPosition += kHorizontalPadding;
    }

    if (self.mainStackView.subviews.count == 2) {
        xPosition += kHorizontalPadding;
        width += kHorizontalPadding * 2 + kSelectorPadding / 2;
        xPosition -= kHorizontalPadding / 2 * longCharacterStrings;
    }

    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         self.selectorView.frame = CGRectMake(xPosition, yPosition, width, height);
                     }];
}

- (void)view:(UIView *)view shouldHide:(BOOL)shouldHide withDuration:(double)duration {
    [UIView animateWithDuration:duration
                     animations:^{
                         view.hidden = shouldHide;
                     }];
}

- (void)hideLabelsExceptLabel:(UILabel *)selectedLabel withDuration:(double)duration {
    for (UIStackView *stackView in self.mainStackView.arrangedSubviews) {
        UILabel *label = stackView.arrangedSubviews.lastObject;
        if (!label.isHidden && label != selectedLabel) {
            [self view:label shouldHide:YES withDuration:duration];
        }
    }
}

- (UIImageView *)configuredImageViewFromImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    CGFloat aspectRatio = imageView.image.size.width / imageView.image.size.height;

    [NSLayoutConstraint activateConstraints:@[
        [imageView.heightAnchor constraintEqualToConstant:kImageHeight],
        [imageView.widthAnchor constraintEqualToAnchor:imageView.heightAnchor
                                            multiplier:aspectRatio],
    ]];

    return imageView;
}

- (UILabel *)configuredLabelWithText:(NSString *)text {
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = self.theme.jpBlackColor;
    label.font = self.theme.headline;
    label.contentMode = UIViewContentModeScaleAspectFit;
    return label;
}

- (UIStackView *)stackViewFromImage:(UIImage *)image
                          andString:(NSString *)string {

    UIStackView *stackView = [UIStackView new];
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = kStackViewSpacing;

    UIImageView *imageView = [self configuredImageViewFromImage:image];

    UILabel *label = [self configuredLabelWithText:string];
    label.hidden = (self.mainStackView.subviews.count != 0);

    [stackView addArrangedSubview:imageView];
    [stackView addArrangedSubview:label];

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

- (CGFloat)calculateBackgroundWidth {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat backgroundViewWidth = screenWidth - (kHorizontalPadding * 2);

    if (self.mainStackView.subviews.count == 2) {
        backgroundViewWidth = screenWidth - (kHorizontalPadding * 4);
        [self appendLongTextWidthForContentWidth:backgroundViewWidth];
    }
    return backgroundViewWidth;
}

- (CGFloat)calculateMainStackViewWidth {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat mainStackViewWidth = screenWidth - (kHorizontalPadding * 2) - kContentPadding;

    if (self.mainStackView.subviews.count == 2) {
        mainStackViewWidth = screenWidth - (kHorizontalPadding * 6) - kContentPadding;
        [self appendLongTextWidthForContentWidth:mainStackViewWidth];
    }
    return mainStackViewWidth;
}

- (void)appendLongTextWidthForContentWidth:(CGFloat)contentWidth {
    for (UIView *view in self.mainStackView.subviews) {
        UILabel *label = view.subviews.lastObject;
        if (label.text.length > 5) {
            contentWidth += kHorizontalPadding;
        }
    }
}

- (void)layoutUnscrollableContent {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;

    self.scrollView.contentSize = CGSizeMake(screenWidth, kSectionHeight);
    self.scrollView.contentInset = UIEdgeInsetsZero;

    CGFloat mainStackViewWidth = [self calculateMainStackViewWidth];
    CGFloat backgroundViewWidth = [self calculateBackgroundWidth];

    self.backgroundView.frame = CGRectMake(0, 0, backgroundViewWidth, kSectionHeight);
    self.backgroundView.center = CGPointMake(screenWidth / 2, self.backgroundView.center.y);

    self.mainStackView.frame = CGRectMake(0, 0, mainStackViewWidth, kSectionHeight);
    self.mainStackView.center = CGPointMake(screenWidth / 2, self.backgroundView.center.y);

    [self setInitialSelectorPosition];
}

- (void)layoutScrollableContent {

    self.scrollView.contentSize = CGSizeMake(self.contentWidth, kSectionHeight);
    self.scrollView.contentOffset = CGPointMake(-kHorizontalPadding, 0);
    self.scrollView.contentInset = UIEdgeInsetsMake(0, kHorizontalPadding, 0, kHorizontalPadding);

    self.backgroundView.frame = CGRectMake(0, 0, self.contentWidth, kSectionHeight);

    CGFloat mainStackViewWidth = self.contentWidth - (kHorizontalPadding * 2);
    self.mainStackView.frame = CGRectMake(kHorizontalPadding, 0, mainStackViewWidth, kSectionHeight);

    [self setInitialSelectorPosition];
}

#pragma mark - Lazy properties

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.layer.cornerRadius = kBackgroundViewCornerRadius;
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
        _selectorView.backgroundColor = UIColor.whiteColor;
        _selectorView.layer.cornerRadius = kSelectorViewCornerRadius;
        _selectorView.layer.shadowRadius = 1.0f;
        _selectorView.layer.shadowOffset = CGSizeMake(0, 2);
        _selectorView.layer.shadowOpacity = 1.0f;
        _selectorView.layer.shadowColor = UIColor.jpGrayColor.CGColor;
    }
    return _selectorView;
}

@end
