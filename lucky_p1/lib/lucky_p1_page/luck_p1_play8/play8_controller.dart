import 'dart:math';

import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p1/lucky_p1_bean/your_bean.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/play_utils.dart';
import 'package:lucky_p1/lucky_p1_util/value_utils.dart';

class Play8Controller extends LuckyBaseController with GetTickerProviderStateMixin{
  PlayUtils playUtils=PlayUtils(PlayType.card8);

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
    if(ValueUtils.instance.getPlay8Point7()){
      list.add(YourBean(content: "play84", reward: ValueUtils.instance.getPlay8Reward(), win: true));
    }
    if(ValueUtils.instance.getPlay8Point77()){
      list.add(YourBean(content: "play85", reward: ValueUtils.instance.getPlay8Reward()*2, win: true));
    }
    while(list.length<12){
      list.add(YourBean(content: "${Random().nextInt(100)}", reward: 0, win: false));
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