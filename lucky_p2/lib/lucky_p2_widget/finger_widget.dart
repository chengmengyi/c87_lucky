import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_lottie_widget.dart';

class FingerWidget extends StatelessWidget{
  double? width;
  double? height;
  FingerWidget({
    this.width,
    this.height,
});
  @override
  Widget build(BuildContext context) => LuckyLottieWidget(name: "finger",width: width??58.w,height: height??58.w,);
}