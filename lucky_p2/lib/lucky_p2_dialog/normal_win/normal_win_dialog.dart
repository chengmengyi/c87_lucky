import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/normal_win/normal_win_controller.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class NormalWinDialog extends LuckyBaseDialog<NormalWinController>{
  double allReward;
  PlayType playType;
  Function(double addNum) dismiss;
  NormalWinDialog({
    required this.allReward,
    required this.playType,
    required this.dismiss,
});

  @override
  NormalWinController initController() => NormalWinController();

  @override
  initView() {
    luckyController.playType=playType;
  }

  @override
  Widget child() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 178.h,
        margin: EdgeInsets.only(left: 12.w,right: 12.w),
        child: Stack(
          children: [
            LuckyImageWidget(
              name: "win3",
              width: double.infinity,
              height: 120.h,
            ).marginOnly(top: 58.h,left: 30.w,right: 30.w),
            Align(
              alignment: Alignment.topCenter,
              child: LuckyLottieWidget(name: "you_win",height: 96.h,fit: BoxFit.fitHeight,),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LuckyGraTextWidget(
                text: "\$$allReward",
                size: 45.sp,
                colors: [
                  "#FFFFFF".toColor(),
                  "#FAFF21".toColor(),
                  "#FF8B02".toColor(),
                ],
                fontWeight: FontWeight.bold,
                shadowsColor: "#170600",
              ).marginOnly(bottom: 6.h),
            ),
          ],
        ),
      ),
      SizedBox(height: 40.h,),
      BtnWidget(
        leftStr: "Claim",
        rightStr: "\$$allReward",
        showVideo: false,
        onTap: (){
          luckyController.clickSingle(allReward,dismiss);
        },
      ),
    ],
  );
}