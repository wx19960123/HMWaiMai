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
#import "HMShopInfoController.h"
#import "HMShopOrderController.h"
#import "ShopCommentController.h"
#import "ShopPOI_InfoModel.h"
#import "HMShopHeaderView.h"


#define KShopHeaderViewMaxHeight   180
#define KShopHeaderViewMinHeight   64

@interface HMShopController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *headerView;//头部视图
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;

@property (nonatomic, weak) UIView *shopTagView;

@property (nonatomic, weak) UIView *shopTagLineView; // 小黄条

@property (nonatomic, weak) UIScrollView *scrollView;//滚动视图
@property (nonatomic, strong) ShopPOI_InfoModel *shopPOI_infoModel;//头部模型数据


@property (nonatomic, weak) HMShopHeaderView *shopHeaderView;

@end

@implementation HMShopController

- (void)viewDidLoad {
    
    [self loadFoodData];//加载数据


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
    
    [self settingShopHeaderView];

    
    [self setShopTagView];
    
    [self settingShopScrollView];
    

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
    [self.view addSubview:shopTagView];
    [shopTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_headerView.mas_bottom).offset(0);
        make.height.offset(44);
    }];
    
    _shopTagView = shopTagView;

    //添加三个按钮
    UIButton *orderBtn = [self makeSHopTagButtonWithTitle:@"点菜"];
    [self makeSHopTagButtonWithTitle:@"评价"];
    [self makeSHopTagButtonWithTitle:@"商家"];
    
    [shopTagView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
    }];
    [shopTagView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];

    UIView *shopTagLineView = [[UIView alloc] init];
    shopTagLineView.backgroundColor = [UIColor yellowColor];
    [shopTagView addSubview:shopTagLineView];
    
    [shopTagLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(50);
        make.height.offset(4);
        make.bottom.offset(0);
        // 小黄条加约束的代码要写在按钮添加约束的后面
        make.centerX.equalTo(orderBtn).offset(0);
    }];
    _shopTagLineView = shopTagLineView;
}

- (void)settingShopScrollView {
    // 创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.equalTo(_shopTagView.mas_bottom).offset(0);
    }];
    // 创建三个控制器
    HMShopOrderController *vc1 = [[HMShopOrderController alloc] init];
    ShopCommentController *vc2 = [[ShopCommentController alloc] init];
    HMShopInfoController *vc3 = [[HMShopInfoController alloc] init];
    NSArray *vcs = @[vc1, vc2, vc3];
    
    for (UIViewController *vc in vcs) {
        [scrollView addSubview:vc.view];
        
        [self addChildViewController:vc]; // 建立父子控制器关系
        
        [vc didMoveToParentViewController:self];
    }
    
    [scrollView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.height.equalTo(scrollView);
    }];
    
    [scrollView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];

    scrollView.delegate = self;

    _scrollView =scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat page = scrollView.contentOffset.x / scrollView.bounds.size.width;    // 取小数页
    
    CGFloat transformOnceX = _shopTagView.bounds.size.width / (_shopTagView.subviews.count - 1);    // 计算小黄条一次需要走的距离

    _shopTagLineView.transform = CGAffineTransformMakeTranslation(transformOnceX * page, 0);    // 设置小黄条水平方向偏移

}


//滚动完全停下后来调用此方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;    // 页数
    // 遍历标签栏中的所有子控件
    for (NSInteger i = 0; i < _shopTagView.subviews.count; i++) {
        
        UIButton *btn = _shopTagView.subviews[i];        // 获取子控件
        
        if ([btn isKindOfClass:[UIButton class]]) {        // 判断当前控件是不是按钮
            if (page == i) { // 如果当前页数和按钮对应时,就把按钮中的文字字体加粗
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            } else { // 把按钮的文字再恢复到不加粗
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
            }
        }
    }
    
}

//滚动完停来会调用此方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];    // 手动去调用 手动拖拽停下来的方法,去更新字体

}

- (UIButton *)makeSHopTagButtonWithTitle:(NSString *)title {//创建按钮方法
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    // 给按钮添加监听事件
    [btn addTarget:self action:@selector(shopTagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 用标签视图子控件的个数来当按钮的tag
    btn.tag = _shopTagView.subviews.count;
    [_shopTagView addSubview:btn];
    
    return btn;
}

- (void)shopTagBtnClick:(UIButton *)btn {
    
    [_scrollView setContentOffset:CGPointMake(btn.tag * _scrollView.bounds.size.width, 0) animated:YES];
    // 动画的方法让scrollView中的内容滚动
}

- (void)settingShopHeaderView {
    // 创建及添加头部视图
    HMShopHeaderView *shopHeaderView = [[HMShopHeaderView alloc] init];
    shopHeaderView.backgroundColor = [UIColor redColor];
    [self.view addSubview:shopHeaderView];
    
    
    [shopHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(KShopHeaderViewMaxHeight);
    }];
    
    _shopHeaderView = shopHeaderView;
    
    shopHeaderView.shopPOI_infoModel = _shopPOI_infoModel;    // 给头部视图传模型

}

- (void)loadFoodData {
    
    // 1.加载json 文件 ---> NSData
    NSData *data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"food.json" withExtension:nil]];
    // 2. NSData ---> dict
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    // 3.获取自己想要的头部视图的数据
    NSDictionary *poi_dict = jsonDict[@"data"][@"poi_info"];
    
    // 4.字典转模型
    ShopPOI_InfoModel *poi_infoModel = [ShopPOI_InfoModel shopPOI_infoWithDict:poi_dict];
    
    _shopPOI_infoModel = poi_infoModel;
    
    
}
@end
