import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class WheelSignRewardController extends LuckyBaseController{
  double signAddNum=ValueUtils.instance.getSignAddNum();

  clickClose(){
    LuckyRouters.instance.back();
  }

  clickDouble(int wheelAddNum){
    LuckyAdUtils.instance.showP2Ad(
      closeAd: (){
        LuckyRouters.instance.back();
        UserInfoUtils.instance.updateUserCoins(mulTwoNums((addTwoNums(signAddNum, wheelAddNum)), 2));
        LuckyEvent(luckyCode: P2LuckyEventCode.showLastPlayFingerGuide);
      },
    );
  }

  clickSingle(int wheelAddNum){
    LuckyAdUtils.instance.showP2Ad(
      closeAd: (){
        LuckyRouters.instance.back();
        UserInfoUtils.instance.updateUserCoins(addTwoNums(signAddNum, wheelAddNum));
        LuckyEvent(luckyCode: P2LuckyEventCode.showLastPlayFingerGuide);
      },
    );
  }
}