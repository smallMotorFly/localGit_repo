//
//  TCMShoppingMarketSelfPayingMarketCartNodeUnitTest.m
//  TCMDemo
//
//  Created by Dao on 2017/11/30.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//


#define EXP_SHORTHAND
#import "TCMUnitTestTools.h"

#import "TCMShoppingMarketSelfPayingMarketCartNode.h"

SpecBegin(TCMShoppingMarketSelfPayingMarketCartNodeUnitTest)

describe(@"TCMShoppingMarketSelfPayingMarketCartNode", ^{
	 __block TCMShoppingMarketSelfPayingMarketCartNode *object = nil;

    void (^changeGoodsCount)(NSInteger count) = ^(NSInteger count){
        TCMShoppingSupplierCartNode *supplierNode = object.supplierList.firstObject;
        TCMShoppingGoodsNode *goodsNode = supplierNode.goodsList.firstObject;
        goodsNode.goodsCount = @(count).description;
    };
    
    describe(@"MarketSelfPaying", ^{
        beforeAll(^{
            //TODO
            object = (TCMShoppingMarketSelfPayingMarketCartNode *)[TCMShoppingMarketCartNode modelWithFile:@"MarketSelfPaying"];
            Delay
        });

        before(^{
            changeGoodsCount(1);
        });

        //TODO: some
        it(@"Market Check", ^{
            expect(object).notTo.beNull();
            expect(object.cartName).equal(@"莘裕菜市场");
            expect(object.cartID).equal(@"4564944");
            expect(object.minDeliveryAmount).equal(@"29.00");
            expect(object.minDeliveryAmountCent).equal(2900);
            expect(object.freeDeliveryFeeAmount).equal(@"59");
            expect(object.freeDeliveryFeeAmountCent).equal(5900);
            expect(object.deliveryFee).equal(@"3");
            expect(object.deliveryFeeCent).equal(300);
            expect(object.outOfReach).beFalsy();
        });

        it(@"Amount", ^{
            expect(object.amountCentsOfSelectedGoods).equal(10);
            expect(object.amountOfSelectedGoods).equal(10);
            expect(object.settlementEnable).beFalsy();

        });

        describe(@"Message", ^{
            __block TCMShoppingGoodsNode *goodsNode = nil;
            beforeAll(^{
                TCMShoppingSupplierCartNode *supplierNode = object.supplierList.firstObject;
                goodsNode = supplierNode.goodsList.firstObject;
            });

            it(@"less than minDeliveryAmountCent", ^{
                //不满足起送
                expect(object.amountCentsOfSelectedGoods).beLessThan(object.minDeliveryAmountCent);
                expect(object.amountOfSelectedGoods.integerValue).beLessThan(object.minDeliveryAmount.integerValue);

                expect(object.settlementEnable).beFalsy();

                NSString *prompt = [NSString stringWithFormat:@"本市场满%@元起送", object.minDeliveryAmount];
                expect(object.addOnPromptMessage).equal(prompt);
                prompt = [NSString stringWithFormat:@"差%.02f元起送", object.balanceCentForDelivery * 0.01];
                expect(object.serviceChargesPromptMessage).equal(prompt);
            });

            it(@"less than freeDeliveryFeeAmountCent", ^{
                changeGoodsCount(object.freeDeliveryFeeAmountCent/goodsNode.goodsPriceCent - 1);
                expect(object.amountCentsOfSelectedGoods).beLessThan(object.freeDeliveryFeeAmountCent);
                expect(object.amountOfSelectedGoods.integerValue).beLessThan(object.freeDeliveryFeeAmount.integerValue);

                expect(object.settlementEnable).beFalsy();
                NSString *prompt = [NSString stringWithFormat:@"本市场满%@元起送", object.freeDeliveryFeeAmount];
                expect(object.addOnPromptMessage).equal(prompt);
                expect(object.serviceChargesPromptMessage).equal(nil);
            });

            it(@"greater freeDeliveryFeeAmountCent", ^{
                changeGoodsCount(object.freeDeliveryFeeAmountCent/goodsNode.goodsPriceCent + 1);
                expect(object.amountCentsOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).
                equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.addOnPromptMessage).equal(nil);
                expect(object.serviceChargesPromptMessage).equal(nil);

                object.outOfReach = YES;
                expect(object.settlementEnable).beFalsy();

                object.outOfReach = NO;
                expect(object.settlementEnable).beTruthy();

            });

        });

    });
});

SpecEnd
