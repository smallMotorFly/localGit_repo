//
//  TCMShoppingAPI.m
//  TCMDemo
//
//  Created by Dao on 2017/11/29.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingAPI.h"

@implementation TCMShoppingAPI


- (id)copyWithZone:(NSZone *)zone{
    TCMShoppingAPI *object = [[self.class alloc] init];

    object.deliveryServiceMode = self.deliveryServiceMode;
    object.minDeliveryAmount = self.minDeliveryAmount;
    object.freeDeliveryFeeAmount = self.freeDeliveryFeeAmount;
    object.deliveryFee = self.deliveryFee;
//    object.outOfBussindess = self.outOfBussindess;

    return object;
}

- (NSInteger)minDeliveryAmountCent{
    return self.minDeliveryAmount.doubleValue * 100;
}
- (NSInteger)freeDeliveryFeeAmountCent{
    return self.freeDeliveryFeeAmount.doubleValue * 100;
}
- (NSInteger)deliveryFeeCent{
    return self.deliveryFee.doubleValue * 100;
}
- (NSString *)addOnPromptMessage{
    return nil;
}

- (NSString *)serviceChargesPromptMessage{
    return nil;
}
- (NSString *)giveAndExchagePromptMessage{
    return nil;
}

- (NSString *)amountOfSelectedGoods{
    return [NSString stringWithFormat:@"%ld", (long)[self amountCentsOfSelectedGoods]];
}

- (NSInteger)amountCentsOfSelectedGoods{
    return 0;
}


- (NSString *)amountOfSelectedGoodsWithServiceCharges{
    return [NSString stringWithFormat:@"%ld", (long)[self amountCentsOfSelectedGoods]];
}
- (NSInteger)amountCentsOfSelectedGoodsWithServiceCharges{
    return 0;
}

- (BOOL)settlementEnable{
    return YES;
}

+ (id)dataWithFile:(NSString *)file{

    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    return dic;
}

@end
