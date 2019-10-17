//
//  IDEALFormViewController.m
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

#import "FloatingTextField.h"
#import "IDEALFormViewController.h"
#import "IDEALBank.h"
#import "IDEALBankTableViewCell.h"
#import "IDEALBankSelectionTableViewController.h"
#import "JPInputField.h"
#import "JPTheme.h"
#import "JPResponse.h"
#import "NSError+Judo.h"
#import "NSString+Localize.h"
#import "UIColor+Judo.h"
#import "UIView+SafeAnchors.h"
#import "UIViewController+JPTheme.h"

@interface IDEALFormViewController ()

@property (nonatomic, strong) UIView *safeAreaView;
@property (nonatomic, strong) UIButton *paymentButton;
@property (nonatomic, strong) JPInputField *nameInputField;
@property (nonatomic, strong) UIButton *bankSelectionButton;
@property (nonatomic, strong) IDEALBankTableViewCell *selectedBankCell;

@property (nonatomic, strong) IDEALBank *_Nullable selectedBank;
@property (nonatomic, strong) JudoCompletionBlock completionBlock;

@property (nonatomic, strong) NSLayoutConstraint *paymentButtonBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *safeAreaViewConstraints;

@end

@implementation IDEALFormViewController

# pragma mark - Initializers

- (instancetype)initWithCompletion:(JudoCompletionBlock)completion {
    
    if (self = [super init]) {
        self.completionBlock = completion;
    }
    
    return self;
}

# pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self registerKeyboardEvents];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.nameInputField endEditing:YES];
    [super viewWillDisappear:animated];
}

# pragma mark - User actions

- (void)onViewTap:(id)sender {
    [self.nameInputField endEditing:YES];
}

- (void)onBackButtonTap:(id)sender {
    if (self.completionBlock) {
        self.completionBlock(nil, NSError.judoUserDidCancelError);
    }
}

- (void)onSelectBankButtonTap:(id)sender {
    IDEALBankSelectionTableViewController *controller = [IDEALBankSelectionTableViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)onPayButtonTap:(id)sender {
    //TODO: Add payment request
}


# pragma mark - Layout setup

- (void)setupView {
    self.view.backgroundColor = UIColor.whiteColor;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(onViewTap:)];
    
    [self.view addGestureRecognizer: tapGesture];
    [self setupNavigationBar];
    [self setupPaymentButton];
    [self setupStackView];
    [self applyTheme: self.theme];
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = self.theme.iDEALTitle;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.theme.backButtonTitle
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onBackButtonTap:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.theme.paymentButtonTitle
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(onPayButtonTap:)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setupPaymentButton {
    
    [self.view addSubview:self.safeAreaView];
    [self.view addSubview:self.paymentButton];
    
    self.safeAreaViewConstraints = [self.safeAreaView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    
    NSArray *viewConstraints = @[
        [self.safeAreaView.heightAnchor constraintEqualToConstant:self.theme.buttonHeight],
        [self.safeAreaView.rightAnchor constraintEqualToAnchor:self.view.safeRightAnchor],
        [self.safeAreaView.leftAnchor constraintEqualToAnchor:self.view.safeLeftAnchor],
        self.safeAreaViewConstraints
    ];
    
    self.paymentButtonBottomConstraint = [self.paymentButton.bottomAnchor constraintEqualToAnchor:self.view.safeBottomAnchor];
    
    NSArray *buttonConstraints = @[
        [self.paymentButton.heightAnchor constraintEqualToConstant:self.theme.buttonHeight],
        [self.paymentButton.rightAnchor constraintEqualToAnchor:self.view.safeRightAnchor],
        [self.paymentButton.leftAnchor constraintEqualToAnchor:self.view.safeLeftAnchor],
        self.paymentButtonBottomConstraint
    ];
    
    [NSLayoutConstraint activateConstraints:viewConstraints];
    [NSLayoutConstraint activateConstraints:buttonConstraints];
}

- (void)setupStackView {
    UIStackView *stackView = [UIStackView new];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    
    [stackView addArrangedSubview:self.nameInputField];
    [stackView addArrangedSubview:self.bankSelectionButton];
    
    [self.view addSubview:stackView];
    
    NSArray *subviewConstraints = @[
        [self.nameInputField.heightAnchor constraintEqualToConstant:self.theme.inputFieldHeight],
        [self.bankSelectionButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10.0f],
        [self.bankSelectionButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10.0f],
        [self.bankSelectionButton.heightAnchor constraintEqualToConstant:self.theme.buttonHeight],
    ];
    
    NSArray *stackViewConstraints = @[
        [stackView.topAnchor constraintEqualToAnchor:self.view.safeTopAnchor constant:20.0f],
        [stackView.rightAnchor constraintEqualToAnchor:self.view.safeRightAnchor],
        [stackView.leftAnchor constraintEqualToAnchor:self.view.safeLeftAnchor],
    ];
    
    [NSLayoutConstraint activateConstraints:subviewConstraints];
    [NSLayoutConstraint activateConstraints:stackViewConstraints];
}

# pragma mark - Lazily instantiated UI properties

- (JPInputField *)nameInputField {
    if (!_nameInputField) {
        _nameInputField = [[JPInputField alloc] initWithTheme:self.theme];
        _nameInputField.textField.keyboardType = UIKeyboardTypeAlphabet;
        [_nameInputField.textField setPlaceholder: @"enter_name".localized
                                    floatingTitle: @"name".localized];
    }
    
    return _nameInputField;
}

- (UIButton *)bankSelectionButton {
    if (!_bankSelectionButton) {
        _bankSelectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bankSelectionButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_bankSelectionButton setBackgroundImage:self.theme.judoButtonColor.asImage forState:UIControlStateNormal];
        [_bankSelectionButton setTitle:@"select_ideal_bank".localized forState:UIControlStateNormal];
        [_bankSelectionButton.titleLabel setFont:self.theme.buttonFont];
        [_bankSelectionButton setTitleColor:self.theme.judoButtonTitleColor forState:UIControlStateNormal];
        
        [_bankSelectionButton addTarget:self
                                 action:@selector(onSelectBankButtonTap:)
                       forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bankSelectionButton;
}

- (UIView *)safeAreaView {
    if (!_safeAreaView) {
        _safeAreaView = [UIView new];
        _safeAreaView.translatesAutoresizingMaskIntoConstraints = NO;
        _safeAreaView.backgroundColor = self.theme.judoButtonColor;
    }
    return _safeAreaView;
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

# pragma mark - Keyboard-related logic

- (void)registerKeyboardEvents {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(keyboardWillShow:)
                               name:UIKeyboardWillShowNotification
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(keyboardWillHide:)
                               name:UIKeyboardWillHideNotification
                             object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    if (@available(iOS 11.0, *)) {
        self.paymentButtonBottomConstraint.constant = -keyboardSize.height + self.view.safeAreaInsets.bottom;
        self.safeAreaViewConstraints.constant = -keyboardSize.height + self.view.safeAreaInsets.bottom;
    } else {
        self.paymentButtonBottomConstraint.constant = -keyboardSize.height;
        self.safeAreaViewConstraints.constant = -keyboardSize.height;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.paymentButtonBottomConstraint.constant = 0;
    self.safeAreaViewConstraints.constant = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
