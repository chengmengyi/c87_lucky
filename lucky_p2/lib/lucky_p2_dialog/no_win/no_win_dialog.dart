import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/no_win/no_win_controller.dart';

class NoWinDialog extends LuckyBaseDialog<NoWinController>{
  Function() dismiss;
  NoWinDialog({
    required this.dismiss,
});

  @override
  NoWinController initController() => NoWinController();

  @override
  Widget child() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      LuckyImageWidget(name: "no1",height: 70.h,),
      SizedBox(height: 16.h,),
      LuckyImageWidget(name: "no2",width: 112.w,height: 112.h,),
      SizedBox(height: 36.h,),
      ClickWidget(
        onTap: (){
          luckyController.clickPlayAgain(dismiss);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            LuckyImageWidget(name: "no3",width: 172.w,height: 44.h,),
            LuckyTextWidget(
              text: " Play Again",
              size: 20.sp,
              color: "#FFFFFF",
              fontWeight: FontWeight.bold,
              fontFamily: "one",
              shadowsColor: "#0A5300",
            )
          ],
        ),
      )
    ],
  );
}