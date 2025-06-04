import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';

abstract class LuckyBaseController extends GetxController{
  late BuildContext context;
  StreamSubscription<LuckyEvent>? _subscription;

  @override
  void onInit() {
    super.onInit();
    if(initLuckyEvent()){
      _subscription=eventBus.on<LuckyEvent>().listen((luckyEvent) {
        receivedLuckyEventMsg(luckyEvent);
      });
    }
  }

  bool initLuckyEvent()=>false;

  receivedLuckyEventMsg(LuckyEvent luckyEvent){}

  @override
  void onClose() {
    if(initLuckyEvent()){
      _subscription?.cancel();
      _subscription=null;
    }
    super.onClose();
  }
}