import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';

class BtnWidget extends StatelessWidget{
  String leftStr;
  String rightStr;
  bool showVideo;
  Function() onTap;
  BtnWidget({
    required this.leftStr,
    required this.rightStr,
    this.showVideo=true,
    required this.onTap,
});

  @override
  Widget build(BuildContext context) => ClickWidget(
    onTap: (){
      onTap.call();
    },
    child: SizedBox(
      width: 172.w,
      height: 44.h,
      child: Stack(
        children: [
          LuckyImageWidget(name: "btn_bg",width: 172.w,height: 44.h,),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LuckyTextWidget(text: leftStr, size: 20.sp, color: "#FFFFFF",shadowsColor: "#0A5300",fontWeight: FontWeight.bold,),
                SizedBox(width: 2.w,),
                LuckyTextWidget(text: rightStr, size: 20.sp, color: "#ECFB1A",shadowsColor: "#0A5300",fontWeight: FontWeight.bold,),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: showVideo,
              child: LuckyImageWidget(name: "unlock4",width: 24.w,height: 27.h,),
            ),
          )
        ],
      ),
    ),
  );
}