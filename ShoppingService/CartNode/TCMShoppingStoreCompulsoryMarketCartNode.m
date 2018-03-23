//
//  TCMShoppingStoreCompulsoryMarketCartNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingStoreCompulsoryMarketCartNode.h"

@implementation TCMShoppingStoreCompulsoryMarketCartNode

- (instancetype)init{
    if (self = [super init]) {
        self.deliveryServiceMode = TCMMarketDeliveryServiceModeStoreCompulsory;
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

    for (TCMShoppingSupplierCartNode *node in self.supplierList) {
        if (node.settlementEnable) {
            return YES;
        }
    }

    return NO;
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    [super mj_keyValuesDidFinishConvertingToObject];
    self.minDeliveryAmount = self.freeDeliveryFeeAmount;
}

@end
