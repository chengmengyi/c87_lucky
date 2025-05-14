import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';

class LuckyGraTextWidget extends StatelessWidget{
  String text;
  double size;
  List<Color> colors;
  FontWeight? fontWeight;
  AlignmentGeometry? begin;
  AlignmentGeometry? end;
  String? shadowsColor;
  TextAlign? textAlign;
  TextOverflow? overflow;

  LuckyGraTextWidget({
    required this.text,
    required this.size,
    required this.colors,
    this.fontWeight,
    this.begin,
    this.end,
    this.shadowsColor,
    this.textAlign,
    this.overflow,
  });


  @override
  Widget build(BuildContext context) => ShaderMask(
    shaderCallback: (rect) {
      return LinearGradient(
        begin: begin??Alignment.topCenter,
        end: end??Alignment.bottomCenter,
        colors: colors,
      ).createShader(rect);
    },
    child: LuckyTextWidget(
      text: text,
      size: size,
      color: "#FFFFFF",
      fontWeight: fontWeight,
      shadowsColor: shadowsColor,
      overflow: overflow,
    ),
  );
}