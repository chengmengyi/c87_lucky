import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';

class NoNetworkController extends LuckyBaseController{
  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.try_again_pop);
  }

  clickClose(){
    LuckyRouters.instance.back();
  }

  clickTry(Function() clickTry){
    LuckyRouters.instance.back();
    clickTry.call();
  }
}