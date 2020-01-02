//
//  JPCreditCardUI.m
//  JudoKitObjC
//
//  Created by Gheorghe Cojocaru on 12/24/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "JPCreditCardUI.h"
#import "RoundedCornerView.h"
#import "UIImage+Icons.h"
#import "JPPaymentMethodsViewModel.h"

@interface JPCreditCardUI()

@property(nonatomic,strong) JPPaymentMethodsCardModel *viewModel;

@property(nonatomic, strong) RoundedCornerView *creditCardView;

@property(nonatomic,strong) UIImage *cardProviderIcon;
@property(nonatomic,strong) UIImageView *cardProviderImageView;

@property(nonatomic,strong) UILabel *cardName;
@property(nonatomic,strong) UILabel *cardNumber;
@property(nonatomic,strong) UILabel *cardExpiryDate;

@end

@implementation JPCreditCardUI

- (instancetype)initWithViewModel:(JPPaymentMethodsCardModel*)viewModel {
    self = [super initWithFrame:CGRectZero];
    self.viewModel = viewModel;
    [self setup];
    return self;
}

-(void)setup{
    [self addCreditCardShadow];
    [self addSubview:self.creditCardView];
    self.cardProviderImageView = [[UIImageView alloc] initWithImage:self.cardProviderIcon];
    self.cardProviderImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardName.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardNumber.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardExpiryDate.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.cardProviderImageView];
    [self addSubview:self.cardName];
    self.cardName.text = self.viewModel.cardTitle;
    self.cardNumber.text = [NSString stringWithFormat: @"•••• •••• •••• %@", self.viewModel.cardNumberLastFour];
    self.cardExpiryDate.text = self.viewModel.expiryDate;
    [self addSubview:self.cardNumber];
    [self addSubview:self.cardExpiryDate];
    [self addCreditCardShadow];
    
    [self setupConstraints];
    [self addCreditCardShadow];
}

-(void)setupConstraints{
    [self.cardProviderImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:28].active = YES;
    [self.cardProviderImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:28].active = YES;
    [self.cardProviderImageView.heightAnchor constraintLessThanOrEqualToConstant:31].active = YES;
    [self.cardProviderImageView.widthAnchor constraintLessThanOrEqualToConstant:70].active = YES;
    
    [self.cardName.topAnchor constraintEqualToAnchor:self.cardProviderImageView.bottomAnchor constant:28].active = YES;
    [self.cardName.leadingAnchor constraintEqualToAnchor:self.cardProviderImageView.leadingAnchor].active = YES;
    
    [self.cardNumber.topAnchor constraintEqualToAnchor:self.cardName.bottomAnchor constant:40].active = YES;
    [self.cardNumber.leadingAnchor constraintEqualToAnchor:self.cardName.leadingAnchor].active = YES;
    
    [self.cardExpiryDate.topAnchor constraintEqualToAnchor:self.cardName.bottomAnchor constant:40].active = YES;
    [self.cardExpiryDate.leadingAnchor constraintEqualToAnchor:self.cardNumber.trailingAnchor constant:82].active = YES;
    
    [self.creditCardView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.creditCardView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.creditCardView.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
    [self.creditCardView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
}


-(void)addCreditCardShadow{
    self.creditCardView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.creditCardView.bounds cornerRadius:self.creditCardView.layer.cornerRadius].CGPath;
    self.creditCardView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.creditCardView.layer.shadowOpacity = 0.3;
    self.creditCardView.layer.shadowOffset = CGSizeMake(0.0f, 14.0f);
    self.creditCardView.layer.shadowRadius = 12;
    self.creditCardView.layer.masksToBounds = NO;
    self.creditCardView.clipsToBounds = NO;
}


- (RoundedCornerView* )creditCardView {
    if (!_creditCardView) {
        _creditCardView = [[RoundedCornerView alloc] initWithRadius:10 forCorners: UIRectCornerAllCorners];
        _creditCardView.translatesAutoresizingMaskIntoConstraints = NO;
        [_creditCardView setBackgroundColor: UIColor.greenColor];
    }
    return _creditCardView;
}

-(UIImage *)cardProviderIcon {
    if(!_cardProviderIcon) {
        _cardProviderIcon = [UIImage imageWithIconName:@"card-visa"];
    }
    return _cardProviderIcon;
}

-(UILabel *)cardName {
    if(!_cardName) {
        _cardName = [[UILabel alloc] init];
        _cardName.font = [UIFont boldSystemFontOfSize:18];
        _cardName.textColor = UIColor.whiteColor;
    }
    return _cardName;
}

-(UILabel *)cardNumber {
    if(!_cardNumber) {
        _cardNumber = [[UILabel alloc] init];
        _cardNumber.textColor = UIColor.whiteColor;
    }
    return _cardNumber;
    
}

-(UILabel *)cardExpiryDate {
    if(!_cardExpiryDate) {
        _cardExpiryDate = [[UILabel alloc] init];
        _cardExpiryDate.textColor = UIColor.whiteColor;
    }
    return _cardExpiryDate;
}






@end
