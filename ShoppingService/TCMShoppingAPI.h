//
//  TCMShoppingAPI.h
//  TCMDemo
//
//  Created by Dao on 2017/11/29.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"
#import "NSString+TCMExtension.h"

#import "GDMarketModel.h"

/**
 *  菜篮子类型
 */
typedef NS_ENUM(NSInteger,TCMShoppingCartNodeType) {
    /**
     *  普通商品
     */
    GDShoppingCartNodeTypeNormal = 0,
    TCMShoppingCartNodeTypeMarket  = GDShoppingCartNodeTypeNormal,
    /**
     *  优品
     */
    GDShoppingCartNodeSuperior = 1,
    TCMShoppingCartNodeTypeSuperior = GDShoppingCartNodeSuperior,
};

//typedef TCMShoppingCartNodeType GDShoppingCartType ;



@interface TCMShoppingAPI : NSObject <NSCopying>

/**满免机制*/
@property (nonatomic, assign) TCMMarketDeliveryServiceMode deliveryServiceMode;

/**起送价格*/
@property (nonatomic, copy) NSString *minDeliveryAmount;
@property (nonatomic, readonly, assign) NSInteger minDeliveryAmountCent;
/**免配送费价格*/
@property (nonatomic, copy) NSString  *freeDeliveryFeeAmount;
@property (nonatomic, readonly, assign) NSInteger freeDeliveryFeeAmountCent;
/**配送费*/
@property (nonatomic, copy) NSString *deliveryFee;
/**配送费:1分制*/
@property (nonatomic, readonly, assign) NSInteger deliveryFeeCent;

//@property (nonatomic, assign) BOOL outOfBussindess;


/**
 * 进入该节点UI界面的提示信息[市场\店铺]， 非 nil 表示不可进入
 */
@property (nonatomic, readonly, copy) NSString *enterNodePromptMessage;

/**
 * 结算
 */
@property (nonatomic, readonly, assign) BOOL settlementEnable;


/**
 *  起送的最低差价[一分制]
 */
@property (nonatomic, readonly, assign) NSInteger balanceCentForDelivery;
/** 起送的最低差价[0.00] */
@property (nonatomic, readonly, copy) NSString *balanceForDelivery;

/**
 *  满免的最低差价[一分制]
 */
@property (nonatomic, readonly, assign) NSInteger balanceCentForFreeDelivery;
/** 满免的最低差价[0.00] */
@property (nonatomic, readonly, copy) NSString *balanceForFreeDelivery;

/**
 * 通用API
 */


/**
 凑单提示信息[nil表示不需要凑单]
     派生类需事先该方法
 @return 提示信息[默认返回nil]
 */
- (NSString *)addOnPromptMessage;


/**
 所需配送费提示信息[nil表示不需要配送费]
      派生类需实现该方法
 @return 所需配送费提示信息[默认返回nil]
 */
- (NSString *)serviceChargesPromptMessage;

/**
 满赠换购提示语[nil表示无相关活动]
      派生类需实现该方法
 @return 满赠换购提示语[默认返回nil]
 */
- (NSString *)giveAndExchagePromptMessage;

/**
 已选商品结算价(无配送服务费)
 [结果单位:￥0.00]
 @return 已选商品结算价
 */
- (NSString *)amountOfSelectedGoods;


/**
 已选商品结算价(无配送服务费)
 [结果单位:分]
      派生类需实现该方法
 @return 已选商品结算价
 */
- (NSInteger)amountCentsOfSelectedGoods;

/**
 已选商品结算价(含配送服务费)
 [结果单位:￥0.00]
      派生类需实现该方法
 @return 已选商品结算价
 */
- (NSString *)amountOfSelectedGoodsWithServiceCharges;

/**
 已选商品结算价(含配送服务费)
 [结果单位:分]
      派生类需实现该方法
 @return 已选商品结算价
 */
- (NSInteger)amountCentsOfSelectedGoodsWithServiceCharges;





+ (id)dataWithFile:(NSString *)file;

@end
