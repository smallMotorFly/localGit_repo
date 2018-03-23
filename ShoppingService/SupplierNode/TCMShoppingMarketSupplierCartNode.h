//
//  TCMShoppingMarketSupplierCartNode.h
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingSupplierCartNode.h"

/**
 * 市场供应商节点
 */
@interface TCMShoppingMarketSupplierCartNode : TCMShoppingSupplierCartNode


/**
 歇业显示内容
 */
@property (nonatomic, copy) NSString *outOfBusinessInfo;

/**
 歇业起始时间
 */
@property (nonatomic, copy) NSString *outOfBusinessBeginTime;

/**
 歇业结束时间
 */
@property (nonatomic, copy) NSString *outOfBusinessEndTime;

/**
 未来三天是否将歇业
 */
@property (nonatomic, assign) BOOL outOfBusiness;

@end
