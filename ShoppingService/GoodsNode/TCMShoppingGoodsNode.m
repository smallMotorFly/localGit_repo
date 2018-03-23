//
//  TCMShoppingGoodsNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingGoodsNode.h"

@implementation TCMShoppingGoodsNode

- (NSInteger)goodsPriceCent{
    return self.goodsPrice.doubleValue * 100;
}
- (NSInteger)goodsCountNum{
    return self.goodsCount.integerValue;
}

- (NSInteger)amountCent{
    //TODO: 商品校验--勾选
    if (!self.checkForSettlement) {
        return 0;
    }

    NSInteger amount = self.goodsCountNum * self.goodsPriceCent;

    return amount;
}

- (NSString *)amount{
    return [NSString amountStringWithAmount:self.amountCent*0.01];
}

- (BOOL)checkForDelete{
    if (self.invaidStatus) {
        return YES;
    }

    return self.checkForSettlement;
}

- (void)setCheckForDelete:(BOOL)checkForDelete{
    self.checkForSettlement = checkForDelete;
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.checkForSettlement = !self.invaidStatus;
}

@end
