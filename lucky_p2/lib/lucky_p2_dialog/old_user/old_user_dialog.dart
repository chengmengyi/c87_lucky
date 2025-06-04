import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/old_user_controller.dart';

class OldUserDialog extends LuckyBaseDialog<OldUserController>{
  Function() clickSpin;
  Function() clickClose;
  OldUserDialog({
    required this.clickSpin,
    required this.clickClose,
  });

  @override
  OldUserController initController() => OldUserController();

  @override
  Widget child() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: 324.h,
        margin: EdgeInsets.only(left: 36.w,right: 36.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            LuckyImageWidget(name: "old2",width: double.infinity,height: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LuckyTextWidget(text: "Spin the wheel daily for prize！", size: 14.sp, color: "#FFFFFF"),
                SizedBox(height: 16.h,),
                LuckyImageWidget(name: "old1",width: 90.w,height: 90.w,),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClickWidget(
                onTap: (){
                  luckyController.clickSpin(clickSpin);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    LuckyImageWidget(name: "btn_bg",width: 160.w,height: 40.h,),
                    LuckyTextWidget(text: "Spin", size: 20.sp, color: "#FFFFFF",shadowsColor: "#0A5300",fontWeight: FontWeight.bold,)
                  ],
                ),
              ).marginOnly(bottom: 20.h),
            ),
          ],
        ),
      ),
      Positioned(
        top: 14.h,
        right: 32.w,
        child: ClickWidget(
          onTap: (){
            luckyController.clickClose(clickClose);
          },
          child: LuckyImageWidget(name: "icon_close",width: 38.w,height: 38.h,),
        ),
      ),
    ],
  );
}