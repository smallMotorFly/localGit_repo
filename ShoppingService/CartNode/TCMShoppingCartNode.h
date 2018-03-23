//
//  TCMShoppingCartNode.h
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingAPI.h"

#import "TCMShoppingSupplierCartNode.h"



@class GDAddrInfoModel;
/**
 * 购物车节点类
 *  基础API类,定义通用属性、方法
 */
@interface TCMShoppingCartNode : TCMShoppingAPI

/**
 * 通用属性
 */


/**购物车节点类型*/
@property (nonatomic, assign) TCMShoppingCartNodeType cartType;
@property (nonatomic, copy) NSString * cartName;
@property (nonatomic, copy) NSString *cartID;


/**供应商列表*/
@property (nonatomic, strong) NSMutableArray<TCMShoppingSupplierCartNode *> *supplierList;
/**已勾选的供应商列表*/
@property (nonatomic, readonly, copy) NSArray<TCMShoppingSupplierCartNode *> *selectedSupplierList;
/**关联地址*/
@property (nonatomic, copy) GDAddrInfoModel *relevantAddrInfo;
/**是否超出服务区*/
@property (nonatomic, assign) BOOL outOfReach;


/**商品数量*/
@property (nonatomic, readonly, assign) NSInteger goodsCount;


@end


