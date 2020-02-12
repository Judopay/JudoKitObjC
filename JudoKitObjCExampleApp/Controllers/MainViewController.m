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

#import "DemoFeature.h"
#import "Settings.h"
#import "HalfHeightPresentationController.h"
#import "IDEALFormViewController.h"
#import "JPPrimaryAccountDetails.h"

#import "JudoKitObjC.h"

static NSString * const kCellIdentifier = @"com.judo.judopaysample.tableviewcellidentifier";
static NSString * const kConsumerReference = @"judoPay-sample-app-objc";

@interface MainViewController ()

@property (nonatomic, strong) JPCardDetails *cardDetails;
@property (nonatomic, strong) JPPaymentToken *payToken;
@property (nonatomic, strong) JudoKit *judoKitSession;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) JPAmount *amount;

@property (strong, nonatomic) NSArray <DemoFeature *> *features;
@property (strong, nonatomic) Settings *settings;

@end

@implementation MainViewController

# pragma mark - View lifecycle

- (void)viewDidLoad {
    [self initializeJudoSDK];
    [self requestLocationPermissions];
    [super viewDidLoad];
}

#pragma mark - Setup methods

- (void)initializeJudoSDK {
    self.judoKitSession = [[JudoKit alloc] initWithToken:token secret:secret];
    self.judoKitSession.apiSession.sandboxed = YES;
    self.judoKitSession.theme.showSecurityMessage = YES;
}

- (void)requestLocationPermissions {
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
}

#pragma mark - SDK Features

- (void)paymentMethodOption {
    [self.judoKitSession invokePayment:judoId
                                amount:self.amount
                     consumerReference:kConsumerReference
                        paymentMethods:PaymentMethodsAll
               applePayConfiguratation:[self applePayConfigurationWithType:TransactionTypePayment]
                           cardDetails:nil
                            completion:^(JPResponse * response, NSError * error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)paymentOperation {
    [self.judoKitSession invokePayment:judoId
                                amount:self.amount
                     consumerReference:kConsumerReference
                           cardDetails:nil
                            completion:^(JPResponse * response, NSError * error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)preAuthOperation {
    [self.judoKitSession invokePreAuth:judoId
                                amount:self.amount
                     consumerReference:kConsumerReference
                           cardDetails:nil
                            completion:^(JPResponse * response, NSError * error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)createCardTokenOperation {
    [self.judoKitSession invokeRegisterCard:judoId
                          consumerReference:kConsumerReference
                                cardDetails:nil
                                 completion:^(JPResponse * response, NSError * error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)checkCardOperation {
    [self.judoKitSession invokeCheckCard:judoId
                                currency:nil
                               reference:[[JPReference alloc] initWithConsumerReference:kConsumerReference]
                             cardDetails:nil
                              completion:^(JPResponse *response, NSError *error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)saveCardOperation {
    [self.judoKitSession invokeSaveCard:judoId
                      consumerReference:kConsumerReference
                            cardDetails:nil
                             completion:^(JPResponse * response, NSError * error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)tokenPaymentOperation {
    if (!self.cardDetails) {
        [self presentErrorWithMessage:@"You must create a card token first"];
        return;
    }
    
    [self.judoKitSession invokeTokenPayment:judoId
                                     amount:self.amount
                          consumerReference:kConsumerReference
                                cardDetails:self.cardDetails
                               paymentToken:self.payToken
                                 completion:^(JPResponse * response, NSError * error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)tokenPreAuthOperation {
    if (!self.cardDetails) {
        [self presentErrorWithMessage:@"You must create a card token first"];
        return;
    }
    
    [self.judoKitSession invokeTokenPreAuth:judoId
                                     amount:self.amount
                          consumerReference:kConsumerReference
                                cardDetails:self.cardDetails
                               paymentToken:self.payToken
                                 completion:^(JPResponse * response, NSError * error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)applePayPaymentOperation {
    [self initApplePaySleveWithTransactionType:TransactionTypePayment];
}

- (void)applePayPreAuthOperation {
    [self initApplePaySleveWithTransactionType:TransactionTypePreAuth];
}

- (void)idealTransactionOperation {
    [self.judoKitSession invokeIDEALPaymentWithJudoId:judoId
                                               amount:[JPAmount amount:@"0.01" currency:@"EUR"]
                                            reference:[JPReference consumerReference:kConsumerReference]
                                           completion:^(JPResponse *response, NSError *error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)initApplePaySleveWithTransactionType:(TransactionType)transactionType {
    ApplePayConfiguration *configuration = [self applePayConfigurationWithType:transactionType];
    [self.judoKitSession invokeApplePayWithConfiguration:configuration
                                              completion:^(JPResponse *_Nullable response, NSError *_Nullable error) {
        [self handleCallbackWithResponse:response andError:error];
    }];
}

- (void)standaloneApplePayButton {
    ApplePayButtonViewController *avc = [[ApplePayButtonViewController alloc] initWithCurrentSession: self.judoKitSession];
    [self.navigationController pushViewController:avc animated:YES];
}

#pragma mark - Helper methods

- (void)handleCallbackWithResponse:(JPResponse *)response
                          andError:(NSError *)error {
    if (error) {
        [self handleError:error];
        return;
    }
    
    [self handleResponse:response];
}

- (void)handleError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (error.code != JudoErrorUserDidCancel) {
        [self presentErrorWithMessage:error.localizedDescription];
    }
}

- (void)handleResponse:(JPResponse *)response {
    JPTransactionData *transactionData = response.items.firstObject;
    
    if (!transactionData) {
        [self presentErrorWithMessage:@"Callback returned empty response"];
        return;
    }
    
    if (transactionData.cardDetails) {
        self.cardDetails = transactionData.cardDetails;
        self.payToken = transactionData.paymentToken;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [self presentDetailsViewControllerWithTransactionData:transactionData];
    }];
}

- (void)presentDetailsViewControllerWithTransactionData:(JPTransactionData *)transactionData {
    DetailViewController *viewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    viewController.transactionData = transactionData;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)presentErrorWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (ApplePayConfiguration *)applePayConfigurationWithType:(TransactionType)transactionType {
    
    NSDecimalNumber *itemOnePrice = [NSDecimalNumber decimalNumberWithString:@"0.01"];
    NSDecimalNumber *itemTwoPrice = [NSDecimalNumber decimalNumberWithString:@"0.02"];
    NSDecimalNumber *totalPrice = [NSDecimalNumber decimalNumberWithString:@"0.03"];
    
    NSArray *items = @[[PaymentSummaryItem itemWithLabel:@"Item 1" amount:itemOnePrice],
                       [PaymentSummaryItem itemWithLabel:@"Item 2" amount:itemTwoPrice],
                       [PaymentSummaryItem itemWithLabel:@"Tim Apple" amount:totalPrice]];
    
    NSTimeInterval timeInterval = [NSDate new].timeIntervalSince1970;
    NSString *uniquePaymentReference = [NSString stringWithFormat:@"example-reference-%f", timeInterval];
    
    JPReference *reference = [[JPReference alloc] initWithConsumerReference:kConsumerReference
                                                           paymentReference:uniquePaymentReference];
    
    reference.metaData = @{@"example-key": @"example-value"};
    
    ApplePayConfiguration *configuration = [[ApplePayConfiguration alloc] initWithJudoId:judoId
                                                                               reference:reference
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

#pragma mark - Lazy properties

- (JPAmount *)amount {
    if (!_amount) {
        _amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.settings.currency];
    }
    return _amount;
}

- (Settings *)settings {
    if (!_settings) {
        _settings = Settings.defaultSettings;
    }
    return _settings;
}

- (NSArray<DemoFeature *> *)features {
    if (!_features) {
        _features = DemoFeature.defaultFeatures;
    }
    return _features;
}

@end

@implementation MainViewController (TableViewDelegates)

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
    }
}

@end

@implementation MainViewController (Settings)

- (void)settingsViewController:(SettingsViewController *)viewController
             didUpdateSettings:(Settings *)settings {
    self.settings = settings;
    self.judoKitSession.theme.avsEnabled = settings.isAVSEnabled;
}

- (IBAction)settingsButtonHandler:(id)sender {
    SettingsViewController *svc = [[SettingsViewController alloc] initWithSettings:self.settings];
    svc.delegate = self;
    svc.modalPresentationStyle = UIModalPresentationCustom;
    svc.transitioningDelegate = self;
    [self presentViewController:svc animated:YES completion:nil];
}

@end
