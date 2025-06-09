import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class CashSuccessController extends LuckyBaseController{
  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.cash_suc_pop);
  }

  clickKnow(CashTaskBean? cashTaskBean)async{
    TTTTUtils.instance.pointEvent(customId: CustomId.cash_suc_pop_c);
    await CashUtils.instance.deleteCashTask(cashTaskBean);
    LuckyRouters.instance.back();
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