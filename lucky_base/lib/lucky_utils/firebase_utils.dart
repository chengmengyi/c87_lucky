import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feng/feng.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_android_ad_plugins/flutter_android_ad_plugins.dart';
import 'package:flutter_android_ad_plugins/hep/ad_num_hep.dart';
import 'package:flutter_custom_facebook/flutter_custom_facebook.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/fk/fk_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';

import 'local_config.dart';

StorageData<String> p2ValueFirebaseConfig=StorageData<String>(key: "p2ValueFirebaseConfig", defaultValue: "");
StorageData<String> p2AdFirebaseConfig=StorageData<String>(key: "p2AdFirebaseConfig", defaultValue: "");
StorageData<String> p2FacebookConfig=StorageData<String>(key: "p2FacebookConfig", defaultValue: "");
StorageData<String> p2FkConfig=StorageData<String>(key: "p2FkConfig", defaultValue: "");
StorageData<String> adPvConfig=StorageData<String>(key: "adPvConfig", defaultValue: "");


class FirebaseUtils{
  static final FirebaseUtils _instance = FirebaseUtils();
  static FirebaseUtils get instance => _instance;

  FirebaseRemoteConfig? _remoteConfig;

  Function()? valueResultCall;
  var afSwitch="1";

  checkConnectivity(){
    _initFirebase();
    LuckyAdUtils.instance.initAd();
  }

  _initFirebase()async{
    try{
      await Firebase.initializeApp();
      _remoteConfig=FirebaseRemoteConfig.instance;
      await _remoteConfig?.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 1),
      ));
      await _remoteConfig?.fetchAndActivate();
      _getValue();
    }catch(e){
      await Future.delayed(const Duration(milliseconds: 1000));
      _initFacebook();
      _initFirebase();
    }
  }

  _getValue(){
    var valueStr = _remoteConfig?.getString("playcard_number")??"";
    if(valueStr.isNotEmpty&&p2ValueFirebaseConfig.getData().isEmpty){
      p2ValueFirebaseConfig.saveData(valueStr);
      valueResultCall?.call();
    }
    var adStr = _remoteConfig?.getString("skerk_ad_config")??"";
    if(adStr.isNotEmpty){
      p2AdFirebaseConfig.saveData(adStr);
      LuckyAdUtils.instance.updateAdData();
    }
    var afOn = _remoteConfig?.getString("c87card_af_on")??"";
    if(afOn.isNotEmpty){
      afSwitch=afOn;
      // FlutterAndroidAdPlugins.instance.updateAfSwitch(afSwitch);
    }
    var facebookConfig = _remoteConfig?.getString("c87card_pro_fb")??"";
    if(facebookConfig.isNotEmpty){
      p2FacebookConfig.saveData(facebookConfig);
    }
    var risk_control = _remoteConfig?.getString("risk_control")??"";
    if(risk_control.isNotEmpty){
      p2FkConfig.saveData(risk_control);
      FkUtils.instance.initFk();
    }
    var sa_event = _remoteConfig?.getString("sa_event")??"";
    if(sa_event.isNotEmpty){
      adPvConfig.saveData(sa_event);
    }
    _initFacebook();
  }

  test(){
    var valueStr = _remoteConfig?.getString("playcard_number")??"";
    print("kkk====$valueStr");
  }
  
  _initFacebook(){
    var conf = facebookAppkeyBase64.base64();
    if(p2FacebookConfig.getData().isNotEmpty){
      conf=p2FacebookConfig.getData();
    }
    var json = jsonDecode(conf);
    FlutterCustomFacebook.instance.initFaceBook(facebookId: json["app_id"], facebookToken: json["client_token"], facebookAppName: json["app_name"]);
  }
}