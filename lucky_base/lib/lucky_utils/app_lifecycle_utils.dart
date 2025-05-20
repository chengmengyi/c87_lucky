import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';

class AppLifecycleUtils{
  static final AppLifecycleUtils _instance = AppLifecycleUtils();
  static AppLifecycleUtils get instance => _instance;

  init(){
    FlutterAppLifecycle.instance.setCallObserver(AppStateObserver(
      call: (back){
        if(back){
          VoicePlayUtils.instance.pauseBg();
        }else{
          VoicePlayUtils.instance.playBg();
        }
      }
    ));
  }
}