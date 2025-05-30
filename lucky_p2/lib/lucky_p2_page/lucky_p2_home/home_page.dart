import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/home_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/coins_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/set_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/star_widget.dart';

class HomePage extends LuckyBasePage<HomeController>{
  @override
  String bgName() => "home1";

  @override
  HomeController initController() => HomeController();

  @override
  Widget child() => GetBuilder<HomeController>(
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
      SetWidget(),
      SizedBox(width: 12 .w,),
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
            child: ClickWidget(
              onTap: (){
                luckyController.clickTab(1);
              },
              child: LuckyImageWidget(name: luckyController.tabIndex==1?"home_wheel_sel2":"home_wheel_uns2",height: luckyController.tabIndex==1?64.h:56.h,),
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
}