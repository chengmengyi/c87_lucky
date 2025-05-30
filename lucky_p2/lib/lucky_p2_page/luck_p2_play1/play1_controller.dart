import 'dart:math';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class Play1Controller extends LuckyBaseController with GetTickerProviderStateMixin{
  PlayUtils playUtils=PlayUtils(PlayType.card1);
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
    for (int i = 0; i < 12; i++) {
      final bool condition = ValueUtils.instance.getPlay1Point();
      if (condition && remainingNumbersInA.isNotEmpty) {
        final int numberFromA = remainingNumbersInA.first;
        yourList.add(YourBean(content: "$numberFromA", reward: ValueUtils.instance.getPlay1Reward(), win: true));
      } else {
        int randomNumber;
        do {
          randomNumber = random.nextInt(100);
        } while (setA.contains(randomNumber));
        yourList.add(YourBean(content: "$randomNumber", reward: ValueUtils.instance.getPlay1Reward(), win: false));
      }
      if(remainingNumbersInA.isNotEmpty){
        remainingNumbersInA.removeAt(0);
      }
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