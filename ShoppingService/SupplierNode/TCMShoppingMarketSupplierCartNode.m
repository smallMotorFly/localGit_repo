//
//  TCMShoppingMarketSupplierCartNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingMarketSupplierCartNode.h"

#import "TCMShoppingMarketGoodsCartNode.h"

@implementation TCMShoppingMarketSupplierCartNode

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"goodsList":TCMShoppingMarketGoodsCartNode.class
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"supplierId":@"store_id",
             @"supplierName":@"store_name",

             @"minDeliveryAmount":@"send_out_up_price",
             @"freeDeliveryFeeAmount":@"store_customer_transaction",
             @"deliveryFee":@"ship_price",

             @"outOfBusinessBeginTime":@"storeOutBusinessBeginTime",
             @"outOfBusinessEndTime":@"storeOutBusinessEndTime",
             @"outOfBusinessInfo":@"storeOutBusinessInfo",
             
             @"outOfBusiness":@"storeDisabled",
             @"goodsList":@"goods",
             };
}
- (id)copyWithZone:(NSZone *)zone{
    TCMShoppingMarketSupplierCartNode *node = [super copyWithZone:zone];

    node.outOfBusinessInfo = self.outOfBusinessInfo;
    node.outOfBusinessBeginTime = self.outOfBusinessBeginTime;
    node.outOfBusinessEndTime = self.outOfBusinessEndTime;
    node.outOfBusiness = self.outOfBusiness;

    return node;
}

- (NSString *)addOnPromptMessage{
    if (self.balanceCentForDelivery > 0) {
        return [NSString stringWithFormat:@"本店铺满%@元起送", self.minDeliveryAmount];
    }

    if (self.deliveryFeeCent && self.balanceCentForFreeDelivery > 0) {
        return [NSString stringWithFormat:@"本店铺满%@元免%@元配送费", self.freeDeliveryFeeAmount, self.deliveryFee];
    }

    return nil;
}


- (NSString *)balanceForDelivery{
    return [NSString amountStringWithAmount:self.balanceCentForDelivery * 0.01];
}
- (NSInteger)balanceCentForDelivery{
    //非单店铺模式,直接直接返回INT_MIN
    if (!self.isActivity) {
        return INT_MIN;
    }

    NSInteger balance = self.minDeliveryAmountCent - self.amountCentsOfSelectedGoods;

    return  balance > 0 ? balance : 0;
}

- (NSString *)balanceForFreeDelivery{
    return [NSString amountStringWithAmount:self.balanceCentForFreeDelivery * 0.01];
}
- (NSInteger)balanceCentForFreeDelivery{
    if (!self.isActivity) {
        return INT_MIN;
    }
    NSInteger balance = self.freeDeliveryFeeAmountCent - self.amountCentsOfSelectedGoods;

    return  balance > 0 ? balance : 0;
}


- (BOOL)settlementEnable{
    if (self.outOfBusiness) {
        return NO;
    }

    if (!self.isStoreDeliveryServiceMode) {
        return NO;
    }

    return (self.amountCentsOfSelectedGoods > self.minDeliveryAmountCent);
}

- (void)setDeliveryServiceMode:(TCMMarketDeliveryServiceMode)deliveryServiceMode{
    [super setDeliveryServiceMode:deliveryServiceMode];
    self.storeDeliveryServiceMode = (self.deliveryServiceMode == TCMMarketDeliveryServiceModeStoreCompulsory || self.deliveryServiceMode == TCMMarketDeliveryServiceModeStoreSelfPaying);

}

- (BOOL)isActivity{
    if (self.outOfBusiness) {
        return NO;
    }

    if (!self.isStoreDeliveryServiceMode) {
        return NO;
    }
    return YES;
}
@end
