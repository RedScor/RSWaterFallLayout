//
//  RSWaterFallLayout.m
//  WaterFallCollection
//
//  Created by RedScor Yuan on 2015/5/18.
//  Copyright (c) 2015年 RedScor Yuan. All rights reserved.
//

#import "RSWaterFallLayout.h"

@interface RSWaterFallLayout ()

@property (nonatomic, strong) NSMutableDictionary *columnHeights;
@property (nonatomic, strong) NSMutableArray *layoutArray;
@end

@implementation RSWaterFallLayout

- (NSMutableDictionary *)columnHeights
{
    if (!_columnHeights) {
        self.columnHeights = [[NSMutableDictionary alloc]init];
        [self resetColumnHeights];
    }
    return _columnHeights;
}

- (NSMutableArray *)layoutArray
{
    if (!_layoutArray) {
        self.layoutArray = [[NSMutableArray alloc]init];
    }
    return _layoutArray;
}

- (void)resetColumnHeights {
    for (int i = 0; i< self.columnCount; i++) {
        self.columnHeights[@(i)] = @(self.sectionInset.top);
    }
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.columnSpaceing = 10;
        self.InteritemSpaceing = 10;
        self.columnCount = 3;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    
    //清除所有列的高度
    [self resetColumnHeights];

    //重新item 的屬性加入array中
    self.layoutArray = [NSMutableArray array];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i< count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.layoutArray addObject:attributes];
        
    }
}

/**
 *  返迴collectionView的滾動尺寸
 */
- (CGSize)collectionViewContentSize {
    //計算字典中最大的數字
    NSNumber *maxValue = [[self.columnHeights allValues] valueForKeyPath:@"@max.self"];

    return CGSizeMake(0, [maxValue floatValue] + self.sectionInset.bottom);
}

/**
 *  計算item的屬性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __block NSNumber *minColumn = @0;
    
    [self.columnHeights enumerateKeysAndObjectsUsingBlock:^(NSNumber *columnIdx, NSNumber *height, BOOL *stop) {
        if ([height floatValue] < [self.columnHeights[minColumn] floatValue]) {
            minColumn = columnIdx;
        }
    }];
    
    //計算itemView 寬度
    CGFloat itemWidth = (self.collectionView.frame.size.width - self.sectionInset.right - self.sectionInset.left - (self.columnCount -1) * self.columnSpaceing) / self.columnCount;
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat itemHeight = 0;
    if (self.itemHeightBlock) {
        itemHeight = self.itemHeightBlock(weakSelf,itemWidth,indexPath);
    }else {
        itemHeight = [self.delegate waterfallLayout:self itemHeightOfWidth:itemWidth indexPath:indexPath];
    }
    
    CGFloat itemX = self.sectionInset.left + ([minColumn floatValue] * (itemWidth + self.columnSpaceing));
    CGFloat itemY = [self.columnHeights[minColumn] floatValue] + self.InteritemSpaceing;
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    self.columnHeights[minColumn] = @(itemY + itemHeight);

    return attrs;
}

//返回rect 範圍內的item
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    //已在prepareLayout中儲存了
    return self.layoutArray;
}

@end
