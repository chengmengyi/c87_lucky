import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';

class OldUserController extends LuckyBaseController{
  clickSpin(Function() clickSpin){
    LuckyRouters.instance.back();
    clickSpin.call();
  }

  clickClose(Function() clickClose){
    LuckyRouters.instance.back();
    clickClose.call();
  }
}