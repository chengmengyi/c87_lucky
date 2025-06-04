import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/box_dialog/box_dialog_controller.dart';

class BoxDialog extends LuckyBaseDialog<BoxDialogController>{
  @override
  BoxDialogController initController() => BoxDialogController();

  @override
  Widget child() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [

    ],
  );
}