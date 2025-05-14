import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';

abstract class LuckyBaseStateful extends StatefulWidget{
}

abstract class LuckyBaseState<T extends LuckyBaseStateful> extends State<T>{
  StreamSubscription<LuckyEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    if(initLuckyEvent()){
      _subscription=eventBus.on<LuckyEvent>().listen((luckyEvent) {
        receivedLuckyEventMsg(luckyEvent);
      });
    }
  }

  bool initLuckyEvent()=>false;

  receivedLuckyEventMsg(LuckyEvent luckyEvent){}

  @override
  void dispose() {
    if(initLuckyEvent()){
      _subscription?.cancel();
      _subscription=null;
    }
    super.dispose();
  }
}