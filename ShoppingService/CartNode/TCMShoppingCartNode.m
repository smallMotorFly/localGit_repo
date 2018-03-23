//
//  TCMShoppingCartNode.m
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingCartNode.h"

@implementation TCMShoppingCartNode

- (id)copyWithZone:(NSZone *)zone{
    TCMShoppingCartNode *node = [super copyWithZone:zone];

    node.cartType = self.cartType;
    node.cartID = self.cartID;
    node.cartName = self.cartName;
    node.outOfReach = self.outOfReach;
    node.relevantAddrInfo = self.relevantAddrInfo;
    node.supplierList = [self.supplierList mutableCopy];

    return node;
}


- (NSString *)serviceChargesPromptMessage{
    if (self.outOfReach) {
        return @"当前选中地址与菜市场不符";
    }
    return nil;
}

- (BOOL)settlementEnable{
    if (![super settlementEnable]) {
        return NO;
    }

    return !self.outOfReach;
}

- (NSString *)enterNodePromptMessage{
    if (self.outOfReach) {
        return @"当前选定地址与菜场不符，请更换地址试试";
    }

    return nil;
}

@end
