//
//  TCMShoppingStoreSelfPayingMarketCartNode.h
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingMarketCartNode.h"

/**
 * 单店铺不满付费模式节点类
 *  市场内任一店铺满X元起送
 *  市场内任一店铺满Y元免配送费，不满需支付Z元配送
 */
@interface TCMShoppingStoreSelfPayingMarketCartNode : TCMShoppingMarketCartNode
/*
 1、所选商品总价 < T1(起送价)

 店铺提示:"本店铺满X元起送"
 去结算提示:"差Z元起送"（提示信息按照差额最少的提示）
 2、所选商品总价 < T3(满免价)

 店铺提示:"本店铺满X元免Y元配送费"
 去结算提示:"差Z元免配送费"（提示信息按照差额最少的提示）
 3、所选商品总价 >= T3(满免价)

 去结算提示:"已免Y元配送费"
 */
@end
