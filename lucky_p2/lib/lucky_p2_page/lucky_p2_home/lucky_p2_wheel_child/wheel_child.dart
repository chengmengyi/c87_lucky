import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_child.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_wheel_child/wheel_child_controller.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_widget/finger_widget.dart';

class WheelChild extends LuckyBaseChild<WheelChildController>{
  @override
  WheelChildController initController() => WheelChildController();

  @override
  Widget child() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LuckyImageWidget(name: "wheel1",width: double.infinity,),
        AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: luckyController.animation,
                builder: (context,child)=>Transform.rotate(
                  angle: luckyController.animation.value,
                  child: LuckyImageWidget(name: "wheel3",width: double.infinity,height: double.infinity,),
                ),
              ),
              ClickWidget(
                onTap: (){
                  luckyController.startAnimator();
                },
                child: LuckyImageWidget(name: "wheel2",width: double.infinity,height: double.infinity,),
              ),
            ],
          ),
        ),
        ClickWidget(
          onTap: (){
            luckyController.startAnimator();
          },
          child: SizedBox(
            width: 172.w,
            height: 100.h,
            child: Stack(
              children: [
                SizedBox(
                  width: 172.w,
                  height: 44.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      LuckyImageWidget(name: "btn_bg",width: 172.w,height: 44.h,),
                      LuckyTextWidget(text: "SPIN", size: 20.sp, color: "#FFFFFF",shadowsColor: "#0A5300",fontWeight: FontWeight.bold,),
                    ],
                  ),
                ).marginOnly(top: 24.h),
                Align(
                  alignment: Alignment.topRight,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      LuckyImageWidget(name: "key1",width: 74.w,height: 48.h,),
                      GetBuilder<WheelChildController>(
                        id: "key_num",
                        builder: (_)=>LuckyTextWidget(
                          text: "x${p2KeyNum.getData()}",
                          size: 18.sp,
                          color: "#FFFFFF",
                          fontWeight: FontWeight.bold,shadowsColor: "#21001F",
                        ).marginOnly(top: 2.h,right: 5.w),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GetBuilder<WheelChildController>(
                    id: "spin_finger",
                    builder: (_)=>Visibility(
                      visible: luckyController.showSpinFinger,
                      child: FingerWidget(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}