import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_child.dart';
import 'package:lucky_base/lucky_utils/language/local_text.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_list_bean.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_cash_child/cash_child_controller.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/utils.dart';

class CashChild extends LuckyBaseChild<CashChildController>{
  @override
  CashChildController initController() => CashChildController();

  @override
  Widget child() => Column(
    children: [
      _moneyWidget(),
      SizedBox(height: 16.h,),
      Expanded(
        child: _payListWidget(),
      ),
    ],
  ).marginOnly(left: 20.w,right: 20.w);

  _moneyWidget()=>Container(
    width: double.infinity,
    height: 90.h,
    margin: EdgeInsets.only(top: 16.h),
    child: Stack(
      children: [
        GetBuilder<CashChildController>(
          id: "pay_money",
          builder: (_)=>LuckyImageWidget(name: luckyController.getPayBg(),width: double.infinity,height: double.infinity,),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LuckyTextWidget(text: getMoneySymbol(), size: 28.sp, color: "#0D7300",fontWeight: FontWeight.bold,),
              GetBuilder<CashChildController>(
                id: "coins",
                builder: (_)=>LuckyTextWidget(text: "${getMoneyByCountry(p2UserCoins.getData())}", size: 30.sp, color: "#0D7300",fontWeight: FontWeight.bold,),
              ),
            ],
          ).marginOnly(right: 6.w),
        )
      ],
    ),
  );

  _payListWidget()=>Stack(
    children: [
      LuckyImageWidget(name: "cash1",width: double.infinity,height: double.infinity,),
      Column(
        children: [
          SizedBox(height: 54.h,),
          Expanded(
            child: GetBuilder<CashChildController>(
              id: "pay_list",
              builder: (_)=>ListView.builder(
                itemCount: luckyController.cashList.length,
                itemBuilder: (context,index){
                  var cashListBean = luckyController.cashList[index];
                  return null==cashListBean.cashTaskBean?_cashMoneyItemWidget(luckyController.cashList[index]):_cashTaskItemWidget(luckyController.cashList[index]);
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.w),
            margin: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              color: "#FF8383".toColor().withOpacity(0.1),
            ),
            child: LuckyTextWidget(text: LocalText.tipsCashWillArrive.tr, size: 11.sp, color: "#8F0000"),
          )
        ],
      ),
      Container(
        width: 110.w,
        height: 40.h,
        alignment: Alignment.center,
        child: GetBuilder<CashChildController>(
          id: "pay_top",
          builder: (_)=>LuckyImageWidget(name: luckyController.getPayType(),width: 82.w,fit: BoxFit.fitWidth,),
        ),
      ),
      Container(
        width: double.infinity,
        height: 40.h,
        margin: EdgeInsets.only(left: 118.w),
        child: ListView.builder(
          itemCount: luckyController.cashTypeList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index)=>ClickWidget(
            onTap: (){
              luckyController.clickPayType(index);
            },
            child: Container(
              width: 110.w,
              height: 32.h,
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: "#EAEAFF".toColor(),
                border: Border.all(
                  width: 1.w,
                  color: "#98B4FF".toColor(),
                )
              ),
              child: LuckyImageWidget(name: luckyController.cashTypeList[index].icon),
            ),
          ),
        ),
      )
    ],
  );
  
  _cashMoneyItemWidget(CashListBean bean)=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.w),
    margin: EdgeInsets.only(left: 12.w,right: 12.w,bottom: 12.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(9.w),
      color: "#EEF8FB".toColor(),
      border: Border.all(
        width: 2.w,
        color: "#A3CFD7".toColor().withOpacity(0.4)
      )
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            LuckyTextWidget(text: "${getMoneySymbol()}${getMoneyByCountry(bean.cashMoney)}", size: 34.sp, color: "#000000",fontWeight: FontWeight.bold,),
            Spacer(),
            ClickWidget(
              onTap: (){
                luckyController.clickCashOut(bean);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LuckyImageWidget(name: "btn_bg",width: 76.w,height: 24.h,),
                  LuckyTextWidget(text: LocalText.cashOut.tr, size: 11.sp, color: "#FFFFFF",shadowsColor: "#0A5300",fontWeight: FontWeight.bold,),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h,),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 18.h,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 2.w,right: 2.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      color: "#000000".toColor().withOpacity(0.2)
                  ),
                  child: LayoutBuilder(
                    builder: (context,bc){
                      var maxWidth = bc.maxWidth;
                      return Container(
                        width: maxWidth*getPro(p2UserCoins.getData(), bean.cashMoney),
                        height: 14.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: "#FD8D0E".toColor()
                        ),
                      );
                    },
                  ),
                ),
                LuckyTextWidget(text: "${(getPro(p2UserCoins.getData(), bean.cashMoney)*100).toInt()}%", size: 13.sp, color: "#FFFFFF",shadowsColor: "#000000",fontWeight: FontWeight.bold,)
              ],
            ),
            LuckyImageWidget(name: "icon_money",width: 42.w,height: 42.w,)
          ],
        )
      ],
    ),
  );

  _cashTaskItemWidget(CashListBean cashBean)=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.w),
    margin: EdgeInsets.only(left: 12.w,right: 12.w,bottom: 12.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.w),
        color: "#FFF8E9".toColor(),
        border: Border.all(
            width: 2.w,
            color: "#DCCD88".toColor().withOpacity(0.4)
        )
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            LuckyTextWidget(text: "${getMoneySymbol()}${getMoneyByCountry(cashBean.cashMoney)}", size: 34.sp, color: "#000000",fontWeight: FontWeight.bold,),
            Spacer(),
            ClickWidget(
              onTap: (){
                luckyController.clickCashOut(cashBean);
              },
              child: LuckyImageWidget(name: cashBean.cashTaskBean?.cashStatus==CashStatus.completed?"cash3":"cash2",width: 86.w,height: 24.h,),
            ),
          ],
        ),
        SizedBox(height: 6.h,),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.w),
            color: "#F2E8D0".toColor(),
          ),
          child: Row(
            children: [
              LuckyImageWidget(name: luckyController.getCashTaskIcon(cashBean.cashTaskBean),width: 40.w,height: 40.h,),
              SizedBox(width: 10.w,),
              Expanded(
                child: LuckyTextWidget(text: luckyController.getCashTaskStr(cashBean.cashTaskBean), size: 13.sp, color: "#290000",fontWeight: FontWeight.bold,),
              ),
              LuckyTextWidget(text: "${cashBean.cashTaskBean?.currentPro??0}/${cashBean.cashTaskBean?.totalPro??0}", size: 12.sp, color: "#FF1A00",fontWeight: FontWeight.bold,),
            ],
          ),
        )
      ],
    ),
  );
}