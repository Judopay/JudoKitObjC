//
//  JudoPaymentMethodsViewController.m
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

#import "JudoPaymentMethodsViewController.h"
#import <PassKit/PassKit.h>

#import "JPAmount.h"
#import "JPResponse.h"
#import "JPSession.h"
#import "JPTheme.h"
#import "JPTransaction.h"
#import "JudoKit.h"
#import "JudoPayViewController.h"
#import "JudoPaymentMethodsViewModel.h"
#import "NSBundle+Additions.h"
#import "NSError+Judo.h"
#import "NSString+Additions.h"
#import "UIApplication+Additions.h"
#import "UIColor+Judo.h"
#import "UIView+SafeAnchors.h"
#import "UIViewController+Additions.h"

@interface JudoPaymentMethodsViewController ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) JPTheme *theme;
@property (nonatomic, strong) JudoPaymentMethodsViewModel *viewModel;

@property (nonatomic, strong) JudoCompletionBlock completionBlock;
@property (nonatomic, strong) IDEALRedirectCompletion redirectCompletionBlock;
@property (nonatomic, strong) JudoKit *judoKitSession;

@property PaymentMethods methods;

@end

@implementation JudoPaymentMethodsViewController

- (instancetype)initWithTheme:(JPTheme *)theme
                    viewModel:(JudoPaymentMethodsViewModel *)viewModel
               currentSession:(JudoKit *)session
           redirectCompletion:(IDEALRedirectCompletion)redirectCompletion
                andCompletion:(JudoCompletionBlock)completion {
    if (self = [super init]) {
        _theme = theme;
        _viewModel = viewModel;
        _judoKitSession = session;
        _completionBlock = completion;
        _redirectCompletionBlock = redirectCompletion;
    }
    return self;
}

- (void)loadView {
    [super loadView];

    self.title = @"payment_method".localized;

    self.stackView = [UIStackView new];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.distribution = UIStackViewDistributionFill;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.spacing = self.theme.buttonsSpacing;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.stackView];

    NSArray *constraints = @[
        [self.stackView.leftAnchor constraintEqualToAnchor:self.view.safeLeftAnchor
                                                  constant:self.theme.buttonsSpacing],

        [self.stackView.rightAnchor constraintEqualToAnchor:self.view.safeRightAnchor
                                                   constant:-self.theme.buttonsSpacing],

        [self.stackView.topAnchor constraintEqualToAnchor:self.view.safeTopAnchor
                                                 constant:self.theme.buttonsSpacing]
    ];

    [NSLayoutConstraint activateConstraints:constraints];

    UILabel *headingLabel = [[UILabel alloc] init];
    headingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    headingLabel.numberOfLines = 0;
    headingLabel.textAlignment = NSTextAlignmentCenter;
    headingLabel.textColor = self.theme.judoTextColor;
    headingLabel.text = @"select_payment_method".localized;

    [self.stackView addArrangedSubview:headingLabel];
    [self setupPaymentMethodButtons];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.theme.backButtonTitle
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backButtonAction:)];

    [self applyTheme:self.theme];
}

- (void)setupPaymentMethodButtons {

    if (self.viewModel.paymentMethods & PaymentMethodCard) {
        UIButton *cardPaymentButton = [[UIButton alloc] init];
        [cardPaymentButton setTag:PaymentMethodCard];
        [cardPaymentButton setTitle:@"card_payment".localized forState:UIControlStateNormal];

        [cardPaymentButton.titleLabel setFont:self.theme.buttonFont];
        [cardPaymentButton setBackgroundImage:self.theme.judoButtonColor.asImage forState:UIControlStateNormal];
        [cardPaymentButton setTitleColor:self.theme.judoButtonTitleColor forState:UIControlStateNormal];

        [cardPaymentButton addTarget:self
                              action:@selector(paymentMethodButtonDidTap:)
                    forControlEvents:UIControlEventTouchUpInside];

        cardPaymentButton.translatesAutoresizingMaskIntoConstraints = NO;
        [[cardPaymentButton.heightAnchor constraintEqualToConstant:self.theme.buttonHeight] setActive:YES];
        [cardPaymentButton.layer setCornerRadius:self.theme.buttonCornerRadius];
        [cardPaymentButton setClipsToBounds:YES];

        [self.stackView addArrangedSubview:cardPaymentButton];
    }

    if (self.viewModel.paymentMethods & PaymentMethodApplePay && [PKPaymentAuthorizationViewController canMakePayments]) {
        PKPaymentButtonStyle buttonStyle = PKPaymentButtonStyleBlack;
        if ([UIApplication isUserInterfaceStyleDark] || [self.view.backgroundColor isDarkColor]) {
            buttonStyle = PKPaymentButtonStyleWhite;
        }

        PKPaymentButton *applePayButton = [PKPaymentButton buttonWithType:PKPaymentButtonTypePlain style:buttonStyle];
        [applePayButton setTag:PaymentMethodApplePay];
        [applePayButton addTarget:self
                           action:@selector(paymentMethodButtonDidTap:)
                 forControlEvents:UIControlEventTouchUpInside];

        [[applePayButton.heightAnchor constraintEqualToConstant:self.theme.buttonHeight] setActive:YES];
        [self.stackView addArrangedSubview:applePayButton];
    }

    if (self.viewModel.paymentMethods & PaymentMethodIDEAL) {

        UIButton *idealButton = [UIButton new];
        [idealButton setTag:PaymentMethodIDEAL];

        [idealButton addTarget:self
                        action:@selector(onIDEALButtonTap:)
              forControlEvents:UIControlEventTouchUpInside];

        NSString *iconFilePath = [NSBundle.iconsBundle pathForResource:@"logo-ideal"
                                                                ofType:@"png"];

        [idealButton setImage:[UIImage imageWithContentsOfFile:iconFilePath]
                     forState:UIControlStateNormal];

        idealButton.imageView.contentMode = UIViewContentModeScaleAspectFit;

        [idealButton setTitle:@"iDEAL" forState:UIControlStateNormal];
        [idealButton setTitleColor:self.theme.judoButtonTitleColor forState:UIControlStateNormal];
        idealButton.titleLabel.font = self.theme.buttonFont;

        idealButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 0);
        idealButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);

        [idealButton setBackgroundColor:UIColor.idealPurple];
        idealButton.layer.cornerRadius = 5.0f;

        [[idealButton.heightAnchor constraintEqualToConstant:self.theme.buttonHeight] setActive:YES];

        [self.stackView addArrangedSubview:idealButton];
    }
}

- (void)paymentMethodButtonDidTap:(UIView *)button {

    if (button.tag == PaymentMethodCard) {
        [self onCardPaymentButtonDidTap];
        return;
    }

    if (button.tag == PaymentMethodApplePay) {
        [self onApplePayButtonDidTap];
        return;
    }

    @throw NSInvalidArgumentException;
}

- (void)onCardPaymentButtonDidTap {
    __weak JudoPaymentMethodsViewController *weakSelf = self;
    JudoCompletionBlock completion = ^(JPResponse *response, NSError *error) {
        if (error && error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            return;
        }
        if (weakSelf.completionBlock) {
            weakSelf.completionBlock(response, error);
        }
    };

    JudoPayViewController *viewController =
        [[JudoPayViewController alloc] initWithJudoId:self.viewModel.judoId
                                               amount:self.viewModel.amount
                                            reference:self.viewModel.reference
                                          transaction:TransactionTypePayment
                                       currentSession:self.judoKitSession
                                          cardDetails:self.viewModel.cardDetails
                                           completion:completion];

    viewController.primaryAccountDetails = self.viewModel.primaryAccountDetails;
    viewController.theme = self.theme;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)onApplePayButtonDidTap {
    __weak JudoPaymentMethodsViewController *weakSelf = self;
    [self.judoKitSession invokeApplePayWithConfiguration:self.viewModel.applePayConfiguration
                                              completion:^(JPResponse *_Nullable response, NSError *_Nullable error) {
                                                  if (error && error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                                      return;
                                                  }
                                                  weakSelf.completionBlock(response, error);
                                              }];
}

- (void)onIDEALButtonTap:(id)sender {
    __weak JudoPaymentMethodsViewController *weakSelf = self;

    [self.judoKitSession invokeIDEALPaymentWithJudoId:self.viewModel.judoId
                                               amount:self.viewModel.amount.amount.doubleValue
                                            reference:self.viewModel.reference
                                   redirectCompletion:self.redirectCompletionBlock
                                           completion:^(JPResponse *response, NSError *error) {
                                               if (error && error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                                                   [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                               }
                                               weakSelf.completionBlock(response, error);
                                           }];
}

- (void)backButtonAction:(id)sender {
    if (self.completionBlock) {
        self.completionBlock(nil, [NSError judoUserDidCancelError]);
    }
}

@end
