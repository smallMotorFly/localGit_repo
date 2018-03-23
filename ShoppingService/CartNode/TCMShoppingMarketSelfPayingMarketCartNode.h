//
//  TCMShoppingMarketSelfPayingMarketCartNode.h
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingMarketCartNode.h"

/**
 * 市场不满付费模式节点类
 *  整体市场满X元起送
 *  整体市场满Y元免配送费，不满需支付Z元配送
 */
@interface TCMShoppingMarketSelfPayingMarketCartNode : TCMShoppingMarketCartNode
/*
 1、所选商品总价 < T1(起送价)

 市场提示:"本市场满X元起送"
 去结算提示:"差Z元起送"
 2、所选商品总价 < T3(满免价)

 市场提示:"本市场满X元免Y元配送费"
 去结算提示:"差Z元免配送费"
 3、所选商品总价 >= T3(满免价)

 去结算提示:"已免Y元配送费"
 */
@end
