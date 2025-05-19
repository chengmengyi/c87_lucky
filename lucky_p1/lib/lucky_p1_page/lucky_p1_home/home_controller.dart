import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/lucky_p1_card_child/card_child.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/lucky_p1_reward_child/reward_child.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/user_info_utils.dart';

class HomeController extends LuckyBaseController{
  var tabIndex=0;
  List<Widget> pageList=[
    CardChild(),
    RewardChild(),
  ];

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
    UserInfoUtils.instance.updateUserCoins(10000000);
  }
}