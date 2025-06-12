import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LuckyRouters{
  static final LuckyRouters _instance = LuckyRouters();
  static LuckyRouters get instance => _instance;


  openNextPage({
    required String routersName,
    Map<String, dynamic>? arguments,
  })async{
    Get.toNamed(routersName,arguments: arguments);
  }


  openNextOffCurrentPage({required String routersName,Map<String, dynamic>? arguments}){
    Get.offNamed(routersName,arguments: arguments);
  }

  back(){
    Get.back();
  }

  Map<String, dynamic> getArguments() {
    try {
      return Get.arguments as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  showDialog({required Widget child,}){
    Get.dialog(
      child,
      // arguments: arguments,
      barrierColor: Colors.black87,
      barrierDismissible: false,
    );
  }
}