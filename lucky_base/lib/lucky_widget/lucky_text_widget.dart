import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:outlined_text/outlined_text.dart';

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
  double? withOpacity;

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
    this.withOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedText(
      text: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: null==withOpacity?color.toColor():color.toColor().withOpacity(withOpacity??0.0),
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          overflow: overflow,
          decoration: decoration,
          decorationColor: decorationColor,
        ),
        textAlign: textAlign,
      ),
      strokes: shadowsColor==null?
      []:
      [
        OutlinedTextStroke(
          color: (shadowsColor??"#FFFFFF").toColor(),
          width: 2.w,
        ),
      ],
    );
  }

}