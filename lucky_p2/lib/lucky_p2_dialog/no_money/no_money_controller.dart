import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';

class NoMoneyController extends LuckyBaseController{

  clickClose(){
    LuckyRouters.instance.back();
  }

  clickMore(){
    LuckyRouters.instance.back();
    LuckyEvent(luckyCode: P2LuckyEventCode.showHomeTab,intValue: 0);
  }
}