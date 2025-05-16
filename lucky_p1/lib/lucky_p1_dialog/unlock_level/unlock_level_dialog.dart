import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p1/lucky_p1_dialog/unlock_level/unlock_level_controller.dart';

class UnlockLevelDialog extends LuckyBaseDialog<UnlockLevelController>{
  String icon;
  UnlockLevelDialog({required this.icon});

  @override
  UnlockLevelController initController() => UnlockLevelController();

  @override
  Widget child() => Stack(
    alignment: Alignment.topCenter,
    children: [
      LuckyImageWidget(name: "unlock1",width: 300.w,height: 300.h,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LuckyImageWidget(name: "unlock2",height: 33.h,),
          SizedBox(height: 20.h,),
          Stack(
            alignment: Alignment.topRight,
            children: [
              LuckyImageWidget(name: icon,width: 250.w,),
              LuckyImageWidget(name: "home3",width: 33.w,height: 41.h,),
            ],
          ),
          SizedBox(height: 20.h,),
          _videoBtnWidget(),
          SizedBox(height: 10.h,),
          _coinsBtnWidget(),
        ],
      )
    ],
  );

  _videoBtnWidget()=>ClickWidget(
    onTap: (){
      luckyController.clickVideo(icon);
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        LuckyImageWidget(name: "unlock3",width: 185.w,height: 50.h,),
        LuckyImageWidget(name: "unlock4",width: 24.w,height: 27.h,)
      ],
    ),
  );

  _coinsBtnWidget()=>ClickWidget(
    onTap: (){
      luckyController.clickCoins(icon);
    },
    child: Stack(
      alignment: Alignment.centerRight,
      children: [
        LuckyImageWidget(name: "unlock5",width: 185.w,height: 50.h,),
        LuckyTextWidget(
          text: "5000",
          size: 18.sp,
          color: "#F3FF06",
          fontWeight: FontWeight.bold,
          shadowsColor: "#7E2800",
        ).marginOnly(right: 20.w)
      ],
    ),
  );
}