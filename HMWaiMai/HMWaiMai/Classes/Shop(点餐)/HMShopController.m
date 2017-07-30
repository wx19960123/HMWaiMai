//
//  HMShopController.m
//  HMWaiMai
//
//  Created by wx on 2017/7/30.
//  Copyright © 2017年 wx. All rights reserved.
//

#import "HMShopController.h"
#import "HMFoodDeatilController.h"

@interface HMShopController ()

@end

@implementation HMShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HMFoodDeatilController *foodDeatilVC = [[HMFoodDeatilController alloc] init];
    
    [self.navigationController pushViewController:foodDeatilVC animated:YES];
    
}

@end
