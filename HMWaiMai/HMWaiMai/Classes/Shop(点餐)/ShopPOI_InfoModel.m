//
//  ShopPOI_InfoModel.m
//  HMWaiMai
//
//  Created by wx on 2017/8/2.
//  Copyright © 2017年 wx. All rights reserved.
//

#import "ShopPOI_InfoModel.h"

@implementation ShopPOI_InfoModel
+ (instancetype)shopPOI_infoWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

///  模型属性比字典中key少时,重写此方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
