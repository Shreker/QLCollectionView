//
//  QLLineScaleFlowLayout.m
//  QLLineScaleLayout
//
//  Created by Shrek on 15/6/24.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import "QLLineScaleFlowLayout.h"

@implementation QLLineScaleFlowLayout

static CGFloat const QLLineScaleFlowLayoutItemWH = 100;

- (instancetype)init {
    if (self = [super init]) {
        self.validDistance = 150;
        self.scaleFactor = 0.6;
    }
    return self;
}

/**
 *  一些初始化工作最好在这里实现
 */
- (void)prepareLayout {
    [super prepareLayout];
    [self loadDefaultSetting];
}

#pragma mark - Load default UI and Data
- (void)loadDefaultSetting {
    self.itemSize = CGSizeMake(QLLineScaleFlowLayoutItemWH, QLLineScaleFlowLayoutItemWH);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 50;
    CGFloat fInsetLR = (self.collectionView.frame.size.width - QLLineScaleFlowLayoutItemWH) / 2;
    self.sectionInset = UIEdgeInsetsMake(0, fInsetLR, 0, fInsetLR);
}

/**
 *  系统回调, rect参数是当前屏幕滚动可见的范围
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 0.计算可见的矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    // 1.取得默认的cell的UICollectionViewLayoutAttributes
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    // 计算屏幕最中间的x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 2.遍历所有的布局属性
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // 如果不在屏幕上,直接跳过
        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) continue;
        // 每一个item的中点x
        CGFloat itemCenterX = attrs.center.x;
        // 差距越小, 缩放比例越大
        // 根据跟屏幕最中间的距离计算缩放比例
        CGFloat fDeltaDistance = ABS(itemCenterX - centerX);
        if (fDeltaDistance <= self.validDistance) {
            CGFloat scale = 1 + self.scaleFactor * (1 - (fDeltaDistance / self.validDistance));
            attrs.transform = CGAffineTransformMakeScale(scale, scale);
        } else {
            attrs.transform = CGAffineTransformIdentity;
        }
    }
    return array;
}
/**
 *  只要显示的边界发生改变就重新布局:
 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

/**
 *  用来设置collectionView停止滚动那一刻的位置
 *
 *  @param proposedContentOffset 原本collectionView停止滚动那一刻的位置
 *  @param velocity              滚动速度
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 1.计算出scrollView最后会停留的范围
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    // 计算屏幕最中间的x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 2.取出这个范围内的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    // 3.遍历所有属性
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x - centerX) < ABS(adjustOffsetX)) {
            adjustOffsetX = attrs.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}

@end
