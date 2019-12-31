//
//  JudoPayViewController.m
//  JudoKitObjC
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

#import "JudoPayViewController.h"
#import "BillingCountryInputField.h"
#import "CardInputField.h"
#import "DateInputField.h"
#import "FloatingTextField.h"
#import "IssueNumberInputField.h"
#import "JP3DSWebView.h"
#import "JPPaymentToken.h"
#import "JPSession.h"
#import "JPTheme.h"
#import "JPTransaction.h"
#import "JudoKit.h"
#import "LoadingView.h"
#import "NSError+Judo.h"
#import "PostCodeInputField.h"
#import "SecurityCodeInputField.h"

#import "Functions.h"
#import "JPAddress.h"
#import "JPCard.h"
#import "JPTheme+Additions.h"
#import "NSString+Card.h"
#import "NSString+Localize.h"
#import "NSString+Manipulation.h"
#import "NSTimer+Blocks.h"
#import "UIColor+Judo.h"
#import "UIView+SafeAnchors.h"
#import "UIViewController+Additions.h"

@import CoreLocation;

static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve) {
    UIViewAnimationOptions opt = (UIViewAnimationOptions)curve;
    return opt << 16;
}

@interface JudoPayViewController () <WKNavigationDelegate, JudoPayInputDelegate>

@property (nonatomic, assign) BOOL paymentEnabled;
@property (nonatomic, assign) BOOL isMakingTransaction;
@property (nonatomic, assign) CGFloat currentKeyboardHeight;

@property (nonatomic, readonly) BOOL isTokenPayment;

@property (nonatomic, strong, readwrite) JPAmount *amount;
@property (nonatomic, strong, readwrite) NSString *judoId;
@property (nonatomic, strong, readwrite) JPReference *reference;

@property (nonatomic, strong) NSString *pending3DSReceiptId;
@property (nonatomic, strong) JudoCompletionBlock completionBlock;

@property (nonatomic, strong) JPCardDetails *cardDetails;

@property (nonatomic, strong, readwrite) UIScrollView *scrollView;

@property (nonatomic, strong) NSLayoutConstraint *keyboardHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *maestroFieldsHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *avsFieldsHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *securityMessageTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *paymentButtonHeightConstraint;

@property (nonatomic, strong) UILabel *securityMessageLabel;

@property (nonatomic, strong, readwrite) UIButton *paymentButton;
@property (nonatomic, strong) UIBarButtonItem *paymentNavBarButton;

@property (nonatomic, strong, readwrite) LoadingView *loadingView;
@property (nonatomic, strong, readwrite) JP3DSWebView *threeDSWebView;

@property (nonatomic, assign, readwrite) TransactionType transactionType;
@property (nonatomic, strong, readwrite) JPTransaction *transaction;

@property (nonatomic, strong, readwrite) CardInputField *cardInputField;
@property (nonatomic, strong, readwrite) DateInputField *expiryDateInputField;
@property (nonatomic, strong, readwrite) SecurityCodeInputField *securityCodeInputField;
@property (nonatomic, strong, readwrite) DateInputField *startDateInputField;
@property (nonatomic, strong, readwrite) IssueNumberInputField *issueNumberInputField;
@property (nonatomic, strong, readwrite) PostCodeInputField *postCodeInputField;
@property (nonatomic, strong, readwrite) BillingCountryInputField *billingCountryInputField;

@end

@implementation JudoPayViewController

#pragma mark - Keyboard notification configuration

- (void)keyboardWillShow:(NSNotification *)note {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) {
        return;
    }

    UIViewAnimationCurve animationCurve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat animationDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    self.currentKeyboardHeight = keyboardRect.size.height;

    self.keyboardHeightConstraint.constant = -1 * keyboardRect.size.height + self.view.safeAreaEdgeInsets.bottom;

    [self.paymentButton setNeedsUpdateConstraints];

    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationOptionsWithCurve(animationCurve)
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)note {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) {
        return;
    }

    UIViewAnimationCurve animationCurve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat animationDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    self.currentKeyboardHeight = 0.0;

    self.keyboardHeightConstraint.constant = 0;

    [self.paymentButton setNeedsUpdateConstraints];

    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationOptionsWithCurve(animationCurve)
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        return;
    }

    UIViewAnimationCurve animationCurve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat animationDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    self.currentKeyboardHeight = keyboardRect.size.height;

    self.keyboardHeightConstraint.constant = -1 * keyboardRect.size.height;

    [self.paymentButton setNeedsUpdateConstraints];

    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationOptionsWithCurve(animationCurve)
                     animations:^{
                         [self.paymentButton layoutIfNeeded];
                     }
                     completion:nil];
}

#pragma mark - Initialization

- (instancetype)initWithJudoId:(NSString *)judoId
                        amount:(JPAmount *)amount
                     reference:(JPReference *)reference
                   transaction:(TransactionType)type
                currentSession:(JudoKit *)session
                   cardDetails:(JPCardDetails *)cardDetails
                    completion:(JudoCompletionBlock)completion {

    if (self = [super init]) {
        _judoId = judoId;
        _amount = amount;
        _reference = reference;
        _type = type;
        _judoKitSession = session;
        _cardDetails = cardDetails;
        _completionBlock = completion;
        _transactionType = type;
        _transaction = [_judoKitSession transactionForType:type
                                                    judoId:judoId
                                                    amount:amount
                                                 reference:reference];
    }

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter addObserver:self
                           selector:@selector(keyboardWillShow:)
                               name:UIKeyboardWillShowNotification
                             object:nil];

    [notificationCenter addObserver:self
                           selector:@selector(keyboardWillHide:)
                               name:UIKeyboardWillHideNotification
                             object:nil];

    [notificationCenter addObserver:self
                           selector:@selector(keyboardWillChangeFrame:)
                               name:UIKeyboardWillShowNotification
                             object:nil];

    NSDictionary *dictionary = @{@"UserAgent" : getUserAgent()};
    [NSUserDefaults.standardUserDefaults registerDefaults:dictionary];
    [NSUserDefaults.standardUserDefaults synchronize];

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];

    self.judoKitSession.apiSession.uiClientMode = YES;
    self.title = [self.theme titleForTransactionWithType:self.transactionType];
    self.threeDSWebView.navigationDelegate = self;

    // Button Actions
    BOOL isRegisterCard = self.transactionType == TransactionTypeRegisterCard || self.transactionType == TransactionTypeSaveCard;
    NSString *payNavBarButtonTitle = isRegisterCard ? self.theme.registerCardNavBarButtonTitle : self.theme.paymentButtonTitle;

    [self.paymentButton addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    self.paymentNavBarButton = [[UIBarButtonItem alloc] initWithTitle:payNavBarButtonTitle
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(payButtonAction:)];

    self.paymentNavBarButton.enabled = NO;
    [self.paymentNavBarButton setTintColor:self.theme.tintColor];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.theme.backButtonTitle
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(doneButtonAction:)];
    self.navigationItem.rightBarButtonItem = self.paymentNavBarButton;
    self.navigationController.presentationController.delegate = self;
    [self applyTheme:self.theme];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self paymentEnabled:NO];

    if (self.cardDetails == nil && self.cardInputField.textField.text) {
        [self.cardInputField textFieldDidChangeValue:self.cardInputField.textField];
        [self.expiryDateInputField textFieldDidChangeValue:self.cardInputField.textField];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.cardInputField.textField.text.length) {
        if (self.cardInputField.cardNetwork == CardNetworkMaestro) {
            [self.startDateInputField.textField becomeFirstResponder];
        } else {
            [self.securityCodeInputField.textField becomeFirstResponder];
        }
    } else {
        [self.cardInputField.textField becomeFirstResponder];
    }
}

- (void)setupView {

    // Themes (needs to be set before setting up subviews
    self.loadingView = [LoadingView new];
    self.loadingView.theme = self.theme;

    NSString *paymentButtonTitle = (self.transactionType == TransactionTypeRegisterCard || self.transactionType == TransactionTypeSaveCard) ? self.theme.registerCardTitle : self.theme.paymentButtonTitle;

    self.loadingView.actionLabel.text = (self.transactionType == TransactionTypeRegisterCard || self.transactionType == TransactionTypeSaveCard) ? self.theme.loadingIndicatorRegisterCardTitle : self.theme.loadingIndicatorProcessingTitle;

    [self.paymentButton setTitle:paymentButtonTitle forState:UIControlStateNormal];

    self.startDateInputField.isStartDate = YES;

    // View
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = self.view.bounds.size;

    [self.scrollView addSubview:self.cardInputField];
    [self.scrollView addSubview:self.startDateInputField];
    [self.scrollView addSubview:self.issueNumberInputField];
    [self.scrollView addSubview:self.expiryDateInputField];
    [self.scrollView addSubview:self.securityCodeInputField];
    [self.scrollView addSubview:self.billingCountryInputField];
    [self.scrollView addSubview:self.postCodeInputField];
    [self.scrollView addSubview:self.securityMessageLabel];

    [self.view addSubview:self.paymentButton];
    [self.view addSubview:self.threeDSWebView];
    [self.view addSubview:self.loadingView];

    // Delegates
    self.cardInputField.delegate = self;
    self.startDateInputField.delegate = self;
    self.issueNumberInputField.delegate = self;
    self.expiryDateInputField.delegate = self;
    self.securityCodeInputField.delegate = self;
    self.billingCountryInputField.delegate = self;
    self.postCodeInputField.delegate = self;

    // Layout Constraints
    self.keyboardHeightConstraint = [self.paymentButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0];
    self.paymentButtonHeightConstraint = [self.paymentButton.heightAnchor constraintEqualToConstant:self.theme.buttonHeight];

    NSArray *constraints = @[
        self.paymentButtonHeightConstraint,
        [self.paymentButton.leftAnchor constraintEqualToAnchor:self.view.safeLeftAnchor],
        [self.paymentButton.rightAnchor constraintEqualToAnchor:self.view.safeRightAnchor],
        self.keyboardHeightConstraint,

        [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.safeLeftAnchor],
        [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.safeRightAnchor],

        [self.loadingView.leftAnchor constraintEqualToAnchor:self.view.safeLeftAnchor],
        [self.loadingView.rightAnchor constraintEqualToAnchor:self.view.safeRightAnchor],
        [self.loadingView.topAnchor constraintEqualToAnchor:self.view.safeTopAnchor],
        [self.loadingView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

        [self.threeDSWebView.leftAnchor constraintEqualToAnchor:self.view.safeLeftAnchor],
        [self.threeDSWebView.rightAnchor constraintEqualToAnchor:self.view.safeRightAnchor],
        [self.threeDSWebView.topAnchor constraintEqualToAnchor:self.view.safeTopAnchor],
        [self.threeDSWebView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ];

    [NSLayoutConstraint activateConstraints:constraints];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]-1-[button]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"scrollView" : self.scrollView,
                                                                                @"button" : self.paymentButton}]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[tdsecure]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"tdsecure" : self.threeDSWebView}]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(68)-[tdsecure]-(30)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"tdsecure" : self.threeDSWebView}]];

    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[card]-(-1)-|" options:0 metrics:nil views:@{@"card" : self.cardInputField}]];

    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.cardInputField
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scrollView
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0
                                                                 constant:2]];

    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[expiry]-(-1)-[security(==expiry)]-(-1)-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"expiry" : self.expiryDateInputField, @"security" : self.securityCodeInputField}]];

    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[start]-(-1)-[issue(==start)]-(-1)-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"start" : self.startDateInputField, @"issue" : self.issueNumberInputField}]];

    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[billing]-(-1)-[post(==billing)]-(-1)-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"billing" : self.billingCountryInputField, @"post" : self.postCodeInputField}]];

    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(12)-[securityMessage]-(12)-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"securityMessage" : self.securityMessageLabel}]];

    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[card(fieldHeight)]-(5)-[start]-(5)-[expiry(fieldHeight)]-(5)-[billing]-(20)-|"
                                                                            options:0
                                                                            metrics:@{@"fieldHeight" : @(self.theme.inputFieldHeight)}
                                                                              views:@{@"card" : self.cardInputField,
                                                                                      @"start" : self.startDateInputField,
                                                                                      @"expiry" : self.expiryDateInputField,
                                                                                      @"billing" : self.billingCountryInputField}]];

    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[card(fieldHeight)]-(5)-[issue(==start)]-(5)-[security(fieldHeight)]-(5)-[post]-(20)-|"
                                                                            options:0
                                                                            metrics:@{@"fieldHeight" : @(self.theme.inputFieldHeight)}
                                                                              views:@{@"card" : self.cardInputField,
                                                                                      @"issue" : self.issueNumberInputField,
                                                                                      @"start" : self.startDateInputField,
                                                                                      @"security" : self.securityCodeInputField,
                                                                                      @"post" : self.postCodeInputField}]];

    self.maestroFieldsHeightConstraint = [NSLayoutConstraint constraintWithItem:self.startDateInputField
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0
                                                                       constant:1.0];

    self.avsFieldsHeightConstraint = [NSLayoutConstraint constraintWithItem:self.billingCountryInputField
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:0.0];

    self.securityMessageTopConstraint = [NSLayoutConstraint constraintWithItem:self.securityMessageLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.postCodeInputField
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:0.0f];

    self.securityMessageLabel.hidden = !self.theme.showSecurityMessage;

    [self.startDateInputField addConstraint:self.maestroFieldsHeightConstraint];
    [self.billingCountryInputField addConstraint:self.avsFieldsHeightConstraint];

    [self.scrollView addConstraint:self.securityMessageTopConstraint];

    if (self.cardDetails) {
        NSString *formattedLastFour = [self.cardDetails formattedCardLastFour];
        NSString *formattedExpiryDate = [self.cardDetails formattedExpiryDate];
        [self updateInputFieldsWithNetwork:self.cardDetails.cardNetwork];
        self.cardInputField.textField.text = self.isTokenPayment ? formattedLastFour : [self.cardDetails.cardNumber cardPresentationStringWithAcceptedNetworks:self.theme.acceptedCardNetworks error:nil];
        self.expiryDateInputField.textField.text = formattedExpiryDate;
        self.cardInputField.textField.alpha = self.isTokenPayment ? 0.5f : 1.0f;
        self.expiryDateInputField.textField.alpha = self.isTokenPayment ? 0.5f : 1.0f;
        [self updateInputFieldsWithNetwork:[self.cardDetails cardNetwork]];
        self.securityCodeInputField.isTokenPayment = self.isTokenPayment;
        self.cardInputField.isTokenPayment = self.isTokenPayment;
        self.cardInputField.userInteractionEnabled = !self.isTokenPayment;
        self.expiryDateInputField.userInteractionEnabled = !self.isTokenPayment;
        self.cardInputField.textField.secureTextEntry = NO;
    }
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];

    CGFloat bottomInset = 0.0;

    if (@available(iOS 11.0, *)) {
        bottomInset = self.view.safeAreaInsets.bottom;
    } else {
        bottomInset = self.bottomLayoutGuide.length;
    }

    [self.paymentButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, bottomInset, 0)];
    self.paymentButtonHeightConstraint.constant = self.theme.buttonHeight + bottomInset;
    [self.paymentButton setNeedsUpdateConstraints];
}

#pragma mark - Actions
- (void)payButtonAction:(id)sender {
    if (!self.reference || !self.judoId) {
        if (self.completionBlock) {
            self.completionBlock(nil, [NSError judoParameterError]);
        }
        return;
    }

    if (self.isMakingTransaction) {
        return;
    }

    self.isMakingTransaction = YES;
    self.paymentNavBarButton.enabled = NO;

    [self.securityCodeInputField.textField resignFirstResponder];
    [self.postCodeInputField.textField resignFirstResponder];

    [self.loadingView startAnimating];

    if (self.paymentToken) {
        self.paymentToken.secureCode = self.securityCodeInputField.textField.text;
        [self.transaction setPaymentToken:self.paymentToken];
    } else {
        JPAddress *address = nil;
        if (self.theme.avsEnabled && self.postCodeInputField.textField.text) {
            address = [JPAddress new];
            address.postCode = self.postCodeInputField.textField.text;
            address.billingCountry = self.billingCountryInputField.textField.text;
        }

        NSString *issueNumber = nil;
        NSString *startDate = nil;

        if (self.cardInputField.cardNetwork == CardNetworkMaestro) {
            issueNumber = self.issueNumberInputField.textField.text;
            startDate = self.startDateInputField.textField.text;
        }

        NSString *cardNumberString = self.cardDetails.cardNumber;

        if (!cardNumberString) {
            cardNumberString = [self.cardInputField.textField.text stringByRemovingWhitespaces];
        }

        JPCard *card = [[JPCard alloc] initWithCardNumber:cardNumberString
                                           cardholderName:nil
                                               expiryDate:self.expiryDateInputField.textField.text
                                               secureCode:self.securityCodeInputField.textField.text];

        card.cardAddress = address;
        card.issueNumber = issueNumber;
        card.startDate = startDate;

        [self.transaction setCard:card];
    }

    [self sendPaymentRequest];
}

- (void)sendPaymentRequest {
    [self.judoKitSession sendWithCompletion:self.transaction
                                 completion:^(JPResponse *response, NSError *error) {
                                     if (!self.completionBlock) {
                                         return;
                                     }

                                     if (response) {
                                         self.completionBlock(response, nil);
                                         [self.loadingView stopAnimating];
                                         return;
                                     }

                                     if (error && error.domain == JudoErrorDomain && error.code == JudoError3DSRequest) {
                                         if (!error.userInfo) {
                                             self.completionBlock(nil, [NSError judoResponseParseError]);
                                             return;
                                         }

                                         NSError *load3DSerror = nil;

                                         self.pending3DSReceiptId = [self.threeDSWebView load3DSWithPayload:error.userInfo error:&load3DSerror];

                                         if (load3DSerror) {
                                             self.completionBlock(nil, load3DSerror);
                                             [self.loadingView stopAnimating];
                                             return;
                                         }

                                         self.loadingView.actionLabel.text = self.theme.redirecting3DSTitle;
                                         self.title = self.theme.authenticationTitle;
                                         [self paymentEnabled:NO];
                                         return;
                                     }

                                     self.completionBlock(nil, error);
                                 }];
}

- (void)doneButtonAction:(id)sender {
    if (self.completionBlock) {
        self.completionBlock(nil, [NSError judoUserDidCancelError]);
    }
}

- (void)toggleStartDateVisibility:(BOOL)isVisible {
    self.maestroFieldsHeightConstraint.constant = isVisible ? self.theme.inputFieldHeight : 0;
    [self.issueNumberInputField setNeedsUpdateConstraints];
    [self.startDateInputField setNeedsUpdateConstraints];

    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.issueNumberInputField layoutIfNeeded];
                         [self.startDateInputField layoutIfNeeded];
                         [self.expiryDateInputField layoutIfNeeded];
                         [self.securityCodeInputField layoutIfNeeded];
                     }];
}

- (void)toggleAVSVisibility:(BOOL)isVisible completion:(void (^)(void))completion {
    self.avsFieldsHeightConstraint.constant = isVisible ? self.theme.inputFieldHeight : 0;
    [self.billingCountryInputField setNeedsUpdateConstraints];
    [self.postCodeInputField setNeedsUpdateConstraints];

    [UIView animateWithDuration:0.2
        animations:^{
            [self.billingCountryInputField layoutIfNeeded];
            [self.postCodeInputField layoutIfNeeded];
        }
        completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
}

- (void)updateInputFieldsWithNetwork:(CardNetwork)network {
    self.cardInputField.cardNetwork = network;
    [self.cardInputField updateCardLogo];
    self.securityCodeInputField.cardNetwork = network;
    [self.securityCodeInputField updateCardLogo];
    [self.securityCodeInputField.textField setPlaceholder:self.securityCodeInputField.title floatingTitle:self.securityCodeInputField.title];
    [self toggleStartDateVisibility:(network == CardNetworkMaestro)];
}

- (void)paymentEnabled:(BOOL)enabled {
    self.paymentEnabled = enabled;
    self.paymentButton.hidden = !enabled;

    if (_currentKeyboardHeight > 0) {
        self.keyboardHeightConstraint.constant = -_currentKeyboardHeight + self.view.safeAreaEdgeInsets.bottom;
        [self.paymentButton setNeedsUpdateConstraints];
    }

    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(enabled ? UIViewAnimationOptionCurveEaseOut : UIViewAnimationOptionCurveEaseIn)animations:^{
                            [self.paymentButton layoutIfNeeded];
                        }
                     completion:nil];

    self.paymentNavBarButton.enabled = enabled;
}

- (void)showHintAfterDefaultDelay:(JPInputField *)input {
    BOOL showHint = self.securityCodeInputField.isTokenPayment && !self.securityCodeInputField.textField.text.length;
    if (showHint) {
        [input displayHint:self.securityCodeInputField.hintLabelText];
    } else {
        [input displayHint:@""];
    }

    [self updateSecurityMessagePosition:!showHint];

    [NSTimer scheduleWithDelay:3.0
                       handler:^(CFRunLoopTimerRef runLoopTimerRef) {
                           NSString *hintLabelText = input.hintLabelText;
                           if (hintLabelText.length && !input.textField.text.length && input.textField.isFirstResponder) {
                               [self updateSecurityMessagePosition:NO];
                               [input displayHint:hintLabelText];
                           }
                       }];
}

- (void)updateSecurityMessagePosition:(BOOL)toggleUp {
    [self.scrollView layoutIfNeeded];
    //self.securityMessageTopConstraint.constant = (toggleUp && !self.hintLabel.isActive) ? -self.hintLabel.bounds.size.height : 14.0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.scrollView layoutIfNeeded];
                     }];
}

#pragma mark - Lazy Loading

- (BOOL)isTokenPayment {
    return self.paymentToken != nil;
}

- (JP3DSWebView *)threeDSWebView {
    if (!_threeDSWebView) {
        _threeDSWebView = [JP3DSWebView new];
        _threeDSWebView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _threeDSWebView;
}

- (CardInputField *)cardInputField {
    if (!_cardInputField) {
        _cardInputField = [[CardInputField alloc] initWithTheme:self.theme];
        _cardInputField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _cardInputField;
}

- (DateInputField *)startDateInputField {
    if (!_startDateInputField) {
        _startDateInputField = [[DateInputField alloc] initWithTheme:self.theme];
        _startDateInputField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _startDateInputField;
}

- (IssueNumberInputField *)issueNumberInputField {
    if (!_issueNumberInputField) {
        _issueNumberInputField = [[IssueNumberInputField alloc] initWithTheme:self.theme];
        _issueNumberInputField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _issueNumberInputField;
}

- (DateInputField *)expiryDateInputField {
    if (!_expiryDateInputField) {
        _expiryDateInputField = [[DateInputField alloc] initWithTheme:self.theme];
        _expiryDateInputField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _expiryDateInputField;
}

- (SecurityCodeInputField *)securityCodeInputField {
    if (!_securityCodeInputField) {
        _securityCodeInputField = [[SecurityCodeInputField alloc] initWithTheme:self.theme];
        _securityCodeInputField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _securityCodeInputField;
}

- (BillingCountryInputField *)billingCountryInputField {
    if (!_billingCountryInputField) {
        _billingCountryInputField = [[BillingCountryInputField alloc] initWithTheme:self.theme];
        _billingCountryInputField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _billingCountryInputField;
}

- (PostCodeInputField *)postCodeInputField {
    if (!_postCodeInputField) {
        _postCodeInputField = [[PostCodeInputField alloc] initWithTheme:self.theme];
        _postCodeInputField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _postCodeInputField;
}

- (UILabel *)securityMessageLabel {
    if (_securityMessageLabel) {
        return _securityMessageLabel;
    }

    _securityMessageLabel = [UILabel new];
    _securityMessageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _securityMessageLabel.numberOfLines = 0;

    NSDictionary *attributes = @{NSForegroundColorAttributeName : self.theme.judoTextColor,
                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:self.theme.securityMessageTextSize]};

    NSDictionary *boldAttributes = @{NSForegroundColorAttributeName : self.theme.judoTextColor,
                                     NSFontAttributeName : [UIFont systemFontOfSize:self.theme.securityMessageTextSize]};

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"secure_server".localized
                                                                                         attributes:attributes];

    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:self.theme.securityMessageString
                                                                             attributes:boldAttributes]];

    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = 3.0f;

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    _securityMessageLabel.attributedText = attributedString;
    return _securityMessageLabel;
}

- (UIButton *)paymentButton {
    if (!_paymentButton) {
        _paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _paymentButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_paymentButton setBackgroundImage:self.theme.judoButtonColor.asImage forState:UIControlStateNormal];
        [_paymentButton setTitle:@"pay".localized forState:UIControlStateNormal];
        [_paymentButton.titleLabel setFont:self.theme.buttonFont];
        [_paymentButton setTitleColor:self.theme.judoButtonTitleColor forState:UIControlStateNormal];
    }
    return _paymentButton;
}

#pragma mark - JudoPayInputDelegate

- (void)cardInput:(CardInputField *)input didFailWithError:(NSError *)error {
    [input errorAnimation:(error.code == JudoErrorInvalidCardNumberError)];
    if (error.userInfo[NSLocalizedDescriptionKey]) {
        [input displayError:error.userInfo[NSLocalizedDescriptionKey]];
    }
}

- (void)cardInput:(CardInputField *)input didFindValidNumber:(NSString *)cardNumberString {
    if (input.cardNetwork == CardNetworkMaestro) {
        [self.startDateInputField.textField becomeFirstResponder];
    } else {
        [self.expiryDateInputField.textField becomeFirstResponder];
    }
}

- (void)cardInput:(CardInputField *)input didDetectNetwork:(CardNetwork)network {
    [self updateInputFieldsWithNetwork:network];
    [input displayHint:@""];
}

- (void)dateInput:(DateInputField *)input didFailWithError:(NSError *)error {
    [input errorAnimation:(error.code == JudoErrorInputMismatchError)];
    if (error.userInfo[NSLocalizedDescriptionKey]) {
        [input displayError:error.userInfo[NSLocalizedDescriptionKey]];
    }
}

- (void)dateInput:(DateInputField *)input didFindValidDate:(NSDate *)date {
    [input displayHint:@""];
    if (input == self.startDateInputField) {
        [self.issueNumberInputField.textField becomeFirstResponder];
    } else {
        [self.securityCodeInputField.textField becomeFirstResponder];
    }
}

- (void)issueNumberInputDidEnterCode:(IssueNumberInputField *)input withIssueNumber:(NSString *)issueNumber {
    if (issueNumber.length == 3) {
        [self.expiryDateInputField.textField becomeFirstResponder];
    }
}

- (void)billingCountryInput:(BillingCountryInputField *)input didSelect:(BillingCountry)billingCountry {
    self.postCodeInputField.billingCountry = billingCountry;
    self.postCodeInputField.textField.text = @"";
    self.postCodeInputField.userInteractionEnabled = billingCountry != BillingCountryOther;
    [self judoPayInputDidChangeText:self.billingCountryInputField];
}

- (void)postCodeInputField:(PostCodeInputField *)input didFailWithError:(NSError *)error {
    if (error.userInfo[NSLocalizedDescriptionKey]) {
        [input displayError:error.userInfo[NSLocalizedDescriptionKey]];
    }
}

- (void)judoPayInput:(JPInputField *)input didValidate:(BOOL)valid {
    if (input == self.securityCodeInputField) {
        if (self.theme.avsEnabled && valid) {
            [self.postCodeInputField.textField becomeFirstResponder];
            [self toggleAVSVisibility:YES
                           completion:^{
                               [self.scrollView scrollRectToVisible:self.postCodeInputField.frame animated:YES];
                           }];
        }
    } else if (input == self.postCodeInputField) {
        [input displayHint:@""];
    }
}

- (void)judoPayInputDidChangeText:(JPInputField *)input {
    [self showHintAfterDefaultDelay:input];
    BOOL allFieldsValid = NO;
    allFieldsValid = (self.cardDetails.cardNumber.isCardNumberValid || self.cardInputField.isValid) && self.expiryDateInputField.isValid && self.securityCodeInputField.isValid;
    if (self.theme.avsEnabled) {
        allFieldsValid = allFieldsValid && self.postCodeInputField.isValid && self.billingCountryInputField.isValid;
    }
    if (self.cardInputField.cardNetwork == CardNetworkMaestro) {
        allFieldsValid = allFieldsValid && (self.issueNumberInputField.isValid || self.startDateInputField.isValid);
    }
    [self paymentEnabled:allFieldsValid];
}

#pragma mark - WKNavigation Delegate Methods

- (void)handleRedirectForWebView:(WKWebView *)webView
                     redirectURL:(NSString *)redirectURL
                 decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableString *javascriptCode = [NSMutableString new];

        [javascriptCode appendString:@"const paRes = document.getElementsByName('PaRes')[0].value;"];
        [javascriptCode appendString:@"const md = document.getElementsByName('MD')[0].value;"];
        [javascriptCode appendString:@"[paRes, md]"];

        [webView evaluateJavaScript:javascriptCode
                  completionHandler:^(NSArray *response, NSError *error) {
                      NSDictionary *responseDictionary = [self mapToDictionaryWithResponse:response];
                      [self setLoadingViewTitleForTransactionType:self.transactionType];
                      [self handleACSFormWithResponse:responseDictionary decisionHandler:decisionHandler];
                  }];
    });
}

- (void)handleACSFormWithResponse:(NSDictionary *)response
                  decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    if (!self.pending3DSReceiptId) {
        if (self.completionBlock) {
            self.completionBlock(nil, [NSError judo3DSRequestFailedErrorWithUnderlyingError:nil]);
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }

    [self.loadingView startAnimating];
    self.title = self.theme.authenticationTitle;

    [self.transaction threeDSecureWithParameters:response
                                       receiptId:self.pending3DSReceiptId
                                      completion:^(JPResponse *response, NSError *error) {
                                          [self.loadingView stopAnimating];

                                          if (self.completionBlock) {
                                              if (response) {
                                                  self.completionBlock(response, nil);
                                                  decisionHandler(WKNavigationActionPolicyAllow);

                                              } else {
                                                  NSError *judoError = error ? error : NSError.judoResponseParseError;
                                                  self.completionBlock(nil, judoError);
                                                  decisionHandler(WKNavigationActionPolicyCancel);
                                              }
                                          }
                                      }];
}

- (NSDictionary *)mapToDictionaryWithResponse:(NSArray *)response {

    if (response.count != 2)
        return nil;

    return @{
        @"PaRes" : response[0],
        @"MD" : [response[1] stringByReplacingOccurrencesOfString:@" " withString:@"+"]
    };
}

- (void)setLoadingViewTitleForTransactionType:(TransactionType)transactionType {
    if (transactionType == TransactionTypeRegisterCard) {
        self.loadingView.actionLabel.text = self.theme.verifying3DSRegisterCardTitle;
    } else {
        self.loadingView.actionLabel.text = self.theme.verifying3DSPaymentTitle;
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSString *urlString = navigationAction.request.URL.absoluteString;

    if ([urlString rangeOfString:@"Parse3DS"].location == NSNotFound) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }

    [self handleRedirectForWebView:webView redirectURL:urlString decisionHandler:decisionHandler];
    return;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    NSMutableString *scriptContent = [NSMutableString stringWithString:@"const meta = document.createElement('meta');"];
    [scriptContent appendString:@"meta.name='viewport';"];
    [scriptContent appendString:@"meta.content='width=device-width';"];
    [scriptContent appendString:@"const head = document.getElementsByTagName('head')[0];"];
    [scriptContent appendString:@"head.appendChild(meta);"];
    [scriptContent appendString:@"meta.name"];

    [_threeDSWebView evaluateJavaScript:scriptContent completionHandler:nil];

    NSMutableString *removePaResFieldScript = [NSMutableString stringWithString:@"const paResField = document.getElementById('pnPaRESPanel');"];
    [removePaResFieldScript appendString:@"paResField.parentElement.removeChild(paResField);"];
    [removePaResFieldScript appendString:@"paResField.name"];

    [_threeDSWebView evaluateJavaScript:removePaResFieldScript completionHandler:nil];

    CGFloat alphaVal = 1.0f;
    if ([webView.URL.absoluteString isEqualToString:@"about:blank"]) {
        alphaVal = 0.0f;
    }
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.threeDSWebView.alpha = alphaVal;
                         [self.loadingView stopAnimating];
                     }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.threeDSWebView.alpha = 0.0f;
                         [self.loadingView stopAnimating];
                     }];

    if (self.completionBlock) {
        self.completionBlock(nil, [NSError judo3DSRequestFailedErrorWithUnderlyingError:error]);
    }
}

#pragma mark -  UIAdaptivePresentationControllerDelegate methods
- (void)presentationControllerWillDismiss:(UIPresentationController *)presentationController {
    if (self.completionBlock) {
        self.completionBlock(nil, [NSError judoUserDidCancelError]);
    }
}

@end
