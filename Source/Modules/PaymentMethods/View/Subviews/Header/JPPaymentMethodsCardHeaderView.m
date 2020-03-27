//
//  JPPaymentMethodsCardHeaderView.m
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

#import "JPPaymentMethodsCardHeaderView.h"
#import "Functions.h"
#import "JPCardView.h"
#import "JPPaymentMethodsViewModel.h"

@interface JPPaymentMethodsCardHeaderView ()
@property (nonatomic, strong) JPCardView *cardView;
@property (nonatomic, strong) JPTheme *theme;

@end

@implementation JPPaymentMethodsCardHeaderView

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    self.theme = theme;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    [self.cardView applyTheme:self.theme];
    [self animateCardChangeTransitionWithViewModel:viewModel];
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.cardView];

    CGFloat topConstant = 100.0 * getWidthAspectRatio();
    CGFloat bottomConstant = -10.0 * getWidthAspectRatio();

    [NSLayoutConstraint activateConstraints:@[
        [self.cardView.topAnchor constraintEqualToAnchor:self.topAnchor
                                                constant:topConstant],
        [self.cardView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor
                                                   constant:bottomConstant],
        [self.cardView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.cardView.widthAnchor constraintEqualToAnchor:self.cardView.heightAnchor
                                                multiplier:1.715],
    ]];
}

#pragma mark - Animations

- (void)animateCardChangeTransitionWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    switch (viewModel.animationType) {
        case AnimationTypeBottomToTop:
            [self animateBottomToTopCardChangeWithViewModel:viewModel];
            break;
        case AnimationTypeLeftToRight:
            [self animateLeftToRightCardChangeWithViewModel:viewModel];
            break;
        case AnimationTypeRightToLeft:
            [self animateRightToLeftCardChangeWithViewModel:viewModel];
            break;
        case AnimationTypeSetup:
            [self.cardView configureWithPaymentMethodModel:viewModel];
            [self animateCardSetup];
        case AnimationTypeNone:
            break;
    }
}

- (void)animateCardSetup {
    self.cardView.transform = CGAffineTransformMakeTranslation(0.0, 100.0);
    self.cardView.alpha = 0.0;

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3
                     animations:^{
                         weakSelf.cardView.alpha = 1.0;
                         weakSelf.cardView.transform = CGAffineTransformIdentity;
                     }];
}

- (void)animateBottomToTopCardChangeWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    JPCardView *oldCardView = self.cardView;

    CGPoint oldPosition = CGPointMake(0.0f, (self.cardView.frame.size.height + self.frame.size.width / 2));
    CGPoint newPosition = CGPointMake(0.0f, oldCardView.frame.size.height * 2);

    [self transitionCard:oldCardView
           withViewModel:viewModel
            fromPosition:oldPosition
              toPosition:newPosition];
}

- (void)animateRightToLeftCardChangeWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    JPCardView *oldCardView = self.cardView;

    CGPoint oldPosition = CGPointMake(-self.frame.size.width * 2, 0.0f);
    CGPoint newPosition = CGPointMake(self.frame.size.width - 30, 0.0f);

    [self transitionCard:oldCardView
           withViewModel:viewModel
            fromPosition:oldPosition
              toPosition:newPosition];
}

- (void)animateLeftToRightCardChangeWithViewModel:(JPPaymentMethodsHeaderModel *)viewModel {
    JPCardView *oldCardView = self.cardView;

    CGPoint oldPosition = CGPointMake(self.frame.size.width * 2, 0.0f);
    CGPoint newPosition = CGPointMake(-self.frame.size.width - 30, 0.0f);

    [self transitionCard:oldCardView
           withViewModel:viewModel
            fromPosition:oldPosition
              toPosition:newPosition];
}

#pragma mark - Helper Methods

- (void)prepareNewCardViewWithModel:(JPPaymentMethodsHeaderModel *)viewModel {
    self.cardView = [self createCardView];
    [self.cardView applyTheme:self.theme];
    [self.cardView configureWithPaymentMethodModel:viewModel];
    [self setupViews];
}

- (void)setInitialTransformationWithXPosition:(CGFloat)xPosition
                                 andYPosition:(CGFloat)yPosition {

    CGAffineTransform translation = CGAffineTransformMakeTranslation(xPosition, yPosition);
    CGAffineTransform scale = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);

    self.cardView.transform = CGAffineTransformConcat(translation, scale);
    [self layoutIfNeeded];
}

- (void)transitionCard:(JPCardView *)cardView
         withViewModel:(JPPaymentMethodsHeaderModel *)viewModel
          fromPosition:(CGPoint)oldPosition
            toPosition:(CGPoint)newPosition {

    [self prepareNewCardViewWithModel:viewModel];
    [self setInitialTransformationWithXPosition:oldPosition.x andYPosition:oldPosition.y];
    [self transitionFromCardView:cardView toXPosition:newPosition.x andYPosition:newPosition.y];
}

- (void)transitionFromCardView:(JPCardView *)cardView
                   toXPosition:(CGFloat)xPosition
                  andYPosition:(CGFloat)yPosition {

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5
        animations:^{
            [weakSelf transformOldCardView:cardView withXPosition:xPosition andYPosition:yPosition];
            [weakSelf transformNewCardView:weakSelf.cardView];
        }
        completion:^(BOOL finished) {
            [cardView removeFromSuperview];
        }];
}

- (void)transformNewCardView:(JPCardView *)cardView {
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0.0, 0.0);
    CGAffineTransform scale = CGAffineTransformMakeScale(1, 1);
    cardView.transform = CGAffineTransformConcat(translation, scale);
}

- (void)transformOldCardView:(JPCardView *)cardView
               withXPosition:(CGFloat)xPosition
                andYPosition:(CGFloat)yPosition {

    CGAffineTransform translation = CGAffineTransformMakeTranslation(xPosition, yPosition);
    CGAffineTransform scale = CGAffineTransformMakeScale(0.6, 0.6);

    cardView.transform = CGAffineTransformConcat(translation, scale);
    cardView.alpha = 0.0;
}

#pragma mark - Lazy Properties

- (JPCardView *)cardView {
    if (!_cardView) {
        _cardView = [self createCardView];
    }
    return _cardView;
}

- (JPCardView *)createCardView {
    JPCardView *updatedCardView = [JPCardView new];
    updatedCardView.translatesAutoresizingMaskIntoConstraints = NO;
    updatedCardView.layer.shadowColor = UIColor.grayColor.CGColor;
    updatedCardView.layer.shadowRadius = 10.0;
    updatedCardView.layer.shadowOffset = CGSizeMake(0, 4);
    updatedCardView.layer.shadowOpacity = 1.0;
    return updatedCardView;
}

@end
