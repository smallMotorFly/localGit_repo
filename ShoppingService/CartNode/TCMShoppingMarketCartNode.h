//
//  TCMShoppingMarketCartNode.h
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingCartNode.h"
#import "TCMGiveAndExchangeGoodsModel.h"

/**
 * 购物车市场节点类
 *  基础API类,定义通用属性、方法
 *  不应具象为实体对象;
 */
@interface TCMShoppingMarketCartNode : TCMShoppingCartNode

/**经度*/
//@property (nonatomic, copy) NSString *lngStr;
/**纬度*/
//@property (nonatomic, copy) NSString *latStr;
/**配送服务时间段*/
//@property (nonatomic, copy) NSString *deliverTimeStr;


/**
 * 满赠换购相关
 *  LowPriceActivity
 **/
/**
 *  是否显示满赠换购按钮
 */
@property (nonatomic) BOOL showLowPriceActivity;
/**
 *  满赠换购ID
 */
@property (nonatomic, copy) NSString *lowPriceActivityId;

/**
 *  是否有满赠换购商品
 */
@property (nonatomic, readonly) BOOL haveGiveAndExchageGoods;
/**
 *  是否有满赠换购规则
 */
@property (nonatomic, readonly) BOOL haveGiveAndExchageRules;
/**
 *  满赠换购按钮 名称
 */
@property (nonatomic, copy) NSString *lowPriceActivityButtonName;
/**
 *  活动名称
 */
@property (nonatomic, copy) NSString *lowPriceActivityTitle;
/**
 *  满赠换购商品信息
 */
@property (nonatomic, strong) NSMutableArray <TCMGiveAndExchangeGoodsModel*> *lowPriceActivityGoods;
@property (nonatomic, strong) NSMutableArray <TCMGiveAndExchangeStepModel*> *lowPriceActivitySteps;



+ (instancetype)modelWithFile:(NSString *)file;

@end
