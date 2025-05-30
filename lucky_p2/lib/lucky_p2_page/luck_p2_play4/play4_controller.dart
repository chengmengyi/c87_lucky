import 'dart:math';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
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
        }
    );
  }

  _initYourList(){
    List<YourBean> list = [];
    if(ValueUtils.instance.getPlay4Point9()){
      list.add(YourBean(content: "play411", reward: ValueUtils.instance.getPlay4Reward(), win: true,is9: true));
    }
    var newCandidatesList = List<String>.from(candidates);
    if(ValueUtils.instance.getPlay4PointOther()){
      var randomContent = candidates.random();
      newCandidatesList.remove(randomContent);
      var play4reward = ValueUtils.instance.getPlay4Reward();
      for (int i = 0; i < 3; i++) {
        list.add(YourBean(content: randomContent, reward: play4reward, win: true));
      }
    }
    while(list.length<15){
      var randomContent = newCandidatesList.random();
      newCandidatesList.remove(randomContent);
      for (int i = 0; i < 2; i++) {
        if(list.length>=15){
          break;
        }
        list.add(YourBean(content: randomContent, reward: 0, win: false));
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