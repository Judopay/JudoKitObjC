//
//  JPCardCustomizationPatternPickerCell.h
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

#import "JPCardCustomizationPatternPickerCell.h"
#import "JPCardCustomizationPatternCell.h"
#import "JPCardCustomizationViewModel.h"
#import "NSLayoutConstraint+Additions.h"
#import "UIView+Additions.h"

@interface JPCardCustomizationPatternPickerCell ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) JPCardCustomizationPatternPickerModel *patternPickerModel;
@end

@implementation JPCardCustomizationPatternPickerCell

#pragma mark - Constants

const float kPatternSelectedCellSize = 50.0f;
const float kPatternUnselectedCellSize = 36.0f;
const float kPatternCollectionViewPadding = 24.0f;

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
    if ([viewModel isKindOfClass:JPCardCustomizationPatternPickerModel.class]) {
        self.patternPickerModel = (JPCardCustomizationPatternPickerModel *)viewModel;
        [self.collectionView performBatchUpdates:nil completion:nil];
    }
}

#pragma mark - Layout Setup

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.collectionView];

    NSArray *constraints = @[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    ];

    [NSLayoutConstraint activateConstraints:constraints withPriority:999];
    [self.collectionView.heightAnchor constraintEqualToConstant:kPatternSelectedCellSize].active = YES;
}

#pragma mark - Lazy properties

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:self.collectionViewLayout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0, kPatternCollectionViewPadding, 0, kPatternCollectionViewPadding);
        [_collectionView registerClass:JPCardCustomizationPatternCell.class
            forCellWithReuseIdentifier:JPCardCustomizationPatternCell.cellIdentifier];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewLayout {
    if (!_collectionViewLayout) {
        _collectionViewLayout = [UICollectionViewFlowLayout new];
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _collectionViewLayout;
}

@end

@implementation JPCardCustomizationPatternPickerCell (CollectionViewDataSource)

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = JPCardCustomizationPatternCell.cellIdentifier;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                           forIndexPath:indexPath];

    if ([cell isKindOfClass:JPCardCustomizationPatternCell.class]) {
        JPCardCustomizationPatternCell *patternCell = (JPCardCustomizationPatternCell *)cell;
        [patternCell configureWithViewModel:self.patternPickerModel.patternModels[indexPath.row]];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.patternPickerModel.patternModels.count;
}

@end

@implementation JPCardCustomizationPatternPickerCell (FlowDelegate)

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JPCardCustomizationPatternModel *selectedPatternModel;
    selectedPatternModel = self.patternPickerModel.patternModels[indexPath.row];
    JPCardPatternType patternType = selectedPatternModel.pattern.type;
    [self.delegate patternPickerCell:self didSelectPatternWithType:patternType];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    JPCardCustomizationPatternModel *pattern = self.patternPickerModel.patternModels[indexPath.row];
    CGSize selectedCellSize = CGSizeMake(kPatternSelectedCellSize, kPatternSelectedCellSize);
    CGSize unselectedCellSize = CGSizeMake(kPatternUnselectedCellSize, kPatternUnselectedCellSize);
    return pattern.isSelected ? selectedCellSize : unselectedCellSize;
}

@end
