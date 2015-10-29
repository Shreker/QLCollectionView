//
//  QLViewController.m
//  QLCircleLayout
//
//  Created by Shrek on 15/6/25.
//  Copyright (c) 2015年 M. All rights reserved.
//

/** QLScreenSize */
#define QLScreenSize [[UIScreen mainScreen] bounds].size
#define QLScreenWidth QLScreenSize.width
#define QLScreenHeight QLScreenSize.height

#define QLColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])
#define QLColorRandom QLColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#import "QLViewController.h"
#import "QLLayoutCell.h"
#import "QLCircleLayout.h"
#import "QLPileLayout.h"

@interface QLViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionViewFlowLayout *_flowLayout;
    __weak UICollectionView *_collectionView;
}

@property (nonatomic, strong) NSMutableArray *arrMImageNames;

@end

@implementation QLViewController

static NSString * const strIdentifier = @"QLLayoutCell";

- (NSMutableArray *)arrMImageNames {
    if (!_arrMImageNames) {
        _arrMImageNames = [NSMutableArray array];
        for (NSUInteger index = 1; index <= 20; index ++) {
            [_arrMImageNames addObject:[NSString stringWithFormat:@"%zd.jpg", index]];
        }
    }
    return _arrMImageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark - Load default UI and Data
- (void)loadDefaultSetting {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setHeaderReferenceSize:CGSizeMake(0, 30)];
    [flowLayout setMinimumInteritemSpacing:20];
    [flowLayout setMinimumLineSpacing:20];
    [flowLayout setItemSize:CGSizeMake(100, 100)];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    _flowLayout = flowLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, QLScreenWidth, 200) collectionViewLayout:[[QLCircleLayout alloc] init]];
    [collectionView registerNib:[UINib nibWithNibName:@"QLLayoutCell" bundle:nil] forCellWithReuseIdentifier:strIdentifier];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrMImageNames.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QLLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
    cell.strImageName = self.arrMImageNames[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 删除模型数据
    [self.arrMImageNames removeObjectAtIndex:indexPath.item];
    
    // 删UI(刷新UI)
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if ([_collectionView.collectionViewLayout isKindOfClass:[QLCircleLayout class]]) {
        [_collectionView setCollectionViewLayout:[[QLPileLayout alloc] init] animated:YES];
    } else {
        [_collectionView setCollectionViewLayout:[[QLCircleLayout alloc] init] animated:YES];
    }
}

@end
