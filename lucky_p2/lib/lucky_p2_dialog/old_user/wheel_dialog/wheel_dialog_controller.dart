import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_dialog/normal_win/normal_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/wheel_sign_reward/wheel_sign_reward_dialog.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class WheelDialogController extends LuckyBaseController with GetSingleTickerProviderStateMixin{
  var canClick=true;
  late AnimationController _animationController;
  late Animation<double> animation;
  late AnimationStatusListener _statusListener;

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  @override
  void onReady() {
    super.onReady();
    startAnimator();
  }

  startAnimator(){
    if(!canClick){
      return;
    }
    canClick=false;
    _animationController.forward();
  }

  _initAnimator(){
    var wheelAddNum = ValueUtils.instance.getWheelAddNum();
    var angle=0;
    switch(wheelAddNum){
      case 20:
        angle=0;
        break;
      case 50:
        angle=[45,225].random();
        break;
      case 80:
        angle=[90,315].random();
        break;
      case 100:
        angle=[135,270].random();
        break;
    }
    _animationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 1000));
    _statusListener=(status){
      if(status==AnimationStatus.completed){
        _animatorEnd(wheelAddNum);
      }
    };
    _animationController.addStatusListener(_statusListener);
    animation=Tween<double>(begin: 0,end: (720+angle)*pi/180).animate(_animationController);
  }

  _animatorEnd(int wheelAddNum)async{
    await Future.delayed(Duration(milliseconds: 800));
    LuckyRouters.instance.back();
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      adPosId: AdPosId.skerk_signin_spin_int,
      closeAd: (){
        LuckyRouters.instance.showDialog(
          child: WheelSignRewardDialog(
            wheelAddNum: wheelAddNum,
          ),
        );
      },
    );
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

  @override
  void onClose() {
    _animationController.dispose();
    _animationController.removeStatusListener(_statusListener);
    super.onClose();
  }
}