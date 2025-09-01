import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_num_hep.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/firebase_utils.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';


StorageData<int> adShowNumTotal=StorageData<int>(key: "adShowNumTotal", defaultValue: 0);
StorageData<double> adRevenueTotal=StorageData<double>(key: "adRevenueTotal", defaultValue: 0.0);
StorageData<String> firstLaunchAppTimer=StorageData<String>(key: "firstLaunchAppTimer", defaultValue: "");

class AdPvUtil{
  static final AdPvUtil _adPvUtil=AdPvUtil();
  static AdPvUtil get instance => _adPvUtil;

  uploadPv(AdMoneyInfoBean? ad, AdInfoData? adInfoData,){
    adShowNumTotal.saveData(adShowNumTotal.getData()+1);
    adRevenueTotal.saveData((Decimal.fromJson("${adRevenueTotal.getData()}")+Decimal.fromJson("${ad?.revenue??0.0}")).toDouble());

    if(firstLaunchAppTimer.getData()==getTodayTime()){
      var saltv0 = getSaltv0();
      if(adRevenueTotal.getData()>=saltv0){
        var map={
          "kwai_key_event_action_type":4,
          "kwai_key_event_action_value":saltv0,
        };
        uploadEvent(
          event: CustomId.sa_ltv0,
          values: map,
        );
      }
      var saltv0other = getSaltv0other();
      if(adRevenueTotal.getData()>=saltv0other){
        var map={
          "kwai_key_event_action_type":4,
          "kwai_key_event_action_value":saltv0other,
        };
        uploadEvent(
          event: CustomId.sa_ltv0_other,
          values: map,
        );
      }
    }
    var sapv = getSapv();
    if(adShowNumTotal.getData()>=sapv){
      var map={
        "kwai_key_event_action_type":1,
        "kwai_key_event_action_value":sapv,
      };
      uploadEvent(
        event: CustomId.sa_pv,
        values: map,
      );
    }
    var sapvother = getSapvother();
    if(adShowNumTotal.getData()>=sapvother){
      var map={
        "kwai_key_event_action_type":1,
        "kwai_key_event_action_value":sapvother,
      };
      uploadEvent(
        event: CustomId.sa_pv_other,
        values: map,
      );
    }
  }

  uploadEvent({
    required CustomId event,
    Map<String,dynamic>? values,
}){
    FlutterCheckAf.instance.logEvent(eventName: event.name,eventValues: values);
    TTTTUtils.instance.pointEvent(customId: event,params: values);
  }

  double getSaltv0(){
    if(kDebugMode){
      return 0.00001;
    }
    try{
      var data = adPvConfig.getData();
      if(data.isEmpty){
        data=adPvLocalConfigStrBase64.base64();
      }
      return jsonDecode(data)["sa_ltv0"];
    }catch(e){
      return 0.1;
    }
  }


  double getSaltv0other(){
    if(kDebugMode){
      return 0.00001;
    }
    try{
      var data = adPvConfig.getData();
      if(data.isEmpty){
        data=adPvLocalConfigStrBase64.base64();
      }
      return jsonDecode(data)["sa_ltv0_other"];
    }catch(e){
      return 0.2;
    }
  }

  int getSapv(){
    if(kDebugMode){
      return 1;
    }
    try{
      var data = adPvConfig.getData();
      if(data.isEmpty){
        data=adPvLocalConfigStrBase64.base64();
      }
      return jsonDecode(data)["sa_pv"];
    }catch(e){
      return 5;
    }
  }
  int getSapvother(){
    if(kDebugMode){
      return 1;
    }
    try{
      var data = adPvConfig.getData();
      if(data.isEmpty){
        data=adPvLocalConfigStrBase64.base64();
      }
      return jsonDecode(data)["sa_pv_other"];
    }catch(e){
      return 8;
    }
  }
}