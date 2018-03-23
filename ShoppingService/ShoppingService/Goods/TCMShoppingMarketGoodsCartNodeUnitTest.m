//
//  TCMShoppingMarketGoodsCartNodeUnitTest.m
//  TCMDemo
//
//  Created by Dao on 2017/11/29.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//


#define EXP_SHORTHAND
#import "TCMUnitTestTools.h"

#import "TCMShoppingMarketGoodsCartNode.h"
#import "TCMShoppingMarketCartNode.h"
#import "TCMShoppingMarketSupplierCartNode.h"

SpecBegin(TCMShoppingMarketGoodsCartNodeUnitTest)

describe(@"TCMShoppingMarketGoodsCartNode", ^{
	 __block TCMShoppingMarketGoodsCartNode *object = nil;
    __block TCMShoppingMarketCartNode *cartNode = nil;
    __block TCMShoppingMarketSupplierCartNode *supplierNode = nil;
    beforeAll(^{
    	//TODO

    });

    //TODO: some
    describe(@"StoreCompulsory", ^{
        beforeAll(^{
            //TODO
            cartNode = [TCMShoppingMarketCartNode modelWithFile:@"StoreCompulsory"];
            supplierNode = (TCMShoppingMarketSupplierCartNode *)cartNode.supplierList.firstObject;
            object = (TCMShoppingMarketGoodsCartNode *)supplierNode.goodsList.firstObject;

        });

        //TODO: some
        it(@"StoreCheck", ^{
            expect(object).notTo.beNull();
            expect(object.goodsID).equal(@"902792");
            expect(object.goodsName).equal(@"鸡腿");
            expect(object.goodsPrice).equal(@"16.80");
            expect(object.categoryID).equal(@"65757,4877");
            expect(object.goodsCartID).equal(@"703042692540461056");
            expect(object.inventory).equal(97);
            expect(object.goodsStandard).equal(@"500g/份");
            expect(object.supplierID).equal(@"5165");
            expect(object.supplierName).equal(@"天天鲜蔬菜朱莘店");
            expect(object.invaidStatus).beFalsy();

            if (!object.invaidStatus) {
                NSInteger amount = object.goodsCount.integerValue * object.goodsPrice.doubleValue * 100;
                expect(object.amountCent).equal(amount);

                NSString *amountString =[NSString stringWithFormat:@"%.02f", amount * 0.01];
                expect(object.amount).equal(amountString);

            }

        });
    });

    afterAll(^{

    });
});

SpecEnd
