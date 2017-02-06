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

@interface JudoWalletManagementViewController()

@property (nonnull, nonatomic, strong) JPTheme *theme;
@property (nonnull, nonatomic, strong) WalletService *walletService;
@property (nonatomic, weak) id<JPWalletDelegate> delegate;

@property (nonatomic, strong, readwrite) UIScrollView *contentView;

@end

@implementation JudoWalletManagementViewController

- (nonnull instancetype)initWithTheme:(nonnull JPTheme *)theme delegate:(nullable id<JPWalletDelegate>)delegate; {
    self = [super init];
    
    if (self) {
        self.theme = theme;
        self.walletService = [[WalletService alloc] initWithWalletRepository:[InMemoryWalletRepository new]];
        self.delegate = delegate;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpView];
    [self setUpConstraints];
}

- (void)setUpView {
    self.view.backgroundColor = [self.theme judoContentViewBackgroundColor];
    
    //[self.view addSubview:self.contentView];
    //self.contentView.contentSize = self.view.bounds.size;
    NSArray<WalletCard *> *walletCards = [self.walletService get];
    
     [self cardView];
}

- (void)setUpNavigationBar {
    self.title = @"Wallet";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.theme.backButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController:)];
    //self.navigationItem.rightBarButtonItem = self.paymentNavBarButton;
    
    self.navigationController.navigationBar.tintColor = self.theme.judoTextColor;
    
    if (![self.theme.tintColor colorMode]) {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:self.theme.judoNavigationBarTitleColor};
}

- (void)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpConstraints {
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:0 metrics:nil views:@{@"scrollView":self.contentView}]];
    
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

- (UIView *)cardView {
    CGRect rect = CGRectMake(13,80,self.view.frame.size.width - 26, 70);
    UIView *card = [[UIView alloc] initWithFrame:rect];
    card.backgroundColor = [UIColor redColor];
    card.translatesAutoresizingMaskIntoConstraints = NO;
    card.layer.borderColor = self.theme.judoInputFieldBorderColor.CGColor;
    card.layer.borderWidth = 0.5;
    card.backgroundColor = [self.theme judoContentViewBackgroundColor];
    card.layer.cornerRadius = 5.0;
    [self.view addSubview:card];
    /*
    NSLayoutConstraint *c;
    c = [NSLayoutConstraint constraintWithItem:self.contentView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:card
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1
                                      constant:0];
    [self.contentView addConstraint:c];*/
    
    return card;
}

@end
