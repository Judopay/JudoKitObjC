//
//  ViewController.m
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

#import "ViewController.h"
#import "DetailViewController.h"
#import "ExampleAppCredentials.h"
#import "ApplePayConfiguration.h"

#import "JudoKitObjC.h"

typedef NS_ENUM(NSUInteger, TableViewContent) {
    TableViewContentPayment,
    TableViewContentPreAuth,
    TableViewContentCreateCardToken,
    TableViewContentSaveCard,
    TableViewContentRepeatPayment,
    TableViewContentTokenPreAuth,
    TableViewContentApplePayPayment,
    TableViewContentApplePayPreAuth,
    TableViewContentPaymentMethods
};

static NSString * const kCellIdentifier     = @"com.judo.judopaysample.tableviewcellidentifier";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    UIAlertController *_alertController;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *settingsViewBottomConstraint;
@property (nonatomic, strong) NSString *currentCurrency;

@property (nonatomic, strong) JPCardDetails *cardDetails;
@property (nonatomic, strong) JPPaymentToken *payToken;

@property (nonatomic, strong) UIView *tableFooterView;
@property (nonatomic, strong) JudoKit *judoKitSession;

@property (nonatomic, nonnull, strong) NSString *reference;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // initialize the SDK by setting it up with a token and a secret
    self.judoKitSession = [[JudoKit alloc] initWithToken:token secret:secret];
    
    self.currentCurrency = @"GBP";
    
    self.reference = [self getSampleConsumerReference];
    
    // setting the SDK to Sandbox Mode - once this is set, the SDK wil stay in Sandbox mode until the process is killed
    self.judoKitSession.apiSession.sandboxed = YES;
    self.judoKitSession.theme.showSecurityMessage = YES;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = self.tableFooterView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_alertController) {
        [self presentViewController:_alertController animated:YES completion:nil];
        _alertController = nil;
    }
}

#pragma mark - Actions

- (IBAction)settingsButtonHandler:(id)sender {
    if (self.settingsViewBottomConstraint.constant != 0) {
        [self.view layoutIfNeeded];
        self.settingsViewBottomConstraint.constant = 0.0f;
        [UIView animateWithDuration:.5f animations:^{
            self.tableView.alpha = 0.2f;
            [self.view layoutIfNeeded];
        }];
    }
}

- (IBAction)settingsButtonDismissHandler:(id)sender {
    if (self.settingsViewBottomConstraint.constant == 0) {
        [self.view layoutIfNeeded];
        self.settingsViewBottomConstraint.constant = -350.0f;
        [UIView animateWithDuration:.5f animations:^{
            self.tableView.alpha = 1.0f;
            [self.view layoutIfNeeded];
        }];
    }
}

- (IBAction)segmentedControlValueChange:(UISegmentedControl *)segmentedControl {
    self.currentCurrency = [segmentedControl titleForSegmentAtIndex:segmentedControl.selectedSegmentIndex];
}

- (IBAction)AVSValueChanged:(UISwitch *)theSwitch {
    self.judoKitSession.theme.avsEnabled = theSwitch.on;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    NSString *tvText;
    NSString *tvDetailText;
    
    switch (indexPath.row) {
        case TableViewContentPayment:
            tvText = @"Payment";
            tvDetailText = @"with default settings";
            break;
            
        case TableViewContentPreAuth:
            tvText = @"PreAuth";
            tvDetailText = @"to reserve funds on a card";
            break;
            
        case TableViewContentCreateCardToken:
            tvText = @"Register card";
            tvDetailText = @"to be stored for future transactions";
            break;
            
        case TableViewContentSaveCard:
            tvText = @"Save card";
            tvDetailText = @"to be stored for future transactions";
            break;
            
        case TableViewContentRepeatPayment:
            tvText = @"Token payment";
            tvDetailText = @"with a stored card token";
            break;
            
        case TableViewContentTokenPreAuth:
            tvText = @"Token preAuth";
            tvDetailText = @"with a stored card token";
            break;
            
        case TableViewContentApplePayPayment:
            tvText = @"Apple Pay payment";
            tvDetailText = @"with a wallet card";
            break;
            
        case TableViewContentApplePayPreAuth:
            tvText = @"Apple Pay preAuth";
            tvDetailText = @"with a wallet card";
            break;
            
        case TableViewContentPaymentMethods:
            tvText = @"Payment Method";
            tvDetailText = @"with default payment methods";
            break;
            
        default:
            break;
    }
    
    cell.textLabel.text = tvText;
    cell.detailTextLabel.text = tvDetailText;
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TableViewContent type = indexPath.row;
    
    switch (type) {
        case TableViewContentPayment:
            [self paymentOperation];
            break;
            
        case TableViewContentPreAuth:
            [self preAuthOperation];
            break;
            
        case TableViewContentCreateCardToken:
            [self createCardTokenOperation];
            break;
            
        case TableViewContentSaveCard:
            [self saveCardOperation];
            break;
            
        case TableViewContentRepeatPayment:
            [self tokenPaymentOperation];
            break;
            
        case TableViewContentTokenPreAuth:
            [self tokenPreAuthOperation];
            break;
            
        case TableViewContentApplePayPayment:
            [self applePayPaymentOperation];
            break;
            
        case TableViewContentApplePayPreAuth:
            [self applePayPreAuthOperation];
            break;
            
        case TableViewContentPaymentMethods:
            [self paymentMethodOption];
            break;
            
        default:
            break;
    }
}

#pragma mark - Operations

- (void)paymentMethodOption {
    JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.currentCurrency];
    
    ApplePayConfiguration *configuration = [self applePayConfigurationWithType:TransactionTypePayment];

    [self.judoKitSession invokePayment:judoId
                                amount:amount
                     consumerReference:self.reference
                        paymentMethods:PaymentMethodsAll
               applePayConfiguratation: configuration
                           cardDetails:nil
                            completion:^(JPResponse * response, NSError * error) {
                                if (error || response.items.count == 0) {
                                    if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        return;
                                    }
                                    self->_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.userInfo[NSLocalizedDescriptionKey] preferredStyle:UIAlertControllerStyleAlert];
                                    [self->_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                                    [self dismissViewControllerAnimated:YES completion:nil];
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
    JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.currentCurrency];
    
    [self.judoKitSession invokePayment:judoId amount:amount consumerReference:self.reference cardDetails:nil completion:^(JPResponse * response, NSError * error) {
        if (error || response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            self->_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.userInfo[NSLocalizedDescriptionKey] preferredStyle:UIAlertControllerStyleAlert];
            [self->_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self dismissViewControllerAnimated:YES completion:nil];
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
    JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.currentCurrency];
    
    [self.judoKitSession invokePreAuth:judoId amount:amount consumerReference:self.reference cardDetails:nil completion:^(JPResponse * response, NSError * error) {
        if (error || response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            self->_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.userInfo[NSLocalizedDescriptionKey] preferredStyle:UIAlertControllerStyleAlert];
            [self->_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self dismissViewControllerAnimated:YES completion:nil];
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
    [self.judoKitSession invokeRegisterCard:judoId consumerReference:self.reference cardDetails:nil completion:^(JPResponse * response, NSError * error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        if (error && response.items.count == 0) {
            if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            self->_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.userInfo[NSLocalizedDescriptionKey] preferredStyle:UIAlertControllerStyleAlert];
            [self->_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
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
            self->_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.userInfo[NSLocalizedDescriptionKey] preferredStyle:UIAlertControllerStyleAlert];
            [self->_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            return;
        }
        
        JPTransactionData *tData = response.items[0];
        if (tData.cardDetails) {
            self.cardDetails = tData.cardDetails;
            self.payToken = tData.paymentToken;
        }
    }];
}

- (void)tokenPaymentOperation {
    if (self.cardDetails) {
        JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.currentCurrency];
        
        [self.judoKitSession invokeTokenPayment:judoId amount:amount consumerReference:self.reference cardDetails:self.cardDetails paymentToken:self.payToken completion:^(JPResponse * response, NSError * error) {
            if (error || response.items.count == 0) {
                if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    return;
                }
                self->_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.userInfo[NSLocalizedDescriptionKey] preferredStyle:UIAlertControllerStyleAlert];
                [self->_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)tokenPreAuthOperation {
    if (self.cardDetails) {
        JPAmount *amount = [[JPAmount alloc] initWithAmount:@"0.01" currency:self.currentCurrency];
        
        [self.judoKitSession invokeTokenPreAuth:judoId amount:amount consumerReference:self.reference cardDetails:self.cardDetails paymentToken:self.payToken completion:^(JPResponse * response, NSError * error) {
            if (error || response.items.count == 0) {
                if (error.domain == JudoErrorDomain && error.code == JudoErrorUserDidCancel) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    return;
                }
                self->_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.userInfo[NSLocalizedDescriptionKey] preferredStyle:UIAlertControllerStyleAlert];
                [self->_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [self dismissViewControllerAnimated:YES completion:nil];
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
#pragma mark - Lazy Loading

- (UIView *)tableFooterView {
    if (_tableFooterView == nil) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, self.view.bounds.size.width - 30, 50)];
        label.numberOfLines = 2;
        label.text = @"To view test card details:\nSign in to judo and go to Developer/Tools.";
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = [UIColor grayColor];
        [_tableFooterView addSubview:label];
    }
    return _tableFooterView;
}

- (NSString *)getSampleConsumerReference {
    return @"judoPay-sample-app-objc";
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
                                                                               reference:self.reference
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

@end
