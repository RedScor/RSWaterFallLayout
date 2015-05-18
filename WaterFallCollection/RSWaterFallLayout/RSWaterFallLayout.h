//
//  RSWaterFallLayout.h
//  WaterFallCollection
//
//  Created by RedScor Yuan on 2015/5/18.
//  Copyright (c) 2015年 RedScor Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^ItemHeigthBlock)(UICollectionViewLayout *layout,CGFloat width,NSIndexPath *indexPath);

@class RSWaterFallLayout;
@protocol RSWaterFallLayoutDelegate <NSObject>

- (CGFloat)waterfallLayout:(RSWaterFallLayout *)waterflowLayout itemHeightOfWidth:(CGFloat)width indexPath:(NSIndexPath *)indexPath;

@end

@interface RSWaterFallLayout : UICollectionViewFlowLayout

/**
 *  View距離螢幕邊界位置(top, left, bottom, right)
 */

/**
*  item 間列的間距
*/
@property (nonatomic, assign) CGFloat      columnSpaceing;
/**
 *  item 間行的間距
 */
@property (nonatomic, assign) CGFloat      InteritemSpaceing;
/**
 *  item 幾列
 */
@property (nonatomic, assign) CGFloat      columnCount;

@property (nonatomic, copy) ItemHeigthBlock itemHeightBlock;
@property (nonatomic, weak) id<RSWaterFallLayoutDelegate> delegate ;
@end
