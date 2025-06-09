import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class UpLevelController extends LuckyBaseController{
  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.level_pop);
  }

  clickDouble(double addNum, Function() dismiss){
    TTTTUtils.instance.pointEvent(customId: CustomId.level_pop_c);
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.reward,
      adPosId: AdPosId.skerk_winup_rv,
      showAd: ValueUtils.instance.showAd(AdType.reward),
      closeAd: (){
        LuckyRouters.instance.back();
        UserInfoUtils.instance.updateUserCoins(mulTwoNums(addNum, 2));
        dismiss.call();
      },
    );
  }

  clickSingle(double addNum, Function() dismiss){
    TTTTUtils.instance.pointEvent(customId: CustomId.level_pop_close);
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_winup_int,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      closeAd: (){
        LuckyRouters.instance.back();
        UserInfoUtils.instance.updateUserCoins(addNum);
        dismiss.call();
      },
    );
  }
}