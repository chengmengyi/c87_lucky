import 'package:flutter/material.dart';

class LuckyImageWidget extends StatelessWidget{
  String name;
  double? width;
  double? height;
  BoxFit? fit;

  LuckyImageWidget({
    required this.name,
    this.width,
    this.height,
    this.fit,
});

  @override
  Widget build(BuildContext context) => Image.asset("lucky_images/$name.webp",width: width,height: height,fit: fit??BoxFit.fill,);
}