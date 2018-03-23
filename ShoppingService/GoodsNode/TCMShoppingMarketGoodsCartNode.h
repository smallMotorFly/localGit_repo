//
//  TCMShoppingMarketGoodsCartNode.h
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingGoodsNode.h"

/**
 * 市场商品节点
 */
@interface TCMShoppingMarketGoodsCartNode : TCMShoppingGoodsNode


/**
 *  所属店铺的营业状态
 */
@property (nonatomic, assign) BOOL belongBusiness;
/**
 *  商品所属店铺ID
 */
@property (nonatomic, copy) NSString *supplierID;

@property (nonatomic, copy) NSString *supplierName;

@end
