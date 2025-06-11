import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/old_user_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/wheel_dialog/wheel_dialog.dart';
import 'package:lucky_p2/lucky_p2_routers/lucky_p2_routers.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/first_play_guide_overlay.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_steps.dart';

class UserGuideUtils{
  static final UserGuideUtils _instance = UserGuideUtils();
  static UserGuideUtils get instance => _instance;

  OverlayEntry? _overlayEntry;

  checkShowGuide({
    BuildContext? context,
    GlobalKey? firstGuideGlobalKey,
  }){
    switch(p2UserGuideStep.getData()){
      case UserGuideSteps.firstPlayGuide:
        _showFirstPlayGuide(context,firstGuideGlobalKey);
        break;
      case UserGuideSteps.showGuaGuide:
        LuckyRouters.instance.openNextPage(routersName: LuckyP2RoutersName.play1);
        break;
      case UserGuideSteps.showCashGuide:
        // LuckyEvent(luckyCode: P2LuckyEventCode.showCashGuide);

        break;
      case UserGuideSteps.completed:
        _checkShowOldUserGuide();
        break;
    }
  }

  _checkShowOldUserGuide(){
    if(_hasShowedOldDialog()){
      return;
    }
    _addOldUserTimer();
    LuckyRouters.instance.showDialog(
      child: OldUserDialog(
        clickSpin: (){
          TTTTUtils.instance.pointEvent(customId: CustomId.wheel_c,params: {"source_from":"old"});
          LuckyRouters.instance.showDialog(
            child: WheelDialog(),
          );
        },
        clickClose: (){
          LuckyEvent(luckyCode: P2LuckyEventCode.showLastPlayFingerGuide);
        },
      ),
    );
  }

  _showFirstPlayGuide(BuildContext? context,GlobalKey? firstGuideGlobalKey){
    if(null==context||null==firstGuideGlobalKey){
      return;
    }
    var renderBox = firstGuideGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    TTTTUtils.instance.pointEvent(customId: CustomId.card_guide);
    showOverlay(
      context: context,
      widget: FirstPlayGuideOverlay(
        offset: offset,
        size: renderBox.size,
        dismissCall: (){
          TTTTUtils.instance.pointEvent(customId: CustomId.card_guide_c);
          p2UserGuideStep.saveData(UserGuideSteps.showGuaGuide);
          checkShowGuide();
        },
      ),
    );
  }

  bool _hasShowedOldDialog(){
    try{
      return p2OldUserGuideTimer.getData().contains(getTodayTime());
    }catch(e){
      return false;
    }
  }

  // bool checkShowRevealAllGuide() => p2UserPlayNum.getData()==2&&p2UserGuideStep.getData()==UserGuideSteps.showRevealAllGuide;
  //
  // bool checkBubble() => p2UserPlayNum.getData()>2&&p2UserGuideStep.getData()==UserGuideSteps.showBubble;

  completedNewUserGuide(){
    p2UserGuideStep.saveData(UserGuideSteps.completed);
    _addOldUserTimer();
  }

  _addOldUserTimer(){
    p2OldUserGuideTimer.saveData("${p2OldUserGuideTimer.getData()}${getTodayTime()}");
  }

  showOverlay({
    required BuildContext context,
    required Widget widget,
  }){
    _overlayEntry=OverlayEntry(builder: (_)=>widget);
    Overlay.of(context).insert(_overlayEntry!);
  }

  hideOverlay(){
    _overlayEntry?.remove();
    _overlayEntry=null;
  }
}