
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';

class BigWinController extends LuckyBaseController{

  clickDouble(double allReward,Function(double addNum) dismiss){
    LuckyAdUtils.instance.showP2Ad(
      closeAd: (){
        LuckyRouters.instance.back();
        dismiss.call(mulTwoNums(allReward, 2));
      },
    );

  }

  clickSingle(double allReward,Function(double addNum) dismiss){
    LuckyAdUtils.instance.showP2Ad(
      closeAd: (){
        LuckyRouters.instance.back();
        dismiss.call(allReward);
      },
    );
  }
}