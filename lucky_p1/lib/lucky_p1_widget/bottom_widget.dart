import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_stateful.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';

class BottomWidget extends LuckyBaseStateful{
  Function() revealAllCall;
  BottomWidget({
    required this.revealAllCall,
});
  @override
  State<StatefulWidget> createState() => BottomWidgetState();
}

class BottomWidgetState extends LuckyBaseState<BottomWidget>{
  var reward=0;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 113.h,
    child: Stack(
      children: [
        LuckyImageWidget(name: "bottom1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.centerLeft,
          child: ClickWidget(
            onTap: (){
              LuckyRouters.instance.back();
            },
            child: LuckyImageWidget(name: "bottom2",width: 76.w,height: 89.h,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClickWidget(
            onTap: (){
              widget.revealAllCall.call();
            },
            child: LuckyImageWidget(name: "bottom3",width: 185.w,height: 51.h,).marginOnly(bottom: 18.h),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: LuckyGraTextWidget(
            text: "$reward",
            size: 23.sp,
            fontWeight: FontWeight.bold,
            colors: ["#FFFFFF".toColor(),"#E8FAFF".toColor(),],
            shadowsColor: "#000225",
          ),
        )
      ],
    ),
  );

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P1LuckyEventCode.updatePlayBottomReward:
        setState(() {
          reward=luckyEvent.intValue??0;
        });
        break;
    }
  }
}