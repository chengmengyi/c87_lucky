import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_ad_utils.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/user_info_utils.dart';

class UnlockLevelController extends LuckyBaseController{

  clickVideo(String icon){
    LuckyAdUtils.instance.showP1Ad(
      closeAd: (){
        _unlockLevel(icon);
      },
    );
  }

  clickCoins(String icon){
    UserInfoUtils.instance.updateUserCoins(-5000);
    _unlockLevel(icon);
  }

  _unlockLevel(String type)async{
    var indexWhere = PlayType.values.indexWhere((element) => element.name==type);
    if(indexWhere>=0){
      await PlayInfoUtils.instance.unlockPlayType(PlayType.values[indexWhere]);
      LuckyRouters.instance.back();
    }
  }
}