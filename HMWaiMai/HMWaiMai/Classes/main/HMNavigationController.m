//
//  HMNavigationController.m
//  HMWaiMai
//
//  Created by wx on 2017/7/30.
//  Copyright © 2017年 wx. All rights reserved.
//

#import "HMNavigationController.h"
#import "HMBaseController.h"

@interface HMNavigationController ()

@end

@implementation HMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.hidden = YES;//隐藏自带导航条

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(HMBaseController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];

    if (self.childViewControllers.count > 1) {
        viewController.navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_backItem"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)childViewControllerForStatusBarStyle {// 实现此方法让子控制器去设置状态栏的样式

    return self.topViewController;
}
@end
