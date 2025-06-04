import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';

import '../lucky_utils/lucky_export.dart';

abstract class LuckyBaseDialog<T extends LuckyBaseController> extends StatelessWidget{
  late T luckyController;
  bool _init=true;

  @override
  Widget build(BuildContext context) {
    if(_init){
      luckyController=Get.put(initController());
      luckyController.context=context;
      initView();
      _init=false;
    }
    return WillPopScope(
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: child(),
        ),
      ),
      onWillPop: ()async{
        return false;
      },
    );
  }

  T initController();

  Widget child();

  initView(){}
}