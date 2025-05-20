import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';
import 'package:lucky_p1/lucky_p1_dialog/up_level/up_level_controller.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';

class UpLevelDialog extends LuckyBaseDialog<UpLevelController>{
  PlayType playType;
  Function() dismiss;
  UpLevelDialog({required this.playType,required this.dismiss});

  @override
  UpLevelController initController() => UpLevelController();

  @override
  Widget child() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // LuckyImageWidget(name: "level1",width: double.infinity,height: 200.h,).marginOnly(left: 16.w,right: 16.w),
      LuckyLottieWidget(name: "up_level",width: double.infinity,height: 200.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LuckyImageWidget(name: "coins1",width: 34.w,height: 34.w,),
          SizedBox(width: 10.w,),
          LuckyGraTextWidget(
            text: "+${luckyController.getUpLevelReward(playType)}",
            size: 30.sp,
            colors: [
              "#FFFFFF".toColor(),
              "#FAFF21".toColor(),
              "#FF8B02".toColor(),
            ],
            fontWeight: FontWeight.bold,
          )
        ],
      ),
      SizedBox(height: 20.h,),
      ClickWidget(
        onTap: (){
          luckyController.clickContinue(dismiss);
        },
        child: LuckyImageWidget(name: "level2",width: 185.w,height: 52.h,),
      )
    ],
  );
}