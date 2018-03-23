//
//  TCMShoppingMarketCompulsoryMarketCartNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingMarketCompulsoryMarketCartNode.h"


@implementation TCMShoppingMarketCompulsoryMarketCartNode

- (instancetype)init{
    if (self = [super init]) {
        self.deliveryServiceMode = TCMMarketDeliveryServiceModeMarketCompulsory;
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
    if (amountCent < self.minDeliveryAmountCent) {
        NSInteger balance = self.minDeliveryAmountCent - amountCent;
        return balance;
    }

    return 0;
}


- (NSString *)addOnPromptMessage{
    NSString *balance = self.balanceForDelivery;
    if (balance) {
        return [NSString stringWithFormat:@"本市场满%@元起送", self.minDeliveryAmount];
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


- (void)mj_keyValuesDidFinishConvertingToObject{
    [super mj_keyValuesDidFinishConvertingToObject];
    self.minDeliveryAmount = self.freeDeliveryFeeAmount;
}

@end
