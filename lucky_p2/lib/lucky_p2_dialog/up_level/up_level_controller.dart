import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';

class UpLevelController extends LuckyBaseController{
  clickDouble(double addNum, Function() dismiss){
    LuckyAdUtils.instance.showP2Ad(
      closeAd: (){
        LuckyRouters.instance.back();
        UserInfoUtils.instance.updateUserCoins(mulTwoNums(addNum, 2));
        dismiss.call();
      },
    );
  }

  clickSingle(double addNum, Function() dismiss){
    LuckyAdUtils.instance.showP2Ad(
      closeAd: (){
        LuckyRouters.instance.back();
        UserInfoUtils.instance.updateUserCoins(addNum);
        dismiss.call();
      },
    );
  }
}