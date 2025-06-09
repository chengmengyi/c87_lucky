import 'dart:async';

import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/box_bean.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class BoxDialogController extends LuckyBaseController{
  var chooseIndex=-1,canClick=true;
  List<BoxBean> list=[
    BoxBean(index: 0, normalLottie: "box1", openLottie: "box2", open: false,reward: ValueUtils.instance.getBoxAddNum()),
    BoxBean(index: 1, normalLottie: "box1", openLottie: "box2", open: false,reward: ValueUtils.instance.getBoxAddNum()),
    BoxBean(index: 2, normalLottie: "box1", openLottie: "box2", open: false,reward: ValueUtils.instance.getBoxAddNum()),
  ];

  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.open_box_pop);
  }

  clickBox(index){
    if(!canClick){
      return;
    }
    canClick=false;
    chooseIndex=index;
    list[index].open=true;
    update(["box"]);
    Timer(Duration(milliseconds: 1000), (){
      for (var value in list) {
        value.open=true;
      }
      update(["box","btn"]);
    });
  }

  bool showBtn(){
    for (var value in list) {
      if(!value.open){
        return false;
      }
    }
    return true;
  }

  clickAll(){
    TTTTUtils.instance.pointEvent(customId: CustomId.open_box_pop_c);
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.reward,
      adPosId: AdPosId.skerk_box_rv,
      showAd: ValueUtils.instance.showAd(AdType.reward),
      closeAd: (){
        var allReward=0.0;
        for (var value in list) {
          allReward=addTwoNums(allReward, value.reward);
        }
        UserInfoUtils.instance.updateUserCoins(allReward);
        LuckyRouters.instance.back();
      },
    );
  }

  clickGiveUp(){
    TTTTUtils.instance.pointEvent(customId: CustomId.open_box_pop_close);
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_box_int,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      closeAd: (){
        UserInfoUtils.instance.updateUserCoins(list[chooseIndex].reward);
        LuckyRouters.instance.back();
      },
    );
  }
}