import 'dart:math';

import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/win_reward_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

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
      },
      refreshKey: (){
        update(["your_widget"]);
      },
    );
  }

  _initYourList(){
    List<YourBean> list=[];
    var winnerBean = ValueUtils.instance.getWinnerBean(playUtils.playType);
    if(winnerBean.winNum>0){
      if(winnerBean.winType==WinType.diamond){
        list.add(YourBean(content: "", reward: 0.0, win: true,isKey: true));
      }else{
        list.add(YourBean(content: "play84", reward: winnerBean.coinsNum, win: true));
        if(winnerBean.winNum>1){
          list.add(YourBean(content: "play85", reward: winnerBean.coinsNum*2, win: true));
        }
      }
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