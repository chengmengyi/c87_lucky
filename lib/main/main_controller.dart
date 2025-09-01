import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/local_notification_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p1/lucky_p1_routers/lucky_p1_routers.dart';
import 'package:lucky_p2/lucky_p2_routers/lucky_p2_routers.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pv_util.dart';

class MainController extends LuckyBaseController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;

  StorageData<bool> p2FirstLaunchApp=StorageData<bool>(key: "p2FirstLaunchApp", defaultValue: true);

  @override
  void onInit() {
    super.onInit();
    if(firstLaunchAppTimer.getData().isEmpty){
      firstLaunchAppTimer.saveData(getTodayTime());
    }
    animationController=AnimationController(duration: const Duration(seconds: 13),vsync: this)
      ..addListener(() {
        update(["progress","progress_text"]);
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          _checkAf();
        }
      });
    LocationNotificationUtils.instance.checkClickByLaunchApp();
    LocationNotificationUtils.instance.checkOpenApp();
    LocationNotificationUtils.instance.checkNotificationNum();
  }

  _checkAf(){
    var checkUser = FlutterCheckAf.instance.checkUser();
    if(p2FirstLaunchApp.getData()){
      p2FirstLaunchApp.saveData(false);
      LuckyRouters.instance.openNextOffCurrentPage(routersName: LuckyP2RoutersName.home);
      return;
    }
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_launch,
      showAd: true,
      isOpen: true,
      closeAd: (){
        LuckyRouters.instance.openNextOffCurrentPage(routersName: LuckyP2RoutersName.home);
      },
    );
    // if(kDebugMode){
    //   checkUser=true;
    // }
    // if(checkUser){
    //   LuckyAdUtils.instance.showP2Ad(
    //     adType: AdType.interstitial,
    //     adPosId: AdPosId.skerk_launch,
    //     showAd: true,
    //     isOpen: true,
    //     closeAd: (){
    //       LuckyRouters.instance.openNextOffCurrentPage(routersName: LuckyP2RoutersName.home);
    //     },
    //   );
    // }else{
    //   LuckyRouters.instance.openNextOffCurrentPage(routersName: LuckyP1RoutersName.home);
    // }
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