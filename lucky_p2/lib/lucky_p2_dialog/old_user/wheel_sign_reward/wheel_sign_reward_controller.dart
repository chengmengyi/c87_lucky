import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class WheelSignRewardController extends LuckyBaseController{
  double signAddNum=ValueUtils.instance.getSignAddNum();

  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.old_reward_pop);
  }

  clickDouble(int wheelAddNum){
    TTTTUtils.instance.pointEvent(customId: CustomId.old_reward_pop_c);
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.reward,
      adPosId: AdPosId.skerk_signin_rv,
      showAd: ValueUtils.instance.showAd(AdType.reward),
      closeAd: (){
        LuckyRouters.instance.back();
        UserInfoUtils.instance.updateUserCoins(mulTwoNums((addTwoNums(signAddNum, wheelAddNum)), 2));
        LuckyEvent(luckyCode: P2LuckyEventCode.showLastPlayFingerGuide);
      },
    );
  }

  clickSingle(int wheelAddNum){
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_signin_int,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      closeAd: (){
        LuckyRouters.instance.back();
        UserInfoUtils.instance.updateUserCoins(addTwoNums(signAddNum, wheelAddNum));
        LuckyEvent(luckyCode: P2LuckyEventCode.showLastPlayFingerGuide);
      },
    );
  }

  clickClose(){
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_close_int,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      closeAd: (){
        LuckyRouters.instance.back();
      },
    );
  }
}