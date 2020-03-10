//
//  JPPaymentMethodsCardListFooterCell.m
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

#import "JPPaymentMethodsCardListFooterCell.h"
#import "JPPaymentMethodsViewModel.h"
#import "UIImage+Additions.h"
#import "UIView+Additions.h"

@interface JPPaymentMethodsCardListFooterCell ()
@property (nonatomic, copy) void (^onTransactionButtonTapHandler)(void);
@end

@implementation JPPaymentMethodsCardListFooterCell

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

#pragma mark - View Model Configuration

- (void)configureWithViewModel:(JPPaymentMethodsModel *)viewModel {

    if (![viewModel isKindOfClass:JPPaymentMethodsCardFooterModel.class]) {
        return;
    }

    JPPaymentMethodsCardFooterModel *footerModel;
    footerModel = (JPPaymentMethodsCardFooterModel *)viewModel;

    [self.addCardButton setTitle:footerModel.addCardButtonTitle
                        forState:UIControlStateNormal];

    UIImage *buttonImage = [UIImage imageWithIconName:footerModel.addCardButtonIconName];

    [self.addCardButton setImage:buttonImage forState:UIControlStateNormal];
    self.addCardButton.imageView.contentMode = UIViewContentModeScaleAspectFit;

    self.addCardButton.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    self.addCardButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);

    self.onTransactionButtonTapHandler = footerModel.onTransactionButtonTapHandler;
}

- (void)onTransactionButtonTap {
    self.onTransactionButtonTapHandler();
}

#pragma mark - Theming

- (void)applyTheme:(JPTheme *)theme {
    [self.addCardButton setTitleColor:theme.jpBlackColor forState:UIControlStateNormal];
    self.addCardButton.titleLabel.font = theme.bodyBold;
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.addCardButton];
    [self.addCardButton pinToAnchors:AnchorTypeTrailing forView:self withPadding:24.0];
    [self.addCardButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
}

#pragma mark - Lazy instantiated properties

- (UIButton *)addCardButton {
    if (!_addCardButton) {
        _addCardButton = [UIButton new];
        _addCardButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_addCardButton addTarget:self
                           action:@selector(onTransactionButtonTap)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCardButton;
}

@end
