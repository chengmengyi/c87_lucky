import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_stateful.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class BubbleWidget extends LuckyBaseStateful{
  @override
  State<StatefulWidget> createState() => BubbleWidgetState();
}

class BubbleWidgetState extends LuckyBaseState<BubbleWidget>{
  double addNum=ValueUtils.instance.getBubbleAddNum();
  bool showBubble=false;
  double width=375.w,currentX=0.0;
  double height=812.h,currentY=0.0;
  Timer? _timer;
  bool right=true,down=true,showGuide=false;

  @override
  void initState() {
    super.initState();
    showBubble=UserGuideUtils.instance.checkBubble();
    Future((){
      _initAnimator();
    });
  }

  @override
  Widget build(BuildContext context) => showBubble?
  LayoutBuilder(
    builder: (c,bc){
      width=bc.maxWidth-58.w;
      height=bc.maxHeight-58.h;
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: currentY,
              left: currentX,
              child: ClickWidget(
                onTap: (){
                  _click();
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    LuckyImageWidget(name: "bubble",width: 58.w,height: 58.w,),
                    LuckyTextWidget(text: "\$$addNum", size: 18.sp, color: "#1AFF16",shadowsColor: "#000000",)
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  ):
  Container();

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.updateUserPlayNum:
        if(!showBubble){
          setState(() {
            showBubble=UserGuideUtils.instance.checkBubble();
          });
          _initAnimator();
        }
        break;
    }
  }

  _initAnimator(){
    if(!showBubble){
      return;
    }
    _timer=Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if(right){
        currentX++;
        if(down){
          currentY++;
          if(currentY>=height){
            down=false;
          }
        }else{
          currentY--;
          if(currentY<=0){
            down=true;
          }
        }
        if(currentX>=width){
          right=false;
        }
      }else{
        currentX--;
        if(down){
          currentY++;
          if(currentY>=height){
            down=false;
          }
        }else{
          currentY--;
          if(currentY<=0){
            down=true;
          }
        }
        if(currentX<=0){
          right=true;
        }
      }
      setState(() {});
    });
  }

  _click(){
    TTTTUtils.instance.pointEvent(customId: CustomId.float_c);
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.reward,
      adPosId: AdPosId.skerk_float_rv,
      showAd: ValueUtils.instance.showAd(AdType.reward),
      closeAd: (){
        UserInfoUtils.instance.updateUserCoins(addNum);
        addNum=ValueUtils.instance.getBubbleAddNum();
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer=null;
    super.dispose();
  }
}