import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/box_dialog/box_dialog_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/finger_widget.dart';

class BoxDialog extends LuckyBaseDialog<BoxDialogController>{
  @override
  BoxDialogController initController() => BoxDialogController();

  @override
  Widget child() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      LuckyImageWidget(name: "box2",width: double.infinity,),
      LuckyTextWidget(text: "Open the treasure chest\nWin big prizes", size: 16.sp, color: "#FFFFFF",textAlign: TextAlign.center,),
      GetBuilder<BoxDialogController>(
        id: "box",
        builder: (_)=>Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _boxItem(0),
                SizedBox(width: 80.w,),
                _boxItem(1),
              ],
            ),
            SizedBox(height: 12.h,),
            _boxItem(2),
          ],
        ),
      ),
      _btnWidget(),
    ],
  );
  
  _boxItem(index){
    var boxBean = luckyController.list[index];
    return ClickWidget(
      onTap: (){
        luckyController.clickBox(index);
      },
      child: SizedBox(
        width: 105.w,
        height: 92.h,
        child: Stack(
          children: [
            LuckyLottieWidget(name: boxBean.open?"box2":"box1",width: 105.w,height: 92.h,),
            Align(
              alignment: Alignment.bottomRight,
              child: Visibility(
                visible: !boxBean.open,
                child: FingerWidget(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: boxBean.open,
                child: LuckyTextWidget(text: "+\$${boxBean.reward}", size: 18.sp, color: "#1AFF16",shadowsColor: "#000000",fontWeight: FontWeight.bold,),
              ),
            )
          ],
        ),
      ),
    );
  }

  _btnWidget()=>GetBuilder<BoxDialogController>(
    id: "btn",
    builder: (_)=>Visibility(
      visible: luckyController.showBtn(),
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30.h,),
          BtnWidget(
            leftStr: "CLAIM ALL",
            rightStr: "",
            onTap: (){
              luckyController.clickAll();
            },
          ),
          SizedBox(height: 10.h,),
          ClickWidget(
            onTap: (){
              luckyController.clickGiveUp();
            },
            child: LuckyTextWidget(text: "Give Up", size: 14.sp, color: "#FFFFFF",withOpacity: 0.8,),
          )
        ],
      ),
    ),
  );
}