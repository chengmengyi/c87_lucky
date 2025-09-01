import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/language/local_text.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/old_user/wheel_dialog/wheel_dialog_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class WheelDialog extends LuckyBaseDialog<WheelDialogController>{

  @override
  WheelDialogController initController() => WheelDialogController();

  @override
  Widget child() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      LuckyImageWidget(name: "wheel1",width: double.infinity,),
      AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: luckyController.animation,
              builder: (context,child)=>Transform.rotate(
                angle: luckyController.animation.value,
                child: LuckyImageWidget(name: "wheel3",width: double.infinity,height: double.infinity,),
              ),
            ),
            ClickWidget(
              onTap: (){
                luckyController.startAnimator();
              },
              child: LuckyImageWidget(name: "wheel2",width: double.infinity,height: double.infinity,),
            ),
          ],
        ),
      ),
      BtnWidget(
        leftStr: LocalText.spin.tr,
        rightStr: "",
        showVideo: false,
        onTap: (){
          luckyController.startAnimator();
        },
      ),
      SizedBox(height: 20.h,),
      ClickWidget(
        onTap: (){
          luckyController.clickClose();
        },
        child: LuckyImageWidget(name: "icon_close2",width: 16.w,height: 16.w,),
      )
    ],
  );
}