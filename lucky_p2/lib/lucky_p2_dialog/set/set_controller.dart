import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_p2/lucky_p2_routers/lucky_p2_routers.dart';

class SetController extends LuckyBaseController{

  clickBg(){
    bgOpen.saveData(!bgOpen.getData());
    if(bgOpen.getData()){
      VoicePlayUtils.instance.playBg();
    }else{
      VoicePlayUtils.instance.pauseBg();
    }
    update(["bg"]);
  }

  clickGua(){
    guaOpen.saveData(!guaOpen.getData());
    update(["gua"]);
  }

  clickContact()async{
    // var uri = Uri(scheme: "mailto",path: email);
    // var can = await canLaunchUrl(uri);
    // if(can){
    //   launchUrl(uri);
    // }
    FlutterTbaInfo.instance.jumpToEmail(email);
  }

  clickWeb(){
    LuckyRouters.instance.openNextPage(routersName: LuckyP2RoutersName.web);
  }
}