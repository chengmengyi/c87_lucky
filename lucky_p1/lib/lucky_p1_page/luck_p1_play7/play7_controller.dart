import 'dart:math';

import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p1/lucky_p1_bean/your_bean.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/play_utils.dart';
import 'package:lucky_p1/lucky_p1_util/value_utils.dart';

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
      }
    );
  }

  _initYourList(){
    List<YourBean> list=[];
    var play7num = ValueUtils.instance.getPlay7Num();
    var play7reward = ValueUtils.instance.getPlay7Reward();
    while(list.length<play7num){
      list.add(YourBean(content: "play77", reward: play7reward, win: true,play7Num: play7num));
    }
    while(list.length<12){
      list.add(YourBean(content: _otherSourceList.random(), reward: 0, win: false,play7Num: play7num));
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