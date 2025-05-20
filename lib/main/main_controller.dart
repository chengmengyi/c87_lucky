import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p1/lucky_p1_routers/lucky_p1_routers.dart';

class MainController extends LuckyBaseController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController=AnimationController(duration: const Duration(seconds: 3),vsync: this)
      ..addListener(() {
        update(["progress","progress_text"]);
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          LuckyRouters.instance.openNextOffCurrentPage(routersName: LuckyP1RoutersName.home);
        }
      });
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