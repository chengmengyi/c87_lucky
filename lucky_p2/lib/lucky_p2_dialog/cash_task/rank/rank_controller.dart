import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class RankController extends LuckyBaseController{
  CashTaskBean? cashTaskBean;
  List<String> rankList=[];

  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.cash_queue_pop);
  }

  @override
  void onReady() {
    super.onReady();
    _initRankList();
  }

  clickWatch(){
    TTTTUtils.instance.pointEvent(customId: CustomId.cash_queue_po_c,params: {"ad_number":p2CashRankWatchAdNum.getData()+1});
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.reward,
      adPosId: AdPosId.skerk_skipwait_rv,
      showAd: true,
      closeAd: (){
        p2CashRankWatchAdNum.saveData(p2CashRankWatchAdNum.getData()+1);
        _closeAd();
      },
    );
  }

  _closeAd()async{
    await CashUtils.instance.updateCaskTask(UpdateType.rank);
    var bean = await CashUtils.instance.queryCashTaskInfoByPayTypeAndPayMoney(cashTaskBean?.payTypeIndex??0, cashTaskBean?.payMoney??0);
    if(bean?.taskType!=TaskType.task2Rank){
      LuckyRouters.instance.back();
    }else{
      cashTaskBean=bean;
      _initRankList();
    }
  }

  _initRankList()async{
    rankList.clear();
    var totalPro = (cashTaskBean?.totalPro??0)-1;
    for(var index=0;index<totalPro;index++){
      if(Random().nextInt(10)<5){
        rankList.add(_generatePhoneNumber());
      }else{
        rankList.add(_generateEmail());
      }
    }
    var currentPro = cashTaskBean?.currentPro??0;
    var account = await CashUtils.instance.queryAccountByPayType(cashTaskBean?.payTypeIndex??0);
    if(currentPro<=0){
      rankList.insert(0, account);
    }else{
      rankList.insert(currentPro-1, account);
    }
    update(["rank_title","rank_list"]);
  }

  String _generatePhoneNumber() {
    final prefixList = ['130', '131', '132', '133', '134', '135', '136', '137', '138', '139',
      '150', '151', '152', '153', '155', '156', '157', '158', '159',
      '170', '171', '172', '173', '175', '176', '177', '178', '179',
      '180', '181', '182', '183', '184', '185', '186', '187', '188', '189'];
    final random = Random();
    final prefix = prefixList[random.nextInt(prefixList.length)];
    final suffix = List.generate(8, (_) => random.nextInt(10)).join(); // 8 digits
    return prefix + suffix;
  }

  String _generateEmail() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    String username = List.generate(6 + random.nextInt(5), (index) => chars[random.nextInt(chars.length)]).join();
    const domains = ['gmail.com', 'yahoo.com', 'outlook.com'];
    String domain = domains[random.nextInt(domains.length)];
    return '$username@$domain';
  }

  String getAccountStr(String account){
    if(_isEmail(account)){
      var lastIndex = account.lastIndexOf("@");
      var start = account.substring(0,lastIndex);
      if(start.length<=2){
        return account;
      }else{
        return "${start.substring(0,2)}***${account.substring(lastIndex,account.length)}";
      }
    }
    if(account.length<=5){
      return "${account.substring(0,1)}*";
    }
    return "${account.substring(0,1)}***${account.substring(account.length-3,account.length)}";
  }

  bool _isEmail(String input) {
    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );
    return emailRegex.hasMatch(input);
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