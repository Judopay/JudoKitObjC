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
#import <JudoKitObjC/JudoKitObjC.h>
#import <InAppSettingsKit/IASKAppSettingsViewController.h>

#import "MainViewController.h"
#import "DetailViewController.h"
#import "DemoFeature.h"
#import "Settings.h"

static NSString * const kCellIdentifier = @"com.judo.judopaysample.tableviewcellidentifier";
static NSString * const kConsumerReference = @"judoPay-sample-app-objc";

@interface MainViewController ()

@property (nonatomic, strong) JPReference *reference;
@property (nonatomic, strong) JPCardDetails *cardDetails;
@property (nonatomic, strong) JPPaymentToken *payToken;
@property (nonatomic, strong) JudoKit *judoKitSession;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray <DemoFeature *> *features;
@property (strong, nonatomic) Settings *settings;

// INFO: Workaround for the judoKitSession setup
@property (nonatomic, strong) NSArray <NSString *> *settingsToObserve;
@property (nonatomic, assign) BOOL shouldSetupJudoSDK;

@end

@implementation MainViewController

// MARK: View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.features = DemoFeature.defaultFeatures;
    self.settingsToObserve = @[kSandboxedKey, kTokenKey, kSecretKey];
    self.shouldSetupJudoSDK = YES;
    
    [self requestLocationPermissions];
    [self setupPropertiesObservation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // When isSandbox | token | secred changed in the settings, re-init the JudoKitSession
    if (self.shouldSetupJudoSDK) {
        self.shouldSetupJudoSDK = NO;
        [self setupJudoSDK];
    }
}

- (void)dealloc {
    [self removePropertiesObservation];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    if ([self.settingsToObserve containsObject:keyPath]) {
        self.shouldSetupJudoSDK = YES;
    }
}

// MARK: Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass: IASKAppSettingsViewController.class]) {
        IASKAppSettingsViewController *controller = segue.destinationViewController;
        controller.neverShowPrivacySettings = YES;
    }
}

// MARK: Setup methods

- (void)setupJudoSDK {
    self.judoKitSession = [[JudoKit alloc] initWithToken:self.settings.token
                                                  secret:self.settings.secret];
    self.judoKitSession.isSandboxed = self.settings.isSandboxed;
}

- (void)setupPropertiesObservation {
    for (NSString *property in self.settingsToObserve) {
        [NSUserDefaults.standardUserDefaults addObserver:self
                                              forKeyPath:property
                                                 options:NSKeyValueObservingOptionNew
                                                 context:NULL];
    }
}

- (void)removePropertiesObservation {
    for (NSString *property in self.settingsToObserve) {
        [NSUserDefaults.standardUserDefaults removeObserver:self forKeyPath:property];
    }
}

- (void)requestLocationPermissions {
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
}

// MARK: SDK Features

- (void)paymentOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokeTransactionWithType:TransactionTypePayment
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [weakSelf handleResponse:response error:error];
    }];
}

- (void)preAuthOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokeTransactionWithType:TransactionTypePreAuth
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [weakSelf handleResponse:response error:error];
    }];
}

- (void)createCardTokenOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokeTransactionWithType:TransactionTypeRegisterCard
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [weakSelf handleResponse:response error:error];
    }];
}

- (void)checkCardOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokeTransactionWithType:TransactionTypeCheckCard
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [weakSelf handleResponse:response error:error];
    }];
}

- (void)saveCardOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokeTransactionWithType:TransactionTypeSaveCard
                                     configuration:self.configuration
                                        completion:^(JPResponse *response, NSError *error) {
        [weakSelf handleResponse:response error:error];
    }];
}

- (void)applePayPaymentOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokeApplePayWithMode:TransactionModePayment
                                  configuration:self.configuration
                                     completion:^(JPResponse *response, NSError *error) {
        [weakSelf handleResponse:response error:error];
    }];
}

- (void)applePayPreAuthOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokeApplePayWithMode:TransactionModePreAuth
                                  configuration:self.configuration
                                     completion:^(JPResponse *response, NSError *error) {
        [weakSelf handleResponse:response error:error];
    }];
}

- (void)paymentMethodOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokePaymentMethodScreenWithMode:TransactionModePayment
                                             configuration:self.configuration
                                                completion:^(JPResponse *response, NSError *error) {
        [weakSelf handleResponse:response error:error];
    }];
}

- (void)preAuthMethodOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokePaymentMethodScreenWithMode:TransactionModePreAuth
                                             configuration:self.configuration
                                                completion:^(JPResponse *response, NSError *error) {
        [weakSelf handleResponse:response error:error];
    }];
}

- (void)serverToServerMethodOperation {
    __weak typeof(self) weakSelf = self;
    [self.judoKitSession invokePaymentMethodScreenWithMode:TransactionModeServerToServer
                                             configuration:self.configuration
                                                completion:^(JPResponse *response, NSError *error) {
                                  [weakSelf handleResponse:response error:error];
    }];
}

// MARK: Helper methods

- (void)handleResponse:(JPResponse *)response error:(NSError *)error {
    if (error) {
        [self presentErrorWithMessage: error.localizedDescription];
        return;
    }
    
    if (!response) {
        return;
    }
    
    JPTransactionData *transactionData = response.items.firstObject;
    
    if (transactionData.cardDetails) {
        self.cardDetails = transactionData.cardDetails;
        self.payToken = transactionData.paymentToken;
    }
    
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf presentDetailsViewControllerWithTransactionData:transactionData];
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

// MARK: Lazy properties

- (JPConfiguration *)configuration {
    JPConfiguration *configuration = [[JPConfiguration alloc] initWithJudoID:self.settings.judoId
                                                                      amount:self.settings.amount
                                                                   reference:self.reference];
    configuration.siteId = self.settings.siteId;
    configuration.paymentMethods = self.settings.paymentMethods;
    configuration.uiConfiguration.isAVSEnabled = self.settings.isAVSEnabled;
    configuration.uiConfiguration.shouldDisplayAmount = self.settings.isAmountLabelEnabled;
    configuration.supportedCardNetworks = self.settings.supportedCardNetworks;
    configuration.applePayConfiguration = self.applePayConfiguration;
    return configuration;
}

- (JPApplePayConfiguration *)applePayConfiguration {
    
    NSDecimalNumber *itemOnePrice = [NSDecimalNumber decimalNumberWithString:@"0.01"];
    NSDecimalNumber *itemTwoPrice = [NSDecimalNumber decimalNumberWithString:@"0.02"];
    NSDecimalNumber *totalPrice = [NSDecimalNumber decimalNumberWithString:@"0.03"];
    
    NSArray *items = @[[JPPaymentSummaryItem itemWithLabel:@"Item 1" amount:itemOnePrice],
                       [JPPaymentSummaryItem itemWithLabel:@"Item 2" amount:itemTwoPrice],
                       [JPPaymentSummaryItem itemWithLabel:@"Tim Apple" amount:totalPrice]];
    
    JPApplePayConfiguration *configuration = [[JPApplePayConfiguration alloc] initWithMerchantId:self.settings.applePayMerchantId
                                                                                        currency:self.settings.amount.currency
                                                                                     countryCode:@"GB"
                                                                             paymentSummaryItems:items];
    configuration.requiredShippingContactFields = ContactFieldAll;
    configuration.requiredBillingContactFields = ContactFieldAll;
    configuration.returnedContactInfo = ReturnedInfoAll;
    configuration.shippingMethods = @[[[PaymentShippingMethod alloc] initWithIdentifier:@"method"
                                                                                 detail:@"details"
                                                                                  label:@"label"
                                                                                 amount:totalPrice
                                                                                   type:JPPaymentSummaryItemTypeFinal]];
    return configuration;
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
        _settings = [[Settings alloc] initWith:NSUserDefaults.standardUserDefaults];
    }
    return _settings;
}

@end

@implementation MainViewController (TableViewDelegates)

// MARK: UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.features.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Features";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"To view test card details:\nSign in to judo and go to Developer/Tools.";
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    DemoFeature *option = self.features[indexPath.row];
    cell.textLabel.text = option.title;
    cell.detailTextLabel.text = option.details;
    return cell;
}

// MARK: UITableViewDelegate

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
            
        case DemoFeatureTypeServerToServer:
            [self serverToServerMethodOperation];
            break;
    }
}

@end
