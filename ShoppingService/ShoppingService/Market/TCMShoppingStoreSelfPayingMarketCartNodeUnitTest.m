//
//  TCMShoppingStoreSelfPayingMarketCartNodeUnitTest.m
//  TCMDemo
//
//  Created by Dao on 2017/11/30.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//


#define EXP_SHORTHAND
#import "TCMUnitTestTools.h"

#import "TCMShoppingStoreSelfPayingMarketCartNode.h"

SpecBegin(TCMShoppingStoreSelfPayingMarketCartNodeUnitTest)

describe(@"TCMShoppingStoreSelfPayingMarketCartNode", ^{
	 __block TCMShoppingStoreSelfPayingMarketCartNode *object = nil;

    void (^changeGoodsCount)(NSInteger count) = ^(NSInteger count){
        TCMShoppingSupplierCartNode *supplierNode = object.supplierList.firstObject;
        TCMShoppingGoodsNode *goodsNode = supplierNode.goodsList.firstObject;
        goodsNode.goodsCount = @(count).description;
    };

    describe(@"StoreSelfPaying", ^{
        beforeAll(^{
            //TODO
            object = (TCMShoppingStoreSelfPayingMarketCartNode *)[TCMShoppingMarketCartNode modelWithFile:@"StoreSelfPaying"];
            Delay
        });

        //TODO: some
        it(@"Market Check", ^{
            expect(object).notTo.beNull();
            expect(object.cartName).equal(@"莘光菜市场");
            expect(object.cartID).equal(@"4555977");
            expect(object.minDeliveryAmount).equal(@"29.00");
            expect(object.minDeliveryAmountCent).equal(2900);
            expect(object.freeDeliveryFeeAmount).equal(@"59");
            expect(object.freeDeliveryFeeAmountCent).equal(5900);
            expect(object.deliveryFee).equal(@"3");
            expect(object.deliveryFeeCent).equal(300);
            expect(object.outOfReach).beFalsy();
        });

        it(@"Amount", ^{
            expect(object.amountCentsOfSelectedGoods).equal(0);
            expect(object.amountOfSelectedGoods).equal(0);
            expect(object.settlementEnable).beFalsy();

        });
        describe(@"Message", ^{
            __block TCMShoppingGoodsNode *goodsNode = nil;
            beforeAll(^{
                TCMShoppingSupplierCartNode *supplierNode = object.supplierList.firstObject;
                goodsNode = supplierNode.goodsList.firstObject;
            });

            it(@"不满足起送", ^{
                //不满足起送
                changeGoodsCount(floor(object.minDeliveryAmountCent * 1.0 /goodsNode.goodsPriceCent));

                expect(object.amountCentsOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beFalsy();
                expect(object.addOnPromptMessage).equal(nil);
                expect(object.serviceChargesPromptMessage).equal(nil);
            });

            it(@"不满足满免条件", ^{
                changeGoodsCount(ceil(object.minDeliveryAmountCent * 1.0 /goodsNode.goodsPriceCent));
                expect(object.amountCentsOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beFalsy();
                expect(object.addOnPromptMessage).equal(nil);
                expect(object.serviceChargesPromptMessage).equal(nil);
            });

            it(@"达到满免", ^{
                changeGoodsCount(ceil(object.freeDeliveryFeeAmountCent * 1.0 /goodsNode.goodsPriceCent));
                expect(object.amountCentsOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beFalsy();
                expect(object.addOnPromptMessage).equal(nil);
                expect(object.serviceChargesPromptMessage).equal(nil);

            });

        });

    });
});

SpecEnd
