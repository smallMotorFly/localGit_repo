//
//  TCMShoppingMarketSelfPayingMarketCartNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingMarketSelfPayingMarketCartNode.h"

@implementation TCMShoppingMarketSelfPayingMarketCartNode

- (instancetype)init{
    if (self = [super init]) {
        self.deliveryServiceMode = TCMMarketDeliveryServiceModeMarketSelfPaying;
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
    NSInteger amountCent = self.amountCentsOfSelectedGoods;
    NSInteger balance = 0;
    if (amountCent < self.minDeliveryAmountCent) {
        balance = self.minDeliveryAmountCent - amountCent;
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
    NSInteger amountCent = self.amountCentsOfSelectedGoods;
    NSInteger balance = 0;
    if (amountCent < self.freeDeliveryFeeAmountCent) {
        balance = self.freeDeliveryFeeAmountCent - amountCent;
    }
    return balance;
}


- (NSString *)addOnPromptMessage{
    if (self.balanceCentForDelivery) {
        return [NSString stringWithFormat:@"本市场满%@元起送", self.minDeliveryAmount];
    }

    if (self.deliveryFeeCent && self.balanceCentForFreeDelivery) {
        return [NSString stringWithFormat:@"本市场满%@元免%@元配送费", self.freeDeliveryFeeAmount, self.deliveryFee];
    }

    return nil;
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

    if (self.amountCentsOfSelectedGoods >= self.minDeliveryAmountCent) {
        return YES;
    }

    return NO;
}

@end
