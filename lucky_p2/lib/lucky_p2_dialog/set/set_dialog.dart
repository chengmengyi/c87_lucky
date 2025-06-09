import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/set/set_controller.dart';

class SetDialog extends LuckyBaseDialog<SetController>{
  @override
  SetController initController() => SetController();

  @override
  Widget child() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: 284.h,
        margin: EdgeInsets.only(left: 36.w,right: 36.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            LuckyImageWidget(name: "set1",width: double.infinity,height: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _backgroundWidget(),
                SizedBox(height: 16.h,),
                _soundWidget(),
                SizedBox(height: 16.h,),
                _contactWidget(),
              ],
            ).marginOnly(left: 36.w,right: 36.w),
            _privacyWidget(),
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

  _backgroundWidget()=>Row(
    children: [
      LuckyTextWidget(
        text: "Background Music",
        size: 14.sp,
        color: "#DAE1FD",
        shadowsColor: "#182273",
        fontWeight: FontWeight.bold,
      ),
      const Spacer(),
      GetBuilder<SetController>(
        id: "bg",
        builder: (_)=>ClickWidget(
          onTap: (){
            luckyController.clickBg();
          },
          child: LuckyImageWidget(name: bgOpen.getData()?"back_on":"back_off",width: 66.w,height: 30.h,),
        ),
      )
    ],
  );

  _soundWidget()=>Row(
    children: [
      LuckyTextWidget(
        text: "Sound Effects",
        size: 14.sp,
        color: "#DAE1FD",
        shadowsColor: "#182273",
        fontWeight: FontWeight.bold,
      ),
      const Spacer(),
      GetBuilder<SetController>(
        id: "gua",
        builder: (_)=>ClickWidget(
          onTap: (){
            luckyController.clickGua();
          },
          child: LuckyImageWidget(name: guaOpen.getData()?"sound_on":"sound_off",width: 66.w,height: 30.h,),
        ),
      )
    ],
  );

  _contactWidget()=>Row(
    children: [
      LuckyTextWidget(
        text: "Contact Us",
        size: 14.sp,
        color: "#DAE1FD",
        shadowsColor: "#182273",
        fontWeight: FontWeight.bold,
      ),
      const Spacer(),
      ClickWidget(
        onTap: (){
          luckyController.clickContact();
        },
        child: LuckyImageWidget(name: "set2",width: 83.w,height: 30.h,),
      )
    ],
  );

  _privacyWidget()=>Align(
    alignment: Alignment.bottomCenter,
    child: ClickWidget(
      onTap: (){
        luckyController.clickWeb();
      },
      child: LuckyTextWidget(
        text: "Privacy policy",
        size: 14.sp,
        color: "#FFFFFF",
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        decorationColor: "#FFFFFF".toColor(),
      ),
    ).marginOnly(bottom: 20.h),
  );
}