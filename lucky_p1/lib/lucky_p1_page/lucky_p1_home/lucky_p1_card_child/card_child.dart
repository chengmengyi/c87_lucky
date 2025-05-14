import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_child.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/lucky_p1_card_child/card_child_controller.dart';
import 'package:lucky_p1/lucky_p1_widget/coins_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/star_widget.dart';

class CardChild extends LuckyBaseChild<CardChildController>{

  @override
  CardChildController initController() => CardChildController();

  @override
  Widget child() => Column(
    children: [
      _titleWidget(),
      Expanded(
        child: SingleChildScrollView(
          child: GetBuilder<CardChildController>(
            id: "list",
            builder: (_)=> luckyController.list.length==9?
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
        ),
      )
    ],
  );

  _item1Widget(int startIndex) => Row(
    children: [
       Expanded(
         child: _itemWidget(startIndex,234.h),
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
    return ClickWidget(
      onTap: (){
        luckyController.clickItem(index);
      },
      child: Stack(
        children: [
          LuckyImageWidget(name: infoBean.type??"",height: height,),
          Visibility(
            visible: infoBean.unlock!=1,
            child: Container(
              width: double.infinity,
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.w),
                color: "#000000".toColor().withOpacity(0.5),
              ),
              child: LuckyImageWidget(name: "home3",width: 33.w,height: 41.h,),
            ),
          )
        ],
      ),
    );
  }

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
        child: LuckyImageWidget(name: "icon_set",width: 34.w,height: 34.w,),
      ),
      SizedBox(width: 12 .w,),
    ],
  );
}