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
#import "CardLogoView.h"
#import "CardInputField.h"

@interface JudoWalletManagementViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonnull, nonatomic, strong) JudoWallet *judoWalletSession;
@property (nonnull, nonatomic, strong) WalletService *walletService;
@property (nonnull, nonatomic, strong) NSMutableArray<WalletCard *> *walletCards;

@property (nonnull, nonatomic, strong) UIView *logoContainerView;
@property (nonnull, nonatomic, strong) UITableView *cardsTableView;

@end

@implementation JudoWalletManagementViewController

- (nonnull instancetype)initWithJudoWallet:(nonnull JudoWallet *)judoWalletSession {
    self = [super init];
    
    if (self) {
        self.judoWalletSession = judoWalletSession;
        self.walletService = [[WalletService alloc] initWithWalletRepository:[InMemoryWalletRepository new]];
        self.walletCards = [NSMutableArray new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpView];
}

- (void)setUpView {
    self.view.backgroundColor = [self.judoWalletSession.judoKit.theme judoContentViewBackgroundColor];
    [self.view addSubview:self.cardsTableView];
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

#pragma mark - Card views

- (UIView *)generateAddCardView {
    CGRect rect = CGRectMake(0, 0, self.cardsTableView.frame.size.width, 70);
    UIView *card = [[UIView alloc] initWithFrame:rect];
    card.translatesAutoresizingMaskIntoConstraints = NO;
    card.layer.borderColor = self.judoWalletSession.judoKit.theme.judoInputFieldBorderColor.CGColor;
    card.layer.borderWidth = 0.5;
    card.backgroundColor = [self.judoWalletSession.judoKit.theme judoContentViewBackgroundColor];
    card.layer.cornerRadius = 5.0;
    
    /*UIView *logoView = [[CardLogoView alloc] initWithType:[CardInputField cardLogoTypeForNetworkType:CardNetworkUnknown]];
    logoView.frame = CGRectMake(0,0, 46, 30);
    [self.logoContainerView addSubview:logoView];
    [card addSubview:self.logoContainerView];
    */

    //UIView *logoView = [[CardLogoView alloc] initWithType:[CardInputField cardLogoTypeForNetworkType:CardNetworkUnknown]];
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectZero];
    logoView.frame = CGRectMake(0, 0, 69, 45);
    logoView.translatesAutoresizingMaskIntoConstraints = NO;
    logoView.clipsToBounds = YES;
    logoView.layer.cornerRadius = 2;
    logoView.backgroundColor = [UIColor redColor];
    [card addSubview:logoView];
    
    /*UILabel *addCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    addCardLabel.translatesAutoresizingMaskIntoConstraints = NO;
    addCardLabel.numberOfLines = 0;
    addCardLabel.text = @"Add Card";
    [addCardLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [card addSubview:addCardLabel];
    */
    return card;
}

- (UIView *)generateUpdateCardView {
    CGRect rect = CGRectMake(0, 0, self.cardsTableView.frame.size.width, 70);
    UIView *card = [[UIView alloc] initWithFrame:rect];
    card.translatesAutoresizingMaskIntoConstraints = NO;
    card.layer.borderColor = self.judoWalletSession.judoKit.theme.judoInputFieldBorderColor.CGColor;
    card.layer.borderWidth = 0.5;
    card.backgroundColor = [self.judoWalletSession.judoKit.theme judoContentViewBackgroundColor];
    card.layer.cornerRadius = 5.0;
    
    UILabel *addCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    addCardLabel.translatesAutoresizingMaskIntoConstraints = NO;
    addCardLabel.numberOfLines = 0;
    addCardLabel.text = @"Update Card";
    [addCardLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [card addSubview:addCardLabel];
    
    return card;
}

#pragma mark - Lazy loading

- (UITableView *)cardsTableView {
    if (!_cardsTableView) {
        _cardsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _cardsTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardsTableView.delegate = self;
        _cardsTableView.dataSource = self;
        _cardsTableView.backgroundColor = [UIColor clearColor];
        _cardsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _cardsTableView.frame = CGRectMake(13, 0, self.view.frame.size.width - 26, self.view.frame.size.height);
    }
    return _cardsTableView;
}

- (UIView *)logoContainerView {
    if (!_logoContainerView) {
        _logoContainerView = [UIView new];
        _logoContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        _logoContainerView.clipsToBounds = YES;
        _logoContainerView.layer.cornerRadius = 2;
    }
    return _logoContainerView;
}

#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    //Number of cards plus add card cell.
    return self.walletCards.count + 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"cell";

    UITableViewCell *cell = (UITableViewCell *)[self.cardsTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UIView *card = indexPath.section < self.walletCards.count ? [self generateUpdateCardView] : [self generateAddCardView];
    [cell addSubview:card];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    indexPath.section < self.walletCards.count ? [self displayUpdateCardScreen] : [self displayRegisterCardScreen];
}

- (void)displayRegisterCardScreen {
    JPAmount *amount = [JPAmount amount:@"0.01" currency:@"GBP"];
    [self.judoWalletSession.judoKit invokeRegisterCard:@"100972777" amount:amount consumerReference:[[NSUUID UUID] UUIDString] cardDetails:nil completion:^(JPResponse * response, NSError * error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        if (error && response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                // [self dismissViewControllerAnimated:YES completion:nil];
                return; // BAIL
            }
            return; // BAIL
        }
        
        WalletCard *card = [[WalletCard alloc] initWithCardDetails:response.items[0].cardDetails assignedName:@"" defaultPaymentMethod:NO];
        
        NSError *walletError;
        [self.walletService add:card error:&walletError];
        
        if (walletError) {
            //throw big fat error.
        }
        
        self.walletCards = [[self.walletService get] mutableCopy];
        [self.cardsTableView reloadData];
        
        if (self.judoWalletSession.delegate) {
            [self.judoWalletSession.delegate didAddCardToWallet:card];
        }
    }];
}

- (void)displayUpdateCardScreen {

}

@end
