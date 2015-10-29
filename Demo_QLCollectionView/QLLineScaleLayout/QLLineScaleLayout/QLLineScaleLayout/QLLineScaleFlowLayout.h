//
//  QLLineScaleFlowLayout.h
//  QLLineScaleLayout
//
//  Created by Shrek on 15/6/24.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLLineScaleFlowLayout : UICollectionViewFlowLayout

/** 有效的缩放范围:在距离屏幕中心距离validDistance范围内会缩放 */
@property (nonatomic, assign) CGFloat validDistance; // default is 150
/** 缩放因素: 值越大, item就会越大 */
@property (nonatomic, assign) CGFloat scaleFactor;

@end
