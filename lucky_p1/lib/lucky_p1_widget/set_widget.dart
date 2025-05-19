import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_p1/lucky_p1_dialog/set/set_dialog.dart';

class SetWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) => ClickWidget(
    onTap: (){
      LuckyRouters.instance.showDialog(child: SetDialog());
    },
    child: LuckyImageWidget(name: "icon_set",width: 34.w,height: 34.w,),
  );
}