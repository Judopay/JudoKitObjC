//
//  ApplePayButtonViewController.m
//  JudoKitObjCExampleApp
//
//  Created by Gheorghe Cojocaru on 8/13/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "ApplePayButtonViewController.h"
#import "JudoKitObjC.h"
#import "ExampleAppCredentials.h"
#import "DetailViewController.h"

@interface ApplePayButtonViewController () {
    UIAlertController *_alertController;
}

@property (nonatomic, strong) JudoKit *judoKitSession;
@property (nonatomic, strong) NSString *currentCurrency;
@end

@implementation ApplePayButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupUI];
    self.currentCurrency = @"GBP";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_alertController) {
        [self presentViewController:_alertController animated:YES completion:nil];
        _alertController = nil;
    }
}

- (instancetype) initWithCurrentSession:(JudoKit *)session {
    if (self = [super init]) {
        _judoKitSession = session;
    }
    return self;
}

- (void)setupUI {
    if ([PKPaymentAuthorizationViewController canMakePayments]) {
        PKPaymentButton *applePayButton = [PKPaymentButton buttonWithType:PKPaymentButtonTypePlain style:PKPaymentButtonStyleBlack];
        [applePayButton setTag:PaymentMethodApplePay];
        [applePayButton addTarget:self
                           action:@selector(appleButtonDidTap:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:applePayButton];
        
        applePayButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:applePayButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:applePayButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    }
}


- (void)appleButtonDidTap:(UIView *)button {
    [self initApplePaySleveWithTransactionType:TransactionTypePayment];
}

- (void)initApplePaySleveWithTransactionType: (TransactionType)transactionType {
    
    ApplePayConfiguration *configuration = [self applePayConfigurationWithType:transactionType];
    
    [self.judoKitSession invokeApplePayWithConfiguration:configuration
                                              completion:^(JPResponse *_Nullable response, NSError *_Nullable error) {
                                                  
                                                  if (error || response.items.count == 0) {
                                                      if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                          return;
                                                      }
                                                      
                                                      self->_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.userInfo[NSLocalizedDescriptionKey] preferredStyle:UIAlertControllerStyleAlert];
                                                      
                                                      [self->_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                                                      
                                                      [self dismissViewControllerAnimated:YES completion:^{
                                                          [self presentViewController:self->_alertController animated:YES completion:nil];
                                                      }];
                                                      
                                                      return;
                                                  }
                                                  
                                                  DetailViewController *viewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
                                                  
                                                  viewController.transactionData = response.items.firstObject;
                                                  viewController.billingInformation = response.billingInfo;
                                                  viewController.shippingInformation = response.shippingInfo;
                                                  
                                                  [self dismissViewControllerAnimated:YES completion:^{
                                                      [self.navigationController pushViewController:viewController animated:YES];
                                                  }];
                                                  
                                              }];
}


- (ApplePayConfiguration *)applePayConfigurationWithType: (TransactionType)transactionType {
    
    NSArray *items = @[
                       [[PaymentSummaryItem alloc] initWithLabel:@"Item 1"
                                                          amount:[NSDecimalNumber decimalNumberWithString:@"0.01"]],
                       [[PaymentSummaryItem alloc] initWithLabel:@"Item 2"
                                                          amount:[NSDecimalNumber decimalNumberWithString:@"0.02"]],
                       [[PaymentSummaryItem alloc] initWithLabel:@"Tim Apple"
                                                          amount:[NSDecimalNumber decimalNumberWithString:@"0.03"]]
                       ];
    
    ApplePayConfiguration *configuration = [[ApplePayConfiguration alloc] initWithJudoId:judoId
                                                                               reference:[self getSampleConsumerReference]
                                                                              merchantId:merchantId
                                                                                currency:self.currentCurrency
                                                                             countryCode:@"GB"
                                                                     paymentSummaryItems:items];
    
    
    configuration.transactionType = transactionType;
    
    configuration.requiredShippingContactFields = ContactFieldAll;
    configuration.requiredBillingContactFields = ContactFieldAll;
    configuration.returnedContactInfo = ReturnedInfoAll;
    
    return configuration;
}

- (NSString *) getSampleConsumerReference {
    return @"judoPay-sample-app-objc";
}

@end
