//
//  MainViewController.m
//  JudoKitObjCExample
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

#import <CoreLocation/CoreLocation.h>

#import "ApplePayButtonViewController.h"
#import "MainViewController.h"
#import "DetailViewController.h"
#import "ExampleAppCredentials.h"
#import "ApplePayConfiguration.h"
#import "SettingsViewController.h"
#import "DemoFeature.h"
#import "Settings.h"
#import "HalfHeightPresentationController.h"
#import "IDEALFormViewController.h"
#import "JPPrimaryAccountDetails.h"
#import "JudoKitObjC.h"

static NSString * const kCellIdentifier = @"com.judo.judopaysample.tableviewcellidentifier";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, SettingsViewControllerDelegate, UIViewControllerTransitioningDelegate> {
    UIAlertController *_alertController;
}

@property (nonatomic, strong) JPCardDetails *cardDetails;
@property (nonatomic, strong) JPPaymentToken *payToken;
@property (nonatomic, strong) JudoKit *judoKitSession;

@property (nonatomic, nonnull, strong) NSString *reference;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) NSArray <DemoFeature *> *features;
@property (strong, nonatomic) Settings *settings;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // initialize the SDK by setting it up with a token and a secret
    self.judoKitSession = [[JudoKit alloc] initWithToken:token secret:secret];
    
    // setting the SDK to Sandbox Mode - once this is set, the SDK wil stay in Sandbox mode until the process is killed
    self.judoKitSession.apiSession.sandboxed = YES;
    self.judoKitSession.theme.showSecurityMessage = YES;

    self.reference = @"judoPay-sample-app-objc";
    
    self.settings = [Settings defaultSettings];
    self.features = [DemoFeature defaultFeatures];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_alertController) {
        [self presentViewController:_alertController animated:YES completion:nil];
        _alertController = nil;
    }
}

#pragma mark - Actions

- (void)setSettings:(Settings *)settings {
    _settings = settings;
    self.judoKitSession.theme.avsEnabled = settings.isAVSEnabled;
}

- (void)settingsViewController:(SettingsViewController *)viewController didUpdateSettings:(Settings *)settings {
    self.settings = settings;
}

- (IBAction)settingsButtonHandler:(id)sender {
    
    SettingsViewController *svc = [[SettingsViewController alloc] initWithSettings:self.settings];
    svc.delegate = self;
    svc.modalPresentationStyle = UIModalPresentationCustom;
    svc.transitioningDelegate = self;
    [self presentViewController:svc animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.features.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    DemoFeature *option = self.features[indexPath.row];
    cell.textLabel.text = option.title;
    cell.detailTextLabel.text = option.details;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DemoFeature *feature = self.features[indexPath.row];
    switch (feature.type) {
        case DemoFeatureTypePayment:
            [self paymentOperation];
            break;

        case DemoFeatureTypePreAuth:
            [self preAuthOperation];
            break;

        case DemoFeatureTypeCreateCardToken:
            [self createCardTokenOperation];
            break;

        case DemoFeatureTypeSaveCard:
            [self saveCardOperation];
            break;
            
        case DemoFeatureTypeCheckCard:
            [self checkCardOperation];
            break;

        case DemoFeatureTypeRepeatPayment:
            [self tokenPaymentOperation];
            break;

        case DemoFeatureTypeTokenPreAuth:
            [self tokenPreAuthOperation];
            break;

        case DemoFeatureTypeApplePayPayment:
            [self applePayPaymentOperation];
            break;

        case DemoFeatureTypeApplePayPreAuth:
            [self applePayPreAuthOperation];
            break;

        case DemoFeatureTypePaymentMethods:
            [self paymentMethodOption];
            break;
            
        case DemoFeatureTypeIDEALTransaction:
            [self idealTransactionOperation];
            break;

        case DemoFeatureTypeStandaloneApplePayButton:
            [self standaloneApplePayButton];

        default:
            break;
    }
}

#pragma mark - Operations

- (void)standaloneApplePayButton {
    ApplePayButtonViewController *standaloneApplePayButtonVC = [[ApplePayButtonViewController alloc] initWithCurrentSession: self.judoKitSession];
    [self.navigationController pushViewController:standaloneApplePayButtonVC animated:YES];
}

- (void)paymentMethodOption {
    JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.settings.currency];
    
    ApplePayConfiguration *configuration = [self applePayConfigurationWithType:TransactionTypePayment];
    
    [self.judoKitSession invokePayment:judoId
                                amount:amount
                     consumerReference:self.reference
                        paymentMethods:PaymentMethodsAll
               applePayConfiguratation:configuration
                           cardDetails:nil
                            completion:^(JPResponse * response, NSError * error) {
                                if (error || response.items.count == 0) {
                                    if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        return;
                                    }
                                    
                                    [self dismissViewControllerAnimated:YES completion:^{
                                        [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
                                    }];
                                    return;
                                }
                                JPTransactionData *tData = response.items[0];
                                if (tData.cardDetails) {
                                    self.cardDetails = tData.cardDetails;
                                    self.payToken = tData.paymentToken;
                                }
                                DetailViewController *viewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
                                viewController.transactionData = tData;
                                [self dismissViewControllerAnimated:YES completion:^{
                                    [self.navigationController pushViewController:viewController animated:YES];
                                }];
                            }];
}

- (void)paymentOperation {
    JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.settings.currency];
    
    [self.judoKitSession invokePayment:judoId
                                amount:amount
                     consumerReference:self.reference
                           cardDetails:nil
                            completion:^(JPResponse * response, NSError * error) {
        if (error || response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
            }];
            return;
        }
        JPTransactionData *tData = response.items[0];
        if (tData.cardDetails) {
            self.cardDetails = tData.cardDetails;
            self.payToken = tData.paymentToken;
        }
        DetailViewController *viewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        viewController.transactionData = tData;
        [self dismissViewControllerAnimated:YES completion:^{
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }];
}

- (void)preAuthOperation {
    JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.settings.currency];
    
    [self.judoKitSession invokePreAuth:judoId
                                amount:amount
                     consumerReference:self.reference
                           cardDetails:nil
                            completion:^(JPResponse * response, NSError * error) {
        if (error || response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
            }];
            return;
        }
        JPTransactionData *tData = response.items[0];
        if (tData.cardDetails) {
            self.cardDetails = tData.cardDetails;
            self.payToken = tData.paymentToken;
        }
        DetailViewController *viewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        viewController.transactionData = tData;
        [self dismissViewControllerAnimated:YES completion:^{
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }];
}

- (void)createCardTokenOperation {
    [self.judoKitSession invokeRegisterCard:judoId
                          consumerReference:self.reference
                                cardDetails:nil
                                 completion:^(JPResponse * response, NSError * error) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        if (error && response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
            return;
        }
        JPTransactionData *tData = response.items[0];
        if (tData.cardDetails) {
            self.cardDetails = tData.cardDetails;
            self.payToken = tData.paymentToken;
        }
    }];
}

- (void)saveCardOperation {
    [self.judoKitSession invokeSaveCard:judoId consumerReference:self.reference cardDetails:nil completion:^(JPResponse * response, NSError * error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if (error && response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
            return;
        }
        
        JPTransactionData *tData = response.items[0];
        if (tData.cardDetails) {
            self.cardDetails = tData.cardDetails;
            self.payToken = tData.paymentToken;
        }
    }];
}

- (void)checkCardOperation {
    [self.judoKitSession invokeCheckCard:judoId
                                currency:nil
                               reference:[[JPReference alloc] initWithConsumerReference:self.reference]
                             cardDetails:nil
                              completion:^(JPResponse *response, NSError *error) {
        if (error || response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
            }];
            return;
        }
        JPTransactionData *tData = response.items[0];
        if (tData.cardDetails) {
            self.cardDetails = tData.cardDetails;
            self.payToken = tData.paymentToken;
        }
        DetailViewController *viewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        viewController.transactionData = tData;
        [self dismissViewControllerAnimated:YES completion:^{
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }];
}

- (void)tokenPaymentOperation {
    if (self.cardDetails) {
        JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.settings.currency];
        
        [self.judoKitSession invokeTokenPayment:judoId
                                         amount:amount
                              consumerReference:self.reference
                                    cardDetails:self.cardDetails
                                   paymentToken:self.payToken
                                     completion:^(JPResponse * response, NSError * error) {
            
            if (error || response.items.count == 0) {
                if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    return;
                }
                [self dismissViewControllerAnimated:YES completion:^{
                    [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
                }];
                return;
            }
            JPTransactionData *tData = response.items[0];
            if (tData.cardDetails) {
                self.cardDetails = tData.cardDetails;
                self.payToken = tData.paymentToken;
            }
            DetailViewController *viewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
            viewController.transactionData = tData;
            [self dismissViewControllerAnimated:YES completion:^{
                [self.navigationController pushViewController:viewController animated:YES];
            }];
        }];
        
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"you need to create a card token before you can do a pre auth" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)idealTransactionOperation {
    [self.judoKitSession invokeIDEALPaymentWithCompletion:^(JPResponse *response, NSError *error) {
        if (error || response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            [self dismissViewControllerAnimated:YES completion:^{
                [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
            }];
            return;
        }
        
        // TODO: Handle response / error
    }];
}

- (void)tokenPreAuthOperation {
    if (self.cardDetails) {
        JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.settings.currency];
        
        [self.judoKitSession invokeTokenPreAuth:judoId
                                         amount:amount
                              consumerReference:self.reference
                                    cardDetails:self.cardDetails
                                   paymentToken:self.payToken
                                     completion:^(JPResponse * response, NSError * error) {
            
            if (error || response.items.count == 0) {
                if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    return;
                }
                [self dismissViewControllerAnimated:YES completion:^{
                    [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
                }];
                return;
            }
            JPTransactionData *tData = response.items[0];
            if (tData.cardDetails) {
                self.cardDetails = tData.cardDetails;
                self.payToken = tData.paymentToken;
            }
            DetailViewController *viewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
            viewController.transactionData = tData;
            [self dismissViewControllerAnimated:YES completion:^{
                [self.navigationController pushViewController:viewController animated:YES];
            }];
        }];
        
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"you need to create a card token before you can do a pre auth" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)applePayPaymentOperation {
    [self initApplePaySleveWithTransactionType:TransactionTypePayment];
}

- (void)applePayPreAuthOperation {
    [self initApplePaySleveWithTransactionType:TransactionTypePreAuth];
}

- (void)initApplePaySleveWithTransactionType:(TransactionType)transactionType {
    
    ApplePayConfiguration *configuration = [self applePayConfigurationWithType:transactionType];
    
    [self.judoKitSession invokeApplePayWithConfiguration:configuration
                                              completion:^(JPResponse *_Nullable response, NSError *_Nullable error) {
                                                  
                                                  if (error || response.items.count == 0) {
                                                      if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                          return;
                                                      }
                                                      
                                                      [self dismissViewControllerAnimated:YES completion:^{
                                                          [self presentErrorWithMessage: error.userInfo[NSLocalizedDescriptionKey]];
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

- (void)presentErrorWithMessage:(NSString *)message {
    self->_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    [self->_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:self->_alertController animated:YES completion:nil];
}

#pragma mark - Lazy Loading
- (ApplePayConfiguration *)applePayConfigurationWithType:(TransactionType)transactionType {
    
    NSArray *items = @[
                       [[PaymentSummaryItem alloc] initWithLabel:@"Item 1"
                                                          amount:[NSDecimalNumber decimalNumberWithString:@"0.01"]],
                       [[PaymentSummaryItem alloc] initWithLabel:@"Item 2"
                                                          amount:[NSDecimalNumber decimalNumberWithString:@"0.02"]],
                       [[PaymentSummaryItem alloc] initWithLabel:@"Tim Apple"
                                                          amount:[NSDecimalNumber decimalNumberWithString:@"0.03"]]
                       ];
    
    ApplePayConfiguration *configuration = [[ApplePayConfiguration alloc] initWithJudoId:judoId
                                                                               reference:self.reference
                                                                              merchantId:merchantId
                                                                                currency:self.settings.currency
                                                                             countryCode:@"GB"
                                                                     paymentSummaryItems:items];
    
    
    configuration.transactionType = transactionType;
    configuration.requiredShippingContactFields = ContactFieldAll;
    configuration.requiredBillingContactFields = ContactFieldAll;
    configuration.returnedContactInfo = ReturnedInfoAll;
    
    return configuration;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    return [[HalfHeightPresentationController alloc] initWithPresentedViewController:presented
                                                            presentingViewController:presenting];
}

@end
