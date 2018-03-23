//
//  TCMShoppingMarketCompulsoryMarketCartNodeUnitTest.m
//  TCMDemo
//
//  Created by Dao on 2017/11/30.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//


#define EXP_SHORTHAND
#import "TCMUnitTestTools.h"

#import "TCMShoppingMarketCompulsoryMarketCartNode.h"

SpecBegin(TCMShoppingMarketCompulsoryMarketCartNodeUnitTest)

describe(@"TCMShoppingMarketCompulsoryMarketCartNode", ^{
	 __block TCMShoppingMarketCompulsoryMarketCartNode *object = nil;

    void (^changeGoodsCount)(NSInteger count) = ^(NSInteger count){
        TCMShoppingSupplierCartNode *supplierNode = object.supplierList.firstObject;
        TCMShoppingGoodsNode *goodsNode = supplierNode.goodsList.firstObject;
        goodsNode.goodsCount = @(count).description;
    };
    //TODO: some
    describe(@"MarketCompulsory", ^{
        beforeAll(^{
            //TODO
            object = (TCMShoppingMarketCompulsoryMarketCartNode *)[TCMShoppingMarketCartNode modelWithFile:@"MarketCompulsory"];

            object.outOfReach = NO;
        });
        before(^{
            changeGoodsCount(1);
        });
        //TODO: some
        it(@"Market Check", ^{
            object = [object copy];
            expect(object).notTo.beNull();
            expect(object.cartName).equal(@"喜满一楼菜市场");
            expect(object.cartID).equal(@"4577708");
            expect(object.minDeliveryAmount).equal(@"29");
            expect(object.minDeliveryAmountCent).equal(2900);
            expect(object.freeDeliveryFeeAmount).equal(@"29");
            expect(object.deliveryFee).equal(@"0");
            expect(object.deliveryFeeCent).equal(0);
        });


        it(@"Amount", ^{
            expect(object.amountCentsOfSelectedGoods).equal(object.minDeliveryAmountCent);
            expect(object.amountOfSelectedGoods).equal(object.minDeliveryAmount);
            expect(object.settlementEnable).beFalsy();
        });

        it(@"less than minDeliveryAmount", ^{
            changeGoodsCount(1);
            expect(object.amountCentsOfSelectedGoods).beLessThan(object.minDeliveryAmountCent);
            expect(object.amountOfSelectedGoods.integerValue).beLessThan(object.minDeliveryAmount.integerValue);
            expect(object.settlementEnable).beFalsy();

            NSString *prompt = [NSString stringWithFormat:@"本市场满%@元起送", object.minDeliveryAmount];
            expect(object.addOnPromptMessage).equal(prompt);

            prompt = [NSString stringWithFormat:@"差%.02f元起送", object.balanceCentForDelivery * 0.01];
            expect(object.serviceChargesPromptMessage).equal(prompt);

        });
        it(@"greater than freeDeliveryFeeAmount", ^{

            changeGoodsCount(5);
            expect(object.freeDeliveryFeeAmountCent).equal(object.minDeliveryAmountCent);
            expect(object.freeDeliveryFeeAmount).equal(object.minDeliveryAmount);
            expect(object.amountCentsOfSelectedGoods).beGreaterThan(object.freeDeliveryFeeAmountCent);
            expect(object.amountOfSelectedGoods).beGreaterThan(object.freeDeliveryFeeAmount);
            expect(object.addOnPromptMessage).beNil();
            expect(object.serviceChargesPromptMessage).beNil();
            object.outOfReach = YES;
            expect(object.settlementEnable).beTruthy();

            object.outOfReach = NO;
            expect(object.settlementEnable).beFalsy();
        });

    });

});

SpecEnd
