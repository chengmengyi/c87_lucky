import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';

class NoWinController extends LuckyBaseController{
  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.paly_failed_pop);
  }

  clickPlayAgain(Function() dismiss){
    TTTTUtils.instance.pointEvent(customId: CustomId.paly_failed_pop_c);
    LuckyRouters.instance.back();
    dismiss.call();
  }
}