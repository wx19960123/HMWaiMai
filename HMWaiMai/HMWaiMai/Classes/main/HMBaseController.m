//
//  HMBaseController.m
//  HMWaiMai
//
//  Created by wx on 2017/7/30.
//  Copyright © 2017年 wx. All rights reserved.
//

#import "HMBaseController.h"
#import "HMNavigationBar.h"

@interface HMBaseController ()

@end

@implementation HMBaseController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    HMNavigationBar *navBar = [[HMNavigationBar alloc] init];
    
    UINavigationItem *navItem = [[UINavigationItem alloc]init];
    
    [navBar setItems:@[navItem]];
    
    _navBar = navBar;
    _navItem = navItem;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview: _navBar];
    
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.offset(64);
    }];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    
    // 让设置状态栏样式的方法重新调用
    [self setNeedsStatusBarAppearanceUpdate];
}

// 设置状态栏式
- (UIStatusBarStyle)preferredStatusBarStyle {
    NSLog(@"---");
    return self.statusBarStyle;
}

- (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        
        if (self.isViewLoaded && self.view.window == nil) {
            
            self.view = nil;

    }
  
}




@end
