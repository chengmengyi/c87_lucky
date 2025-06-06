import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';

class NoKeyController extends LuckyBaseController{

  clickFind(){
    LuckyRouters.instance.back();
    LuckyEvent(luckyCode: P2LuckyEventCode.clickNoKeyFindIt);
    LuckyEvent(luckyCode: P2LuckyEventCode.showLastPlayFingerGuide);
  }

  clickClose(){
    LuckyRouters.instance.back();
  }
}