//
//  TCMShoppingGoodsNode.h
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCMGeneralGoodsModel.h"

#import "NSString+TCMExtension.h"
#import "MJExtension.h"

/**
 * 通用商品节点
 */
@interface TCMShoppingGoodsNode : NSObject

@property (nonatomic, assign) TCMShoppingGoodsType goodsType;


/**
 *  商品ID
 */
@property (nonatomic, copy) NSString *goodsID;

/**
 *  商品名称
 */
@property (nonatomic, copy) NSString *goodsName;


/**
 商品图片[URL]
 */
@property (nonatomic, copy) NSURL *icon;

/**
 *  商品库存
 */
@property (nonatomic, assign) NSInteger inventory;

/**
 *  商品当前价格
 */
@property (nonatomic, copy) NSString *goodsPrice;
/**商品当前价格[一分制]*/
@property (nonatomic, readonly, assign) NSInteger goodsPriceCent;

/**
 *  商品数量
 */
@property (nonatomic, readonly, assign) NSInteger goodsCountNum;
@property (nonatomic, copy) NSString *goodsCount;

/**
 *  商品对应的购物车ID[每一个商品在购物车中都有一个独立ID]
 */
@property (nonatomic, copy) NSString *goodsCartID;


/**
 *  商品规格
 */
@property (nonatomic, copy) NSString *goodsStandard;


/**
 *  商品所属品类
 */
@property (nonatomic, copy) NSString *categoryID;

/**
 是否失效
 */
@property (nonatomic, assign) BOOL invaidStatus;

@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, strong) NSDictionary *gifts;             //赠品



/**
 商品金额
 */
@property (nonatomic, readonly, copy) NSString *amount;
@property (nonatomic, readonly, assign) NSInteger amountCent;

@property (nonatomic, assign) BOOL checkForDelete;
@property (nonatomic, assign) BOOL checkForSettlement;

@end
