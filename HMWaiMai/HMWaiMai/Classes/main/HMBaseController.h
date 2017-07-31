//
//  HMBaseController.h
//  HMWaiMai
//
//  Created by wx on 2017/7/30.
//  Copyright © 2017年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMNavigationBar;

@interface HMBaseController : UIViewController
@property (nonatomic, strong) HMNavigationBar *navBar;// 导航条

@property (nonatomic, strong) UINavigationItem *navItem;// navItem

// 状态栏样式
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;


@end
