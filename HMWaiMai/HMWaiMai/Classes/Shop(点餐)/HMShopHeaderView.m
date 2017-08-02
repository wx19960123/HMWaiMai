//
//  HMShopHeaderView.m
//  HMWaiMai
//
//  Created by wx on 2017/8/2.
//  Copyright © 2017年 wx. All rights reserved.
//

#import "HMShopHeaderView.h"
#import "ShopPOI_InfoModel.h"

@interface HMShopHeaderView ()
@property (nonatomic, weak) UIImageView *backImageView;//背景imageView

@property (nonatomic, weak) UIImageView *avatarView;//头像

@property (nonatomic, weak) UILabel *nameLabel;//店名

@property (nonatomic, weak) UILabel *bulletinLabel;//商家公告


@end
@implementation HMShopHeaderView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    // 添加背景图片
    UIImageView *backImageView = [[UIImageView alloc] init];
    [self addSubview:backImageView];
    
    backImageView.contentMode = UIViewContentModeScaleAspectFill;    // 设置填充模式
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    
    // 轮播视图
    UIView *loopView = [[UIView alloc] init];
    loopView.backgroundColor = [UIColor greenColor];
    [self addSubview:loopView];
    
    [loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(-8);
        make.height.offset(20);
    }];
    
    
    // 虚线
    UIView *dashLineView = [[UIView alloc] init];
    dashLineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:dashLineView];
    
    [dashLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loopView).offset(0);
        make.right.offset(0);
        make.bottom.equalTo(loopView.mas_top).offset(-8);
        make.height.offset(1);
    }];
    
    
    // 4.头像
    UIImageView *avatarView = [[UIImageView alloc] init];
    avatarView.backgroundColor = [UIColor blueColor];
    [self addSubview:avatarView];
    avatarView.layer.cornerRadius = 32;    // 设置圆角

    avatarView.clipsToBounds = YES;    // 超出边界的裁剪掉

    avatarView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;    // 设置边框颜色

    avatarView.layer.borderWidth = 2;    // 边框宽度

    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dashLineView).offset(0);
        make.bottom.equalTo(dashLineView.mas_top).offset(-8);
        make.width.height.offset(64);
    }];
    
    
    
    // 店名
    UILabel *nameLabel = [UILabel makeLabelWithText:@"粮新发现(修正店)" andTextFont:16 andTextColor:[UIColor whiteColor]];
    [self addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarView.mas_right).offset(16);
        make.centerY.equalTo(avatarView).offset(-16);
    }];
    
    
    // 商家公告
    UILabel *bulletinLabel = [UILabel makeLabelWithText:@"公告" andTextFont:14 andTextColor:[UIColor colorWithWhite:1 alpha:0.9]];
    [self addSubview:bulletinLabel];
    
    [bulletinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel).offset(0);
        make.centerY.equalTo(avatarView).offset(16);
        make.right.offset(-16);
    }];
    
    
    _backImageView = backImageView;
    _avatarView = avatarView;
    _nameLabel = nameLabel;
    _bulletinLabel = bulletinLabel;
}











#pragma mark - 有了数据之后给子控件设置数据
- (void)setShopPOI_infoModel:(ShopPOI_InfoModel *)shopPOI_infoModel {
    _shopPOI_infoModel = shopPOI_infoModel;
    
    
    NSString *bgImageURLStr = [shopPOI_infoModel.poi_back_pic_url stringByDeletingPathExtension];
    // 删除url后面多余的.webp后缀

    // 设置背景图片
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:bgImageURLStr]];
    
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:[shopPOI_infoModel.pic_url stringByDeletingPathExtension]]];    // 头像

    _nameLabel.text = shopPOI_infoModel.name;    // 店名

    _bulletinLabel.text = shopPOI_infoModel.bulletin;    // 商家公告

}

@end
