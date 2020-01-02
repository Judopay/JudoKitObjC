//
//  CardPreviewView.m
//  JudoKitObjC
//
//  Created by Gheorghe Cojocaru on 12/23/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "CardPreviewView.h"
#import "CardPreviewViewModel.h"
#import "UIImage+Icons.h"
#import "JPAddCardButton.h"
#import "UIColor+Judo.h"
#import "UIFont+Additions.h"
#import "JPCreditCardUI.h"
#import "NSString+Localize.h"



@interface CardPreviewView ()

@property (nonatomic, strong) UILabel *placeholderTitleLabel;
@property (nonatomic, strong) UILabel *placeholderTextLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *youWillPayLabel;
@property (nonatomic, strong) JPAddCardButton *payButton;
@property (nonatomic, strong) UIImageView *emptyCardPreviewBackgroundImageView;


@property (nonatomic, strong) UIStackView *placeholderTextStackView;
@property (nonatomic, strong) UIStackView *paymentStackView;
@property (nonatomic, strong) UIStackView *generalStackView;
@property (nonatomic, strong) UIStackView *amountStackView;

@property(nonatomic, strong) JPCreditCardUI *creditCardView;
@property(nonatomic, strong) JPCreditCardUI *secondaryCreditCardView;

@property(nonatomic, strong) NSLayoutConstraint *creditCardLeadingConstraint;
@property(nonatomic, strong) NSLayoutConstraint *creditCardHeightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *creditCardWidthConstraint;
@property(nonatomic, strong) NSLayoutConstraint *creditCardTopConstraint;

@end


@implementation CardPreviewView

- (instancetype)initWithViewModel:(CardPreviewViewModel*)viewModel {
    self = [super initWithFrame:CGRectZero];
    self.viewModel = viewModel;
    [self setupUI];
    return self;
}

-(void) setupUI {
    self.backgroundColor = UIColor.whiteColor;
    self.placeholderTitleLabel.text = @"choose_payment_method".localized;
    self.placeholderTextLabel.text = @"no_cards_added".localized;
    self.amountLabel.text =  [NSString stringWithFormat:@"%@ %@", self.viewModel.amount.currency, self.viewModel.amount.amount];
    self.youWillPayLabel.text = @"you_will_pay".localized;
    self.generalStackView.translatesAutoresizingMaskIntoConstraints = NO;
    JPAddCardButtonViewModel *payButtonViewModel = [JPAddCardButtonViewModel new];
    payButtonViewModel.isEnabled = (self.viewModel.payButtonSel != nil);
    payButtonViewModel.title = self.viewModel.payButtonTitle;
    [self.payButton configureWithViewModel:payButtonViewModel];
    [self.payButton addTarget:self action:self.viewModel.payButtonSel forControlEvents:UIControlEventTouchDown];
    [self setupGeneralStackView];
    [self setBackgroundColorForPaymentStackView];
    if(self.viewModel.cardModel) {
        [self setupCreditCardView];
    } else {
        [self setupEmptyView];
    }
    [self addSubview: self.generalStackView];
    [self setupConstraints];
}

-(void)setupEmptyView{
    [self.placeholderTextStackView addArrangedSubview:self.placeholderTitleLabel];
    [self.placeholderTextStackView addArrangedSubview:self.placeholderTextLabel];
    [self setupBackgroundImage];
    self.placeholderTextStackView.backgroundColor = UIColor.clearColor;
    
}

-(void)addCardViewConstraints {
    [self addConstraints: @[self.creditCardLeadingConstraint, self.creditCardHeightConstraint, self.creditCardTopConstraint, self.creditCardWidthConstraint]];
}

-(void)removeEmptyView{
    for (UIView *view in [self.placeholderTextStackView subviews])
    {
        [view removeFromSuperview];
    }
    [self.emptyCardPreviewBackgroundImageView removeFromSuperview];
}

-(void)setupBackgroundImage {
    UIImage *emptyCardPreviewBackgroundImage = [UIImage imageWithResourceName:@"NoCards"];
    self.emptyCardPreviewBackgroundImageView = [[UIImageView alloc]initWithImage:emptyCardPreviewBackgroundImage];
    self.emptyCardPreviewBackgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.emptyCardPreviewBackgroundImageView];
    [self.emptyCardPreviewBackgroundImageView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active = YES;
    [self.emptyCardPreviewBackgroundImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
    [self.emptyCardPreviewBackgroundImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:10].active = YES;
}

-(void) setupConstraints {
    [self.generalStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:24].active = true;
    [self.generalStackView.trailingAnchor  constraintEqualToAnchor:self.trailingAnchor constant:-24].active = true;
    [self.generalStackView.topAnchor  constraintEqualToAnchor:self.topAnchor constant:35].active = true;
    [self.generalStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-15].active = true;
    
    
    [self.payButton.heightAnchor constraintEqualToConstant:45].active = YES;
    [self.payButton.trailingAnchor constraintEqualToAnchor:self.generalStackView.trailingAnchor].active = YES;
    [self.payButton.leadingAnchor constraintEqualToAnchor:self.amountStackView.trailingAnchor].active = YES;
    
    [self.amountStackView.topAnchor constraintEqualToAnchor:self.paymentStackView.topAnchor].active = YES;
    [self.amountStackView.bottomAnchor constraintEqualToAnchor:self.paymentStackView.bottomAnchor].active = YES;
    
}

-(void)setupGeneralStackView{
    [self.amountStackView addArrangedSubview:self.youWillPayLabel];
    [self.amountStackView addArrangedSubview: self.amountLabel];
    
    [self.paymentStackView addArrangedSubview: self.amountStackView];
    [self.paymentStackView addArrangedSubview: self.payButton];
    
    [self.generalStackView addArrangedSubview:self.placeholderTextStackView];
    [self.generalStackView addArrangedSubview:self.paymentStackView];
}

-(void)setupCreditCardView{
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = UIColor.whiteColor;
    backgroundView.frame = self.placeholderTextStackView.frame;
    [self.placeholderTextStackView insertSubview:backgroundView atIndex:0];
    [self addSubview:self.creditCardView];
    self.placeholderTextStackView.backgroundColor = UIColor.whiteColor;
    self.placeholderTextStackView.distribution = UIStackViewAlignmentCenter;
    [self addCardViewConstraints];
}


-(void)setBackgroundColorForPaymentStackView {
    if(self.paymentStackView.subviews.count < 4) {
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        backgroundView.frame = self.paymentStackView.bounds;
        [self.paymentStackView insertSubview:backgroundView atIndex:0];
        
        [backgroundView.leadingAnchor constraintEqualToAnchor:self.paymentStackView.leadingAnchor constant:0].active = true;
        [backgroundView.trailingAnchor  constraintEqualToAnchor:self.paymentStackView.trailingAnchor constant:0].active = true;
        [backgroundView.topAnchor  constraintEqualToAnchor:self.paymentStackView.topAnchor constant:-15].active = true;
        [backgroundView.bottomAnchor constraintEqualToAnchor:self.paymentStackView.bottomAnchor constant:25].active = true;
        
        [self layoutIfNeeded];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = backgroundView.bounds;
        gradient.locations = @[@0.0, @0.1 , @1.0];
        gradient.colors = @[(id)[UIColor colorWithWhite:1 alpha:0.1].CGColor, (id)[UIColor colorWithWhite:1 alpha:0.9].CGColor, (id)[UIColor colorWithWhite:1 alpha:1].CGColor];
        [backgroundView.layer insertSublayer:gradient atIndex:0];
    }
}

- (void)changePaymentMethodPreview:(CardPreviewViewModel*)viewModel animtionType:(CardPrevieAnimationType)animationType {
    [self removeEmptyView];
    [self prepareCreditCardsForAnimation:viewModel];
    
    CGFloat creditCardLeadingConstraintConstant = 0;
    CGFloat creditCardTopConstraintConstant = 20;
    CGFloat creditCardAlpha = 0;
    NSLayoutConstraint *secondaryCreditCardTopConstraint = [NSLayoutConstraint constraintWithItem:self.secondaryCreditCardView
                                                                                        attribute:NSLayoutAttributeTop
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:self
                                                                                        attribute:NSLayoutAttributeTop
                                                                                       multiplier:1.0
                                                                                         constant:20];
    secondaryCreditCardTopConstraint.active = YES;
    switch (animationType) {
        case AnimateLeftTeRight:
            [self.secondaryCreditCardView.leadingAnchor constraintEqualToAnchor:self.creditCardView.trailingAnchor constant:24].active = YES;
            creditCardLeadingConstraintConstant = -UIScreen.mainScreen.bounds.size.width + 24;
            [self.secondaryCreditCardView.centerYAnchor constraintEqualToAnchor:self.creditCardView.centerYAnchor].active = YES;
            break;
        case AnimateRightToLeft:
            [self.secondaryCreditCardView.trailingAnchor constraintEqualToAnchor:self.creditCardView.leadingAnchor constant:-24].active = YES;
            creditCardLeadingConstraintConstant = UIScreen.mainScreen.bounds.size.width - 24;
            [self.secondaryCreditCardView.centerYAnchor constraintEqualToAnchor:self.creditCardView.centerYAnchor].active = YES;
            break;
        case AnimateBottomToTop:
            [self.secondaryCreditCardView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
            [self.creditCardView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
            self.creditCardLeadingConstraint = nil;
            creditCardTopConstraintConstant = self.frame.size.height;
            secondaryCreditCardTopConstraint.constant = self.frame.size.height/2;
            creditCardAlpha = 0.5;
            
        default:
            break;
    }
    [self.secondaryCreditCardView.heightAnchor constraintEqualToAnchor:self.creditCardView.heightAnchor].active = YES;
    [self.secondaryCreditCardView.widthAnchor constraintEqualToAnchor:self.creditCardView.widthAnchor].active = YES;
    self.secondaryCreditCardView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
    
    [UIView animateWithDuration:0 animations:^{
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5  animations:^{
            self.creditCardLeadingConstraint.constant = creditCardLeadingConstraintConstant;
            self.creditCardTopConstraint.constant = creditCardTopConstraintConstant;
            secondaryCreditCardTopConstraint.constant = 20;
            self.creditCardView.alpha = creditCardAlpha;
            self.secondaryCreditCardView.alpha = 1;
            self.creditCardView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
            self.secondaryCreditCardView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self resetCreditCards];
        }];
    }];
    [self setNeedsDisplay];
}

-(void)prepareCreditCardsForAnimation:(CardPreviewViewModel*)viewModel {
    self.viewModel = viewModel;
    [self setupUI];
    [self setNeedsDisplay];
    [self layoutIfNeeded];
    self.secondaryCreditCardView  = [[JPCreditCardUI alloc]initWithViewModel:viewModel.cardModel];
    self.secondaryCreditCardView.alpha = 0.0;
    self.secondaryCreditCardView.translatesAutoresizingMaskIntoConstraints = NO;
    NSInteger payementStackViewBackgroundView = self.paymentStackView.subviews[0].layer.zPosition;
    [self insertSubview:self.secondaryCreditCardView atIndex: payementStackViewBackgroundView+1];
    [self addCardViewConstraints];
}

-(void)resetCreditCards{
    [self.creditCardView removeFromSuperview];
    self.creditCardView = nil;
    self.creditCardView = self.secondaryCreditCardView;
    self.secondaryCreditCardView = nil;
    [self.secondaryCreditCardView removeFromSuperview];
    [self addSubview:self.creditCardView];
    [self removeConstraints:self.constraints];
    self.creditCardHeightConstraint = nil;
    self.creditCardLeadingConstraint = nil;
    self.creditCardWidthConstraint = nil;
    self.creditCardTopConstraint = nil;
    [self setupConstraints];
    [self addCardViewConstraints];
}


#pragma mark - Lazy intantiated properties

- (UILabel *)placeholderTitleLabel {
    if (!_placeholderTitleLabel) {
        _placeholderTitleLabel = [UILabel new];
        _placeholderTitleLabel.numberOfLines = 0;
        _placeholderTitleLabel.font = [UIFont boldSystemFontOfSize:18];
        _placeholderTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _placeholderTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _placeholderTitleLabel;
}

- (UILabel *)placeholderTextLabel {
    if (!_placeholderTextLabel) {
        _placeholderTextLabel = [UILabel new];
        _placeholderTextLabel.numberOfLines = 0;
        _placeholderTextLabel.font = [UIFont systemFontOfSize:14];
        _placeholderTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _placeholderTextLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _placeholderTextLabel;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [UILabel new];
        _amountLabel.numberOfLines = 0;
        _amountLabel.font = [UIFont boldSystemFontOfSize:24];
        _amountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _amountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _amountLabel;
}

- (UILabel *)youWillPayLabel {
    if (!_youWillPayLabel) {
        _youWillPayLabel = [UILabel new];
        _youWillPayLabel.numberOfLines = 0;
        _youWillPayLabel.font = [UIFont boldSystemFontOfSize:14];
        _youWillPayLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _youWillPayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _youWillPayLabel;
}

-(UIStackView *)generalStackView {
    if(!_generalStackView) {
        _generalStackView = [[UIStackView alloc] init];
        _generalStackView.axis = UILayoutConstraintAxisVertical;
        _generalStackView.distribution = UIStackViewDistributionEqualSpacing;
        _generalStackView.alignment = UIStackViewAlignmentLeading;
        _generalStackView.spacing = 50;
    }
    return  _generalStackView;
}

-(UIStackView *)placeholderTextStackView {
    if(!_placeholderTextStackView) {
        _placeholderTextStackView = [[UIStackView alloc] init];
        _placeholderTextStackView.axis = UILayoutConstraintAxisVertical;
        _placeholderTextStackView.distribution = UIStackViewDistributionEqualSpacing;
        _placeholderTextStackView.alignment = UIStackViewAlignmentLeading;
        _placeholderTextStackView.spacing = 4;
    }
    return  _placeholderTextStackView;
}

-(UIStackView *)paymentStackView {
    if(!_paymentStackView) {
        _paymentStackView = [[UIStackView alloc] init];
        _paymentStackView.axis = UILayoutConstraintAxisHorizontal;
        _paymentStackView.distribution = UIStackViewDistributionFillEqually;
        _paymentStackView.alignment = UIStackViewAlignmentTop;
        _paymentStackView.spacing = 0;
    }
    return  _paymentStackView;
}


-(UIStackView *)amountStackView {
    if(!_amountStackView) {
        _amountStackView = [[UIStackView alloc] init];
        _amountStackView.axis = UILayoutConstraintAxisVertical;
        _amountStackView.distribution = UIStackViewDistributionEqualSpacing;
        _amountStackView.alignment = UIStackViewAlignmentTop;
        _amountStackView.spacing = 0;
    }
    return  _amountStackView;
}


- (JPAddCardButton *)payButton {
    if (!_payButton) {
        _payButton = [JPAddCardButton new];
        _payButton.translatesAutoresizingMaskIntoConstraints = NO;
        _payButton.layer.cornerRadius = 4.0f;
        _payButton.titleLabel.font = UIFont.largeTitleFont;
        _payButton.backgroundColor = UIColor.jpGrayColor;
    }
    return _payButton;
}

-(JPCreditCardUI *) creditCardView {
    if(!_creditCardView) {
        _creditCardView = [[JPCreditCardUI alloc] initWithViewModel:self.viewModel.cardModel];
        _creditCardView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _creditCardView;
}

-(NSLayoutConstraint *) creditCardLeadingConstraint {
    if(!_creditCardLeadingConstraint){
        
        _creditCardLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.creditCardView
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.generalStackView
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1.0
                                                                     constant:0];
        _creditCardLeadingConstraint.active = YES;
    }
    return _creditCardLeadingConstraint;
}

-(NSLayoutConstraint *) creditCardHeightConstraint {
    if(!_creditCardHeightConstraint){
        
        _creditCardHeightConstraint = [NSLayoutConstraint constraintWithItem:self.creditCardView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.generalStackView
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:0.58
                                                                    constant:0];
        _creditCardHeightConstraint.active = YES;
    }
    return _creditCardHeightConstraint;
}

-(NSLayoutConstraint *) creditCardWidthConstraint {
    if(!_creditCardWidthConstraint){
        
        _creditCardWidthConstraint = [NSLayoutConstraint constraintWithItem:self.creditCardView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.generalStackView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:0];
        _creditCardWidthConstraint.active = YES;
    }
    return _creditCardWidthConstraint;
}


-(NSLayoutConstraint *) creditCardTopConstraint {
    if(!_creditCardTopConstraint){
        
        _creditCardTopConstraint = [NSLayoutConstraint constraintWithItem:self.creditCardView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:20];
        _creditCardTopConstraint.active = YES;
    }
    return _creditCardTopConstraint;
}



@end
