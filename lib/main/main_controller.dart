import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/local_notification_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p1/lucky_p1_routers/lucky_p1_routers.dart';
import 'package:lucky_p2/lucky_p2_routers/lucky_p2_routers.dart';
import 'package:flutter_check_af/flutter_check_af.dart';

class MainController extends LuckyBaseController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController=AnimationController(duration: const Duration(seconds: 13),vsync: this)
      ..addListener(() {
        update(["progress","progress_text"]);
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          _checkAf();
        }
      });
    LocationNotificationUtils.instance.checkOpenApp();
  }

  _checkAf(){
    var checkUser = FlutterCheckAf.instance.checkUser();
    if(kDebugMode){
      checkUser=true;
    }
    if(checkUser){
      LuckyAdUtils.instance.showP2Ad(
        adType: AdType.interstitial,
        adPosId: AdPosId.skerk_launch,
        showAd: !kDebugMode,
        isOpen: true,
        closeAd: (){
          LuckyRouters.instance.openNextOffCurrentPage(routersName: LuckyP2RoutersName.home);
        },
      );
    }else{
      LuckyRouters.instance.openNextOffCurrentPage(routersName: LuckyP1RoutersName.home);
    }
  }

  @override
  void onReady() {
    super.onReady();
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}