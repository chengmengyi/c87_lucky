import 'dart:convert';

import 'package:feng/feng.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_android_ad_plugins/flutter_android_ad_plugins.dart';
import 'package:flutter_android_ad_plugins/hep/ad_num_hep.dart';
import 'package:flutter_check_adjust/dio/dio_hep.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/firebase_utils.dart';
import 'package:lucky_base/lucky_utils/fk/fk_bean.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';


StorageData<String> p2FkAd=StorageData<String>(key: "p2FkAd", defaultValue: "");

class FkUtils{
  static final FkUtils _fkUtils=FkUtils();
  static FkUtils get instance => _fkUtils;

  var _init=false;

  FkBean? fkBean;

  initFk()async{
    if(_init){
      return;
    }
    fkBean=getFkBean();
    FlutterAndroidAdPlugins.instance.setEverydayWatchAdNum(fkBean?.behavior?.adDailyShow??60);
    _checkRoot();
    _checkVpn();
    _checkSim();
    _checkSimulator();
    _checkDeveloper();
    _checkStore();
    _checkIp();
    _checkNum();
  }

  _checkRoot()async{
    var result = await Feng.instance.roScratchot();
    TTTTUtils.instance.pointEvent(customId: CustomId.session_custom,params: {"root":result?1:0});
    if(fkBean?.ui?.device==0){
      return;
    }
    if(result&&_checkContainerDevice("root")){
      _fkTrue("root");
    }
  }

  _checkVpn()async{
    var result = await Feng.instance.vpScratchn();
    TTTTUtils.instance.pointEvent(customId: CustomId.session_custom,params: {"vpn":result?1:0});
    if(fkBean?.ui?.device==0){
      return;
    }
    if(result&&_checkContainerDevice("vpn")){
      _fkTrue("vpn");
    }
  }

  _checkSim()async{
    var result = await Feng.instance.siScratchm();
    TTTTUtils.instance.pointEvent(customId: CustomId.session_custom,params: {"sim":result?1:0});
    if(fkBean?.ui?.device==0){
      return;
    }
    if(!result&&_checkContainerDevice("sim")){
      _fkTrue("sim");
    }
  }

  _checkSimulator()async{
    var result = await Feng.instance.simulScratchator();
    TTTTUtils.instance.pointEvent(customId: CustomId.session_custom,params: {"simulator":result?1:0});
    if(fkBean?.ui?.device==0){
      return;
    }
    if(result&&_checkContainerDevice("simulator")){
      _fkTrue("simulator");
    }
  }

  _checkDeveloper()async{
    var result = await Feng.instance.develScratchoper();
    TTTTUtils.instance.pointEvent(customId: CustomId.session_custom,params: {"developer":result?1:0});
    if(fkBean?.ui?.device==0){
      return;
    }
    if(result&&_checkContainerDevice("developer")){
      _fkTrue("developer");
    }
  }

  _checkStore()async{
    var result = await Feng.instance.stScratchore();
    TTTTUtils.instance.pointEvent(customId: CustomId.session_custom,params: {"googleplay":result?1:0});
    if(fkBean?.ui?.device==0){
      return;
    }
    if(!result&&_checkContainerDevice("googleplay")){
      _fkTrue("googleplay");
    }
  }

  bool _checkContainerDevice(String type)=>fkBean?.device?.contains(type)==true;

  _checkNum()async{
    var numberUnitID = await Feng.instance.getNuScratchmberUnitID();
    var dioResult = await DioHep.instance.requestPost(
      path: "https://ddi2.shuzilm.cn/q",
      data: {"protocol":2,"pkg":await FlutterTbaInfo.instance.getBundleId(),"did":numberUnitID},
    );
    //{"protocol":2,"ver":"1.0.1","err":0,"device_type":0,"normal_times":0,
    // "duplicate_times":0,"update_times":1,"recall_times":0}
    if(dioResult.success){
      try{
        _init=true;
        var json = jsonDecode(dioResult.msg);
        if(json["err"]==0&&json["device_type"]!=0&&fkBean?.ui?.number==1){
          _fkTrue("number");
        }else{

        }
      }catch(e){

      }
    }
  }

  _checkIp()async{
    var dioResult = await DioHep.instance.requestPost(
      path: "https://ip-prod.scratchluckycardplay.com/api/cdog",
      data: {
        "abird":await FlutterTbaInfo.instance.getAndroidId(),
      },
    );
    if(dioResult.success){
      final decode = base64.decode(dioResult.msg);
      final decode2 = decode.toList();
      List<int> xorList = [];
      for (int i = 0; i < decode2.length; i++) {
        xorList.add(decode2[i] ^ 9);
      }
      //{"code":200,"msg":"Success","data":{"bshark":false}}
      var result = utf8.decode(xorList);
      try{
        var bshark = jsonDecode(result)["data"]["bshark"];
        if(bshark&&_checkContainerDevice("ip")){
          _fkTrue("ip");
        }
      }catch(e){}
    }
  }

  _fkTrue(String from){
    uploadFkTag(from);
    p2FkAd.saveData(from);
  }

  uploadFkTag(String from){
    TTTTUtils.instance.pointEvent(customId: CustomId.risk_chance,params: {"risk_from":from});
  }

  bool checkFk(){
    // if(kDebugMode){
    //   return false;
    // }
    if(p2FkAd.getData().isNotEmpty){
      uploadFkTag(p2FkAd.getData());
      return true;
    }
    if(fkBean?.ui?.behavior!=1){
      return false;
    }
    if(p2TwoRvAdTimeSmallCount.getData()>=(fkBean?.behavior?.adShortShow?.value??3)){
      uploadFkTag("ad_short_show");
      return true;
    }
    if(p2StartCloseRvTimeSmallCount.getData()>=(fkBean?.behavior?.adShortClose?.value??3)){
      uploadFkTag("ad_short_close");
      return true;
    }
    if(p2HasMoneyAndRvLess3Fk.getData()){
      uploadFkTag("wrong_deem_ad_less");
      return true;
    }
    if(p2RvMore90NoMoneyFk.getData()){
      uploadFkTag("wrong_deem_ad_more");
      return true;
    }
    return false;
  }

  test(){
    print("kk====${p2TwoRvAdTimeSmallCount.getData()}===${fkBean?.behavior?.adShortShow?.value}==${checkFk()}");
  }

  FkBean getFkBean() {
    try {
      var str = fkValueStrBase64.base64();
      var s = p2FkConfig.getData();
      if(s.isNotEmpty){
        str=s;
      }
      return FkBean.fromJson(jsonDecode(str));
    } catch (e) {
      return FkBean.fromJson(jsonDecode(fkValueStrBase64.base64()));
    }
  }
}