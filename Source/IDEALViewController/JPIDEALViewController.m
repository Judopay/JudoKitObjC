//
//  JPIDEALViewController.m
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

#import "JPIDEALViewController.h"
#import "UIView+Additions.h"
#import "JPTransactionData.h"
#import "JPOrderDetails.h"
#import "JPResponse.h"

@interface JPIDEALViewController ()
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) JPIDEALBank *iDEALBank;
@property (nonatomic, strong) JPIDEALService *idealService;
@property (nonatomic, strong) JudoCompletionBlock completionBlock;
@property (nonatomic, strong) JPResponse *redirectResponse;
@end

@implementation JPIDEALViewController

#pragma mark - Initializers

- (instancetype)initWithIDEALBank:(JPIDEALBank *)iDEALBank
                    configuration:(JPConfiguration *)configuration
               transactionService:(JPTransactionService *)transactionService
                completionHandler:(JudoCompletionBlock)completion {
    if (self = [super init]) {
        self.idealService = [[JPIDEALService alloc] initWithConfiguration:configuration
                                                       transactionService:transactionService];
        self.iDEALBank = iDEALBank;
        self.completionBlock = completion;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self redirectURLForIDEALBank: self.iDEALBank];
}

#pragma mark - iDEAL Logic

- (void)redirectURLForIDEALBank:(JPIDEALBank *)iDEALBank {
    [self.idealService redirectURLForIDEALBank:iDEALBank
                                    completion:^(JPResponse *response, NSError *error) {
        if (error) {
            [self dismissViewControllerAnimated:YES completion:^{
                self.completionBlock(nil, error);
            }];
            return;
        }
        
        [self handleRedirectResponse:response];
    }];
}

- (void)handleRedirectResponse:(JPResponse *)response {
    JPTransactionData *transactionData = response.items.firstObject;
    NSString *redirectUrl = transactionData.redirectUrl;
    NSString *orderId = transactionData.orderDetails.orderId;
    
    self.redirectResponse = response;
    [self loadWebViewWithURLString:redirectUrl];
}

- (void)loadWebViewWithURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


#pragma mark - Layout setup

- (void)setupViews {
    [self.view addSubview:self.webView];
    [self.webView pinToView:self.view withPadding:0];
}

#pragma mark - Lazy properties

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        _webView = [[WKWebView alloc] initWithFrame:UIScreen.mainScreen.bounds
                                      configuration:configuration];
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end

@implementation JPIDEALViewController (WKWebViewDelegate)

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    // Handle web navigation
}

@end
