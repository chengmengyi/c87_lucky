import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_dialog/ad_limit_dialog/ad_limit_dialog.dart';
import 'package:lucky_base/lucky_dialog/load_ad_fail_dialog/load_ad_fail_dialog.dart';
import 'package:lucky_base/lucky_dialog/open_notification_dialog/open_notification_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/check_af_utils.dart';
import 'package:lucky_base/lucky_utils/firebase_utils.dart';
import 'package:lucky_base/lucky_utils/fk/fk_utils.dart';
import 'package:lucky_base/lucky_utils/local_notification_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/network_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_p2/lucky_p2_dialog/big_win/big_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/comment/comment_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/first_get_coins/first_get_coins_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/normal_win/normal_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/old_user_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/wheel_win/wheel_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/up_level/up_level_dialog.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_card_child/card_child.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_cash_child/cash_child.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_wheel_child/wheel_child.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_steps.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';

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
    TTTTUtils.instance.pointEvent(customId: CustomId.home_page);
    LuckyBase.instance.openAndroid();
    LocationNotificationUtils.instance.init();
    FkUtils.instance.initFk();
    NetworkUtils.instance.initListener();
  }

  @override
  void onReady() {
    super.onReady();
    if(p2ShowComment.getData()&&!p2FirstGetCoins.getData()){
      UserGuideUtils.instance.showCommentDialog();
    }
  }

  clickTab(index){
    if(tabIndex==index){
      return;
    }
    tabIndex=index;
    update(["page"]);
    if(index==2){
      TTTTUtils.instance.pointEvent(customId: CustomId.cash_page);
    }
    if(index==1){
      TTTTUtils.instance.pointEvent(customId: CustomId.wheel_c,params: {"source_from":"home"});
      LuckyEvent(luckyCode: P2LuckyEventCode.clickWheelTabCheckHasKey);
    }
    if(index==0){
      TTTTUtils.instance.pointEvent(customId: CustomId.home_page);
    }
  }

  bool checkShowCashGuide()=>p2UserGuideStep.getData()==UserGuideSteps.showCashGuide;

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
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
    // UserInfoUtils.instance.updateUserCoins(1000.03);

    // CheckAfUtils.instance.initAf();

    // LuckyRouters.instance.showDialog(child: WheelWinDialog(allReward: 10,  dismiss: (add){}));


    // FirebaseUtils.instance.checkConnectivity();


    // FkUtils.instance.checkIp();
    LuckyRouters.instance.showDialog(child: AdLimitDialog());
  }
  @override
  void onClose() {
    NetworkUtils.instance.dispose();
    super.onClose();
  }
}