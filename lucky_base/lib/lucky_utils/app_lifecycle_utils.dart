import 'dart:async';

import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/local_notification_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';

import 'ad_utils/ad_pos_id.dart';

class AppLifecycleUtils{
  static final AppLifecycleUtils _instance = AppLifecycleUtils();
  static AppLifecycleUtils get instance => _instance;

  Timer? _pausedTimer;
  var _isBack=false,isToOpenNotification=false;

  init(){
    FlutterAppLifecycle.instance.setCallObserver(AppStateObserver(
      call: (back){
        if(back){
          _appBackground();
          VoicePlayUtils.instance.pauseBg();
        }else{
          _appFront();
          VoicePlayUtils.instance.playBg();
        }
      }
    ));
  }

  _appBackground(){
    _pausedTimer=Timer(const Duration(milliseconds: 3000), () {
      _isBack=true;
    });
  }

  _appFront(){
    TTTTUtils.instance.session();
    _pausedTimer?.cancel();
    Future.delayed(const Duration(milliseconds: 100),(){
      if(isToOpenNotification){
        LocationNotificationUtils.instance.init(showOpenNotificationDialog: false);
      }else{
        if(_isBack&&!FlutterIosAdHep.instance.adShowing()){
          LuckyAdUtils.instance.showP2Ad(
            adType: AdType.interstitial,
            adPosId: AdPosId.skerk_launch,
            showAd: true,
            isOpen: true,
            closeAd: (){
            },
          );
        }
      }
      isToOpenNotification=false;
      _isBack=false;
    });
  }
}