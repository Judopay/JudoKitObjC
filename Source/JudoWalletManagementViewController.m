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

@interface JudoWalletManagementViewController()

@property (nonnull, nonatomic, strong) JPTheme *theme;
@property (nonnull, nonatomic, strong) WalletService *walletService;

@end

@implementation JudoWalletManagementViewController

- (nonnull instancetype)init {
    return [self initWithTheme:[JPTheme new]];
}

- (nonnull instancetype)initWithTheme:(nonnull JPTheme *)theme {
    self = [super init];
    
    if (self) {
        self.theme = theme;
        self.walletService = [[WalletService alloc] initWithWalletRepository:[InMemoryWalletRepository new]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpView];
}

- (void)setUpView {
    self.view.backgroundColor = [self.theme judoContentViewBackgroundColor];
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

@end
