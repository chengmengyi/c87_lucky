import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_p1/lucky_p1_dialog/big_win/big_win_dialog.dart';
import 'package:lucky_p1/lucky_p1_dialog/no_win/no_win_dialog.dart';
import 'package:lucky_p1/lucky_p1_dialog/normal_win/normal_win_dialog.dart';
import 'package:lucky_p1/lucky_p1_dialog/up_level/up_level_dialog.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/lucky_p1_card_child/card_child.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/lucky_p1_reward_child/reward_child.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_base/lucky_utils/check_af_utils.dart';

class HomeController extends LuckyBaseController{
  var tabIndex=0;
  List<Widget> pageList=[
    CardChild(),
    RewardChild(),
  ];

  @override
  void onInit() {
    super.onInit();
    VoicePlayUtils.instance.playBg();
    p1HomeShowing.saveData(true);
    LuckyBase.instance.func1();
  }

  clickTab(index){
    if(tabIndex==index){
      return;
    }
    tabIndex=index;
    update(["page"]);
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
    LuckyRouters.instance.showDialog(
      child: BigWinDialog(
        allReward: 1000,
        dismiss: (){

        },
      ),
    );
  }

  @override
  void onClose() {
    p1HomeShowing.saveData(false);
    super.onClose();
  }
}