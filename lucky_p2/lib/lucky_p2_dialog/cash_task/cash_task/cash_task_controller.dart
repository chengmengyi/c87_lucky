import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';

class CashTaskController extends LuckyBaseController{

  clickCash(){
    LuckyRouters.instance.back();
    LuckyEvent(luckyCode: P2LuckyEventCode.showHomeTab,intValue: 0);
  }

  String getTaskLeftStr(CashTaskBean? cashTaskBean){
    if(cashTaskBean?.taskType==TaskType.task1Card){
      return "Scratch ";
    }
    return "";
  }

  String getTaskRightStr(CashTaskBean? cashTaskBean){
    if(cashTaskBean?.taskType==TaskType.task1Card){
      return " cards";
    }
    return "";
  }
}