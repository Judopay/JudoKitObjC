//
//  JudoKit.m
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

#import "JudoKit.h"
#import "JPApplePayService.h"
#import "JPConfiguration.h"
#import "JPPaymentMethodsBuilder.h"
#import "JPPaymentMethodsViewController.h"
#import "JPReceipt.h"
#import "JPResponse.h"
#import "JPSliderTransitioningDelegate.h"
#import "JPTheme.h"
#import "JPTransaction.h"
#import "JPTransactionBuilder.h"
#import "JPTransactionEnricher.h"
#import "JPTransactionService.h"
#import "JPTransactionViewController.h"
#import "NSError+Additions.h"
#import "UIApplication+Additions.h"

@interface JudoKit ()
@property (nonatomic, strong) JPTransactionService *transactionService;
@property (nonatomic, strong) JPApplePayService *applePayService;
@property (nonatomic, strong) JPApplePayConfiguration *configuration;
@property (nonatomic, strong) JudoCompletionBlock completionBlock;
@property (nonatomic, strong) JPSliderTransitioningDelegate *transitioningDelegate;
@end

@implementation JudoKit

#pragma mark - Initializers

- (instancetype)initWithToken:(NSString *)token secret:(NSString *)secret {
    return [self initWithToken:token secret:secret allowJailbrokenDevices:YES];
}

- (instancetype)initWithToken:(NSString *)token
                       secret:(NSString *)secret
       allowJailbrokenDevices:(BOOL)jailbrokenDevicesAllowed {

    self = [super init];
    BOOL isDeviceSupported = !(!jailbrokenDevicesAllowed && UIApplication.isCurrentDeviceJailbroken);

    if (self && isDeviceSupported) {
        self.transactionService = [[JPTransactionService alloc] initWithToken:token
                                                                    andSecret:secret];
        return self;
    }

    return nil;
}

#pragma mark - Public methods

- (JPTransaction *)transactionWithType:(TransactionType)type
                         configuration:(JPConfiguration *)configuration {

    self.transactionService.transactionType = type;
    return [self.transactionService transactionWithConfiguration:configuration];
}

- (void)invokeTransactionWithType:(TransactionType)type
                    configuration:(JPConfiguration *)configuration
                       completion:(JudoCompletionBlock)completion {

    self.transactionService.transactionType = type;

    UIViewController *controller;
    controller = [JPTransactionBuilderImpl buildModuleWithTransactionService:self.transactionService
                                                               configuration:configuration
                                                                  completion:completion];
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitioningDelegate = self.transitioningDelegate;
    [UIApplication.topMostViewController presentViewController:controller
                                                      animated:YES
                                                    completion:nil];
}

- (void)invokeApplePayWithMode:(TransactionMode)mode
                 configuration:(JPApplePayConfiguration *)configuration
                    completion:(JudoCompletionBlock)completion {
    self.applePayService = [[JPApplePayService alloc] initWithConfiguration:configuration
                                                         transactionService:self.transactionService];
    [self.applePayService invokeApplePayWithMode:mode completion:completion];
}

- (void)invokePaymentMethodScreenWithMode:(TransactionMode)mode
                            configuration:(JPConfiguration *)configuration
                               completion:(JudoCompletionBlock)completion {
    UIViewController *controller;
    controller = [JPPaymentMethodsBuilderImpl buildModuleWithMode:mode
                                                    configuration:configuration
                                               transactionService:self.transactionService
                                            transitioningDelegate:self.transitioningDelegate
                                                completionHandler:completion];

    if (!controller) {
        return;
    }

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.modalPresentationStyle = UIModalPresentationFullScreen;

    [UIApplication.topMostViewController presentViewController:navController
                                                      animated:YES
                                                    completion:nil];
}

- (void)listTransactionsOfType:(TransactionType)type
                     paginated:(JPPagination *)pagination
                    completion:(JudoCompletionBlock)completion {
    [self.transactionService listTransactionsOfType:type
                                          paginated:pagination
                                         completion:completion];
}

- (JPReceipt *)receiptForReceiptId:(NSString *)receiptId {
    return [self.transactionService receiptForReceiptId:receiptId];
}

#pragma mark - Getters & Setters

- (JPSliderTransitioningDelegate *)transitioningDelegate {
    if (!_transitioningDelegate) {
        _transitioningDelegate = [JPSliderTransitioningDelegate new];
    }
    return _transitioningDelegate;
}

- (void)setIsSandboxed:(BOOL)isSandboxed {
    _isSandboxed = isSandboxed;
    self.transactionService.isSandboxed = isSandboxed;
}

@end
