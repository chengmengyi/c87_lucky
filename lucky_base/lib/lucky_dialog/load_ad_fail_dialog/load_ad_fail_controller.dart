import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';

class LoadAdFailController extends LuckyBaseController{
  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.no_network_pop);
  }

  clickClose(){
    LuckyRouters.instance.back();
  }

  clickTry(){
    clickClose();
  }
}