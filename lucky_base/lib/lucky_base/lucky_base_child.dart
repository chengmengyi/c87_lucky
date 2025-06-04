import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';

abstract class LuckyBaseChild<T extends LuckyBaseController> extends StatelessWidget{
  late T luckyController;
  bool _init=true;

  @override
  Widget build(BuildContext context) {
    if(_init){
      luckyController=Get.put(initController());
      luckyController.context=context;
      _init=false;
    }
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: child(),
    );
  }

  T initController();

  Widget child();
}