import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/big_win/big_win_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class BigWinDialog extends LuckyBaseDialog<BigWinController>{
  double allReward;
  Function(double addNum) dismiss;
  BigWinDialog({
    required this.allReward,
    required this.dismiss,
});

  @override
  BigWinController initController() => BigWinController();

  @override
  Widget child() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: double.infinity,
        height: 432.h,
        child: Stack(
          children: [
            LuckyLottieWidget(name: "big_win",height: 432.h,fit: BoxFit.fitHeight,),
            Align(
              alignment: Alignment.bottomCenter,
              child: LuckyGraTextWidget(
                text: "\$$allReward",
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
      ),
      BtnWidget(
        leftStr: "Claim",
        rightStr: "\$${mulTwoNums(allReward, 2)}",
        onTap: (){
          luckyController.clickDouble(allReward,dismiss);
        },
      ),
      SizedBox(height: 12.h,),
      ClickWidget(
        onTap: (){
          luckyController.clickSingle(allReward,dismiss);
        },
        child: LuckyTextWidget(
          text: "\$$allReward",
          size: 14.sp,
          color: "#FFFFFF",
          withOpacity: 0.8,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationColor: "#FFFFFF".toColor().withOpacity(0.8),
        ),
      )
    ],
  );
}