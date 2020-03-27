//
//  JPScrollableSectionView.m
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

@interface JPSectionView ()

@property (nonatomic, strong) JPTheme *theme;
@property (nonatomic, strong) NSArray<JPSection *> *sections;
@property (nonatomic, assign) CGFloat contentWidth;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIStackView *contentStackView;
@property (nonatomic, strong) UIView *sliderView;

@end

@implementation JPSectionView

#pragma mark - Constants

static const float kBackgroundPadding = 24.0f;
static const float kBackgroundCornerRadius = 14.0f;
static const float kContentPadding = 4.0f;
static const float kContentHeight = 25.0f;
static const float kAnimationDuration = 0.3f;
static const float kSectionWidth = 120.0f;
static const float kSectionHeight = 64.0f;
static const float kSliderCornerRadius = 10.0f;

#pragma mark - Initializers

- (instancetype)initWithSections:(NSArray<JPSection *> *)sections
                        andTheme:(nonnull JPTheme *)theme {
    if (self = [super init]) {
        self.theme = theme;
        self.sections = sections;

        [self setupViews];
        [self setupConstraints];
        [self setupGestureRecognizers];
        [self setupSections];
    }
    return self;
}

#pragma mark - Layout setup

- (void)setupViews {
    [self.scrollView addSubview:self.backgroundView];
    [self.scrollView addSubview:self.sliderView];
    [self.scrollView addSubview:self.contentStackView];

    [self addSubview:self.scrollView];
}

- (void)setupConstraints {
    NSArray *constraints = @[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    ];

    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupGestureRecognizers {
    UITapGestureRecognizer *tapGesture;
    SEL tapSelector = @selector(didTapSectionView:);
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                         action:tapSelector];
    [self.contentStackView addGestureRecognizer:tapGesture];
}

- (void)setupSections {
    for (JPSection *section in self.sections) {
        [self addSectionWithImage:section.image
                         andTitle:section.title];
    }
}

#pragma mark - User actions

- (void)didTapSectionView:(UITapGestureRecognizer *)sender {
    CGPoint tapLocation = [sender locationInView:self.contentStackView];
    NSUInteger sectionIndex = (NSUInteger)(tapLocation.x / self.adaptiveSectionWidth);
    [self switchToSectionAtIndex:sectionIndex];
    [self.delegate sectionView:self didSelectSectionAtIndex:sectionIndex];
}

#pragma mark - Public methods

- (void)addSectionWithImage:(UIImage *)image
                   andTitle:(NSString *)title {

    self.contentWidth += self.adaptiveSectionWidth;

    self.scrollView.contentSize = CGSizeMake(self.contentWidth, kSectionHeight);
    self.backgroundView.frame = CGRectMake(0, 0, self.contentWidth, kSectionHeight);
    self.contentStackView.frame = CGRectMake(0, 0, self.contentWidth, kSectionHeight);
    self.sliderView.frame = CGRectMake(kContentPadding,
                                       kContentPadding,
                                       self.adaptiveSectionWidth - kContentPadding * 2,
                                       kSectionHeight - kContentPadding * 2);

    UIStackView *horizontalStackView = [self generateHorizontalStackView];
    UIStackView *verticalStackView = [self generateVerticalStackView];

    UIImageView *imageView = [self generateSectionImageViewFromImage:image];
    [horizontalStackView addArrangedSubview:imageView];

    if (title && title.length > 0) {
        UILabel *label = [self generateSectionLabelWithTitle:title];
        label.hidden = self.contentStackView.subviews.count > 0;
        [horizontalStackView addArrangedSubview:label];
    }

    [verticalStackView addArrangedSubview:horizontalStackView];
    [self.contentStackView addArrangedSubview:verticalStackView];
}

- (void)switchToSectionAtIndex:(NSUInteger)index {
    [self moveSliderToIndex:index];
    [self revealSectionTitleAtIndex:index];
}

#pragma mark - Helper methods

- (void)moveSliderToIndex:(NSUInteger)index {

    CGFloat xPosition = kContentPadding + index * self.adaptiveSectionWidth;
    CGFloat yPosition = kContentPadding;
    CGFloat width = self.adaptiveSectionWidth - kContentPadding * 2;
    CGFloat height = kSectionHeight - kContentPadding * 2;

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         weakSelf.sliderView.frame = CGRectMake(xPosition, yPosition, width, height);
                     }];
}

- (void)revealSectionTitleAtIndex:(NSUInteger)index {
    NSUInteger currentIndex = 0;
    for (UIStackView *verticalStackView in self.contentStackView.subviews) {

        UILabel *label = [self labelForVerticalStackView:verticalStackView];
        BOOL shouldHideLabel = (currentIndex != index);

        if (label.isHidden != shouldHideLabel) {
            [UIView animateWithDuration:kAnimationDuration
                             animations:^{
                                 label.hidden = shouldHideLabel;
                             }];
        }
        currentIndex++;
    }
}

#pragma mark - Getters

- (CGFloat)adaptiveSectionWidth {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;

    if (self.sections.count * kSectionWidth > screenWidth) {
        return kSectionWidth;
    }

    return (screenWidth - kBackgroundPadding * 2) / self.sections.count;
}

- (UIImageView *)generateSectionImageViewFromImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    CGFloat aspectRatio = imageView.image.size.width / imageView.image.size.height;

    NSArray *constraints = @[
        [imageView.heightAnchor constraintEqualToConstant:kContentHeight],
        [imageView.widthAnchor constraintEqualToAnchor:imageView.heightAnchor
                                            multiplier:aspectRatio]
    ];

    [NSLayoutConstraint activateConstraints:constraints];

    return imageView;
}

- (UILabel *)generateSectionLabelWithTitle:(NSString *)title {
    UILabel *label = [UILabel new];
    label.text = title;
    label.contentMode = UIViewContentModeScaleAspectFit;
    label.textColor = self.theme.jpBlackColor;
    label.font = self.theme.headline;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

- (UIStackView *)generateHorizontalStackView {
    UIStackView *stackView = [UIStackView new];
    stackView.spacing = kContentPadding;
    stackView.alignment = UIStackViewAlignmentCenter;
    return stackView;
}

- (UIStackView *)generateVerticalStackView {
    UIStackView *stackView = [UIStackView new];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.alignment = UIStackViewAlignmentCenter;
    return stackView;
}

- (UILabel *)labelForVerticalStackView:(UIStackView *)stackView {
    UIStackView *horizontalStackView = stackView.subviews.firstObject;
    if ([horizontalStackView.subviews.lastObject isKindOfClass:UILabel.class]) {
        return horizontalStackView.subviews.lastObject;
    }
    return nil;
}

#pragma mark - Lazy properties

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.contentOffset = CGPointMake(-kBackgroundPadding, 0);
        _scrollView.contentInset = UIEdgeInsetsMake(0, kBackgroundPadding, 0, kBackgroundPadding);
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = UIColor.jpLightGrayColor;
        _backgroundView.layer.cornerRadius = kBackgroundCornerRadius;
    }
    return _backgroundView;
}

- (UIStackView *)contentStackView {
    if (!_contentStackView) {
        _contentStackView = [UIStackView new];
        _contentStackView.distribution = UIStackViewDistributionFillEqually;
    }
    return _contentStackView;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [UIView new];
        _sliderView.translatesAutoresizingMaskIntoConstraints = NO;
        _sliderView.backgroundColor = UIColor.jpWhiteColor;
        _sliderView.layer.cornerRadius = kSliderCornerRadius;
        _sliderView.layer.shadowRadius = 1.0f;
        _sliderView.layer.shadowOffset = CGSizeMake(0, 2);
        _sliderView.layer.shadowOpacity = 1.0f;
        _sliderView.layer.shadowColor = UIColor.jpGrayColor.CGColor;
    }
    return _sliderView;
}

@end
