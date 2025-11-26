import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_sql/lucky_base_sql.dart';
import 'package:lucky_base/lucky_utils/lucky_sql/lucky_sql_name.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_task/rank/rank_dialog.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class CashStatus{
  static const int cashing=0;
  static const int completed=1;
}

class TaskType{
  static const String task1Card="task1Card";
  static const String task2Rank="task2Rank";
  static const String task3Task9="task3Task9";
}

class UpdateType{
  static const String card="card";
  static const String wheel="wheel";
  static const String bubble="bubble";
  static const String rank="rank";
}

class CashUtils extends LuckyBaseSql{
  static final CashUtils _instance = CashUtils();
  static CashUtils get instance => _instance;

  Future<CashTaskBean?> createCashTask(int payTypeIndex,int payMoney,String account)async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p2CashTask,where: '"payTypeIndex" = ? AND "payMoney" = ?',whereArgs: [payTypeIndex,payMoney]);
    if(list.isNotEmpty){
      return null;
    }
    var bean = CashTaskBean(payTypeIndex: payTypeIndex,payMoney: payMoney,taskType: TaskType.task1Card,currentPro: 0,totalPro: 10,task3Index: 0,cashStatus: CashStatus.cashing);
    await sql.insert(LuckySqlName.p2CashTask, bean.toJson());
    await insertAccount(payTypeIndex, account);
    // LuckyEvent(luckyCode: P2LuckyEventCode.updateCashList);
    return bean;
  }

  insertAccount(int payTypeIndex,String account)async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p2CashAccount,where: '"payTypeIndex" = ?',whereArgs: [payTypeIndex]);
    if(list.isNotEmpty){
      return;
    }
    await sql.insert(LuckySqlName.p2CashAccount, {"payTypeIndex":payTypeIndex,"account":account});
  }

  Future<String> queryAccountByPayType(int payTypeIndex)async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p2CashAccount,where: '"payTypeIndex" = ?',whereArgs: [payTypeIndex]);
    if(list.isEmpty){
      return "";
    }
    return list.first["account"] as String;
  }

  Future<CashTaskBean?> queryCashTaskInfoByPayTypeAndPayMoney(int payTypeIndex,int payMoney)async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p2CashTask,where: '"payTypeIndex" = ? AND "payMoney" = ?',whereArgs: [payTypeIndex,payMoney]);
    if(list.isEmpty){
      return null;
    }
    return CashTaskBean.fromJson(list.first);
  }

  updateCaskTask(String updateType)async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p2CashTask,where: '"cashStatus" = ?',whereArgs: [CashStatus.cashing]);
    if(list.isEmpty){
      return;
    }
    CashTaskBean? rankCashTaskBean;
    for (var value in list) {
      var cashTaskBean = CashTaskBean.fromJson(value);
      if(cashTaskBean.taskType==TaskType.task1Card&&updateType==UpdateType.card){
        cashTaskBean.currentPro=(cashTaskBean.currentPro??0)+1;
        if((cashTaskBean.currentPro??0)>=(cashTaskBean.totalPro??0)){
          cashTaskBean.taskType=TaskType.task2Rank;
          cashTaskBean.currentPro=ValueUtils.instance.getRankCurrent();
          cashTaskBean.totalPro=ValueUtils.instance.getRankAll();
          rankCashTaskBean ??= cashTaskBean;
        }
        await sql.update(LuckySqlName.p2CashTask, cashTaskBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
      }
      if(cashTaskBean.taskType==TaskType.task2Rank&&updateType==UpdateType.rank){
        cashTaskBean.currentPro=(cashTaskBean.currentPro??0)-ValueUtils.instance.getCurrentReduce();
        cashTaskBean.totalPro=(cashTaskBean.totalPro??0)-ValueUtils.instance.getAllReduce();
        if((cashTaskBean.currentPro??0)<=0){
          cashTaskBean.currentPro=1;
        }
        if((cashTaskBean.totalPro??0)<=0){
          cashTaskBean.totalPro=1;
        }
        if((cashTaskBean.currentPro??0)<=1){
          cashTaskBean.taskType=TaskType.task3Task9;
          cashTaskBean.currentPro=0;
          var firstWtdTask = ValueUtils.instance.getFirstWtdTask();
          cashTaskBean.totalPro=firstWtdTask?.num??0;
          cashTaskBean.task3Index=0;
        }
        await sql.update(LuckySqlName.p2CashTask, cashTaskBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
      }
      if(cashTaskBean.taskType==TaskType.task3Task9&&updateType!=UpdateType.rank){
        var wtdTask = ValueUtils.instance.getWtdTaskByIndex(cashTaskBean);
        if(wtdTask?.type==updateType){
          cashTaskBean.currentPro=(cashTaskBean.currentPro??0)+1;
          if((cashTaskBean.currentPro??0)>=(cashTaskBean.totalPro??0)){
            if(ValueUtils.instance.checkIsFinalTask(cashTaskBean)){
              cashTaskBean.cashStatus=CashStatus.completed;
            }else{
              var nextWtdTask = ValueUtils.instance.getNextWtdTask(cashTaskBean);
              cashTaskBean.currentPro=0;
              cashTaskBean.totalPro=nextWtdTask?.num??0;
              cashTaskBean.task3Index=(cashTaskBean.task3Index??0)+1;
            }
          }
          await sql.update(LuckySqlName.p2CashTask, cashTaskBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
        }
      }
    }
    if(null!=rankCashTaskBean){
      LuckyRouters.instance.showDialog(child: RankDialog(cashTaskBean: rankCashTaskBean));
    }
    LuckyEvent(luckyCode: P2LuckyEventCode.updateCashList);
  }

  Future<bool> checkAutoShowAccountDialog()async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p2CashTask);
    return list.isEmpty;
  }

  deleteCashTask(CashTaskBean? bean)async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p2CashTask,where: '"payTypeIndex" = ? AND "payMoney" = ?',whereArgs: [bean?.payTypeIndex,bean?.payMoney]);
    if(list.isEmpty){
      return;
    }
    await sql.delete(LuckySqlName.p2CashTask,where: '"id" = ?',whereArgs: [list.first["id"]]);
    LuckyEvent(luckyCode: P2LuckyEventCode.updateCashList);
  }

  test()async{
    var sql = await initSql();
    sql.delete(LuckySqlName.p2CashTask);
    var list = await sql.query(LuckySqlName.p2CashTask);
    print(list);
    LuckyEvent(luckyCode: P2LuckyEventCode.updateCashList);
  }
}