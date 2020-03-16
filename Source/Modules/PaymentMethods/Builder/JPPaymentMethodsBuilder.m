//
//  JPPaymentMethodsBuilder.m
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

#import "JPPaymentMethodsBuilder.h"

#import "JPAmount.h"
#import "JPCardStorage.h"
#import "JPReference.h"
#import "JudoKit.h"

#import "JPPaymentMethodsInteractor.h"
#import "JPPaymentMethodsPresenter.h"
#import "JPPaymentMethodsRouter.h"
#import "JPPaymentMethodsViewController.h"
#import "NSError+Additions.h"

#import "JPApplePayService.h"

@implementation JPPaymentMethodsBuilderImpl

#pragma mark - Constants

static NSString * const kEuroCurrency = @"EUR";

#pragma mark - Public methods

+ (JPPaymentMethodsViewController *)buildModuleWithMode:(TransactionMode)mode
                                          configuration:(JPConfiguration *)configuration
                                     transactionService:(JPTransactionService *)transactionService
                                  transitioningDelegate:(JPSliderTransitioningDelegate *)transitioningDelegate
                                      completionHandler:(JudoCompletionBlock)completion {

    for (JPPaymentMethod *paymentMethod in configuration.paymentMethods) {
        BOOL isIDEALPresent = (paymentMethod.type == JPPaymentMethodTypeIDeal);
        BOOL isApplePayPresent = (paymentMethod.type == JPPaymentMethodTypeApplePay);
        BOOL isCurrencyEUR = [configuration.amount.currency isEqualToString:kEuroCurrency];
        BOOL isOnlyPaymentMethod = (configuration.paymentMethods.count == 1);
        BOOL isApplePaySupported = [JPApplePayService isApplePaySupported];

        if (isIDEALPresent && isOnlyPaymentMethod && !isCurrencyEUR) {
            completion(nil, NSError.judoInvalidIDEALCurrencyError);
            return nil;
        }

        if (isApplePayPresent && isOnlyPaymentMethod && !isApplePaySupported) {
            completion(nil, NSError.judoApplePayNotSupportedError);
            return nil;
        }
    }

    JPPaymentMethodsViewController *viewController = [JPPaymentMethodsViewController new];
    JPPaymentMethodsPresenterImpl *presenter = [JPPaymentMethodsPresenterImpl new];

    JPPaymentMethodsRouterImpl *router;
    router = [[JPPaymentMethodsRouterImpl alloc] initWithConfiguration:configuration
                                                    transactionService:transactionService
                                                 transitioningDelegate:transitioningDelegate
                                                            completion:completion];

    JPPaymentMethodsInteractorImpl *interactor;
    interactor = [[JPPaymentMethodsInteractorImpl alloc] initWithMode:mode
                                                        configuration:configuration
                                                   transactionService:transactionService
                                                           completion:completion];

    presenter.view = viewController;
    presenter.interactor = interactor;
    presenter.router = router;

    router.viewController = viewController;

    viewController.presenter = presenter;
    viewController.uiConfiguration = configuration.uiConfiguration;

    return viewController;
}

@end
