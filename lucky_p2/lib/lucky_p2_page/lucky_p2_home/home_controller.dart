import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_p2/lucky_p2_dialog/big_win/big_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_card_child/card_child.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_cash_child/cash_child.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_wheel_child/wheel_child.dart';

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
}