import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_stateful.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';

class StarWidget extends LuckyBaseStateful{
  @override
  State<StatefulWidget> createState() => StarWidgetState();
}

class StarWidgetState extends LuckyBaseState<StarWidget>{

  @override
  bool initLuckyEvent() => true;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.centerLeft,
    children: [
      SizedBox(
        width: 90.w,
        height: 26.h,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            LuckyImageWidget(name: "star2",width: 90.w,height: 26.h,),
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: _getPro(),
                child: LuckyImageWidget(name: "star3",width: 90.w,height: 22.h,),
              ),
            ),
            Align(
              child: LuckyTextWidget(
                text: "LV${(p2UserPlayNum.getData()~/5)+1}",
                size: 14.sp,
                color: "#FFFFFF",
                fontWeight: FontWeight.bold,
                shadowsColor: "#000000",
              ),
            )
          ],
        ),
      ).marginOnly(left: 10.w),
      LuckyImageWidget(name: "star1",width: 36.w,height: 36.h,),
    ],
  );

  double _getPro(){
    var playNum = p2UserPlayNum.getData();
    var i = (playNum~/5)*5;
    return getPro(playNum-i, 5);
  }

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.updateUserPlayNum:
        setState(() {});
        break;
    }
  }
}