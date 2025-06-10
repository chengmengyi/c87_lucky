import 'dart:math';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p2/lucky_p2_bean/win_reward_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class Play3Controller extends LuckyBaseController with GetTickerProviderStateMixin{
  PlayUtils playUtils=PlayUtils(PlayType.card3);
  List<int> winList=[];

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
    final random = Random();
    final Set<int> setA = {};
    while (setA.length < 3) {
      setA.add(random.nextInt(100));
    }
    winList.clear();
    winList.addAll(setA.toList());
    final List<YourBean> yourList = [];
    final List<int> remainingNumbersInA = List.from(winList);
    var winnerBean = ValueUtils.instance.getWinnerBean(playUtils.playType);
    if(winnerBean.winNum>0){
      if(winnerBean.winType==WinType.diamond){
        yourList.add(YourBean(content: "+1", reward: 0.0, win: true,isKey: true));
      }else{
        for (int i = 0; i < winnerBean.winNum; i++) {
          if (remainingNumbersInA.isNotEmpty) {
            final int numberFromA = remainingNumbersInA.first;
            yourList.add(YourBean(content: "$numberFromA", reward: winnerBean.coinsNum, win: true));
          }
          if(remainingNumbersInA.isNotEmpty){
            remainingNumbersInA.removeAt(0);
          }
        }
      }
    }
    var otherLength = 12-yourList.length;
    for (int i = 0; i < otherLength; i++) {
      int randomNumber;
      do {
        randomNumber = random.nextInt(100);
      } while (setA.contains(randomNumber));
      yourList.add(YourBean(content: "$randomNumber", reward: ValueUtils.instance.getRandomRewardByMax(), win: false));
    }
    yourList.shuffle();
    playUtils.setYourList(yourList);
    update(["your_widget"]);
  }

  @override
  void onClose() {
    playUtils.onClose();
    super.onClose();
  }
}