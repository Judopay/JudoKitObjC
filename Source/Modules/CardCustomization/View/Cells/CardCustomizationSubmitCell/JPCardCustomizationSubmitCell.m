//
//  JPCardCustomizationSubmitCell.m
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

#import "JPCardCustomizationSubmitCell.h"
#import "Functions.h"
#import "JPCardCustomizationViewModel.h"
#import "NSString+Additions.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"
#import "UIStackView+Additions.h"

@interface JPCardCustomizationSubmitCell ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation JPCardCustomizationSubmitCell

#pragma mark - Constants

const float kSubmitStackViewSpacing = 3.0f;
const float kSubmitStackViewTop = 70.0f;
const float kSubmitStackViewBottom = 30.0f;
const float kSubmitStackViewLeading = 0.0f;
const float kSubmitStackViewTrailing = 24.0f;
const float kSubmitStackViewHeight = 46.0f;
const float kSubmitSaveButtonWidth = 200.0f;
const float kSubmitSaveButtonCornerRadius = 4.0f;

#pragma mark - Initializers

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPCardCustomizationViewModel *)viewModel {
    if ([viewModel isKindOfClass:JPCardCustomizationSubmitModel.class]) {
        JPCardCustomizationSubmitModel *submitModel;
        submitModel = (JPCardCustomizationSubmitModel *)viewModel;
        self.saveButton.enabled = submitModel.isSaveEnabled;
    }
}

#pragma mark - User Actions

- (void)didTapSaveButton {
    [self.delegate didTapSaveForSubmitCell:self];
}

- (void)didTapCancelButton {
    [self.delegate didTapCancelForSubmitCell:self];
}

#pragma mark - Layout setup

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    [self.stackView addArrangedSubview:self.cancelButton];
    [self.stackView addArrangedSubview:self.saveButton];
    [self addSubview:self.stackView];

    [self setupConstraints];
}

- (void)setupConstraints {
    NSArray *constraints = @[
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor
                                                 constant:kSubmitStackViewTop],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor
                                                    constant:-kSubmitStackViewBottom],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                     constant:kSubmitStackViewLeading],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                      constant:-kSubmitStackViewTrailing],
        [self.stackView.heightAnchor constraintEqualToConstant:kSubmitStackViewHeight],
        [self.saveButton.widthAnchor constraintEqualToConstant:kSubmitSaveButtonWidth * getWidthAspectRatio()],
    ];
    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - Lazy properties

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView horizontalStackViewWithSpacing:kSubmitStackViewSpacing];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _stackView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        _cancelButton.titleLabel.font = UIFont.headline;
        [_cancelButton setTitle:@"cancel".localized.uppercaseString
                       forState:UIControlStateNormal];

        [_cancelButton setTitleColor:UIColor.jpBlackColor
                            forState:UIControlStateNormal];

        [_cancelButton addTarget:self
                          action:@selector(didTapCancelButton)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton new];
        _saveButton.translatesAutoresizingMaskIntoConstraints = NO;
        _saveButton.titleLabel.font = UIFont.headline;
        _saveButton.layer.cornerRadius = kSubmitSaveButtonCornerRadius;
        _saveButton.layer.masksToBounds = YES;
        [_saveButton setTitle:@"save".localized.uppercaseString
                     forState:UIControlStateNormal];

        [_saveButton setBackgroundImage:UIColor.jpBlackColor.asImage
                               forState:UIControlStateNormal];

        [_saveButton setTitleColor:UIColor.whiteColor
                          forState:UIControlStateNormal];

        [_saveButton addTarget:self
                        action:@selector(didTapSaveButton)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

@end
