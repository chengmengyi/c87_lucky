import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';
import 'package:lucky_p1/lucky_p1_dialog/big_win/big_win_controller.dart';

class BigWinDialog extends LuckyBaseDialog<BigWinController>{
  int allReward;
  Function() dismiss;
  BigWinDialog({
    required this.allReward,
    required this.dismiss,
});

  @override
  BigWinController initController() => BigWinController();

  @override
  initView() {
    luckyController.dismissCall=dismiss;
  }

  @override
  Widget child() => SizedBox(
    width: double.infinity,
    height: 432.h,
    child: Stack(
      children: [
        LuckyLottieWidget(name: "big_win",height: 432.h,fit: BoxFit.fitHeight,),
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
          ).marginOnly(bottom: 66.h),
        ),
      ],
    ),
  );
}