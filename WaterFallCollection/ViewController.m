//
//  ViewController.m
//  WaterFallCollection
//
//  Created by RedScor Yuan on 2015/5/18.
//  Copyright (c) 2015年 RedScor Yuan. All rights reserved.
//

#import "ViewController.h"
#import "RSWaterFallLayout.h"
#import "CollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,RSWaterFallLayoutDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *itemHeights;
@end
static NSString *identifier = @"collectionCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RSWaterFallLayout *layout = [[RSWaterFallLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    layout.itemHeightBlock = ^(UICollectionViewLayout *layout,CGFloat width,NSIndexPath *indexPath) {
//        
//        return (CGFloat)[self.itemHeights[indexPath.item] floatValue];
//    };
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - RSWaterFallLayoutDelegate
- (CGFloat)waterfallLayout:(RSWaterFallLayout *)waterflowLayout itemHeightOfWidth:(CGFloat)width indexPath:(NSIndexPath *)indexPath
{
    //return View's height / View's Width * width
    return [self.itemHeights[indexPath.item] floatValue];
}

- (NSMutableArray *)itemHeights
{
    if (!_itemHeights) {
        self.itemHeights = [[NSMutableArray alloc]init];
        for (int i = 0; i< 50; i++) {
            
            self.itemHeights[i] = @(arc4random() % 105 + 50);
        }
    }
    return _itemHeights;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
