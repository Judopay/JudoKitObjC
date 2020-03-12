//
//  JPPaymentMethodsRouter.m
//  JudoKitObjC
//
//  Copyright (c) 2019 Alternative Payments Ltd
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

#import "JPPaymentMethodsRouter.h"
#import "JPCardCustomizationBuilder.h"
#import "JPCardCustomizationViewController.h"
#import "JPIDEALViewController.h"
#import "JPPaymentMethodsViewController.h"
#import "JPTransactionBuilder.h"
#import "JPTransactionService.h"
#import "JPTransactionViewController.h"
#import "NSError+Additions.h"

#import "JPConfiguration.h"
#import "JPSliderTransitioningDelegate.h"
#import "JPTransaction.h"

@interface JPPaymentMethodsRouterImpl ()

@property (nonatomic, strong) JPConfiguration *configuration;
@property (nonatomic, strong) JPTransactionService *transactionService;
@property (nonatomic, strong) JudoCompletionBlock completionHandler;
@property (nonatomic, strong) JPSliderTransitioningDelegate *transitioningDelegate;

@end

@implementation JPPaymentMethodsRouterImpl

#pragma mark - Initializers

- (instancetype)initWithConfiguration:(JPConfiguration *)configuration
                   transactionService:(JPTransactionService *)transactionService
                transitioningDelegate:(JPSliderTransitioningDelegate *)transitioningDelegate
                           completion:(JudoCompletionBlock)completion {
    if (self = [super init]) {
        self.configuration = configuration;
        self.transactionService = transactionService;
        self.transitioningDelegate = transitioningDelegate;
        self.completionHandler = completion;
    }
    return self;
}

#pragma mark - Protocol Conformance

- (void)navigateToTransactionModule {
    self.transactionService.transactionType = TransactionTypeSaveCard;
    JPTransactionViewController *controller;
    controller = [JPTransactionBuilderImpl buildModuleWithTransactionService:self.transactionService
                                                               configuration:self.configuration
                                                                  completion:nil];

    controller.delegate = self.viewController;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitioningDelegate = self.transitioningDelegate;
    [self.viewController presentViewController:controller animated:YES completion:nil];
}

- (void)navigateToIDEALModuleWithBank:(JPIDEALBank *)bank
                        andCompletion:(JudoCompletionBlock)completion {

    if (!self.configuration.siteId) {
        completion(nil, NSError.judoParameterError);
        return;
    }

    JPIDEALViewController *controller;
    controller = [[JPIDEALViewController alloc] initWithIDEALBank:bank
                                                    configuration:self.configuration
                                               transactionService:self.transactionService
                                                completionHandler:completion];

    controller.theme = self.configuration.uiConfiguration.theme;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.viewController presentViewController:controller animated:YES completion:nil];
}

- (void)navigateToCardCustomizationWithIndex:(NSUInteger)index {
    JPCardCustomizationViewController *viewController;
    JPTheme *theme = self.configuration.uiConfiguration.theme;
    viewController = [JPCardCustomizationBuilderImpl buildModuleWithCardIndex:index
                                                                     andTheme:theme];

    [self.viewController.navigationController pushViewController:viewController
                                                        animated:YES];
}

- (void)dismissViewController {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)completeTransactionWithResponse:(JPResponse *)response
                               andError:(NSError *)error {
    if (self.completionHandler)
        self.completionHandler(response, error);
}

@end
