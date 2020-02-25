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
#import "JPCardCustomizationCell.h"
#import "JPCardCustomizationHeaderCell.h"
#import "JPCardCustomizationPresenter.h"
#import "JPCardCustomizationTextInputCell.h"
#import "JPCardCustomizationView.h"
#import "JPCardCustomizationViewModel.h"
#import "NSString+Additions.h"
#import "UIImage+Additions.h"

@interface JPCardCustomizationViewController ()
@property (nonatomic, strong) NSArray<JPCardCustomizationViewModel *> *viewModels;
@end

@implementation JPCardCustomizationViewController

#pragma mark - Constants

const float kBackButtonSize = 22.0f;
const int kMaxInputLength = 28;

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
        [self reloadOnlyCardHeaderCell];
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

- (void)reloadOnlyCardHeaderCell {
    NSIndexPath *cardIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.cardCustomizationView.tableView reloadRowsAtIndexPaths:@[ cardIndexPath ]
                                                withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Layout setup

- (void)configureView {
    [self configureNavigationBar];
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
    [backButton setImage:[UIImage imageWithIconName:@"back-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackButtonTap) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backBarButton.customView.heightAnchor constraintEqualToConstant:kBackButtonSize].active = YES;
    [backBarButton.customView.widthAnchor constraintEqualToConstant:kBackButtonSize].active = YES;
    self.navigationItem.leftBarButtonItem = backBarButton;
}

@end

@implementation JPCardCustomizationViewController (TableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JPCardCustomizationViewModel *selectedModel = self.viewModels[indexPath.row];
    JPCardCustomizationCell *cell = [tableView dequeueReusableCellWithIdentifier:selectedModel.identifier
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

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureWithViewModel:selectedModel];
    return cell;
}

@end

@implementation JPCardCustomizationViewController (TableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end

@implementation JPCardCustomizationViewController (PatternPickerDelegate)

- (void)patternPickerCell:(JPCardCustomizationPatternPickerCell *)pickerCell didSelectPatternWithType:(JPCardPatternType)type {

    [self.presenter handlePatternSelectionWithType:type];
}

@end

@implementation JPCardCustomizationViewController (TextInputDelegate)

- (BOOL)inputField:(JPInputField *)inputField shouldChangeText:(NSString *)text {
    if (text.length > kMaxInputLength) {
        [inputField displayErrorWithText:@"card_title_length_warning".localized];
        return NO;
    }
    [inputField clearError];
    [self.presenter handleCardInputFieldChangeWithInput:text];
    return YES;
}

@end
