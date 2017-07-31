//
//  HMNavigationBar.m
//  HMWaiMai
//
//  Created by wx on 2017/7/31.
//  Copyright © 2017年 wx. All rights reserved.
//

#import "HMNavigationBar.h"

@implementation HMNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setShadowImage:[UIImage new]];
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        
        // 创建一个imageView来让导航条样式,将要修改此控件的透明度实现渐变效果
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_navigationBar_white"]];
        [self addSubview:bgImageView];
        
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
        _bgImageView = bgImageView;
        
    }
    return self;
}





@end
