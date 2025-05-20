import 'package:audioplayers/audioplayers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';

StorageData<bool> bgOpen=StorageData<bool>(key: "bgOpen", defaultValue: true);
StorageData<bool> guaOpen=StorageData<bool>(key: "guaOpen", defaultValue: true);

class VoicePlayUtils{
  static final VoicePlayUtils _instance = VoicePlayUtils();
  static VoicePlayUtils get instance => _instance;

  final _bgPlayer=AudioPlayer();
  final _guaPlayer=AudioPlayer();

  playBg(){
    if(_bgPlayer.state==PlayerState.playing){
      return;
    }
    if(bgOpen.getData()){
      if(_bgPlayer.state==PlayerState.paused){
        _bgPlayer.resume();
      }else{
        _bgPlayer.setReleaseMode(ReleaseMode.loop);
        _bgPlayer.play(AssetSource("bg1.MP3"));
      }
    }
  }

  pauseBg(){
    if(_bgPlayer.state==PlayerState.playing){
      _bgPlayer.pause();
    }
  }

  playGua(){
    if(guaOpen.getData()){
      _guaPlayer.play(AssetSource("gua.MP3"));
    }
  }
}