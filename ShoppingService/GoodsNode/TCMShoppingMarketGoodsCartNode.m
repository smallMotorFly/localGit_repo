//
//  TCMShoppingMarketGoodsCartNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingMarketGoodsCartNode.h"

#import "MJExtension.h"

@implementation TCMShoppingMarketGoodsCartNode

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"goodsID":@"goods_id",
             @"goodsName":@"goods_name",
             @"goodsPrice":@"goods_current_price",
             @"goodsCount":@"goods_count",
             @"goodsCartID":@"goods_cart_id",
             @"goodsStandard":@"standard_description",
             @"icon":@"img",
             @"inventory":@"goods_inventory",
             @"categoryID":@"categoryId",
             @"supplierList":@"status",
             @"supplierList":@"gifts",
             @"activityId":@"marketActivityId",
             @"supplierID":@"store_id",
             @"supplierName":@"store_name",
             };
}

- (instancetype)init{
    if (self = [super init]) {
        self.goodsType = TCMShoppingGoodsTypeMarket;
    }
    return self;
}


- (void)mj_keyValuesDidFinishConvertingToObject{
    [super mj_keyValuesDidFinishConvertingToObject];
    if (self.goodsCountNum > self.inventory) {
        self.goodsCountNum = self.inventory;
    }
}


- (void)setGoodsCountNum:(NSInteger)goodsCountNum{
    self.goodsCount = @(goodsCountNum).description;
}
- (NSInteger)goodsCountNum{
    return self.goodsCount.integerValue;
}

@end
