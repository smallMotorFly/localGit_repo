//
//  TCMShoppingSupplierCartNode.h
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingAPI.h"
#import "TCMShoppingGoodsNode.h"

/**
 * 供应商节点
 */
@interface TCMShoppingSupplierCartNode : TCMShoppingAPI


/**
 *  配送服务模式:是否为单店铺服务模式
 */
@property (nonatomic, assign, getter=isStoreDeliveryServiceMode) BOOL storeDeliveryServiceMode;

/**供应商ID*/
@property (nonatomic, copy) NSString *supplierId;
@property (nonatomic, copy) NSString *supplierName;

/**店铺节点下的商品列表*/
@property (nonatomic, copy) NSMutableArray<TCMShoppingGoodsNode *> *goodsList;
@property (nonatomic, readonly, copy) NSArray<TCMShoppingGoodsNode *> *selectedGoodsListForSettlement;
@property (nonatomic, readonly, copy) NSArray<TCMShoppingGoodsNode *> *selectedGoodsListForDelete;

@property (nonatomic, readonly, assign) NSInteger goodsCount;

/**是否选中*/
@property (nonatomic, readonly, assign, getter=isSelected) BOOL selected;



@end
