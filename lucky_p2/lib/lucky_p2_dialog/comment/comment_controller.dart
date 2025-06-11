import 'package:in_app_review/in_app_review.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p2/lucky_p2_dialog/comment/comment_result/comment_result_dialog.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class CommentController extends LuckyBaseController{
  var chooseIndex=-1,canClick=true;

  clickStars(index)async{
    if(!canClick){
      return;
    }
    canClick=false;
    chooseIndex=index;
    update(["list","finger"]);
    p2ShowComment.saveData(false);
    await Future.delayed(Duration(milliseconds: 1000));
    if(index<=2){
      LuckyRouters.instance.back();
      LuckyRouters.instance.showDialog(child: CommentResultDialog());
    }else{
      UserInfoUtils.instance.updateUserCoins(5);
      var instance = InAppReview.instance;
      if (await instance.isAvailable()) {
        instance.requestReview();
      }
      LuckyRouters.instance.back();
    }
  }

  clickClose(){
    if(!canClick){
      return;
    }
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_close_int,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      closeAd: (){
        LuckyRouters.instance.back();
      },
    );
  }
}