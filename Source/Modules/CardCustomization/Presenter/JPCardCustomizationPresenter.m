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
@property (nonatomic, strong) JPCardCustomizationTitleModel *titleModel;
@property (nonatomic, strong) JPCardCustomizationHeaderModel *headerModel;
@property (nonatomic, strong) JPCardCustomizationPatternPickerModel *patternPickerModel;
@end

@implementation JPCardCustomizationPresenterImpl

- (void)prepareViewModel {
    JPStoredCardDetails *cardDetails = self.interactor.cardDetails;

    self.titleModel.title = @"customize_card".localized;

    self.headerModel.cardLastFour = cardDetails.cardLastFour;
    self.headerModel.cardExpiryDate = cardDetails.expiryDate;
    self.headerModel.cardNetwork = cardDetails.cardNetwork;
    self.headerModel.cardPatternType = cardDetails.patternType;
    
    for (JPCardCustomizationPatternModel *model in self.patternPickerModel.patternModels) {
        model.isSelected = NO;
        if (model.pattern.type == cardDetails.patternType) {
            model.isSelected = YES;
        }
    }

    NSArray *viewModels = @[ self.titleModel, self.headerModel, self.patternPickerModel ];
    [self.view updateViewWithViewModels:viewModels];
}

- (void)handleBackButtonTap {
    [self.router popViewController];
}

- (void)handlePatternSelectionWithType:(JPCardPatternType)type {
    [self.interactor updateStoredCardPatternWithType:type];
    [self prepareViewModel];
}

#pragma mark - Lazy properties

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

- (NSArray *)defaultCardPatterns {
    return @[JPCardPattern.black,
             JPCardPattern.blue,
             JPCardPattern.green,
             JPCardPattern.red,
             JPCardPattern.orange,
             JPCardPattern.gold,
             JPCardPattern.cyan,
             JPCardPattern.olive];
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
