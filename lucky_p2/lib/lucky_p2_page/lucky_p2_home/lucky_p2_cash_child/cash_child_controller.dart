import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/language/local_text.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_list_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_type_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/account/account_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_success/cash_succes_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_task/cash_task/cash_task_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_task/rank/rank_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/no_money/no_money_dialog.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class CashType{
  static const int pay=0;
  static const int cashApp=1;
  static const int webMoney=2;
  static const int pagBank=3;
  static const int master=4;
  static const int gp=5;
  static const int amazon=6;
  static const int pix=7;
}

class CashChildController extends LuckyBaseController{
  late CashTypeBean chooseCashType;
  List<CashListBean> cashList=[];
  List<CashTypeBean> cashTypeList=[];

  @override
  void onInit() {
    super.onInit();
    _initCashTypeList();
  }

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
    var account = await CashUtils.instance.queryAccountByPayType(chooseCashType.cashType);
    if(account.isEmpty){
      LuckyRouters.instance.showDialog(
        child: AccountDialog(
          cashTypeBean: chooseCashType,
          callback: (payIndex,acc){
            _createCashTask(payIndex,acc,bean.cashMoney);
          },
        ),
      );
    }else{
      _createCashTask(chooseCashType.cashType,account,bean.cashMoney);
    }
  }

  _createCashTask(int cashType,String account, int cashMoney)async{
    var cashTaskBean = await CashUtils.instance.createCashTask(cashType, cashMoney,account);
    UserInfoUtils.instance.updateUserCoins(-(cashMoney.toDouble()));
    _showCashTaskDialog(cashTaskBean);
    clickPayType(cashType);
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
    chooseCashType=cashTypeList[index];
    update(["pay_money","pay_top"]);
    _initCashList();
  }

  String getPayBg()=>chooseCashType.bg;

  String getPayType()=>chooseCashType.icon;

  _initCashList()async{

    cashList.clear();
    for(var value in ValueUtils.instance.getCashList()){
      var taskBean = await CashUtils.instance.queryCashTaskInfoByPayTypeAndPayMoney(chooseCashType.cashType, value);
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
      return LocalText.scratchCards.tr.replaceFirst("tihuan", "${bean?.totalPro??0}");
    }else if(bean?.taskType==TaskType.task2Rank){
      return LocalText.yourCurrentRank.tr;
    }else{
      var wtdTask = ValueUtils.instance.getWtdTaskByIndex(bean);
      if(wtdTask?.type=="card"){
        return LocalText.scratchCards.tr.replaceFirst("tihuan", "${bean?.totalPro??0}");
      }else if(wtdTask?.type=="wheel"){
        return LocalText.playSpins.tr.replaceFirst("tihuan", "${bean?.totalPro??0}");
      } else if(wtdTask?.type=="bubble"){
        return LocalText.collectCashPops.tr.replaceFirst("tihuan", "${bean?.totalPro??0}");
      }else{
        return "";
      }
    }
  }

  _initCashTypeList(){
    cashTypeList.clear();
    cashTypeList.addAll(getCashTypeList());
    chooseCashType=cashTypeList.first;
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
        update(["coins","pay_list"]);
        break;
      case P2LuckyEventCode.showAccountDialog:
        var first = ValueUtils.instance.getCashList().first;
        if(p2UserCoins.getData()<first){
          return;
        }
        LuckyRouters.instance.showDialog(
          child: AccountDialog(
            cashTypeBean: chooseCashType,
            callback: (payIndex,acc){
              _createCashTask(payIndex,acc,first);
            },
          ),
        );
        break;
    }
  }
}