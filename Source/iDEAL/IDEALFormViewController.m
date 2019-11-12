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
@property (nonatomic, strong) UIView *selectedBankLabelView;
@property (nonatomic, strong) UITableViewCell *bankSelectionCell;

@property (nonatomic, strong) JPTheme *theme;
@property (nonatomic, strong) IDEALBank *_Nullable selectedBank;
@property (nonatomic, strong) JudoCompletionBlock completionBlock;

@property (nonatomic, strong) NSLayoutConstraint *paymentButtonBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *safeAreaViewConstraints;

@end


@implementation IDEALFormViewController

- (instancetype)initWithTheme:(JPTheme *)theme
                   completion:(JudoCompletionBlock)completion {
    
    if (self = [super init]) {
        self.theme = theme;
        self.completionBlock = completion;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self displaySavedBankIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerKeyboardObservers];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.nameInputField endEditing:YES];
    [self removeKeyboardObservers];
    [super viewWillDisappear:animated];
}

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
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)onPayButtonTap:(id)sender {
    //TODO: Add payment request
}

- (void)didSelectBank:(IDEALBank *)bank {
    [self shouldDisplayPaymentElements:YES];
    self.selectedBank = bank;
    
    NSBundle *bundle = [NSBundle bundleForClass:IDEALFormViewController.class];
    
    NSString *iconBundlePath = [bundle pathForResource:@"icons" ofType:@"bundle"];
    NSBundle *iconBundle = [NSBundle bundleWithPath:iconBundlePath];
    
    NSString *iconName = [NSString stringWithFormat:@"logo-%@", bank.bankIdentifierCode];
    NSString *iconFilePath = [iconBundle pathForResource:iconName ofType:@"png"];
    
    self.bankSelectionCell.textLabel.text = nil;
    self.bankSelectionCell.imageView.image = [UIImage imageWithContentsOfFile:iconFilePath];
    
    [NSUserDefaults.standardUserDefaults setInteger:bank.type forKey:@"iDEALBankType"];
}

- (void)shouldDisplayPaymentElements:(BOOL)shouldContinue {
    self.safeAreaView.hidden = !shouldContinue;
    self.paymentButton.hidden = !shouldContinue;
    self.selectedBankLabelView.hidden = !shouldContinue;
    self.navigationItem.rightBarButtonItem.enabled = shouldContinue;
}

- (void)displaySavedBankIfNeeded {
    NSInteger bankTypeValue = [NSUserDefaults.standardUserDefaults integerForKey:@"iDEALBankType"];
    IDEALBankType bankType = (IDEALBankType)bankTypeValue;
    
    if (bankType == IDEALBankNone) {
        return;
    }
    
    IDEALBank *storedBank = [IDEALBank bankWithType:bankType];
    [self didSelectBank:storedBank];
}

- (void)setupView {
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
    
    [self shouldDisplayPaymentElements:NO];
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
    [stackView addArrangedSubview:self.selectedBankLabelView];
    [stackView addArrangedSubview:self.bankSelectionCell];
    
    [self.view addSubview:stackView];
    
    NSArray *subviewConstraints = @[
        [self.nameInputField.heightAnchor constraintEqualToConstant:self.theme.inputFieldHeight],
        [self.bankSelectionCell.leftAnchor constraintEqualToAnchor:stackView.leftAnchor],
        [self.bankSelectionCell.rightAnchor constraintEqualToAnchor:stackView.rightAnchor],
        [self.bankSelectionCell.heightAnchor constraintEqualToConstant:self.theme.buttonHeight],
    ];
    
    NSArray *stackViewConstraints = @[
        [stackView.topAnchor constraintEqualToAnchor:self.view.safeTopAnchor constant:20.0f],
        [stackView.rightAnchor constraintEqualToAnchor:self.safeAreaView.rightAnchor],
        [stackView.leftAnchor constraintEqualToAnchor:self.safeAreaView.leftAnchor],
    ];
    
    [NSLayoutConstraint activateConstraints:subviewConstraints];
    [NSLayoutConstraint activateConstraints:stackViewConstraints];
}

- (JPInputField *)nameInputField {
    if (!_nameInputField) {
        _nameInputField = [[JPInputField alloc] initWithTheme:self.theme];
        _nameInputField.textField.keyboardType = UIKeyboardTypeAlphabet;
        [_nameInputField.textField setPlaceholder: @"enter_name".localized
                                    floatingTitle: @"name".localized];
    }
    
    return _nameInputField;
}

- (UIView *)selectedBankLabelView {
    if (!_selectedBankLabelView) {
        
        UILabel *selectedBankLabel = [UILabel new];
        selectedBankLabel.translatesAutoresizingMaskIntoConstraints = NO;
        selectedBankLabel.text = @"selected_bank".localized;
        selectedBankLabel.textColor = self.theme.judoInputFieldTextColor;
        selectedBankLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
        
        _selectedBankLabelView = [UIView new];
        _selectedBankLabelView.translatesAutoresizingMaskIntoConstraints = NO;
        [_selectedBankLabelView addSubview:selectedBankLabel];
        
        NSArray *constraints = @[
            [selectedBankLabel.leadingAnchor constraintEqualToAnchor:_selectedBankLabelView.leadingAnchor constant:15.0f],
            [selectedBankLabel.topAnchor constraintEqualToAnchor:_selectedBankLabelView.topAnchor],
            [selectedBankLabel.bottomAnchor constraintEqualToAnchor:_selectedBankLabelView.bottomAnchor],
            [selectedBankLabel.trailingAnchor constraintEqualToAnchor:_selectedBankLabelView.trailingAnchor],
        ];
        
        [NSLayoutConstraint activateConstraints:constraints];
    }
    
    return _selectedBankLabelView;
}

- (UITableViewCell *)bankSelectionCell {
    if (!_bankSelectionCell) {
        _bankSelectionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _bankSelectionCell.translatesAutoresizingMaskIntoConstraints = NO;
        _bankSelectionCell.textLabel.text = @"select_ideal_bank".localized;
        _bankSelectionCell.textLabel.textColor = self.theme.judoTextColor;
        _bankSelectionCell.imageView.contentMode = UIViewContentModeLeft;
        _bankSelectionCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(onSelectBankButtonTap:)];
        
        [_bankSelectionCell addGestureRecognizer:tapGesture];
    }
    
    return _bankSelectionCell;
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
        _paymentButton.accessibilityIdentifier = @"Pay Button";
        [_paymentButton setBackgroundImage:self.theme.judoButtonColor.asImage forState:UIControlStateNormal];
        [_paymentButton setTitle:@"pay".localized forState:UIControlStateNormal];
        [_paymentButton.titleLabel setFont:self.theme.buttonFont];
        [_paymentButton setTitleColor:self.theme.judoButtonTitleColor forState:UIControlStateNormal];
    }
    return _paymentButton;
}

- (void)registerKeyboardObservers {
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

- (void)removeKeyboardObservers {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
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
