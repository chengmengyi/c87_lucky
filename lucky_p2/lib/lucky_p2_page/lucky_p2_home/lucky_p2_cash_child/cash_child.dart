import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_child.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_wheel_child/wheel_child_controller.dart';

class CashChild extends LuckyBaseChild<WheelChildController>{
  @override
  WheelChildController initController() => WheelChildController();

  @override
  Widget child() => Center(
    child: LuckyTextWidget(text: "cash", size: 20.sp, color: "#000000"),
  );
}