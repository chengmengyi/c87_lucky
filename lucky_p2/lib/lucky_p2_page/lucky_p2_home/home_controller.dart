import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_p2/lucky_p2_dialog/big_win/big_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/normal_win/normal_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/old_user_dialog.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_card_child/card_child.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_cash_child/cash_child.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_wheel_child/wheel_child.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_steps.dart';

class HomeController extends LuckyBaseController{
  var tabIndex=0;
  List<Widget> pageList=[
    CardChild(),
    WheelChild(),
    CashChild(),
  ];

  @override
  void onInit() {
    super.onInit();
    VoicePlayUtils.instance.playBg();
  }

  clickTab(index){
    if(tabIndex==index){
      return;
    }
    tabIndex=index;
    update(["page"]);
    if(index==2&&checkShowCashGuide()){
      p2UserGuideStep.saveData(UserGuideSteps.showRevealAllGuide);
      update(["cash_guide"]);
    }
    if(index==1){
      LuckyEvent(luckyCode: P2LuckyEventCode.clickWheelTabCheckHasKey);
    }
  }

  bool checkShowCashGuide()=>p2UserGuideStep.getData()==UserGuideSteps.showCashGuide;

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.showCashGuide:
        update(["cash_guide"]);
        break;
      case P2LuckyEventCode.clickNoKeyFindIt:
        clickTab(0);
        break;
      case P2LuckyEventCode.updateKeyNum:
        update(["key_num"]);
        break;
      case P2LuckyEventCode.showHomeTab:
        clickTab(luckyEvent.intValue??0);
        break;
    }
  }

  test()async{
    if(!kDebugMode){
      return;
    }
    // LuckyRouters.instance.showDialog(child: UnlockLevelDialog());
    // var list = await PlayInfoUtils.instance.queryPlayList();
    // print("kk====${list.length}");
    // UserInfoUtils.instance.updateUserCoins(10000000);
    // VoicePlayUtils.instance.playBg();
  }
}