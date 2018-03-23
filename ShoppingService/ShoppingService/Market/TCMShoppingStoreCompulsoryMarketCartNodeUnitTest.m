//
//  TCMShoppingStoreCompulsoryMarketCartNodeUnitTest.m
//  TCMDemo
//
//  Created by Dao on 2017/11/30.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//


#define EXP_SHORTHAND
#import "TCMUnitTestTools.h"

#import "TCMShoppingStoreCompulsoryMarketCartNode.h"

SpecBegin(TCMShoppingStoreCompulsoryMarketCartNodeUnitTest)

describe(@"TCMShoppingStoreCompulsoryMarketCartNode", ^{
	 __block TCMShoppingStoreCompulsoryMarketCartNode *object = nil;

    void (^changeGoodsCount)(NSInteger count) = ^(NSInteger count){
        TCMShoppingSupplierCartNode *supplierNode = object.supplierList.firstObject;
        TCMShoppingGoodsNode *goodsNode = supplierNode.goodsList.firstObject;
        goodsNode.goodsCount = @(count).description;
    };

    describe(@"StoreCompulsory", ^{
        beforeAll(^{
            //TODO
            object = (TCMShoppingStoreCompulsoryMarketCartNode *)[TCMShoppingMarketCartNode modelWithFile:@"StoreCompulsory"];
            Delay
        });

        //TODO: some
        it(@"Market Check", ^{
            expect(object).notTo.beNull();
            expect(object.cartName).equal(@"朱莘菜市场");
            expect(object.cartID).equal(@"4564548");
            expect(object.minDeliveryAmount).equal(@"29");
            expect(object.minDeliveryAmountCent).equal(2900);
            expect(object.freeDeliveryFeeAmount).equal(@"29");
            expect(object.freeDeliveryFeeAmountCent).equal(2900);
            expect(object.deliveryFee).equal(@"0");
            expect(object.deliveryFeeCent).equal(0);
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
                changeGoodsCount(1);
                expect(goodsNode.goodsCountNum).equal(0);
                expect(goodsNode.goodsPriceCent).equal(0);
                expect(object.amountCentsOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beFalsy();
                expect(object.addOnPromptMessage).equal(nil);
                expect(object.serviceChargesPromptMessage).equal(nil);
            });


            it(@"达到满免", ^{
                changeGoodsCount(object.freeDeliveryFeeAmountCent/goodsNode.goodsPriceCent + 1);
                expect(object.amountCentsOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beTruthy();
                expect(object.addOnPromptMessage).equal(nil);
                expect(object.serviceChargesPromptMessage).equal(nil);

            });

        });
    });
    
});

SpecEnd
