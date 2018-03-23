//
//  TCMShoppingMarketCartNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingMarketCartNode.h"

//市场模式
#import "TCMShoppingMarketCompulsoryMarketCartNode.h"
#import "TCMShoppingMarketSelfPayingMarketCartNode.h"

//单店铺模式
#import "TCMShoppingStoreCompulsoryMarketCartNode.h"
#import "TCMShoppingStoreSelfPayingMarketCartNode.h"

#import "TCMShoppingMarketSupplierCartNode.h"



@implementation TCMShoppingMarketCartNode

- (instancetype)init{
    if (self = [super init]) {
        self.cartType = TCMShoppingCartNodeTypeMarket;
    }
    return self;
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"lowPriceActivityGoods":TCMGiveAndExchangeGoodsModel.class,
             @"lowPriceActivitySteps":TCMGiveAndExchangeStepModel.class,
             @"supplierList":TCMShoppingMarketSupplierCartNode.class
             };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"lowPriceActivityButtonName":@"showLowPriceActivityButtonName",
             @"lowPriceActivityTitle":@"showLowPriceActivityTitle",
             @"cartID":@"area_id",
             @"cartName":@"area_name",
             @"minDeliveryAmount":@"send_out_up_price",
             @"freeDeliveryFeeAmount":@"customer_transaction",
             @"deliveryFee":@"ship_price",
             @"outOfReach":@"nearMarket",
             @"supplierList":@"stores",

             };
}

- (id)copyWithZone:(NSZone *)zone{
    TCMShoppingMarketCartNode *node = [super copyWithZone:zone];

    node.showLowPriceActivity = self.showLowPriceActivity;
    node.lowPriceActivityId = self.lowPriceActivityId;
    node.lowPriceActivityButtonName = self.lowPriceActivityButtonName;
    node.lowPriceActivityTitle = self.lowPriceActivityTitle;
    node.lowPriceActivityGoods = self.lowPriceActivityGoods.mutableCopy;
    node.lowPriceActivitySteps = self.lowPriceActivitySteps.mutableCopy;

    return node;
}

- (NSString *)amountOfSelectedGoods{
    return [NSString amountStringWithAmount: self.amountCentsOfSelectedGoods * 0.01];
}

- (NSInteger)amountCentsOfSelectedGoods{
    NSInteger amount = 0;
    for (TCMShoppingSupplierCartNode *node in self.supplierList) {
        amount += node.amountCentsOfSelectedGoods;
    }
    return amount;
}

- (NSString *)amountOfSelectedGoodsWithServiceCharges{
    return [NSString amountStringWithAmount: self.amountCentsOfSelectedGoodsWithServiceCharges * 0.01];
}

- (NSInteger)amountCentsOfSelectedGoodsWithServiceCharges{
    NSInteger amount = self.amountCentsOfSelectedGoods;
    if (amount < self.freeDeliveryFeeAmountCent) {
        amount += self.deliveryFeeCent;
    }
    return amount;
}


- (NSString *)giveAndExchagePromptMessage{
    return @"满赠换购信息";
}

- (NSInteger)balanceCentForFreeDelivery{
    return self.balanceCentForDelivery;
}

- (NSString *)balanceForFreeDelivery{
    return self.balanceForDelivery;
}


- (void)mj_keyValuesDidFinishConvertingToObject{
    for (int i = 0; i < self.lowPriceActivityGoods.count; i++) {
        TCMGiveAndExchangeGoodsModel *goods = self.lowPriceActivityGoods[i];
        goods.marketActivityId = self.lowPriceActivityId;
        if (i == 0) {
            goods.isFirst = YES;
        }else if (i == self.lowPriceActivityGoods.count-1){
            goods.isLast = YES;
        }
    }

    for (TCMShoppingSupplierCartNode *node in self.supplierList) {
        node.deliveryServiceMode = self.deliveryServiceMode;

        if (self.deliveryServiceMode == TCMMarketDeliveryServiceModeStoreCompulsory) {
            node.minDeliveryAmount = node.freeDeliveryFeeAmount;
        } else if (self.deliveryServiceMode == TCMMarketDeliveryServiceModeStoreSelfPaying) {
            node.minDeliveryAmount = self.minDeliveryAmount;
        }
        node.deliveryFee = self.deliveryFee;
    }

}
+ (NSMutableArray *)mj_objectArrayWithKeyValuesArray:(id)keyValuesArray{
    NSMutableArray *array = [NSMutableArray array];

    for (NSDictionary *keyValues in keyValuesArray) {
        TCMMarketDeliveryServiceMode mode = [[keyValues valueForKey:@"marketDeliveryType"] integerValue];
        TCMShoppingMarketCartNode *node = nil;
        switch (mode) {
            case TCMMarketDeliveryServiceModeMarketCompulsory:
                node = [TCMShoppingMarketCompulsoryMarketCartNode mj_objectWithKeyValues:keyValues];
                break;
            case TCMMarketDeliveryServiceModeMarketSelfPaying:
                node = [TCMShoppingMarketSelfPayingMarketCartNode mj_objectWithKeyValues:keyValues];
                break;
            case TCMMarketDeliveryServiceModeStoreCompulsory:
                node = [TCMShoppingStoreCompulsoryMarketCartNode mj_objectWithKeyValues:keyValues];
                break;
            case TCMMarketDeliveryServiceModeStoreSelfPaying:
                node = [TCMShoppingStoreSelfPayingMarketCartNode mj_objectWithKeyValues:keyValues];
                break;
        }
        if (node) {
            [array addObject:node];
        }
    }
    return array;
}

+ (instancetype)modelWithFile:(NSString *)file{

    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"plist"];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
    NSArray *arrays = [TCMShoppingMarketCartNode mj_objectArrayWithKeyValuesArray:dataArray];

    return arrays.firstObject;
}

@end
