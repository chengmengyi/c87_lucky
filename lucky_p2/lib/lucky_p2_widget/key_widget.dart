import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';

class KeyWidegt extends StatelessWidget{
  double width;
  double height;
  GlobalKey globalKey;
  KeyWidegt({
    required this.width,
    required this.height,
    required this.globalKey,
  });
  
  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.bottomRight,
    key: globalKey,
    children: [
      LuckyImageWidget(name: "icon_key",width: width,height: height,),
      LuckyTextWidget(text: "x1", size: 10.sp, color: "#FFFFFF",shadowsColor: "#000000",fontWeight: FontWeight.bold,).marginOnly(right: 10.w,bottom: 10.h)
    ],
  );
}