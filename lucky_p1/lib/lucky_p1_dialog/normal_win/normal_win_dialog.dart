import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';
import 'package:lucky_p1/lucky_p1_dialog/normal_win/normal_win_controller.dart';

class NormalWinDialog extends LuckyBaseDialog<NormalWinController>{
  int allReward;
  Function() dismiss;
  NormalWinDialog({
    required this.allReward,
    required this.dismiss,
});

  @override
  NormalWinController initController() => NormalWinController();

  @override
  initView() {
    luckyController.dismissCall=dismiss;
  }

  @override
  Widget child() => Container(
    width: double.infinity,
    height: 174.h,
    margin: EdgeInsets.only(left: 12.w,right: 12.w),
    child: Stack(
      children: [
        LuckyImageWidget(name: "win1",width: double.infinity,height: 174.h,),
        Align(
          alignment: Alignment.bottomCenter,
          child: LuckyGraTextWidget(
            text: "$allReward",
            size: 40.sp,
            colors: [
              "#FFFFFF".toColor(),
              "#FAFF21".toColor(),
              "#FF8B02".toColor(),
            ],
            fontWeight: FontWeight.bold,
            shadowsColor: "#170600",
          ).marginOnly(bottom: 6.h),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: LuckyLottieWidget(name: "you_win",width: 214.w,height: 56.h,),
        )
      ],
    ),
  );
}