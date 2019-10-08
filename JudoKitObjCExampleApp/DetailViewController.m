//
//  DetailViewController.m
//  JudoKitDemoObjC
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

#import "DetailViewController.h"
#import "ContactInformation.h"
#import "DetailsTableViewController.h"

@import JudoKitObjC;

@interface DetailViewController ()

@property (nonatomic, strong) IBOutlet UILabel *dateStampLabel;
@property (nonatomic, strong) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *resolutionLabel;
@property (weak, nonatomic) IBOutlet UIStackView *billingAddressStackView;
@property (weak, nonatomic) IBOutlet UIStackView *shippingAddressStackView;
@property (weak, nonatomic) IBOutlet UILabel *billingAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *shippingAddressLabel;

@property (nonatomic, strong) NSDateFormatter *inputDateFormatter;
@property (nonatomic, strong) NSDateFormatter *outputDateFormatter;

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Payment receipt";
    self.navigationItem.hidesBackButton = YES;
    
    if (self.transactionData) {
        NSDate *createdAtDate = [self.inputDateFormatter dateFromString:self.transactionData.createdAt];
        self.dateStampLabel.text = [self.outputDateFormatter stringFromDate:createdAtDate];
        
        self.numberFormatter.currencyCode = self.transactionData.amount.currency;
        self.amountLabel.text = self.transactionData.amount.amount;
        self.resolutionLabel.text = self.transactionData.message;
    }
    
    if (self.billingInformation) {
        [self.billingAddressStackView setHidden:NO];
        self.billingAddressLabel.text = self.billingInformation.toString;
    }
    
    if (self.shippingInformation) {
        [self.shippingAddressStackView setHidden:NO];
        self.shippingAddressLabel.text = self.shippingInformation.toString;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.transactionData) {
        self.numberFormatter.currencyCode = self.transactionData.amount.currency;
        self.amountLabel.text = [self.numberFormatter stringFromNumber:@([self.transactionData.amount.amount floatValue])];
        self.resolutionLabel.text = self.transactionData.message;
    }
}

- (IBAction)homeButtonHandler:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)presentCardDetailsData:(id)sender {
    JPCardDetails *cardDetails = self.transactionData.cardDetails;
    
    if (!cardDetails) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:@"No card details data to display."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }

    NSArray<DetailsRow *> *rows = @[
    [DetailsRow withTitle:@"Card last 4 digits" andValue: cardDetails.cardLastFour],
    [DetailsRow withTitle:@"End date" andValue: cardDetails.endDate],
    [DetailsRow withTitle:@"Card token" andValue: cardDetails.cardToken],
    [DetailsRow withTitle:@"Card type" andValue: [NSString stringWithFormat:@"%lu", (unsigned long)cardDetails.cardNetwork]],
    [DetailsRow withTitle:@"Bank" andValue: cardDetails.bank],
    [DetailsRow withTitle:@"Card category" andValue: cardDetails.cardCategory],
    [DetailsRow withTitle:@"Card country" andValue: cardDetails.cardCountry],
    [DetailsRow withTitle:@"Card funding" andValue: cardDetails.cardFunding],
    [DetailsRow withTitle:@"Card scheme" andValue: cardDetails.cardScheme]
    ];
    
    NSArray<DetailsSection *> *sections = @[[[DetailsSection alloc] initWithTitle:@"Card Details" rows: rows]];
    DetailsTableViewController *detailsViewController = [[DetailsTableViewController alloc] initWithData:sections andTitle:@"Details"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailsViewController];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Lazy Loading

- (NSDateFormatter *)inputDateFormatter {
    if (_inputDateFormatter == nil) {
        _inputDateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        [_inputDateFormatter setLocale:enUSPOSIXLocale];
        [_inputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSZZZZZ"];
    }
    return _inputDateFormatter;
}

- (NSDateFormatter *)outputDateFormatter {
    if (_outputDateFormatter == nil) {
        _outputDateFormatter = [[NSDateFormatter alloc] init];
        [_outputDateFormatter setDateFormat:@"yyyy-MM-dd, HH:mm"];
    }
    return _outputDateFormatter;
}

- (NSNumberFormatter *)numberFormatter {
    if (_numberFormatter == nil) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        _numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    return _numberFormatter;
}

@end
