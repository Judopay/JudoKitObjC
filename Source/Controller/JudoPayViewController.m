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
#import "JPTransaction.h"
#import "JPSession.h"
#import "JP3DSWebView.h"
#import "JPPaymentToken.h"
#import "CardInputField.h"
#import "DateInputField.h"
#import "SecurityCodeInputField.h"
#import "PostCodeInputField.h"
#import "BillingCountryInputField.h"
#import "IssueNumberInputField.h"
#import "NSError+Judo.h"
#import "JudoKit.h"
#import "JPTheme.h"
#import "LoadingView.h"
#import "FloatingTextField.h"

#import "NSString+Card.h"
#import "UIColor+Judo.h"
#import "NSTimer+Blocks.h"

#import "JPCard.h"
#import "JPAddress.h"

@import CoreLocation;

static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve) {
    UIViewAnimationOptions opt = (UIViewAnimationOptions)curve;
    return opt << 16;
}



@interface JudoPayViewController () <UIWebViewDelegate, JudoPayInputDelegate> {
    BOOL _paymentEnabled;
    BOOL _isMakingTransaction;
    CGFloat _currentKeyboardHeight;
}

@property (nonatomic, readonly) BOOL isTokenPayment;

@property (nonatomic, strong, readwrite) JPAmount *amount;
@property (nonatomic, strong, readwrite) NSString *judoId;
@property (nonatomic, strong, readwrite) JPReference *reference;

@property (nonatomic, strong) NSString *pending3DSReceiptId;
@property (nonatomic, strong) JudoCompletionBlock completionBlock;

@property (nonatomic, strong) JPCardDetails *cardDetails;

@property (nonatomic, strong, readwrite) UIScrollView *contentView;

@property (nonatomic, strong) NSLayoutConstraint *keyboardHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *maestroFieldsHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *avsFieldsHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *securityMessageTopConstraint;

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
        return; // BAIL
    }
    
    UIViewAnimationCurve animationCurve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat animationDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _currentKeyboardHeight = keyboardRect.size.height;
    
    self.keyboardHeightConstraint.constant = -1 * keyboardRect.size.height + (_paymentEnabled ? 0 : self.paymentButton.bounds.size.height);
    
    [self.paymentButton setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOptionsWithCurve(animationCurve) animations:^{
        [self.paymentButton layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)note {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) {
        return; // BAIL
    }
    
    UIViewAnimationCurve animationCurve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat animationDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    _currentKeyboardHeight = 0.0;
    
    self.keyboardHeightConstraint.constant = (_paymentEnabled ? 0 : self.paymentButton.bounds.size.height);
    
    [self.paymentButton setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOptionsWithCurve(animationCurve) animations:^{
        [self.paymentButton layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        return; // BAIL
    }
    
    UIViewAnimationCurve animationCurve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat animationDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _currentKeyboardHeight = keyboardRect.size.height;
    
    self.keyboardHeightConstraint.constant = -1 * keyboardRect.size.height + (_paymentEnabled ? 0 : self.paymentButton.bounds.size.height);
    
    [self.paymentButton setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOptionsWithCurve(animationCurve) animations:^{
        [self.paymentButton layoutIfNeeded];
    } completion:nil];
}

#pragma mark - Initialization

- (instancetype)initWithJudoId:(NSString *)judoId amount:(JPAmount *)amount reference:(JPReference *)reference transaction:(TransactionType)type currentSession:(JudoKit *)session cardDetails:(JPCardDetails *)cardDetails completion:(JudoCompletionBlock)completion {
    self = [super init];
    if (self) {
        self.judoId = judoId;
        self.amount = amount;
        self.reference = reference;
        self.type = type;
        self.judoKitSession = session;
        self.cardDetails = cardDetails;
        self.completionBlock = completion;
        self.cardDetails = cardDetails;
        self.transactionType = type;
        self.transaction = [self.judoKitSession transactionForType:type judoId:judoId amount:amount reference:reference];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
    
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
    
    self.title = self.transactionTitle;
    
    self.threeDSWebView.delegate = self;
    
    // Button Actions
    NSString *payNavBarButtonTitle = self.transactionType == TransactionTypeRegisterCard ? self.theme.registerCardNavBarButtonTitle : self.theme.paymentButtonTitle;
    
    [self.paymentButton addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.paymentNavBarButton = [[UIBarButtonItem alloc] initWithTitle:payNavBarButtonTitle style:UIBarButtonItemStyleDone target:self action:@selector(payButtonAction:)];
    
    self.paymentNavBarButton.enabled = NO;
    
    [self.paymentNavBarButton setTintColor:self.theme.tintColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.theme.backButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonAction:)];
    self.navigationItem.rightBarButtonItem = self.paymentNavBarButton;
    
    self.navigationController.navigationBar.tintColor = self.theme.judoTextColor;
    
    if (![self.theme.tintColor colorMode]) {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:self.theme.judoNavigationBarTitleColor};
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
    self.loadingView.theme = self.theme;
    
    NSString *paymentButtonTitle = self.transactionType == TransactionTypeRegisterCard ? self.theme.registerCardTitle : self.theme.paymentButtonTitle;
    
    self.loadingView.actionLabel.text = self.transactionType == TransactionTypeRegisterCard ? self.theme.loadingIndicatorRegisterCardTitle : self.theme.loadingIndicatorProcessingTitle;
    
    [self.paymentButton setTitle:paymentButtonTitle forState:UIControlStateNormal];
    
    self.startDateInputField.isStartDate = YES;
    
    // View
    [self.view addSubview:self.contentView];
    self.contentView.contentSize = self.view.bounds.size;
    
    self.view.backgroundColor = [self.theme judoContentViewBackgroundColor];
    
    [self.contentView addSubview:self.cardInputField];
    [self.contentView addSubview:self.startDateInputField];
    [self.contentView addSubview:self.issueNumberInputField];
    [self.contentView addSubview:self.expiryDateInputField];
    [self.contentView addSubview:self.securityCodeInputField];
    [self.contentView addSubview:self.billingCountryInputField];
    [self.contentView addSubview:self.postCodeInputField];
    [self.contentView addSubview:self.securityMessageLabel];
    
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
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:0 metrics:nil views:@{@"scrollView":self.contentView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]-1-[button]" options:0 metrics:nil views:@{@"scrollView":self.contentView, @"button":self.paymentButton}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[loadingView]|" options:0 metrics:nil views:@{@"loadingView":self.loadingView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[loadingView]|" options:0 metrics:nil views:@{@"loadingView":self.loadingView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[tdsecure]-|" options:0 metrics:nil views:@{@"tdsecure":self.threeDSWebView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(68)-[tdsecure]-(30)-|" options:0 metrics:nil views:@{@"tdsecure":self.threeDSWebView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[button]|" options:0 metrics:nil views:@{@"button":self.paymentButton}]];
    
    [self.paymentButton addConstraint:[NSLayoutConstraint constraintWithItem:self.paymentButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50]];
    
    self.keyboardHeightConstraint = [NSLayoutConstraint constraintWithItem:self.paymentButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:_paymentEnabled ? 0 : 50];
    
    [self.view addConstraint:self.keyboardHeightConstraint];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[card]-(-1)-|" options:0 metrics:nil views:@{@"card":self.cardInputField}]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.cardInputField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:2]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[expiry]-(-1)-[security(==expiry)]-(-1)-|" options:0 metrics:nil views:@{@"expiry":self.expiryDateInputField, @"security":self.securityCodeInputField}]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[start]-(-1)-[issue(==start)]-(-1)-|" options:0 metrics:nil views:@{@"start":self.startDateInputField, @"issue":self.issueNumberInputField}]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[billing]-(-1)-[post(==billing)]-(-1)-|" options:0 metrics:nil views:@{@"billing":self.billingCountryInputField, @"post":self.postCodeInputField}]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(12)-[securityMessage]-(12)-|" options:0 metrics:nil views:@{@"securityMessage":self.securityMessageLabel}]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[card(fieldHeight)]-(5)-[start]-(5)-[expiry(fieldHeight)]-(5)-[billing]-(20)-|" options:0 metrics:@{@"fieldHeight":@(self.theme.inputFieldHeight)} views:@{@"card":self.cardInputField, @"start":self.startDateInputField, @"expiry":self.expiryDateInputField, @"billing":self.billingCountryInputField}]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[card(fieldHeight)]-(5)-[issue(==start)]-(5)-[security(fieldHeight)]-(5)-[post]-(20)-|" options:0 metrics:@{@"fieldHeight":@(self.theme.inputFieldHeight)} views:@{@"card":self.cardInputField, @"issue":self.issueNumberInputField, @"start":self.startDateInputField, @"security":self.securityCodeInputField, @"post":self.postCodeInputField}]];
    
    self.maestroFieldsHeightConstraint = [NSLayoutConstraint constraintWithItem:self.startDateInputField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.0];
    
    self.avsFieldsHeightConstraint = [NSLayoutConstraint constraintWithItem:self.billingCountryInputField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.0];
    
    self.securityMessageTopConstraint = [NSLayoutConstraint constraintWithItem:self.securityMessageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.postCodeInputField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0f];
    
    self.securityMessageLabel.hidden = !self.theme.showSecurityMessage;
    
    [self.startDateInputField addConstraint:self.maestroFieldsHeightConstraint];
    [self.billingCountryInputField addConstraint:self.avsFieldsHeightConstraint];
    
    [self.contentView addConstraint:self.securityMessageTopConstraint];
    
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

#pragma mark - Actions


- (void)payButtonAction:(id)sender {
    if (!self.reference || !self.amount || !self.judoId) {
        if (self.completionBlock) {
            self.completionBlock(nil, [NSError judoParameterError]);
        }
        return; // BAIL
    }
    
    if (_isMakingTransaction) {
        return; // BAIL
    }
    
    _isMakingTransaction = YES;
    self.paymentNavBarButton.enabled = NO;
    
    [self.securityCodeInputField.textField resignFirstResponder];
    [self.postCodeInputField.textField resignFirstResponder];
    
    [self.loadingView startAnimating];
    
    if (self.paymentToken) {
        self.paymentToken.secureCode = self.securityCodeInputField.textField.text;
        [self.transaction setPaymentToken:self.paymentToken];
    } else {
        JPAddress *address = nil;
        if (self.theme.avsEnabled) {
            if (self.postCodeInputField.textField.text) {
                address = [JPAddress new];
                address.postCode = self.postCodeInputField.textField.text;
                address.billingCountry = self.billingCountryInputField.textField.text;
            }
        }
        
        NSString *issueNumber = nil;
        NSString *startDate = nil;
        
        if (self.cardInputField.cardNetwork == CardNetworkMaestro) {
            issueNumber = self.issueNumberInputField.textField.text;
            startDate = self.startDateInputField.textField.text;
        }
        
        NSString *cardNumberString = self.cardDetails.cardNumber;
        
        if (!cardNumberString) {
            cardNumberString = [self.cardInputField.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        
        JPCard *card = [[JPCard alloc] initWithCardNumber:cardNumberString
                                               expiryDate:self.expiryDateInputField.textField.text
                                               secureCode:self.securityCodeInputField.textField.text];
        
        card.cardAddress = address;
        
        card.issueNumber = issueNumber;
        card.startDate = startDate;
        
        [self.transaction setCard:card];
    }
    
    [self.judoKitSession sendWithCompletion:self.transaction completion:^(JPResponse * response, NSError * error) {
        if (error) {
            if (error.domain == JudoErrorDomain && error.code == JudoError3DSRequest) {
                if (!error.userInfo) {
                    if (self.completionBlock) {
                        self.completionBlock(nil, [NSError judoResponseParseError]);
                        return; // BAIL
                    }
                }
                
                NSError *load3DSerror = nil;
                
                self.pending3DSReceiptId = [self.threeDSWebView load3DSWithPayload:error.userInfo error:&load3DSerror];
                
                if (load3DSerror && self.completionBlock) {
                    self.completionBlock(nil, load3DSerror);
                    [self.loadingView stopAnimating];
                    return; // BAIL
                }
                
                self.loadingView.actionLabel.text = self.theme.redirecting3DSTitle;
                self.title = self.theme.authenticationTitle;
                [self paymentEnabled:NO];
                
            } else if (self.completionBlock) {
                self.completionBlock(nil, error);
            }
        } else if (response) {
            if (self.completionBlock) {
                self.completionBlock(response, nil);
                [self.loadingView stopAnimating];
            }
        }
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
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.issueNumberInputField layoutIfNeeded];
        [self.startDateInputField layoutIfNeeded];
        
        [self.expiryDateInputField layoutIfNeeded];
        [self.securityCodeInputField layoutIfNeeded];
    }];
}

- (void)toggleAVSVisibility:(BOOL)isVisible completion:(void (^)())completion {
    self.avsFieldsHeightConstraint.constant = isVisible ? self.theme.inputFieldHeight : 0;
    [self.billingCountryInputField setNeedsUpdateConstraints];
    [self.postCodeInputField setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.billingCountryInputField layoutIfNeeded];
        [self.postCodeInputField layoutIfNeeded];
        
    } completion:^(BOOL finished) {
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
    _paymentEnabled = enabled;
    self.paymentButton.hidden = !enabled;
    
    self.keyboardHeightConstraint.constant = -_currentKeyboardHeight + (_paymentEnabled ? 0 : self.paymentButton.bounds.size.height);
    
    [self.paymentButton setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.25 delay:0.0 options:(enabled ? UIViewAnimationOptionCurveEaseOut : UIViewAnimationOptionCurveEaseIn) animations:^{
        [self.paymentButton layoutIfNeeded];
    } completion:nil];
    
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
    
    [NSTimer scheduleWithDelay:3.0 handler:^(CFRunLoopTimerRef runLoopTimerRef) {
        NSString *hintLabelText = input.hintLabelText;
        if (hintLabelText.length && !input.textField.text.length && input.textField.isFirstResponder) {
            [self updateSecurityMessagePosition:NO];
            [input displayHint:hintLabelText];
        }
    }];
}

- (void)updateSecurityMessagePosition:(BOOL)toggleUp {
    [self.contentView layoutIfNeeded];
    //self.securityMessageTopConstraint.constant = (toggleUp && !self.hintLabel.isActive) ? -self.hintLabel.bounds.size.height : 14.0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView layoutIfNeeded];
    }];
}
/*
- (void)showAlertOnHintLabel:(NSString *)message {
    [self.hintLabel showAlert:message];
    [self updateSecurityMessagePosition:NO];
}

- (void)hideAlertOnHintLabel {
    [self.hintLabel hideAlert];
    [self updateSecurityMessagePosition:YES];
}*/

#pragma mark - Lazy Loading

- (BOOL)isTokenPayment {
    return self.paymentToken != nil;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentView.directionalLockEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentView;
}

- (LoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [LoadingView new];
    }
    return _loadingView;
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
    if (!_securityMessageLabel) {
        _securityMessageLabel = [UILabel new];
        _securityMessageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _securityMessageLabel.numberOfLines = 0;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Secure server: " attributes:@{NSForegroundColorAttributeName:self.theme.judoTextColor, NSFontAttributeName:[UIFont boldSystemFontOfSize:self.theme.securityMessageTextSize]}];
        
        [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:self.theme.securityMessageString attributes:@{NSForegroundColorAttributeName:self.theme.judoTextColor, NSFontAttributeName:[UIFont systemFontOfSize:self.theme.securityMessageTextSize]}]];
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineSpacing = 3.0f;
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
        _securityMessageLabel.attributedText = attributedString;
    }
    return _securityMessageLabel;
}

- (UIButton *)paymentButton {
    if (!_paymentButton) {
        _paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _paymentButton.frame = CGRectZero;
        _paymentButton.translatesAutoresizingMaskIntoConstraints = NO;
        _paymentButton.backgroundColor = self.theme.judoButtonColor;
        [_paymentButton setTitle:@"Pay" forState:UIControlStateNormal];
        [_paymentButton.titleLabel setFont:[UIFont boldSystemFontOfSize:22.0]];
        [_paymentButton setTitleColor:self.theme.judoButtonTitleColor forState:UIControlStateNormal];
    }
    return _paymentButton;
}

- (NSString *)transactionTitle {
    switch (self.transactionType) {
        case TransactionTypePayment:
        case TransactionTypePreAuth:
            return self.theme.paymentTitle;
        case TransactionTypeRegisterCard:
            return self.theme.registerCardTitle;
        case TransactionTypeRefund:
            return self.theme.refundTitle;
        default:
            return @"Invalid";
    }
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
        if (self.theme.avsEnabled) {
            if (valid) {
                [self.postCodeInputField.textField becomeFirstResponder];
                [self toggleAVSVisibility:YES completion:^{
                    [self.contentView scrollRectToVisible:self.postCodeInputField.frame animated:YES];
                }];
            }
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

#pragma mark - UIWebView Delegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    
    if ([urlString rangeOfString:@"Parse3DS"].location != NSNotFound) {
        NSString *bodyString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        if (!bodyString) {
            if (self.completionBlock) {
                self.completionBlock(nil, [NSError judo3DSRequestFailedErrorWithUnderlyingError:nil]);
            }
            return NO;
        }
        
        NSMutableDictionary *results = [NSMutableDictionary dictionary];
        
        NSArray *pairs = [bodyString componentsSeparatedByString:@"&"];
        
        for (NSString *pair in pairs) {
            if ([pair rangeOfString:@"="].location != NSNotFound) {
                NSArray *components = [pair componentsSeparatedByString:@"="];
                NSString *value = components[1];
                NSString *escapedVal = [value stringByRemovingPercentEncoding];
                
                results[components[0]] = escapedVal;
            }
        }
        
        if (self.pending3DSReceiptId) {
            if (self.transactionType == TransactionTypeRegisterCard) {
                self.loadingView.actionLabel.text = self.theme.verifying3DSRegisterCardTitle;
            } else {
                self.loadingView.actionLabel.text = self.theme.verifying3DSPaymentTitle;
            }
            [self.loadingView startAnimating];
            self.title = self.theme.authenticationTitle;
            [self.transaction threeDSecureWithParameters:results receiptId:self.pending3DSReceiptId completion:^(JPResponse * response, NSError * error) {
                [self.loadingView stopAnimating];
                if (self.completionBlock) {
                    if (error) {
                        self.completionBlock(nil, error);
                    } else if (response) {
                        self.completionBlock(response, nil);
                    } else {
                        self.completionBlock(nil, [NSError judo3DSRequestFailedErrorWithUnderlyingError:nil]);
                    }
                }
            }];
        } else {
            if (self.completionBlock) {
                self.completionBlock(nil, [NSError judo3DSRequestFailedErrorWithUnderlyingError:nil]);
            }
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.threeDSWebView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self.threeDSWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
        }];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat alphaVal = 1.0f;
    if ([webView.request.URL.absoluteString isEqualToString:@"about:blank"]) {
        alphaVal = 0.0f;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.threeDSWebView.alpha = alphaVal;
        [self.loadingView stopAnimating];
    }];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIView animateWithDuration:0.5 animations:^{
        self.threeDSWebView.alpha = 0.0f;
        [self.loadingView stopAnimating];
    }];
    if (self.completionBlock) {
        self.completionBlock(nil, [NSError judo3DSRequestFailedErrorWithUnderlyingError:error]);
    }
}

@end
