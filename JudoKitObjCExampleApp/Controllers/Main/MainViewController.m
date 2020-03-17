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

#import "MainViewController.h"
#import "DetailViewController.h"
#import "ExampleAppCredentials.h"
#import "JPApplePayConfiguration.h"
#import "SettingsViewController.h"
#import "HalfHeightPresentationController.h"
#import "DemoFeature.h"
#import "Settings.h"
#import "JudoKitObjC.h"

static NSString * const kCellIdentifier = @"com.judo.judopaysample.tableviewcellidentifier";
static NSString * const kConsumerReference = @"judoPay-sample-app-objc";

@interface MainViewController ()

@property (nonatomic, strong) JPAmount *amount;
@property (nonatomic, strong) JPReference *reference;
@property (nonatomic, strong) JPCardDetails *cardDetails;
@property (nonatomic, strong) JPPaymentToken *payToken;
@property (nonatomic, strong) JudoKit *judoKitSession;
@property (nonatomic, strong) JPConfiguration *configuration;
@property (nonatomic, strong) JPApplePayConfiguration *applePayConfiguration;
@property (strong, nonatomic) CLLocationManager *locationManager;
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
    self.judoKitSession.isSandboxed = YES;
}

- (void)requestLocationPermissions {
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
}

#pragma mark - SDK Features

- (void)paymentOperation {
    [self.judoKitSession invokeTransactionWithType:TransactionTypePayment
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [self handleResponse:response];
    }];
}

- (void)preAuthOperation {
    [self.judoKitSession invokeTransactionWithType:TransactionTypePreAuth
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [self handleResponse:response];
    }];
}

- (void)createCardTokenOperation {
    [self.judoKitSession invokeTransactionWithType:TransactionTypeRegisterCard
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [self handleResponse:response];
    }];
}

- (void)checkCardOperation {
    [self.judoKitSession invokeTransactionWithType:TransactionTypeCheckCard
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [self handleResponse:response];
    }];
}

- (void)saveCardOperation {
    [self.judoKitSession invokeTransactionWithType:TransactionTypeSaveCard
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [self handleResponse:response];
    }];
}

- (void)applePayPaymentOperation {
    [self.judoKitSession invokeApplePayWithMode:TransactionModePayment
                                  configuration:self.applePayConfiguration
                                     completion:^(JPResponse *response, NSError *error) {
        [self handleResponse:response];
    }];
}

- (void)applePayPreAuthOperation {
    [self.judoKitSession invokeApplePayWithMode:TransactionModePreAuth
                                  configuration:self.applePayConfiguration
                                     completion:^(JPResponse *response, NSError *error) {
        [self handleResponse:response];
    }];
}

- (void)paymentMethodOperation {
    [self.judoKitSession invokePaymentMethodScreenWithMode:TransactionModePayment
                                             configuration:self.configuration
                                                completion:^(JPResponse *response, NSError *error) {
        [self handleResponse:response];
    }];
}

- (void)preAuthMethodOperation {
    [self.judoKitSession invokePaymentMethodScreenWithMode:TransactionModePreAuth
                                             configuration:self.configuration
                                                completion:^(JPResponse *response, NSError *error) {
        [self handleResponse:response];
    }];
}

#pragma mark - Helper methods

- (void)handleResponse:(JPResponse *)response {
    
    if (!response) {
        return;
    }
    
    JPTransactionData *transactionData = response.items.firstObject;

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

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    return [[HalfHeightPresentationController alloc] initWithPresentedViewController:presented
                                                            presentingViewController:presenting];
}

#pragma mark - Lazy properties

- (JPConfiguration *)configuration {
    if (!_configuration) {
        _configuration = [[JPConfiguration alloc] initWithJudoID:judoId
                                                          amount:self.amount
                                                       reference:self.reference];
        
        _configuration.siteId = siteId;
        _configuration.cardAddress = [[JPAddress alloc] initWithLine1:@"myAddress1"
                                                                line2:@"myAddress2"
                                                                line3:@"myAddress3"
                                                                 town:@"myTown"
                                                       billingCountry:@"myCountry"
                                                             postCode:@"myPostalCode"];
        
        _configuration.paymentMethods = @[JPPaymentMethod.card, JPPaymentMethod.iDeal, JPPaymentMethod.applePay];
        _configuration.supportedCardNetworks = CardNetworkVisa | CardNetworkMasterCard | CardNetworkAMEX;
        _configuration.applePayConfiguration = self.applePayConfiguration;
    }
    return _configuration;
}

- (JPApplePayConfiguration *)applePayConfiguration {
    
    NSDecimalNumber *itemOnePrice = [NSDecimalNumber decimalNumberWithString:@"0.01"];
    NSDecimalNumber *itemTwoPrice = [NSDecimalNumber decimalNumberWithString:@"0.02"];
    NSDecimalNumber *totalPrice = [NSDecimalNumber decimalNumberWithString:@"0.03"];
    
    NSArray *items = @[[JPPaymentSummaryItem itemWithLabel:@"Item 1" amount:itemOnePrice],
                       [JPPaymentSummaryItem itemWithLabel:@"Item 2" amount:itemTwoPrice],
                       [JPPaymentSummaryItem itemWithLabel:@"Tim Apple" amount:totalPrice]];
 
    JPApplePayConfiguration *configuration = [[JPApplePayConfiguration alloc] initWithMerchantId:merchantId
                                                                                        currency:self.settings.currency
                                                                                     countryCode:@"GB"
                                                                             paymentSummaryItems:items];
    configuration.requiredShippingContactFields = ContactFieldAll;
    configuration.requiredBillingContactFields = ContactFieldAll;
    configuration.returnedContactInfo = ReturnedInfoAll;

    return configuration;
}

- (JPAmount *)amount {
    if (!_amount) {
        _amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.settings.currency];
    }
    return _amount;
}

- (JPReference *)reference {
    if (!_reference) {
        _reference = [JPReference consumerReference:kConsumerReference];
        _reference.metaData = @{@"exampleMetaKey": @"exampleMetaValue"};
    }
    return _reference;
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

        case DemoFeatureTypeApplePayPayment:
            [self applePayPaymentOperation];
            break;

        case DemoFeatureTypeApplePayPreAuth:
            [self applePayPreAuthOperation];
            break;

        case DemoFeatureTypePaymentMethods:
            [self paymentMethodOperation];
            break;

        case DemoFeatureTypePreAuthMethods:
            [self preAuthMethodOperation];
            break;
    }
}

@end

@implementation MainViewController (Settings)

- (void)settingsViewController:(SettingsViewController *)viewController
             didUpdateSettings:(Settings *)settings {
    self.settings = settings;
    self.configuration.uiConfiguration.isAVSEnabled = settings.isAVSEnabled;
    self.configuration.amount = [JPAmount amount:self.configuration.amount.amount
                                        currency:settings.currency];
}
 
- (IBAction)settingsButtonHandler:(id)sender {
    SettingsViewController *svc = [[SettingsViewController alloc] initWithSettings:self.settings];
    svc.delegate = self;
    svc.modalPresentationStyle = UIModalPresentationCustom;
    svc.transitioningDelegate = self;
    [self presentViewController:svc animated:YES completion:nil];
}

@end
