import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';

class LuckyTextWidget extends StatelessWidget{
  String text;
  double size;
  String color;
  FontWeight? fontWeight;
  String? shadowsColor;
  TextAlign? textAlign;
  TextOverflow? overflow;
  String? fontFamily;
  TextDecoration? decoration;
  Color? decorationColor;

  LuckyTextWidget({
    required this.text,
    required this.size,
    required this.color,
    this.shadowsColor,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.fontFamily,
    this.decoration,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color.toColor(),
        fontWeight: fontWeight,
        shadows: shadowsColor==null?
        null:
        [
          Shadow(
              color: (shadowsColor??"#000000").toColor(),
              blurRadius: 2.w,
              offset: Offset(0,0.5.w)
          )
        ],
        fontFamily: fontFamily,
        overflow: overflow,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
      textAlign: textAlign,
    );
  }

}