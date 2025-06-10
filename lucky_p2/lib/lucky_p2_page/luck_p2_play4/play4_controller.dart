import 'dart:math';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/win_reward_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class Play4Controller extends LuckyBaseController with GetTickerProviderStateMixin{
  PlayUtils playUtils=PlayUtils(PlayType.card4);
  var candidates = ["play44","play45","play46","play47","play48","play49","play410","play412"];


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
    List<YourBean> list = [];
    var winnerBean = ValueUtils.instance.getWinnerBean(playUtils.playType);
    var newCandidatesList = List<String>.from(candidates);
    if(winnerBean.winNum>0){
      if(winnerBean.winType==WinType.diamond){
        list.add(YourBean(content: "", reward: 0.0, win: true,isKey: true));
      }else{
        // if(ValueUtils.instance.getPlay4Point9()){
        //   list.add(YourBean(content: "play411", reward: winnerBean.coinsNum, win: true,is9: true));
        // }
        var randomContent = candidates.random();
        newCandidatesList.remove(randomContent);
        for (int i = 0; i < 3; i++) {
          list.add(YourBean(content: randomContent, reward: winnerBean.coinsNum, win: true));
        }
      }
    }
    while(list.length<15){
      var randomContent = newCandidatesList.random();
      newCandidatesList.remove(randomContent);
      for (int i = 0; i < 2; i++) {
        if(list.length>=15){
          break;
        }
        list.add(YourBean(content: randomContent, reward: winnerBean.coinsNum, win: false));
      }
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