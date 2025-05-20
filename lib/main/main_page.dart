import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:scratch_it_lucky/main/main_controller.dart';

class MainPage extends LuckyBasePage<MainController>{
  @override
  String bgName() => "main1";

  @override
  MainController initController() => MainController();

  @override
  Widget child() => Stack(
    children: [
      LuckyImageWidget(name: "main2",width: double.infinity,height: 480.h,),
      Align(
        alignment: Alignment.topCenter,
        child: LuckyImageWidget(name: "main3",width: 240.w,height: 192.h,).marginOnly(top: 168.h),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<MainController>(
              id: "progress_text",
              builder: (_)=>LuckyTextWidget(text: "${(luckyController.animationController.value*100).toInt()}%", size: 20.sp, color: "#FFFFFF",shadowsColor: "#000000",fontWeight: FontWeight.bold,),
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                LuckyImageWidget(name: "main4",width: 300.w,height: 16.h,),
                GetBuilder<MainController>(
                  id: "progress",
                  builder: (_)=>ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: luckyController.animationController.value,
                      child: LuckyImageWidget(name: "main5",width: 296.w,height: 12.h,),
                    ),
                  ).marginOnly(left: 2.w),
                ),
              ],
            )
          ],
        ).marginOnly(bottom: 130.h),
      )
    ],
  );
}