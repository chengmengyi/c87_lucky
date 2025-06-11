import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class CashTaskController extends LuckyBaseController{

  clickCash(firstStep, CashTaskBean? cashTaskBean,){
    if(firstStep){
      TTTTUtils.instance.pointEvent(customId: CustomId.cash_task_pop_c);
    }else{
      var wtdTask = ValueUtils.instance.getWtdTaskByIndex(cashTaskBean);
      TTTTUtils.instance.pointEvent(customId: CustomId.one_last_step_pop_c,params: {"task_from":wtdTask?.type});
    }

    LuckyRouters.instance.back();
    LuckyEvent(luckyCode: P2LuckyEventCode.showHomeTab,intValue: 0);
  }

  String getTaskLeftStr(CashTaskBean? cashTaskBean){
    if(cashTaskBean?.taskType==TaskType.task1Card){
      return "Scratch ";
    }
    if(cashTaskBean?.taskType==TaskType.task3Task9){
      var wtdTask = ValueUtils.instance.getWtdTaskByIndex(cashTaskBean);
      switch(wtdTask?.type){
        case "card": return "Scratch ";
        case "wheel": return "Play ";
        case "bubble": return "Collect ";
      }
    }
    return "";
  }

  String getTaskRightStr(CashTaskBean? cashTaskBean){
    if(cashTaskBean?.taskType==TaskType.task1Card){
      return " cards";
    }
    if(cashTaskBean?.taskType==TaskType.task3Task9){
      var wtdTask = ValueUtils.instance.getWtdTaskByIndex(cashTaskBean);
      switch(wtdTask?.type){
        case "card": return " cards";
        case "wheel": return " Spins";
        case "bubble": return " Cash Pops";
      }
    }
    return "";
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