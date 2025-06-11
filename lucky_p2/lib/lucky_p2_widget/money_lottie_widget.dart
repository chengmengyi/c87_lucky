import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_stateful.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';

class MoneyLottieWidget extends LuckyBaseStateful{
  @override
  State<StatefulWidget> createState() => MoneyLottieWidgetState();

}

class MoneyLottieWidgetState extends LuckyBaseState<MoneyLottieWidget> with TickerProviderStateMixin{
  var showMoneyLottie=false;
  late AnimationController moneyLottieController;

  @override
  void initState() {
    super.initState();
    moneyLottieController=AnimationController(vsync: this,duration: const Duration(milliseconds: 800))..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        showMoneyLottie=false;
        setState(() {});
        LuckyEvent(luckyCode: P2LuckyEventCode.updateUserCoins);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Visibility(
    visible: showMoneyLottie,
    child: LuckyLottieWidget(name: "money",ext: ".zip",animationController: moneyLottieController,),
  );

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.startMoneyAnimator:
        if(mounted){
          showMoneyLottie=true;
          moneyLottieController..reset()..forward();
          setState(() {});
        }
        break;
    }
  }

  @override
  void dispose() {
    moneyLottieController.dispose();
    super.dispose();
  }
}