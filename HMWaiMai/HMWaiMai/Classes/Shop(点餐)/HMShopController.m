//
//  HMShopController.m
//  HMWaiMai
//
//  Created by wx on 2017/7/30.
//  Copyright © 2017年 wx. All rights reserved.
//

#import "HMShopController.h"
#import "HMFoodDeatilController.h"
#import "HMNavigationBar.h"


#define KShopHeaderViewMaxHeight   180
#define KShopHeaderViewMinHeight   64

@interface HMShopController ()
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;


@end

@implementation HMShopController

- (void)viewDidLoad {
//    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview: headerView];
//    
//    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.offset(0);
//        make.height.offset(KShopHeaderViewMaxHeight);
//    }];
//    
//
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
//    [self.view addGestureRecognizer:pan];
//    
//    _headerView = headerView;
    
    [self setupUI];
     [super viewDidLoad];
    
//    self.navBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor blueColor];//背景颜色

    self.navItem.title = @"点餐";//标题

    self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:0]};
    
    self.navBar.bgImageView.alpha = 0;//透明度
    
    _rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_share"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navItem.rightBarButtonItem = _rightButtonItem;
    self.navBar.tintColor = [UIColor whiteColor];
}


- (void)setupUI {//创建头部视图
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview: headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {//添加约束
        make.top.left.right.offset(0);
        make.height.offset(KShopHeaderViewMaxHeight);
    }];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];//添加手势
    [self.view addGestureRecognizer:pan];
    
    _headerView = headerView;
}

- (void)panGesture:(UIPanGestureRecognizer *)pan{
    CGPoint p = [pan translationInView:pan.view];
//    [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.offset(p.y + _headerView.bounds.size.height);
//    }];
//
    CGFloat shopHeaderViewUpdateHeight = _headerView.bounds.size.height;

    
    [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        if (p.y + shopHeaderViewUpdateHeight < KShopHeaderViewMinHeight) {
            
            make.height.offset(KShopHeaderViewMinHeight);
            
        } else if (p.y + shopHeaderViewUpdateHeight >= KShopHeaderViewMaxHeight) {
            
            make.height.offset(KShopHeaderViewMaxHeight);
            
        } else { // 在大于 64 及小于180之间让它慢慢变化
            
            make.height.offset(p.y + shopHeaderViewUpdateHeight);
        }
        
    }];
    CGFloat alpha = [self resultWithConsult:shopHeaderViewUpdateHeight andConsult1:64 andResult1:1 andConsult2:180 andResult2:0];
    

 
    self.navBar.bgImageView.alpha = alpha;
    
    self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:alpha]};
    
//    CGFloat White = [@(shopHeaderViewUpdateHeight) resultWithValue1:HMValueMake(64, 0.4) andValue2:HMValueMake(180, 1)];
    
//    self.navBar.tintColor = [UIColor colorWithWhite:White alpha:1];
    
    
    // 如果当前是180高度就用白色状态栏,反至用黑色
    if (shopHeaderViewUpdateHeight == KShopHeaderViewMaxHeight && self.statusBarStyle != UIStatusBarStyleLightContent) {
        
        self.statusBarStyle = UIStatusBarStyleLightContent;
        
    } else if (shopHeaderViewUpdateHeight == KShopHeaderViewMinHeight && self.statusBarStyle != UIStatusBarStyleDefault){
        self.statusBarStyle = UIStatusBarStyleDefault;
    }

    
    [pan setTranslation:CGPointZero inView:pan.view];
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    HMFoodDeatilController *foodDeatilVC = [[HMFoodDeatilController alloc] init];
//    
//    [self.navigationController pushViewController:foodDeatilVC animated:YES];
//    
//}


- (CGFloat)resultWithConsult:(CGFloat)consult andConsult1:(CGFloat)consult1 andResult1:(CGFloat)result1 andConsult2:(CGFloat)consult2 andResult2:(CGFloat)result2 {
    CGFloat a = (result1 - result2) / (consult1 - consult2);
    CGFloat b = result1 - (a * consult1);
    return a * consult + b;

}



- (void)setShopTagView{
    UIView *shopTagView = [[UIView alloc] init];
    shopTagView.backgroundColor = [UIColor redColor];
}

@end
