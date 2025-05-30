import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/play_info_bean.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';

class UnlockLevelController extends LuckyBaseController{

  clickVideo(PlayInfoBean playInfoBean){
    LuckyAdUtils.instance.showP1Ad(
      closeAd: (){
        _unlockLevel(playInfoBean,UnlockType.video);
      },
    );
  }

  clickCoins(PlayInfoBean playInfoBean){
    UserInfoUtils.instance.updateUserCoins(-5000);
    _unlockLevel(playInfoBean,UnlockType.coins);
  }

  _unlockLevel(PlayInfoBean playInfoBean,UnlockType unlockType)async{
    if(p1UserCoins.getData()<5000){
      showToast("Insufficient gold coins");
      return;
    }
    var indexWhere = PlayType.values.indexWhere((element) => element.name==playInfoBean.type);
    if(indexWhere>=0){
      var watchVideoNum = await PlayInfoUtils.instance.unlockPlayType(PlayType.values[indexWhere],unlockType);
      if(unlockType==UnlockType.video){
        if(watchVideoNum<3){
          playInfoBean.watchVideoNum=watchVideoNum;
          update(["num"]);
        }else{
          LuckyRouters.instance.back();
        }
      }else{
        LuckyRouters.instance.back();
      }
    }
  }
}