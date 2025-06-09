import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_list_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/account/account_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_success/cash_succes_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_task/cash_task/cash_task_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_task/rank/rank_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/no_money/no_money_dialog.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class CashChildController extends LuckyBaseController{
  var chooseIndex=0;
  List<CashListBean> cashList=[];

  @override
  void onReady() {
    super.onReady();
    _initCashList();
  }

  clickCashOut(CashListBean bean)async{
    TTTTUtils.instance.pointEvent(customId: CustomId.cash_page_c);
    if(null!=bean.cashTaskBean){
      if(bean.cashTaskBean?.cashStatus==CashStatus.completed){
        LuckyRouters.instance.showDialog(child: CashSuccessDialog(cashTaskBean: bean.cashTaskBean,));
        return;
      }
      _showCashTaskDialog(bean.cashTaskBean);
      return;
    }
    if(p2UserCoins.getData()<bean.cashMoney){
      LuckyRouters.instance.showDialog(child: NoMoneyDialog(chooseMoney: bean.cashMoney));
      return;
    }
    var account = await CashUtils.instance.queryAccountByPayType(chooseIndex);
    if(account.isEmpty){
      LuckyRouters.instance.showDialog(
        child: AccountDialog(
          chooseIndex: chooseIndex,
          callback: (payIndex,acc){
            _createCashTask(payIndex,acc,bean.cashMoney);
          },
        ),
      );
    }else{
      _createCashTask(chooseIndex,account,bean.cashMoney);
    }
  }

  _createCashTask(int payIndex,String account, int cashMoney)async{
    var cashTaskBean = await CashUtils.instance.createCashTask(chooseIndex, cashMoney,account);
    UserInfoUtils.instance.updateUserCoins(-(cashMoney.toDouble()));
    _showCashTaskDialog(cashTaskBean);
  }

  _showCashTaskDialog(CashTaskBean? cashTaskBean){
    if(cashTaskBean?.taskType==TaskType.task2Rank){
      LuckyRouters.instance.showDialog(child: RankDialog(cashTaskBean: cashTaskBean));
    }else{
      LuckyRouters.instance.showDialog(
        child: CashTaskDialog(
          cashTaskBean: cashTaskBean,
          firstStep: cashTaskBean?.taskType==TaskType.task1Card,
        ),
      );
    }
  }

  clickPayType(index){
    if(chooseIndex==index){
      return;
    }
    chooseIndex=index;
    update(["pay_money","pay_top"]);
    _initCashList();
  }

  String getPayBg()=>"pay_bg${chooseIndex+1}";

  String getPayType()=>"pay_type${chooseIndex+1}";

  _initCashList()async{
    cashList.clear();
    for(var value in ValueUtils.instance.getCashList()){
      var taskBean = await CashUtils.instance.queryCashTaskInfoByPayTypeAndPayMoney(chooseIndex, value);
      cashList.add(CashListBean(cashMoney: value, cashTaskBean: taskBean));
    }
    update(["pay_list"]);
  }

  String getCashTaskIcon(CashTaskBean? bean){
    if(bean?.taskType==TaskType.task1Card){
      return "task_card";
    }else if(bean?.taskType==TaskType.task2Rank){
      return "task_rank";
    }else{
      var wtdTask = ValueUtils.instance.getWtdTaskByIndex(bean);
      if(wtdTask?.type=="card"){
        return "task_card";
      }else if(wtdTask?.type=="wheel"){
        return "task_wheel";
      } else if(wtdTask?.type=="bubble"){
        return "task_bubble";
      }else{
        return "task_rank";
      }
    }
  }

  String getCashTaskStr(CashTaskBean? bean){
    if(bean?.taskType==TaskType.task1Card){
      return "Scratch ${bean?.totalPro??0} Cards";
    }else if(bean?.taskType==TaskType.task2Rank){
      return "Your Current rank";
    }else{
      var wtdTask = ValueUtils.instance.getWtdTaskByIndex(bean);
      if(wtdTask?.type=="card"){
        return "Scratch ${bean?.totalPro??0} cards";
      }else if(wtdTask?.type=="wheel"){
        return "Play ${bean?.totalPro??0} Spins";
      } else if(wtdTask?.type=="bubble"){
        return "Collect ${bean?.totalPro??0} Cash Pops";
      }else{
        return "";
      }
    }
  }

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.updateCashList:
        _initCashList();
        break;
      case P2LuckyEventCode.updateUserCoins:
        update(["coins"]);
        break;
    }
  }
}