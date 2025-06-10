import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_child.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_card_child/card_child_controller.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_widget/finger_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/max_num_widget.dart';

class CardChild extends LuckyBaseChild<CardChildController>{

  @override
  CardChildController initController() => CardChildController();

  @override
  Widget child() => SingleChildScrollView(
    child: GetBuilder<CardChildController>(
      id: "list",
      builder: (_)=> luckyController.list.length==9?
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: kDebugMode,
            child: ClickWidget(
              onTap: (){
                luckyController.test();
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(height: 12.h,),
          _item1Widget(0),
          SizedBox(height: 12.h,),
          _item2Widget(3),
          SizedBox(height: 12.h,),
          _item1Widget(6),
        ],
      ):
      Container(),
    ),
  );

  _item1Widget(int startIndex) => Row(
    children: [
       Expanded(
         child: SizedBox(
           key: startIndex==0?luckyController.firstPlayGlobalKey:null,
           child: _itemWidget(startIndex,234.h),
         ),
       ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _itemWidget(startIndex+1,110.h),
            SizedBox(height: 14.h,),
            _itemWidget(startIndex+2,110.h),
          ],
        ),
      )
    ],
  );

  _item2Widget(int startIndex) => Row(
    children: [
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _itemWidget(startIndex,110.h),
            SizedBox(height: 14.h,),
            _itemWidget(startIndex+1,110.h),
          ],
        ),
      ),
      Expanded(
        child: _itemWidget(startIndex+2,234.h),
      ),
    ],
  );

  _itemWidget(int index,double height){
    var infoBean = luckyController.list[index];
    var indexWhere = PlayType.values.indexWhere((value)=>value.name==infoBean.type);
    PlayType playType=PlayType.card1;
    if(indexWhere>=0){
      playType=PlayType.values[indexWhere];
    }
    return ClickWidget(
      onTap: (){
        luckyController.clickItem(index);
      },
      child: Stack(
        children: [
          LuckyImageWidget(name: "new_${infoBean.type}",height: height,),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 80.w,
              height: 36.h,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  LuckyImageWidget(name: "home4",width: 80.w,height: 36.h,),
                  LuckyTextWidget(text: "${infoBean.hasNum??0}/10", size: 14.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,).marginOnly(top: 5.h)
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: height,
            alignment: Alignment.bottomCenter,
            child: MaxNumWidget(playType: playType, fontSize: 18.sp),
          ),
          Visibility(
            visible: infoBean.showFinger==true,
            child: Container(
              width: double.infinity,
              height: height,
              alignment: Alignment.center,
              child: FingerWidget(),
            ),
          ),
        ],
      ),
    );
  }
}