import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/wheel_sign_reward/wheel_sign_reward_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class WheelSignRewardDialog extends LuckyBaseDialog<WheelSignRewardController>{
  int wheelAddNum;
  WheelSignRewardDialog({
    required this.wheelAddNum,
});

  @override
  WheelSignRewardController initController() => WheelSignRewardController();
  @override
  Widget child() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: 324.h,
        margin: EdgeInsets.only(left: 36.w,right: 36.w),
        child: Stack(
          children: [
            LuckyImageWidget(name: "sign1",width: double.infinity,height: double.infinity,),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 63.h,),
                  LuckyTextWidget(text: "Come back tomorrow to claim\nthe 5x reward", size: 14.sp, color: "#FFFFFF",textAlign: TextAlign.center,),
                  SizedBox(height: 16.h,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          LuckyImageWidget(name: "sign2",width: 68.w,height: 68.w,).marginOnly(bottom: 16.h),
                          SizedBox(
                            width: 108.w,
                            height: 32.h,
                            child: Stack(
                              children: [
                                LuckyImageWidget(name: "sign3",width: 108.w,height: 32.h,),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: LuckyImageWidget(name: "icon_money",width: 32.w,height: 32.h,),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: LuckyTextWidget(
                                    text: "+\$$wheelAddNum",
                                    size: 17.sp,
                                    color: "#FFFFFF",
                                    shadowsColor: "#000000",
                                    fontWeight: FontWeight.bold,
                                  ).marginOnly(left: 10.w),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 20.w,),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          LuckyImageWidget(name: "sign4",width: 68.w,height: 68.w,).marginOnly(bottom: 16.h),
                          SizedBox(
                            width: 108.w,
                            height: 32.h,
                            child: Stack(
                              children: [
                                LuckyImageWidget(name: "sign3",width: 108.w,height: 32.h,),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: LuckyImageWidget(name: "icon_money",width: 32.w,height: 32.h,),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: LuckyTextWidget(
                                    text: "+\$${luckyController.signAddNum}",
                                    size: 17.sp,
                                    color: "#FFFFFF",
                                    shadowsColor: "#000000",
                                    fontWeight: FontWeight.bold,
                                  ).marginOnly(left: 10.w),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BtnWidget(
                    leftStr: "Double Claim",
                    rightStr: "",
                    onTap: (){
                      luckyController.clickDouble(wheelAddNum);
                    },
                  ),
                  SizedBox(height: 6.h,),
                  ClickWidget(
                    onTap: (){
                      luckyController.clickSingle(wheelAddNum);
                    },
                    child: LuckyTextWidget(
                      text: "Claim",
                      size: 14.sp,
                      color: "#FFFFFF",
                      withOpacity: 0.8,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: "#FFFFFF".toColor().withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                ],
              ),
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