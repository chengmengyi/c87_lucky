import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/lucky_p1_card_child/card_child.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/lucky_p1_reward_child/reward_child.dart';

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
}