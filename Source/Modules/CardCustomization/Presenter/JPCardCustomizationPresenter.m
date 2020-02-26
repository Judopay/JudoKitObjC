//
//  JPCardCustomizationPresenter.m
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

#import "JPCardCustomizationPresenter.h"
#import "JPCardCustomizationInteractor.h"
#import "JPCardCustomizationRouter.h"
#import "JPCardCustomizationViewController.h"
#import "JPCardCustomizationViewModel.h"
#import "JPStoredCardDetails.h"
#import "NSString+Additions.h"

@interface JPCardCustomizationPresenterImpl ()
@property (nonatomic, assign) BOOL shouldPreserveResponder;
@property (nonatomic, assign) JPCardPatternType selectedPatternType;
@property (nonatomic, strong) NSString *selectedCardTitle;
@property (nonatomic, strong) JPCardCustomizationTitleModel *titleModel;
@property (nonatomic, strong) JPCardCustomizationHeaderModel *headerModel;
@property (nonatomic, strong) JPCardCustomizationPatternPickerModel *patternPickerModel;
@property (nonatomic, strong) JPCardCustomizationTextInputModel *textInputModel;
@property (nonatomic, strong) JPCardCustomizationIsDefaultModel *isDefaultModel;
@property (nonatomic, strong) JPCardCustomizationSubmitModel *submitModel;
@end

@implementation JPCardCustomizationPresenterImpl

#pragma mark - Protocol methods

- (void)prepareViewModel {
    JPStoredCardDetails *cardDetails = self.interactor.cardDetails;

    self.titleModel.title = @"customize_card".localized;
    self.textInputModel.text = self.selectedCardTitle;
    self.isDefaultModel.isDefault = cardDetails.isDefault;
    self.submitModel.isSaveEnabled = self.isSaveButtonEnabled;

    [self updateHeaderModelWithCardDetails:cardDetails];
    [self setSelectedPatternModelForPatternType:self.selectedPatternType];

    [self.view updateViewWithViewModels:self.viewModels
                shouldPreserveResponder:self.shouldPreserveResponder];
}

- (void)handleBackButtonTap {
    [self.router navigateBack];
}

- (void)handlePatternSelectionWithType:(JPCardPatternType)type {
    self.shouldPreserveResponder = NO;
    self.selectedPatternType = type;
    [self prepareViewModel];
}

- (void)handleCardInputFieldChangeWithInput:(NSString *)input {
    self.shouldPreserveResponder = YES;
    self.selectedCardTitle = input;
    [self prepareViewModel];
}

- (void)handleCancelEvent {
    [self.router navigateBack];
}

- (void)handleSaveEvent {
    [self.interactor updateStoredCardTitleWithInput:self.selectedCardTitle];
    [self.interactor updateStoredCardPatternWithType:self.selectedPatternType];
    [self.router navigateBack];
}

#pragma mark - Helper methods

- (void)updateHeaderModelWithCardDetails:(JPStoredCardDetails *)cardDetails {
    self.headerModel.cardLastFour = cardDetails.cardLastFour;
    self.headerModel.cardExpiryDate = cardDetails.expiryDate;
    self.headerModel.cardNetwork = cardDetails.cardNetwork;
    self.headerModel.cardTitle = self.selectedCardTitle;
    self.headerModel.cardPatternType = self.selectedPatternType;
}

- (void)setSelectedPatternModelForPatternType:(JPCardPatternType)type {
    for (JPCardCustomizationPatternModel *model in self.patternPickerModel.patternModels) {
        model.isSelected = NO;
        if (model.pattern.type == type) {
            model.isSelected = YES;
        }
    }
}

- (BOOL)isSaveButtonEnabled {
    JPStoredCardDetails *cardDetails = self.interactor.cardDetails;
    BOOL isSameTitle = ([self.selectedCardTitle isEqualToString:cardDetails.cardTitle]);
    BOOL isSamePattern = (self.selectedPatternType == cardDetails.patternType);
    BOOL isTitleEmpty = (self.selectedCardTitle.length == 0);

    return !isTitleEmpty && (!isSameTitle || !isSamePattern);
}

#pragma mark - Lazy properties

- (JPCardPatternType)selectedPatternType {
    if (!_selectedPatternType) {
        _selectedPatternType = self.interactor.cardDetails.patternType;
    }
    return _selectedPatternType;
}

- (NSString *)selectedCardTitle {
    if (!_selectedCardTitle) {
        _selectedCardTitle = self.interactor.cardDetails.cardTitle;
    }
    return _selectedCardTitle;
}

- (NSArray *)viewModels {
    return @[
        self.titleModel,
        self.headerModel,
        self.patternPickerModel,
        self.textInputModel,
        self.isDefaultModel,
        self.submitModel
    ];
}

- (JPCardCustomizationTitleModel *)titleModel {
    if (!_titleModel) {
        _titleModel = [JPCardCustomizationTitleModel new];
        _titleModel.identifier = @"JPCardCustomizationTitleCell";
    }
    return _titleModel;
}

- (JPCardCustomizationHeaderModel *)headerModel {
    if (!_headerModel) {
        _headerModel = [JPCardCustomizationHeaderModel new];
        _headerModel.identifier = @"JPCardCustomizationHeaderCell";
    }
    return _headerModel;
}

- (JPCardCustomizationPatternPickerModel *)patternPickerModel {
    if (!_patternPickerModel) {
        _patternPickerModel = [JPCardCustomizationPatternPickerModel new];
        _patternPickerModel.identifier = @"JPCardCustomizationPatternPickerCell";
        _patternPickerModel.patternModels = self.defaultPatternModels;
    }
    return _patternPickerModel;
}

- (JPCardCustomizationTextInputModel *)textInputModel {
    if (!_textInputModel) {
        _textInputModel = [JPCardCustomizationTextInputModel new];
        _textInputModel.identifier = @"JPCardCustomizationTextInputCell";
    }
    return _textInputModel;
}

- (JPCardCustomizationIsDefaultModel *)isDefaultModel {
    if (!_isDefaultModel) {
        _isDefaultModel = [JPCardCustomizationIsDefaultModel new];
        _isDefaultModel.identifier = @"JPCardCustomizationIsDefaultCell";
    }
    return _isDefaultModel;
}

- (JPCardCustomizationSubmitModel *)submitModel {
    if (!_submitModel) {
        _submitModel = [JPCardCustomizationSubmitModel new];
        _submitModel.identifier = @"JPCardCustomizationSubmitCell";
    }
    return _submitModel;
}

- (NSArray *)defaultCardPatterns {
    return @[ JPCardPattern.black,
              JPCardPattern.blue,
              JPCardPattern.green,
              JPCardPattern.red,
              JPCardPattern.orange,
              JPCardPattern.gold,
              JPCardPattern.cyan,
              JPCardPattern.olive ];
}

- (NSArray *)defaultPatternModels {
    NSMutableArray *models = [NSMutableArray new];
    for (JPCardPattern *pattern in self.defaultCardPatterns) {
        JPCardCustomizationPatternModel *model = [self patternModelForPattern:pattern];
        [models addObject:model];
    }
    return models;
}

- (JPCardCustomizationPatternModel *)patternModelForPattern:(JPCardPattern *)pattern {
    JPCardCustomizationPatternModel *model = [JPCardCustomizationPatternModel new];
    model.pattern = pattern;
    model.isSelected = NO;
    return model;
}

@end
