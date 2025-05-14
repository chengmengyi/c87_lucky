import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:scratch_it_lucky/main/main_controller.dart';

class MainPage extends LuckyBasePage<MainController>{
  @override
  String bgName() => "";

  @override
  MainController initController() => MainController();

  @override
  Widget child() => Center(
    child: ClickWidget(
      onTap: (){

      },
      child: LuckyTextWidget(text: "main", size: 20.sp, color: "#000000"),
    ),
  );
}