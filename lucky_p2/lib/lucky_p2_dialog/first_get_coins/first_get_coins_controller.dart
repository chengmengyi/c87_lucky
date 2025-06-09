import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class FirstGetCoinsController extends LuckyBaseController{

  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.card_coin_guide_pop);
  }

  clickDouble(double allReward,Function(double addNum) dismiss){
    TTTTUtils.instance.pointEvent(customId: CustomId.card_coin_guide_pop_c);
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.reward,
      adPosId: AdPosId.skerk_wheel_rv,
      showAd: ValueUtils.instance.showAd(AdType.reward),
      closeAd: (){
        LuckyRouters.instance.back();
        dismiss.call(mulTwoNums(allReward, 2));
      },
    );
  }

  clickSingle(double allReward,Function(double addNum) dismiss){
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_wheel_int,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      closeAd: (){
        LuckyRouters.instance.back();
        dismiss.call(allReward);
      },
    );
  }
}