import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class MaxNumWidget extends StatelessWidget{
  PlayType playType;
  double fontSize;
  MaxNumWidget({
    required this.playType,
    required this.fontSize,
});

  @override
  Widget build(BuildContext context) => LuckyGraTextWidget(
    text: "${getMoneySymbol()}${getMoneyByCountry(ValueUtils.instance.getBigNum(playType))}",
    size: fontSize,
    colors: ["#FAFF21".toColor(),"#FF8B02".toColor()],
    shadowsColor: "#351400",
    fontWeight: FontWeight.bold,
  );
}