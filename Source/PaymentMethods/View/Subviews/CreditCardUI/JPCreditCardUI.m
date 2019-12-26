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


@interface JPCreditCardUI()

@property(nonatomic, strong) RoundedCornerView *creditCardView;
@property(nonatomic,strong) UIImage *cardProviderIcon;
@property(nonatomic,strong) UIImageView *cardProviderImageView;
@property(nonatomic,strong) UILabel *cardName;
@property(nonatomic,strong) UILabel *cardNumber;
@property(nonatomic,strong) UILabel *cardExpiryDate;



@end


@implementation JPCreditCardUI

- (instancetype)init{
self = [super initWithFrame:CGRectZero];
[self setup];
return self;
}


-(void)setup{
    [self addSubview:self.creditCardView];
    self.cardProviderImageView = [[UIImageView alloc] initWithImage:self.cardProviderIcon];
    self.cardProviderImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardName.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardNumber.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardExpiryDate.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:_cardProviderImageView];
    [self addSubview:self.cardName];
    self.cardName.text = @"Card for online shopping";
    self.cardNumber.text = @"•••• •••• •••• 1122";
    self.cardExpiryDate.text = @"12/22";

    [self addSubview:self.cardNumber];
    [self addSubview:self.cardExpiryDate];
    
    [self setupConstraints];
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
    


}




- (RoundedCornerView* )creditCardView {
    if (!_creditCardView) {
        _creditCardView = [[RoundedCornerView alloc] initWithRadius:10 forCorners: UIRectCornerAllCorners];
        [_creditCardView setBackgroundColor: UIColor.greenColor];
        [_creditCardView setFrame:CGRectMake(0, 0, 327, 190)];
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
