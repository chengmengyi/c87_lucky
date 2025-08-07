import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_dialog/open_notification_dialog/open_notification_controller.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';

class OpenNotificationDialog extends LuckyBaseDialog<OpenNotificationController>{
  @override
  OpenNotificationController initController() => OpenNotificationController();

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
              SizedBox(height: 44.h,),
              LuckyImageWidget(name: "open2",width: 224.w,height: 86.h,),
              SizedBox(height: 20.h,),
              LuckyTextWidget(text: "Turn on push notifications", size: 19.sp, color: "#FFFFFF"),
              LuckyTextWidget(text: "Open the notification to\nreceive cash", size: 14.sp, color: "#FFFFFF",textAlign: TextAlign.center,),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            child: ClickWidget(
              onTap: (){
                luckyController.clickOpen();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LuckyImageWidget(name: "btn_bg",width: 160.w,height: 42.h,),
                  LuckyTextWidget(text: "Go and Open", size: 20.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,shadowsColor: "#0A5300",),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}