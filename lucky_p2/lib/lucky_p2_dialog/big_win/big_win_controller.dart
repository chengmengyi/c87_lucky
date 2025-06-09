
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class BigWinController extends LuckyBaseController{
  PlayType playType=PlayType.card1;

  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.bigwin_pop,params: {"source_from":playType.name});
  }

  clickDouble(double allReward,Function(double addNum) dismiss){
    TTTTUtils.instance.pointEvent(customId: CustomId.bigwin_pop_c,params: {"source_from":playType.name});
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.reward,
      adPosId: AdPosId.skerk_bigwin_rv,
      showAd: ValueUtils.instance.showAd(AdType.reward),
      closeAd: (){
        LuckyRouters.instance.back();
        dismiss.call(mulTwoNums(allReward, 2));
      },
    );

  }

  clickSingle(double allReward,Function(double addNum) dismiss){
    TTTTUtils.instance.pointEvent(customId: CustomId.bigwin_pop_close,params: {"source_from":playType.name});
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_bigwin_int,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      closeAd: (){
        LuckyRouters.instance.back();
        dismiss.call(allReward);
      },
    );
  }
}