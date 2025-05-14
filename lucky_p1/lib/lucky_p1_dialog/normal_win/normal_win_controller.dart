import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';

class NormalWinController extends LuckyBaseController{
  Function()? dismissCall;

  @override
  void onReady() {
    super.onReady();
    _delayClose();
  }

  _delayClose()async{
    await Future.delayed(const Duration(milliseconds: 2000));
    LuckyRouters.instance.back();
    dismissCall?.call();
  }
}