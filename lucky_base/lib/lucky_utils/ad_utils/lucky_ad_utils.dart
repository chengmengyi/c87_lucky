import 'dart:convert';

import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/firebase_utils.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';


StorageData<int> p2LookAdNum=StorageData<int>(key: "p2LookAdNum", defaultValue: 0);
StorageData<int> p2LastAdLevel=StorageData<int>(key: "p2LastAdLevel", defaultValue: 0);


class LuckyAdUtils{
  static final LuckyAdUtils _instance = LuckyAdUtils();
  static LuckyAdUtils get instance => _instance;

  initAd(){
    FlutterIosAdHep.instance.initMax(
      maxKey: maxKey.base64(),
      data: _createAdData(),
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
        showFail: (ad){
          showToast("Advertisement display failed, please try again later");
        }, 
        closeAd: (){
          VoicePlayUtils.instance.playBg();
          closeAd.call();
        }, 
        onAdRevenuePaidCallback: (ad,info){

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
    TTTTUtils.instance.pointEvent(customId: CustomId.skerk_ad_chance,params: {"ad_pos_id":adPosId.name});
    var resultData = FlutterIosAdHep.instance.getCacheResultData(AdType.reward);
    if(null==resultData){
      TTTTUtils.instance.pointEvent(customId: CustomId.skerk_ad_nocache,params: {"ad_pos_id":adPosId.name});
      if(isOpen){
        closeAd.call();
      }else{
        if(adType==AdType.reward){
          showToast("Advertisement display failed, please try again later");
        }else{
          closeAd.call();
        }
      }
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: AdType.reward,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          TTTTUtils.instance.adEvent(ad: ad, adPosId: adPosId, adInfoData: info);
          VoicePlayUtils.instance.pauseBg();
          p2LookAdNum.saveData(p2LookAdNum.getData()+1);
          var adLevel = p2LastAdLevel.getData()+5;
          if(p2LookAdNum.getData()>=adLevel){
            TTTTUtils.instance.pointEvent(customId: CustomId.cash_ad_detail,params: {"ad":adLevel});
            p2LastAdLevel.saveData(adLevel);
          }
        },
        showFail: (ad){
          TTTTUtils.instance.pointEvent(customId: CustomId.skerk_ad_impression_fail,params: {"ad_pos_id":adPosId.name});
          if(isOpen){
            closeAd.call();
          }else{
            if(adType==AdType.reward){
              showToast("Advertisement display failed, please try again later");
            }else{
              closeAd.call();
            }
          }
        },
        closeAd: (){
          VoicePlayUtils.instance.playBg();
          closeAd.call();
        },
        onAdRevenuePaidCallback: (ad,info){

        },
      ),
    );
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
      oneRewardList: _getAdList(json["skerk_rv_one"]),
      oneInterList: _getAdList(json["skerk_int_two"]),
      twoRewardList: _getAdList(json["skerk_rv_two"]),
      twoInterList: _getAdList(json["skerk_int_two"]),
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
            sort: value["bgzglmzx"],
          )
      );
    }
    return resultList;
  }
}