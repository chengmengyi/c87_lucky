import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';

class UpLevelController extends LuckyBaseController{
  int getUpLevelReward(PlayType playType){
    switch(playType){
      case PlayType.card1: return 100;
      case PlayType.card2: return 300;
      case PlayType.card3: return 500;
      case PlayType.card4: return 800;
      case PlayType.card5: return 1000;
      case PlayType.card6: return 1500;
      case PlayType.card7: return 2000;
      case PlayType.card8: return 2500;
      case PlayType.card9: return 3000;
    }
  }

  clickContinue(Function() dismiss){
    LuckyRouters.instance.back();
    dismiss.call();
  }
}