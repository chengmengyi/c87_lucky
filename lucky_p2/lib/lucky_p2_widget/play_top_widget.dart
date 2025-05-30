import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/coins_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/star_widget.dart';

class PlayTopWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(width: 14.w,),
      ClickWidget(
        onTap: (){
          LuckyRouters.instance.back();
        },
        child: LuckyImageWidget(name: "icon_home",width: 34.w,height: 34.w,),
      ),
      SizedBox(width: 14.w,),
      StarWidget(),
      SizedBox(width: 14.w,),
      CoinsWidget(),
    ],
  );
}