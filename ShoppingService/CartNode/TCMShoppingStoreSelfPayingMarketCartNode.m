//
//  TCMShoppingStoreSelfPayingMarketCartNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingStoreSelfPayingMarketCartNode.h"

@implementation TCMShoppingStoreSelfPayingMarketCartNode

- (instancetype)init{
    if (self = [super init]) {
        self.deliveryServiceMode = TCMMarketDeliveryServiceModeStoreSelfPaying;
    }
    return self;
}

- (NSString *)balanceForDelivery{
    NSInteger balance = self.balanceCentForDelivery;
    if (balance) {
        return [NSString stringWithFormat:@"%.02f", balance * 0.01];
    }
    return nil;
}
- (NSInteger)balanceCentForDelivery{
    NSInteger balance = INT_MAX;

    for (TCMShoppingSupplierCartNode *node in self.supplierList) {
        NSInteger supplierBalance = node.balanceCentForDelivery;
        balance = MIN(balance, supplierBalance);
        if (balance == 0) {
            break;
        }
    }

    return balance;
}

- (NSString *)balanceForFreeDelivery{
    NSInteger balance = self.balanceCentForFreeDelivery;
    if (balance) {
        return [NSString stringWithFormat:@"%.02f", balance * 0.01];
    }
    return nil;
}
- (NSInteger)balanceCentForFreeDelivery{
    NSInteger balance = INT_MAX;

    for (TCMShoppingSupplierCartNode *node in self.supplierList) {
        NSInteger supplierBalance = node.balanceCentForFreeDelivery;
        balance = MIN(balance, supplierBalance);
        if (balance == 0) {
            break;
        }
    }

    return balance;
}

- (NSString *)serviceChargesPromptMessage{
    if ([super serviceChargesPromptMessage]) {
        return [super serviceChargesPromptMessage];
    }
    NSString *balance = self.balanceForDelivery;
    if (balance) {
        return [NSString stringWithFormat:@"差%@元起送", balance];
    }

    if (self.deliveryFeeCent) {
        balance = self.balanceForFreeDelivery;
        if (balance) {
            return [NSString stringWithFormat:@"差%@元免配送费", balance];
        } else {
            return [NSString stringWithFormat:@"已免%@元配送费", self.deliveryFee];
        }
    }
    return nil;
}



- (BOOL)settlementEnable{
    if (![super settlementEnable]) {
        return NO;
    }

    //遍历是否存在可结算的店铺
    for (TCMShoppingSupplierCartNode *node in self.supplierList) {
        if (node.settlementEnable) {
            return YES;
        }
    }

    return NO;
}

@end
