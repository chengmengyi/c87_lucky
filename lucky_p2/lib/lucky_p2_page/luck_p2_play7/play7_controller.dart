import 'dart:math';

import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/win_reward_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class Play7Controller extends LuckyBaseController with GetTickerProviderStateMixin{
  PlayUtils playUtils=PlayUtils(PlayType.card7);
  final List<String> _otherSourceList=["play74","play75","play76"];

  @override
  void onReady() {
    super.onReady();
    playUtils.initPlay(this);
    _initYourList();
  }

  clickRevealAll(){
    playUtils.startAutoScratch(
      offsetCallback: (offset){

      }
    );
  }

  onThreshold(){
    playUtils.onThreshold(
      resetCallback: (){
        _initYourList();
      },
      refreshKey: (){
        update(["your_widget"]);
      },
    );
  }

  _initYourList(){
    List<YourBean> list=[];
    // var play7num = ValueUtils.instance.getPlay7Num();
    // var play7reward = ValueUtils.instance.getPlay7Reward();
    var winnerBean = ValueUtils.instance.getWinnerBean(playUtils.playType);
    if(winnerBean.winNum>0){
      if(winnerBean.winType==WinType.diamond){
        list.add(YourBean(content: "", reward: 0.0, win: true,isKey: true));
      }else{
        while(list.length<winnerBean.winNum){
          list.add(YourBean(content: "play77", reward: winnerBean.coinsNum, win: true,play7Num: winnerBean.winNum));
        }
      }
    }

    while(list.length<12){
      list.add(YourBean(content: _otherSourceList.random(), reward: 0, win: false,play7Num: winnerBean.winNum));
    }
    list.shuffle();
    playUtils.setYourList(list);
    update(["your_widget"]);
  }

  @override
  void onClose() {
    playUtils.onClose();
    super.onClose();
  }
}