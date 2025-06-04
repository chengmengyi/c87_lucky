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
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_steps.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_utils.dart';
import 'package:lucky_p2/lucky_p2_widget/finger_widget.dart';

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
              UserGuideUtils.instance.completedNewUserGuide();
              setState(() {});
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
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Visibility(
            visible: UserGuideUtils.instance.checkShowRevealAllGuide(),
            child: ClickWidget(
              onTap: (){
                UserGuideUtils.instance.completedNewUserGuide();
                setState(() {});
                widget.revealAllCall.call();
              },
              child: FingerWidget(),
            ),
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
      case P2LuckyEventCode.updatePlayBottomReward:
        setState(() {
          reward=luckyEvent.intValue??0;
        });
        break;
      case P2LuckyEventCode.showRevealAllGuide:
        setState(() {});
        break;
    }
  }
}