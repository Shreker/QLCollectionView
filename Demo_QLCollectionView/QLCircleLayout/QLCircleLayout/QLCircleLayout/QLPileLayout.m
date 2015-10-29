//
//  QLPileLayout.m
//  QLCircleLayout
//
//  Created by Shrek on 15/6/25.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import "QLPileLayout.h"

@implementation QLPileLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

//- (CGSize)collectionViewContentSize {
//    return CGSizeMake(500, 500);
//}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(100, 100);
    attrs.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    if (indexPath.item >= 5) {
        attrs.hidden = YES;
    } else {
        CGFloat angle = (arc4random_uniform(20)/100.0)*(arc4random_uniform(2)-1);
        attrs.transform = CGAffineTransformMakeRotation(angle);
        // zIndex越大,就越在上面
        attrs.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
    }
    return attrs;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    return array;
}

@end
