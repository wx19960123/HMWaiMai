//
//  ShopPOI_InfoModel.h
//  HMWaiMai
//
//  Created by wx on 2017/8/2.
//  Copyright © 2017年 wx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopPOI_InfoModel : NSObject

@property (nonatomic, copy) NSString *poi_back_pic_url;//头部背景图片

@property (nonatomic, copy) NSString *pic_url;//头像

@property (nonatomic, copy) NSString *name;//店名

@property (nonatomic, copy) NSString *bulletin;//商家公告


+ (instancetype)shopPOI_infoWithDict:(NSDictionary *)dict;

@end
