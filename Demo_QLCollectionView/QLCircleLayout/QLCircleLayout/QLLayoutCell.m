//
//  QLLayoutCell.m
//  QLCircleLayout
//
//  Created by Shrek on 15/6/24.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import "QLLayoutCell.h"

@interface QLLayoutCell ()
{
    __weak IBOutlet UIImageView *_imageView;
}

@end

@implementation QLLayoutCell

- (void)awakeFromNib {
    [self loadDefaultSetting];
}

#pragma mark - Load default UI and Data
- (void)loadDefaultSetting {
    [_imageView.layer setCornerRadius:5.0];
    [_imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_imageView.layer setBorderWidth:3.0];
    [_imageView.layer setMasksToBounds:YES];
}

- (void)setStrImageName:(NSString *)strImageName {
    _strImageName = [strImageName copy];
    _imageView.image = [UIImage imageNamed:strImageName];
}

@end
