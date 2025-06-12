import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/up_level/up_level_controller.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class UpLevelDialog extends LuckyBaseDialog<UpLevelController>{
  double addNum;
  PlayType playType;
  Function() dismiss;
  UpLevelDialog({
    required this.addNum,
    required this.playType,
    required this.dismiss,
  });

  @override
  UpLevelController initController() => UpLevelController();

  @override
  initView() {
    TTTTUtils.instance.pointEvent(customId: CustomId.level_pop,params: {"source_from":playType.name});
  }

  @override
  Widget child() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      LuckyLottieWidget(name: "up_level",width: double.infinity,height: 200.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              LuckyImageWidget(name: "up_level2",width: 80.w,height: 80.w,),
              LuckyTextWidget(text: "\$$addNum", size: 18.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,shadowsColor: "#043200",),
            ],
          ),
          LuckyImageWidget(name: "up_level4",width: 40.w,height: 40.w,),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              LuckyImageWidget(name: "up_level3",width: 80.w,height: 80.w,),
              LuckyTextWidget(text: "\$${mulTwoNums(addNum, 2)}", size: 18.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,shadowsColor: "#043200",),
            ],
          ),
        ],
      ),
      SizedBox(height: 20.h,),
      BtnWidget(
        leftStr: "Claim",
        rightStr: "\$${mulTwoNums(addNum, 2)}",
        onTap: (){
          luckyController.clickDouble(addNum,dismiss,playType);
        },
      ),
      SizedBox(height: 12.h,),
      ClickWidget(
        onTap: (){
          luckyController.clickSingle(addNum,dismiss,playType);
        },
        child: LuckyTextWidget(
          text: "\$$addNum",
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