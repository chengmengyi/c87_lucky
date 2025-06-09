import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class NoKeyController extends LuckyBaseController{
  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.wheel_not_key);
  }

  clickFind(){
    TTTTUtils.instance.pointEvent(customId: CustomId.wheel_not_key_c);
    LuckyRouters.instance.back();
    LuckyEvent(luckyCode: P2LuckyEventCode.clickNoKeyFindIt);
    LuckyEvent(luckyCode: P2LuckyEventCode.showLastPlayFingerGuide);
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