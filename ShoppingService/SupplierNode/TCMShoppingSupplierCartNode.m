//
//  TCMShoppingSupplierCartNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingSupplierCartNode.h"


@implementation TCMShoppingSupplierCartNode

- (id)copyWithZone:(NSZone *)zone{
    TCMShoppingSupplierCartNode *node = [super copyWithZone:zone];

    node.storeDeliveryServiceMode = self.storeDeliveryServiceMode;
    node.supplierId = self.supplierId;
    node.supplierName = self.supplierName;
    node.goodsList = self.goodsList.mutableCopy;

    return node;
}


- (NSArray<TCMShoppingGoodsNode *> *)selectedGoodsListForSettlement{
    NSMutableArray *array = [NSMutableArray array];

    for (NSInteger index = 0; index < self.goodsList.count; index++) {
        TCMShoppingGoodsNode *node = [self.goodsList objectAtIndex:index];

        if (node.checkForSettlement) {
            [array addObject:node];
        }
    }

    return [array copy];
}

- (NSArray<TCMShoppingGoodsNode *> *)selectedGoodsListForDelete{
    NSMutableArray *array = [NSMutableArray array];

    for (NSInteger index = 0; index < self.goodsList.count; index++) {
        TCMShoppingGoodsNode *node = [self.goodsList objectAtIndex:index];

        if (node.checkForDelete) {
            [array addObject:node];
        }
    }

    return [array copy];
}



- (NSString *)amountOfSelectedGoods{
    return [NSString amountStringWithAmount:self.amountCentsOfSelectedGoods * 0.01];
}
- (NSInteger)amountCentsOfSelectedGoods{
    NSInteger amount = 0;

    for (TCMShoppingGoodsNode *node in self.goodsList) {
        amount += node.amountCent;
    }

    return amount;
}

- (NSString *)amountOfSelectedGoodsWithServiceCharges{
    return self.amountOfSelectedGoods;
}

- (NSInteger)amountCentsOfSelectedGoodsWithServiceCharges{
    return self.amountCentsOfSelectedGoods;
}


@end
