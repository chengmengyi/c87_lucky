import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LuckyLottieWidget extends StatelessWidget{
  String name;
  double? width;
  double? height;
  BoxFit? fit;
  LuckyLottieWidget({
    required this.name,
    this.width,
    this.height,
    this.fit,
});

  @override
  Widget build(BuildContext context) => Lottie.asset(
    "lucky_lottie/$name.json",
    width: width,
    height: height,
    fit: fit,
  );
}