import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';

abstract class LuckyBasePage<T extends LuckyBaseController> extends StatelessWidget{
  late T luckyController;
  bool _init=true;

  @override
  Widget build(BuildContext context) {
    if(_init){
      luckyController=Get.put(initController());
      luckyController.context=context;
      _init=false;
    }
    return Scaffold(
      body: Stack(
        children: [
          bgName().isEmpty?
          Container():
          LuckyImageWidget(name: bgName(),width: double.infinity,height: double.infinity,),
          SafeArea(
            top: safeTop(),
            bottom: false,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: child(),
            ),
          ),
        ],
      ),
    );
  }

  T initController();

  String bgName();

  Widget child();

  bool safeTop()=>true;
}