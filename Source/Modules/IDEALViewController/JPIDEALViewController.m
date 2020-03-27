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
#import "JPAmount.h"
#import "JPConstants.h"
#import "JPOrderDetails.h"
#import "JPResponse.h"
#import "JPTransactionData.h"
#import "JPTransactionStatusView.h"
#import "NSError+Additions.h"
#import "UIView+Additions.h"

@interface JPIDEALViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) JPTransactionStatusView *transactionStatusView;
@property (nonatomic, strong) JPIDEALBank *iDEALBank;
@property (nonatomic, strong) JPIDEALService *idealService;
@property (nonatomic, strong) JudoCompletionBlock completionBlock;
@property (nonatomic, strong) JPResponse *redirectResponse;

@property (nonatomic, strong) NSString *redirectURL;
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, strong) NSString *checksum;
@property (nonatomic, assign) BOOL shouldDismissWebView;
@property (nonatomic, strong) NSTimer *pollingTimer;

@end

@implementation JPIDEALViewController

#pragma mark - Constants

const float kPollingDelayTimer = 30.0;

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
    [self redirectURLForIDEALBank:self.iDEALBank];
}

#pragma mark - iDEAL Logic

- (void)redirectURLForIDEALBank:(JPIDEALBank *)iDEALBank {

    __weak typeof(self) weakSelf = self;
    [self.idealService redirectURLForIDEALBank:iDEALBank
                                    completion:^(JPResponse *response, NSError *error) {

                                        if (error) {
                                            [weakSelf dismissViewControllerAnimated:YES
                                                                         completion:^{
                                                                             weakSelf.completionBlock(nil, error);
                                                                         }];
                                            return;
                                        }

                                        [weakSelf handleRedirectResponse:response];
                                    }];
}

- (void)handleRedirectResponse:(JPResponse *)response {
    JPTransactionData *transactionData = response.items.firstObject;

    self.redirectURL = transactionData.redirectUrl;
    self.orderID = transactionData.orderDetails.orderId;
    self.redirectResponse = response;

    [self loadWebViewWithURLString:self.redirectURL];
}

- (void)loadWebViewWithURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - Layout setup

- (void)setupViews {
    [self.view addSubview:self.webView];

    [self.view addSubview:self.transactionStatusView];
    [self.transactionStatusView applyTheme:self.theme];

    [self.webView pinToView:self.view withPadding:0.0];
    [self.transactionStatusView pinToView:self.view withPadding:0.0];
    self.transactionStatusView.hidden = YES;
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

- (JPTransactionStatusView *)transactionStatusView {
    if (!_transactionStatusView) {
        _transactionStatusView = [JPTransactionStatusView new];
        _transactionStatusView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _transactionStatusView;
}

@end

@implementation JPIDEALViewController (WKWebViewDelegate)

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {

    if (self.shouldDismissWebView) {
        self.transactionStatusView.hidden = NO;
        [self.transactionStatusView changeToTransactionStatus:JPTransactionStatusPending];
        [self startPolling];
        return;
    }

    if ([self.redirectURL isEqualToString:webView.URL.absoluteString]) {

        NSURLComponents *components = [NSURLComponents componentsWithString:webView.URL.absoluteString];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name = 'cs'"];
        NSURLQueryItem *checksum = [components.queryItems filteredArrayUsingPredicate:predicate].firstObject;

        if (checksum) {
            self.shouldDismissWebView = YES;
            self.checksum = checksum.value;
            return;
        }

        self.completionBlock(nil, NSError.judoMissingChecksumError);
    }
}

- (void)startPolling {
    __weak typeof(self) weakSelf = self;
    self.pollingTimer = [NSTimer scheduledTimerWithTimeInterval:kPollingDelayTimer
                                                        repeats:NO
                                                          block:^(NSTimer *_Nonnull timer) {
                                                              [weakSelf.transactionStatusView changeToTransactionStatus:JPTransactionStatusPendingDelayed];
                                                          }];

    [self.idealService pollTransactionStatusForOrderId:self.orderID
                                              checksum:self.checksum
                                            completion:^(JPResponse *response, NSError *error) {

                                                [weakSelf.pollingTimer invalidate];

                                                if (error) {
                                                    [weakSelf handleError:error];
                                                    return;
                                                }

                                                [weakSelf handleResponse:response];
                                            }];
}

- (void)handleError:(NSError *)error {
    if (error.localizedDescription == NSError.judoRequestTimeoutError.localizedDescription) {
        [self.transactionStatusView changeToTransactionStatus:JPTransactionStatusTimeout];
        self.completionBlock(self.redirectResponse, NSError.judoRequestTimeoutError);
        return;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
    self.completionBlock(self.redirectResponse, error);
    return;
}

- (void)handleResponse:(JPResponse *)response {
    JPOrderDetails *orderDetails = response.items.firstObject.orderDetails;
    if (orderDetails && [orderDetails.orderFailureReason isEqualToString:kFailureReasonUserAbort]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.completionBlock(response, NSError.judoUserDidCancelError);
        return;
    }

    NSString *amountString = [NSString stringWithFormat:@"%.2f", orderDetails.amount];
    response.items.firstObject.amount = [JPAmount amount:amountString currency:kCurrencyEuro];
    response.items.firstObject.createdAt = orderDetails.timestamp;
    response.items.firstObject.message = orderDetails.orderStatus;

    [self dismissViewControllerAnimated:YES completion:nil];
    self.completionBlock(response, nil);
}

@end
