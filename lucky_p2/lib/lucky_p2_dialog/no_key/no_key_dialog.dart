import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/no_key/no_key_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class NoKeyDialog extends LuckyBaseDialog<NoKeyController>{

  @override
  NoKeyController initController() => NoKeyController();

  @override
  Widget child() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: 268.h,
        margin: EdgeInsets.only(left: 36.w,right: 36.w),
        child: Stack(
          children: [
            LuckyImageWidget(name: "no_key1",width: double.infinity,height: double.infinity,),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50.h,),
                  LuckyImageWidget(name: "no_key2",width: 54.w,height: 70.h,),
                  LuckyTextWidget(
                    text: "Not Enough Keys to\nUnlock Spin",
                    size: 18.sp,
                    color: "#FFFFFF",
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BtnWidget(
                leftStr: "Find  it",
                rightStr: "",
                showVideo: false,
                onTap: (){
                  luckyController.clickFind();
                },
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
            luckyController.clickClose();
          },
          child: LuckyImageWidget(name: "icon_close",width: 38.w,height: 38.h,),
        ),
      ),
    ],
  );
}