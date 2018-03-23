//
//  TCMShoppingMarketSupplierCartNodeUnitTest.m
//  TCMDemo
//
//  Created by Dao on 2017/11/29.
//  Copyright © 2017年 淘菜猫. All rights reserved.
//


#define EXP_SHORTHAND
#import "TCMUnitTestTools.h"
#import "NSString+TCMExtension.h"

#import "TCMShoppingMarketSupplierCartNode.h"
#import "TCMShoppingMarketCartNode.h"


SpecBegin(TCMShoppingMarketSupplierCartNodeUnitTest)

typedef void (^service)(NSArray<TCMShoppingGoodsNode *> *);

describe(@"TCMShoppingMarketSupplierCartNode", ^{
    __block TCMShoppingMarketSupplierCartNode *object = nil;
    __block TCMShoppingMarketCartNode *cartNode = nil;
    beforeAll(^{
        //TODO


        Delay
    });
     void (^inServiceWithGoodsList)(NSArray<TCMShoppingGoodsNode *> *)  = ^(NSArray<TCMShoppingGoodsNode *> * goodsList){
        NSInteger amount = 0;
        for (int index = 0; index < goodsList.count; index++) {
            TCMShoppingGoodsNode *node = [goodsList objectAtIndex:index];
            amount += node.amountCent;
        }
        amount *= 10;
        expect(object.amountCentsOfSelectedGoods).equal(amount);

        NSString *amountString = [NSString amountStringWithAmount:amount * 0.01];
        expect(object.amountOfSelectedGoods).equal(amountString);
    };
    void (^changeGoodsCount)(NSInteger count) = ^(NSInteger count){
        TCMShoppingGoodsNode *goodsNode = object.goodsList.firstObject;
        goodsNode.goodsCount = @(count).description;
    };


    //TODO: some
    describe(@"StoreSelfPaying", ^{
        beforeAll(^{
            //TODO
            cartNode = [TCMShoppingMarketCartNode modelWithFile:@"StoreSelfPaying"];
            object = (TCMShoppingMarketSupplierCartNode *)cartNode.supplierList.firstObject;
            Delay
        });

        //TODO: some
        it(@"StoreCheck", ^{
            expect(object).notTo.beNull();
            expect(object.supplierId).equal(@"2935");
            expect(object.supplierName).equal(@"莘光切面店");
            expect(object.minDeliveryAmount).equal(cartNode.minDeliveryAmount);
            expect(object.minDeliveryAmountCent).equal(cartNode.minDeliveryAmountCent);
            expect(object.freeDeliveryFeeAmount).equal(@"59");
            expect(object.freeDeliveryFeeAmountCent).equal(5900);
            expect(object.deliveryFee).equal(cartNode.deliveryFee);
            expect(object.deliveryFeeCent).equal(cartNode.deliveryFeeCent);
        });
        it(@"OutService", ^{
            expect(object.outOfBusiness).beTruthy();
            object.outOfBusiness = YES;
            expect(object.amountCentsOfSelectedGoods).equal(0);
            expect(object.amountOfSelectedGoods).equal(@"0.00");

        });
        it(@"InService", ^{
            expect(object.outOfBusiness).beFalsy();
            object.outOfBusiness = NO;
            NSArray<TCMShoppingGoodsNode *> *goodsList = object.selectedGoodsListForSettlement;

            inServiceWithGoodsList(goodsList);
        });
        describe(@"Message", ^{
            __block TCMShoppingGoodsNode *goodsNode = nil;
            beforeAll(^{
                goodsNode = object.goodsList.firstObject;
            });

            it(@"不满足起送", ^{
                //不满足起送
                expect(goodsNode).notTo.beNil();
                changeGoodsCount(1);
                expect(object.amountCentsOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beFalsy();
                expect(object.addOnPromptMessage).equal(nil);
            });

            it(@"不满足满免条件", ^{
                changeGoodsCount(2);
                expect(object.amountCentsOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beTruthy();
                expect(object.addOnPromptMessage).equal(nil);
            });

            it(@"达到满免", ^{
                changeGoodsCount(object.freeDeliveryFeeAmountCent/goodsNode.goodsPriceCent + 1);
                expect(object.amountCentsOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beTruthy();
                expect(object.addOnPromptMessage).equal(nil);

            });

        });
    });


    describe(@"StoreCompulsory", ^{
        beforeAll(^{
            //TODO
            cartNode = [TCMShoppingMarketCartNode modelWithFile:@"StoreCompulsory"];
            object = (TCMShoppingMarketSupplierCartNode *)cartNode.supplierList.firstObject;
            Delay
        });

        //TODO: some
        it(@"StoreCheck", ^{
            expect(object).notTo.beNull();
            expect(object.supplierId).equal(@"5165");
            expect(object.supplierName).equal(@"天天鲜蔬菜朱莘店");
            expect(object.minDeliveryAmount).equal(object.freeDeliveryFeeAmount);
            expect(object.minDeliveryAmountCent).equal(object.freeDeliveryFeeAmountCent);
            expect(object.freeDeliveryFeeAmount).equal(@"29");
            expect(object.freeDeliveryFeeAmountCent).equal(2900);
            expect(object.deliveryFee).equal(cartNode.deliveryFee);
            expect(object.deliveryFeeCent).equal(cartNode.deliveryFeeCent);
            expect(object.outOfBusiness).beFalsy();
        });

        it(@"OutService", ^{
            expect(object.outOfBusiness).beTruthy();
            object.outOfBusiness = YES;
            expect(object.amountCentsOfSelectedGoods).equal(0);
            expect(object.amountOfSelectedGoods).equal(@"0.00");

        });
        it(@"InService", ^{
            expect(object.outOfBusiness).beFalsy();
            object.outOfBusiness = NO;
            NSArray<TCMShoppingGoodsNode *> *goodsList = object.selectedGoodsListForSettlement;

            inServiceWithGoodsList(goodsList);
        });

        describe(@"Message", ^{
            __block TCMShoppingGoodsNode *goodsNode = nil;
            beforeAll(^{
                goodsNode = object.goodsList.firstObject;
            });

            it(@"不满足起送", ^{
                //不满足起送
                expect(goodsNode).notTo.beNil();
                changeGoodsCount(1);
                expect(object.amountCentsOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beFalsy();
                expect(object.addOnPromptMessage).equal(nil);
            });

            it(@"不满足满免条件", ^{
                changeGoodsCount(2);
                expect(object.amountCentsOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beTruthy();
                expect(object.addOnPromptMessage).equal(nil);
            });

            it(@"达到满免", ^{
                changeGoodsCount(object.freeDeliveryFeeAmountCent/goodsNode.goodsPriceCent + 1);
                expect(object.amountCentsOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.amountOfSelectedGoods).equal(goodsNode.goodsCountNum * goodsNode.goodsPriceCent);

                expect(object.settlementEnable).beTruthy();
                expect(object.addOnPromptMessage).equal(nil);

            });

        });
    });
 
    afterAll(^{
       Delay
    });
});



SpecEnd
