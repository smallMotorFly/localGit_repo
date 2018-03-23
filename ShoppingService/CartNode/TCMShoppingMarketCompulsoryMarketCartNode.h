//
//  TCMShoppingMarketCompulsoryMarketCartNode.h
//  ShoppingService
//
//  Created by Dao on 2017/11/28.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//

#import "TCMShoppingMarketCartNode.h"

/**
 * 市场强制满免模式节点类
 *  菜市场满X元起送
 */
@interface TCMShoppingMarketCompulsoryMarketCartNode : TCMShoppingMarketCartNode
/*
 1、所选商品总价 < T1(起送价)

 市场提示:"本市场满X元起送"
 去结算提示:"差Z元起送"
 2、所选商品总价 >= T1(起送价)

 无提示信息
 */
@end
