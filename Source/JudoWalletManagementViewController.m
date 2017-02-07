//
//  JudoWalletManagementViewController.m
//  JudoKitObjC
//
//  Copyright (c) 2016 Alternative Payments Ltd
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

#import "JudoWalletManagementViewController.h"
#import "UIColor+Judo.h"
#import "WalletService.h"
#import "InMemoryWalletRepository.h"
#import "JPWalletDelegate.h"
#import "CardLogoView.h"
#import "JudoKit.h"
#import "JPAmount.h"
#import "JudoWallet.h"
#import "JPCardDetails.h"
#import "NSError+Judo.h"

@interface JudoWalletManagementViewController()

@property (nonnull, nonatomic, strong) JudoWallet *judoWalletSession;
@property (nonnull, nonatomic, strong) WalletService *walletService;
@property (nonatomic, weak) id<JPWalletDelegate> delegate;

@property (nonatomic, strong, readwrite) UIScrollView *contentView;
@property (nonatomic, strong, readwrite) UIView *logoContainerView;

@end

@implementation JudoWalletManagementViewController

- (nonnull instancetype)initWithJudoKit:(nonnull JudoWallet *)judoWalletSession delegate:(nullable id<JPWalletDelegate>)delegate {
    self = [super init];
    
    if (self) {
        self.judoWalletSession = judoWalletSession;
        self.walletService = [[WalletService alloc] initWithWalletRepository:[InMemoryWalletRepository new]];
        self.delegate = delegate;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpView];
  //  [self setUpConstraints];
}

- (void)setUpView {
    self.view.backgroundColor = [self.judoWalletSession.judoKit.theme judoContentViewBackgroundColor];
    
    //[self.view addSubview:self.contentView];
    //self.contentView.contentSize = self.view.bounds.size;
    NSArray<WalletCard *> *walletCards = [self.walletService get];
    
     [self cardView];
}

- (void)setUpNavigationBar {
    self.title = @"Wallet";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.judoWalletSession.judoKit.theme.backButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController:)];
    //self.navigationItem.rightBarButtonItem = self.paymentNavBarButton;
    
    self.navigationController.navigationBar.tintColor = self.judoWalletSession.judoKit.theme.judoTextColor;
    
    if (![self.judoWalletSession.judoKit.theme.tintColor colorMode]) {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:self.judoWalletSession.judoKit.theme.judoNavigationBarTitleColor};
}

- (void)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpConstraints {
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:0 metrics:nil views:@{@"scrollView":self.contentView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]" options:0 metrics:nil views:@{@"scrollView":self.contentView}]];
    
}

- (UIView *)logoContainerView {
    if (!_logoContainerView) {
        _logoContainerView = [UIView new];
        _logoContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _logoContainerView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentView.directionalLockEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentView;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    JPAmount *amount = [JPAmount amount:@"0.01" currency:@"GBP"];
    [self.judoWalletSession.judoKit invokeRegisterCard:@"100915867" amount:amount consumerReference:[[NSUUID UUID] UUIDString] cardDetails:nil completion:^(JPResponse * response, NSError * error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        if (error && response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return; // BAIL
            }
            return; // BAIL
        }
        
        JPCardDetails *cardDetails = response.items[0].cardDetails;
        WalletCard *card = [[WalletCard alloc] initWithCardData:cardDetails.cardLastFour expiryDate:cardDetails.formattedExpiryDate cardToken:cardDetails.cardToken cardType:1 assignedName:@"" defaultPaymentMethod:NO];
        [self.walletService add:card];
        if (self.judoWalletSession.delegate) {
            [self.judoWalletSession.delegate didAddCardToWallet:card];
        }
    }];
}

- (void)cardView {
    CGRect rect = CGRectMake(13,80,self.view.frame.size.width - 26, 70);
    UIView *card = [[UIView alloc] initWithFrame:rect];
    card.translatesAutoresizingMaskIntoConstraints = NO;
    card.layer.borderColor = self.judoWalletSession.judoKit.theme.judoInputFieldBorderColor.CGColor;
    card.layer.borderWidth = 0.5;
    card.backgroundColor = [self.judoWalletSession.judoKit.theme judoContentViewBackgroundColor];
    card.layer.cornerRadius = 5.0;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [card addGestureRecognizer:singleFingerTap];
    
    UILabel *addCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    addCardLabel.translatesAutoresizingMaskIntoConstraints = NO;
    addCardLabel.numberOfLines = 0;
    addCardLabel.text = @"Add Card";
    addCardLabel.textColor = [UIColor blueColor];
    [addCardLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
    [card addSubview:addCardLabel];
    
    [self.view addSubview:card];
}

@end
