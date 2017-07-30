//
//  HMBaseController.m
//  HMWaiMai
//
//  Created by wx on 2017/7/30.
//  Copyright © 2017年 wx. All rights reserved.
//

#import "HMBaseController.h"

@interface HMBaseController ()

@end

@implementation HMBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    [self.view addSubview: navBar];
    
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.offset(64);
    }];
    
    
    UINavigationItem *navItem = [[UINavigationItem alloc]init];
    
    [navBar setItems:@[navItem]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
