import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_dialog/no_key/no_key_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/normal_win/normal_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/wheel_win/wheel_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class WheelChildController extends LuckyBaseController with GetSingleTickerProviderStateMixin{
  var canClick=true,showSpinFinger=false,wheelAddNum=50;
  late AnimationController _animationController;
  late Animation<double> animation;
  late AnimationStatusListener _statusListener;

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  startAnimator(){
    if(!canClick){
      return;
    }
    TTTTUtils.instance.pointEvent(customId: CustomId.wheel_page_c);
    if(p2KeyNum.getData()<=0){
      _checkHasKey();
      return;
    }
    showSpinFinger=false;
    update(["spin_finger"]);
    wheelAddNum = ValueUtils.instance.getWheelAddNum();
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
    canClick=false;
    animation=Tween<double>(begin: 0,end: (720+angle)*pi/180).animate(_animationController);
    _animationController..reset()..forward();
  }

  _initAnimator(){
    _animationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 1000));
    _statusListener=(status){
      if(status==AnimationStatus.completed){
        _animatorEnd();
      }
    };
    _animationController.addStatusListener(_statusListener);
    animation=Tween<double>(begin: 0,end: 360).animate(_animationController);
  }

  _animatorEnd()async{
    await Future.delayed(Duration(milliseconds: 800));
    canClick=true;
    UserInfoUtils.instance.updateKeyNum(-1);
    await CashUtils.instance.updateCaskTask(UpdateType.wheel);
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_wheel_spin_int,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      closeAd: (){
        LuckyRouters.instance.showDialog(
          child: WheelWinDialog(
            allReward: wheelAddNum.toDouble(),
            dismiss: (addNum){
              UserInfoUtils.instance.updateUserCoins(addNum);
              showSpinFinger=true;
              update(["spin_finger"]);
            },
          ),
        );
      },
    );
  }

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.clickWheelTabCheckHasKey:
        _checkHasKey();
        break;
      case P2LuckyEventCode.updateKeyNum:
        update(["key_num"]);
        break;
    }
  }

  _checkHasKey(){
    if(p2KeyNum.getData()<=0){
      LuckyRouters.instance.showDialog(
        child: NoKeyDialog(),
      );
    }
  }

  @override
  void onClose() {
    _animationController.dispose();
    _animationController.removeStatusListener(_statusListener);
    super.onClose();
  }
}