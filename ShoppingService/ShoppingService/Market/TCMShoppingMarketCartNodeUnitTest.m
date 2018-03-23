//
//  TCMShoppingMarketCartNodeUnitTest.m
//  TCMDemo
//
//  Created by Dao on 2017/11/29.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//


#define EXP_SHORTHAND
#import "TCMUnitTestTools.h"

#import "TCMShoppingMarketCartNode.h"

#import "TCMShoppingMarketCompulsoryMarketCartNode.h"
#import "TCMShoppingMarketSelfPayingMarketCartNode.h"

#import "TCMShoppingStoreCompulsoryMarketCartNode.h"
#import "TCMShoppingStoreSelfPayingMarketCartNode.h"

SpecBegin(TCMShoppingMarketCartNodeUnitTest)

describe(@"TCMShoppingMarketCartNode", ^{
	 __block TCMShoppingMarketCartNode *object = nil;
    beforeAll(^{
    	//TODO
        object = (TCMShoppingMarketCompulsoryMarketCartNode *)[TCMShoppingMarketCartNode modelWithFile:@"MarketCompulsory"];
    });
    
    void (^changeGoodsCount)(NSInteger count) = ^(NSInteger count){
        TCMShoppingSupplierCartNode *supplierNode = object.supplierList.firstObject;
        TCMShoppingGoodsNode *goodsNode = supplierNode.goodsList.firstObject;
        goodsNode.goodsCount = @(count).description;
    };

    //TODO: some
    it(@"enterNodePromptMessage", ^{
        object.outOfReach = YES;
        expect(object.enterNodePromptMessage).equal(@"当前选定地址与菜场不符，请更换地址试试");

        object.outOfReach = NO;
        expect(object.enterNodePromptMessage).beNil();
    });

    it(@"serviceChargesPromptMessage", ^{
        object.outOfReach = YES;
        expect(object.serviceChargesPromptMessage).equal(@"当前选中地址与菜市场不符");

        object.outOfReach = NO;
        expect(object.serviceChargesPromptMessage).notTo.equal(@"当前选中地址与菜市场不符");
    });

    it(@"settlementEnable", ^{
        object.outOfReach = YES;
        expect(object.settlementEnable).beFalsy();

        object.outOfReach = NO;

        changeGoodsCount(0);
        expect(object.settlementEnable).beFalsy();

        changeGoodsCount(100);
        expect(object.settlementEnable).beTruthy();

    });
});

SpecEnd
