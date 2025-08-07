import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_dialog/load_ad_fail_dialog/load_ad_fail_controller.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';

class LoadAdFailDialog extends LuckyBaseDialog<LoadAdFailController>{
  Function() clickTry;
  LoadAdFailDialog({required this.clickTry,});

  @override
  LoadAdFailController initController() => LoadAdFailController();

  @override
  Widget child() => Container(
    width: double.infinity,
    height: 308.h,
    margin: EdgeInsets.only(left: 36.w,right: 36.w),
    child: Stack(
      children: [
        LuckyImageWidget(name: "open1",width: double.infinity,height: 308.h,),
        Positioned(
          right: 0,
          child: ClickWidget(
            onTap: (){
              luckyController.clickClose();
            },
            child: LuckyImageWidget(name: "icon_close",width: 38.w,height: 38.w,),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 60.h,),
              LuckyImageWidget(name: "load_fail1",width: 90.w,height: 86.h,),
              SizedBox(height: 20.h,),
              LuckyTextWidget(text: "Ad loading failed", size: 19.sp, color: "#FFFFFF"),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            child: ClickWidget(
              onTap: (){
                luckyController.clickTry();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LuckyImageWidget(name: "btn_bg",width: 160.w,height: 42.h,),
                  LuckyTextWidget(text: "Try Again", size: 20.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,shadowsColor: "#0A5300",),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}