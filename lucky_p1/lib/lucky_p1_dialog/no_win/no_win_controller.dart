import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';

class NoWinController extends LuckyBaseController{

  clickPlayAgain(Function() dismiss){
    LuckyRouters.instance.back();
    dismiss.call();
  }
}