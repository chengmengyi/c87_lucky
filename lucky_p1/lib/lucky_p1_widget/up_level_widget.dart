import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_stateful.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p1/lucky_p1_util/storage.dart';

class UpLevelWidget extends LuckyBaseStateful{
  @override
  State<StatefulWidget> createState() => UpLevelWidgetState();
}

class UpLevelWidgetState extends LuckyBaseState<UpLevelWidget>{

  @override
  bool initLuckyEvent() => true;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      LuckyImageWidget(name: "up_level_bg",width: 240.w,height: 26.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LuckyTextWidget(text: "Scratch ", size: 13.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,),
          LuckyTextWidget(text: "${getNum()}", size: 16.sp, color: "#00FF15"),
          LuckyTextWidget(text: " cards left to level up", size: 13.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,),
        ],
      )
    ],
  );

  int getNum(){
    var playNum = p1UserPlayNum.getData();
    var i = (playNum~/5)*5;
    return 5-playNum+i;
  }

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P1LuckyEventCode.updateUserPlayNum:
        setState(() {});
        break;
    }
  }
}