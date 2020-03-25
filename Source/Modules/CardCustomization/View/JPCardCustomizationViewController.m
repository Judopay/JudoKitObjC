//
//  JPCardCustomizationViewController.m
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

#import "JPCardCustomizationViewController.h"
#import "JPCardCustomizationHeaderCell.h"
#import "JPCardCustomizationIsDefaultCell.h"
#import "JPCardCustomizationPresenter.h"
#import "JPCardCustomizationTextInputCell.h"
#import "JPCardCustomizationView.h"
#import "JPCardCustomizationViewModel.h"
#import "NSString+Additions.h"
#import "UIImage+Additions.h"
#import "UIViewController+Additions.h"

@interface JPCardCustomizationViewController ()
@property (nonatomic, strong) UIView *fadedView;
@property (nonatomic, strong) NSArray<JPCardCustomizationViewModel *> *viewModels;
@end

@implementation JPCardCustomizationViewController

#pragma mark - Constants

const float kCustomizationViewTopBarPadding = 20.0f;
const float kCustomizationViewBackButtonSize = 22.0f;
const int kCustomizationViewMaxInputLength = 28;
const float kCustomizationViewWhiteGradientLocation = 0.8f;
const float kCustomizationViewClearGradientLocation = 1.0f;

#pragma mark - View lifecycle

- (void)loadView {
    self.cardCustomizationView = [JPCardCustomizationView new];
    self.view = self.cardCustomizationView;
    [self configureView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.presenter prepareViewModel];
}

#pragma mark - User actions

- (void)onBackButtonTap {
    [self.presenter handleBackButtonTap];
}

#pragma mark - Protocol methods

- (void)updateViewWithViewModels:(NSArray<JPCardCustomizationViewModel *> *)viewModels
         shouldPreserveResponder:(BOOL)shouldPreserveResponder {

    self.viewModels = viewModels;
    [self registerReusableCells];

    if (shouldPreserveResponder) {
        [self reloadOnlySpecificCells];
        return;
    }

    [self.cardCustomizationView.tableView reloadData];
}

- (void)registerReusableCells {
    for (JPCardCustomizationViewModel *model in self.viewModels) {
        [self.cardCustomizationView.tableView registerClass:NSClassFromString(model.identifier)
                                     forCellReuseIdentifier:model.identifier];
    }
}

- (void)reloadOnlySpecificCells {
    NSIndexPath *cardIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *saveIndexPath = [NSIndexPath indexPathForRow:self.viewModels.count - 1 inSection:0];

    [self.cardCustomizationView.tableView reloadRowsAtIndexPaths:@[ cardIndexPath, saveIndexPath ]
                                                withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Layout setup

- (void)configureView {
    [self configureNavigationBar];
    [self configureFadedView];
    self.cardCustomizationView.tableView.delegate = self;
    self.cardCustomizationView.tableView.dataSource = self;
}

- (void)configureNavigationBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];

    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *defaultIcon = [UIImage imageWithIconName:@"back-icon"];
    UIImage *backButtonImage = self.theme.backButtonImage ? self.theme.backButtonImage : defaultIcon;
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backButton addTarget:self action:@selector(onBackButtonTap) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backBarButton.customView.heightAnchor constraintEqualToConstant:kCustomizationViewBackButtonSize].active = YES;
    [backBarButton.customView.widthAnchor constraintEqualToConstant:kCustomizationViewBackButtonSize].active = YES;
    self.navigationItem.leftBarButtonItem = backBarButton;
}

- (void)configureFadedView {
    [self.view addSubview:self.fadedView];

    [NSLayoutConstraint activateConstraints:@[
        [self.fadedView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.fadedView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.fadedView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.fadedView.heightAnchor constraintEqualToConstant:self.topBarHeight + kCustomizationViewTopBarPadding],
    ]];
}

#pragma mark - Lazy properties

- (UIView *)fadedView {
    if (!_fadedView) {
        _fadedView = [UIView new];
        _fadedView.translatesAutoresizingMaskIntoConstraints = NO;
        [_fadedView.layer insertSublayer:self.fadedViewGradient atIndex:0];
    }
    return _fadedView;
}

- (CAGradientLayer *)fadedViewGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGRect gradientFrame = CGRectMake(0, 0, screenWidth, self.topBarHeight + kCustomizationViewTopBarPadding);
    gradient.frame = gradientFrame;
    gradient.locations = @[ @(kCustomizationViewWhiteGradientLocation), @(kCustomizationViewClearGradientLocation) ];
    gradient.colors = @[
        (id)UIColor.whiteColor.CGColor,
        (id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
    ];
    return gradient;
}

@end

@implementation JPCardCustomizationViewController (TableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JPCardCustomizationViewModel *selectedModel = self.viewModels[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectedModel.identifier
                                                            forIndexPath:indexPath];

    if ([cell isKindOfClass:JPCardCustomizationPatternPickerCell.class]) {
        JPCardCustomizationPatternPickerCell *patternPickerCell;
        patternPickerCell = (JPCardCustomizationPatternPickerCell *)cell;
        patternPickerCell.delegate = self;
    }

    if ([cell isKindOfClass:JPCardCustomizationTextInputCell.class]) {
        JPCardCustomizationTextInputCell *textInputCell;
        textInputCell = (JPCardCustomizationTextInputCell *)cell;
        textInputCell.inputField.delegate = self;
    }

    if ([cell isKindOfClass:JPCardCustomizationSubmitCell.class]) {
        JPCardCustomizationSubmitCell *submitCell;
        submitCell = (JPCardCustomizationSubmitCell *)cell;
        submitCell.delegate = self;
    }

    if ([cell conformsToProtocol:@protocol(JPThemable)]) {
        UITableViewCell<JPThemable> *themableCell;
        themableCell = (UITableViewCell<JPThemable> *)cell;
        [themableCell applyTheme:self.theme];
    }

    if ([cell conformsToProtocol:@protocol(JPCardCustomizable)]) {
        UITableViewCell<JPCardCustomizable> *customizableCell;
        customizableCell = (UITableViewCell<JPCardCustomizable> *)cell;
        [customizableCell configureWithViewModel:selectedModel];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end

@implementation JPCardCustomizationViewController (TableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:JPCardCustomizationIsDefaultCell.class]) {
        [self.presenter handleToggleDefaultCardEvent];
    }
}

@end

@implementation JPCardCustomizationViewController (PatternPickerDelegate)

- (void)patternPickerCell:(JPCardCustomizationPatternPickerCell *)pickerCell didSelectPatternWithType:(JPCardPatternType)type {
    [self.presenter handlePatternSelectionWithType:type];
}

@end

@implementation JPCardCustomizationViewController (TextInputDelegate)

- (BOOL)inputField:(JPInputField *)inputField shouldChangeText:(NSString *)text {
    if (text.length > kCustomizationViewMaxInputLength) {
        [inputField displayErrorWithText:@"card_title_length_warning".localized];
        return NO;
    }
    [inputField clearError];
    [self.presenter handleCardInputFieldChangeWithInput:text];
    return YES;
}

@end

@implementation JPCardCustomizationViewController (SubmitDelegate)

- (void)didTapCancelForSubmitCell:(JPCardCustomizationSubmitCell *)cell {
    [self.presenter handleCancelEvent];
}

- (void)didTapSaveForSubmitCell:(JPCardCustomizationSubmitCell *)cell {
    [self.presenter handleSaveEvent];
}

@end
