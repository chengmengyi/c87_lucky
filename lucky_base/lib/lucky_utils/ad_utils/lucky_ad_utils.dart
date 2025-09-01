import 'dart:convert';

import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_num_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_load_ad_result_callback.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:flutter_custom_facebook/flutter_custom_facebook.dart';
import 'package:get/get.dart';
import 'package:lucky_base/lucky_dialog/ad_limit_dialog/ad_limit_dialog.dart';
import 'package:lucky_base/lucky_dialog/load_ad_fail_dialog/load_ad_fail_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pv_util.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/firebase_utils.dart';
import 'package:lucky_base/lucky_utils/fk/fk_utils.dart';
import 'package:lucky_base/lucky_utils/language/local_text.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';


StorageData<int> p2LookAdNum=StorageData<int>(key: "p2LookAdNum", defaultValue: 0);
StorageData<int> p2LastAdLevel=StorageData<int>(key: "p2LastAdLevel", defaultValue: 0);



//上次显示激励广告时间
StorageData<int> p2LastShowRvAdTime=StorageData<int>(key: "p2LastShowRvAdTime", defaultValue: 0);
//两次激励广告的时间很小的次数统计
StorageData<int> p2TwoRvAdTimeSmallCount=StorageData<int>(key: "p2TwoRvAdTimeSmallCount", defaultValue: 0);

//开始显示激励广告的时间
StorageData<int> p2StartShowRvAdTime=StorageData<int>(key: "p2StartShowRvAdTime", defaultValue: 0);
//播放到关闭激励广告的时间小的次数统计
StorageData<int> p2StartCloseRvTimeSmallCount=StorageData<int>(key: "p2StartCloseRvTimeSmallCount", defaultValue: 0);

//获取激励广告奖励次数
StorageData<int> p2GetRvRewardCount=StorageData<int>(key: "p2GetRvRewardCount", defaultValue: 0);

//达到提现门槛，视频次数小于3次，被风控
StorageData<bool> p2HasMoneyAndRvLess3Fk=StorageData<bool>(key: "p2HasMoneyAndRvLess3Fk", defaultValue: false);
//视频次数大于90次，没有达到提现门槛，被风控
StorageData<bool> p2RvMore90NoMoneyFk=StorageData<bool>(key: "p2RvMore90NoMoneyFk", defaultValue: false);


class LuckyAdUtils{
  static final LuckyAdUtils _instance = LuckyAdUtils();
  static LuckyAdUtils get instance => _instance;

  initAd(){
    FlutterIosAdHep.instance.initMax(
      maxKey: maxKey.base64(),
      data: _createAdData(),
      topOnAppId: topOpIdBase64.base64(),
      topOnAppKey: topOpKeyBase64.base64(),
      fengKongLogic: (){
        return FkUtils.instance.checkFk();
      },
      iosLoadAdResultCallback: IosLoadAdResultCallback(
        startLoadAdCallback: (info){
          //ad_code_id/ad_format/ad_platform
          TTTTUtils.instance.pointEvent(customId: CustomId.ad_request,params: {"ad_code_id":info?.adId,"ad_format":info?.adType.name,"ad_platform":info?.adPlat});
        },
        loadAdSuccessCallback: (maxAd,info){
          //ad_code_id/ad_format/ad_platform
          TTTTUtils.instance.pointEvent(customId: CustomId.skerk_ad_return,params: {"ad_code_id":info?.adId,"ad_format":info?.adType.name,"ad_platform":info?.adPlat});
        },
        loadAdFailCallback: (info){},
      ),
    );
  }

  updateAdData(){
    FlutterIosAdHep.instance.updateAdData(_createAdData());
  }

  //显示A包的广告
  showP1Ad({
    required Function() closeAd,
  }){
    var resultData = FlutterIosAdHep.instance.getCacheResultData(AdType.reward);
    if(null==resultData){
      showToast("Advertisement display failed, please try again later");
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: AdType.reward, 
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          VoicePlayUtils.instance.pauseBg();
        },
        showFail: (){
          showToast("Advertisement display failed, please try again later");
        }, 
        closeAd: (){
          VoicePlayUtils.instance.playBg();
          closeAd.call();
        },
        revenuePaid: (ad,info){

        },
      ),
    );
  }

  //显示B包的广告
  showP2Ad({
    required AdType adType,
    required AdPosId adPosId,
    required bool showAd,
    required Function() closeAd,
    bool isOpen=false,
  }){
    if(!showAd){
      closeAd.call();
      return;
    }
    if(AdNumHep.instance.notLoad()||FkUtils.instance.checkFk()){
      if(isOpen){
        closeAd.call();
        return;
      }
      LuckyRouters.instance.showDialog(child: AdLimitDialog());
      return;
    }

    TTTTUtils.instance.pointEvent(customId: CustomId.skerk_ad_chance,params: {"ad_pos_id":adPosId.name,"ad_format":adType.name});
    var resultData = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==resultData){
      FlutterIosAdHep.instance.loadAdWhenNoCache(adType);
      TTTTUtils.instance.pointEvent(customId: CustomId.skerk_ad_impression_fail,params: {"ad_pos_id":adPosId.name,"ad_format":adType.name,"reason":"ad_nocache",});
      if(isOpen){
        closeAd.call();
      }else{
        LuckyRouters.instance.showDialog(
          child: LoadAdFailDialog(
            clickTry: (){
              var data = FlutterIosAdHep.instance.getCacheResultData(adType);
              if(null==data){
                closeAd.call();
              }else{
                _startShowAd(adType: adType, adPosId: adPosId, showAd: showAd, closeAd: closeAd);
              }
            },
          ),
        );
      }
      return;
    }
    _startShowAd(adType: adType, adPosId: adPosId, showAd: showAd, closeAd: closeAd);
  }

  _startShowAd({
    required AdType adType,
    required AdPosId adPosId,
    required bool showAd,
    required Function() closeAd,
    bool isOpen=false,
}){
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          _handleTwoShowAdTime(adType);
          AdPvUtil.instance.uploadPv(ad, info);
          // FlutterCustomFacebook.instance.logPurchase(amount: ad?.revenue??0, currency: "USD");
          FlutterCheckAf.instance.uploadAdRevenue(ad?.networkName??"", ad?.revenue??0, ad?.adUnitId??"", adPosId.name);
          TTTTUtils.instance.adEvent(ad: ad, adPosId: adPosId, adInfoData: info);
          VoicePlayUtils.instance.pauseBg();
          p2LookAdNum.saveData(p2LookAdNum.getData()+1);
          var adLevel = p2LastAdLevel.getData()+5;
          if(p2LookAdNum.getData()>=adLevel){
            TTTTUtils.instance.pointEvent(customId: CustomId.cash_ad_detail,params: {"ad":adLevel});
            p2LastAdLevel.saveData(adLevel);
          }
        },
        showFail: (){
          TTTTUtils.instance.pointEvent(customId: CustomId.skerk_ad_impression_fail,params: {"ad_pos_id":adPosId.name,"ad_format":adType.name,"reason":"impfail",});
          if(isOpen){
            closeAd.call();
          }else{
            if(adType==AdType.reward){
              showToast(LocalText.advertisementDisplayFailed.tr);
            }else{
              closeAd.call();
            }
          }
        },
        closeAd: (){
          _handleCloseRvAd(adType);
          VoicePlayUtils.instance.playBg();
          closeAd.call();
        },
        revenuePaid: (ad,info){
          _handleRvLookCount(adType);
        },
      ),
    );
  }

  _handleTwoShowAdTime(AdType adType){
    if(adType==AdType.interstitial){
      return;
    }
    p2StartShowRvAdTime.saveData(DateTime.now().millisecondsSinceEpoch);
    var i = DateTime.now().millisecondsSinceEpoch-p2LastShowRvAdTime.getData();
    var duration = (FkUtils.instance.fkBean?.behavior?.adShortShow?.duration??30)*1000;
    if(i<duration){
      p2TwoRvAdTimeSmallCount.saveData(p2TwoRvAdTimeSmallCount.getData()+1);
    }
    p2LastShowRvAdTime.saveData(DateTime.now().millisecondsSinceEpoch);
  }

  _handleCloseRvAd(AdType adType){
    if(adType==AdType.interstitial){
      return;
    }
    var i = DateTime.now().millisecondsSinceEpoch-p2StartShowRvAdTime.getData();
    var duration = (FkUtils.instance.fkBean?.behavior?.adShortClose?.duration??20)*1000;
    if(i<duration){
      p2StartCloseRvTimeSmallCount.saveData(p2StartCloseRvTimeSmallCount.getData()+1);
    }
  }

  _handleRvLookCount(AdType adType){
    if(adType==AdType.interstitial){
      return;
    }
    p2GetRvRewardCount.saveData(p2GetRvRewardCount.getData()+1);
  }

  ConfigAdData _createAdData(){
    var data = p2AdFirebaseConfig.getData();
    if(data.isEmpty){
      data=adLocalStr.base64();
    }
    var json = jsonDecode(data);
    return ConfigAdData(
      maxShowNum: json["vmmybeqf"],
      maxClickNum: json["iopzmbve"],
      priceSwitch: json["skerk_switch"]??false,
      newInterList: _getAdList(json["skerk_int"]),
      newRewardList: _getAdList(json["skerk_rv"]),
    );
  }

  List<AdInfoData> _getAdList(List? list){
    if(null==list){
      return [];
    }
    List<AdInfoData> resultList=[];
    for (var value in list) {
      resultList.add(
          AdInfoData(
            adId: value["tlixsvwe"],
            adPlat: value["nhkxbpmq"],
            adType: value["axcxamgg"]=="reward"?AdType.reward:AdType.interstitial,
            expireTime: value["kjswqohp"],
          )
      );
    }
    return resultList;
  }
}