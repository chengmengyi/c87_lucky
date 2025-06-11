import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/home_controller.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_wheel_child/wheel_child_controller.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_widget/coins_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/finger_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/money_lottie_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/set_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/star_widget.dart';

class HomePage extends LuckyBasePage<HomeController>{
  @override
  String bgName() => "home1";

  @override
  HomeController initController() => HomeController();

  @override
  Widget child() => Stack(
    children: [
      GetBuilder<HomeController>(
        id: "page",
        builder: (_)=>Column(
          children: [
            _titleWidget(),
            Expanded(
              child: IndexedStack(
                index: luckyController.tabIndex,
                children: luckyController.pageList,
              ),
            ),
            _bottomWidget(),
          ],
        ),
      ),
      _cashGuideWidget(),
      MoneyLottieWidget(),
    ],
  );

  _titleWidget()=>Row(
    children: [
      SizedBox(width: 8.w,),
      StarWidget(),
      SizedBox(width: 8.w,),
      ClickWidget(
        onTap: (){
          luckyController.test();
        },
        child: CoinsWidget(),
      ),
      const Spacer(),
      ClickWidget(
        onTap: (){
          LuckyBase.instance.func4();
        },
        child: LuckyImageWidget(name: "icon_h5",width: 37.w,height: 37.h,),
      ),
      SizedBox(width: 6.w,),
      SetWidget(),
      SizedBox(width: 12.w,),
    ],
  );

  _bottomWidget()=>Stack(
    children: [
      Container(
        margin: EdgeInsets.only(top: 10.h),
        child: LuckyImageWidget(name: "home2",width: double.infinity,height: 84.h,),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ClickWidget(
              onTap: (){
                luckyController.clickTab(0);
              },
              child: LuckyImageWidget(name: luckyController.tabIndex==0?"home_card_sel2":"home_card_uns2",height: luckyController.tabIndex==0?64.h:56.h,),
            ),
          ),
          Expanded(
            child: GetBuilder<WheelChildController>(
              id: "key_num",
              builder: (_)=>ClickWidget(
                onTap: (){
                  luckyController.clickTab(1);
                },
                child: LuckyImageWidget(
                  name: p2KeyNum.getData()<=0?"home_wheel_lock":luckyController.tabIndex==1?"home_wheel_sel2":"home_wheel_uns2",
                  height: luckyController.tabIndex==1?64.h:56.h,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Expanded(
            child: ClickWidget(
              onTap: (){
                luckyController.clickTab(2);
              },
              child: LuckyImageWidget(name: luckyController.tabIndex==2?"home_cash_sel2":"home_cash_uns2",height: luckyController.tabIndex==2?64.h:56.h,),
            ),
          ),
        ],
      )
    ],
  );

  _cashGuideWidget()=>GetBuilder<HomeController>(
    id: "cash_guide",
    builder: (_)=>Positioned(
      right: 0,
      bottom: 0,
      child: Visibility(
        visible: luckyController.checkShowCashGuide(),
        child: ClickWidget(
          onTap: (){
            luckyController.clickTab(2);
          },
          child: FingerWidget(),
        ),
      ),
    ),
  );
}