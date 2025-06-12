import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';

StorageData<String> p2ValueFirebaseConfig=StorageData<String>(key: "p2ValueFirebaseConfig", defaultValue: "");
StorageData<String> p2AdFirebaseConfig=StorageData<String>(key: "p2AdFirebaseConfig", defaultValue: "");


class FirebaseUtils{
  static final FirebaseUtils _instance = FirebaseUtils();
  static FirebaseUtils get instance => _instance;

  FirebaseRemoteConfig? _remoteConfig;

  Function()? valueResultCall;
  var afSwitch="1";

  checkConnectivity(){
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if(!result.contains(ConnectivityResult.none)){
        _initFirebase();
        LuckyAdUtils.instance.initAd();
      }
    });
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
      _initFirebase();
    }
  }

  _getValue(){
    var valueStr = _remoteConfig?.getString("playcard_number")??"";
    print("kk===config value=-==${valueStr}");
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
      FlutterCheckAf.instance.updateAfSwitch(afSwitch);
    }
  }
}