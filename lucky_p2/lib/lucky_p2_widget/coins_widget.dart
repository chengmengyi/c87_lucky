import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_stateful.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';

class CoinsWidget extends LuckyBaseStateful{
  bool fromDetail;
  CoinsWidget({this.fromDetail=false});

  @override
  State<StatefulWidget> createState() => CoinsWidgetState();
}

class CoinsWidgetState extends LuckyBaseState<CoinsWidget>{

  @override
  bool initLuckyEvent() => true;

  @override
  Widget build(BuildContext context) => ClickWidget(
    onTap: (){
      if(widget.fromDetail){
        LuckyRouters.instance.back();
      }
      LuckyEvent(luckyCode: P2LuckyEventCode.showHomeTab,intValue: 2);
    },
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        SizedBox(
          width: 140.w,
          height: 26.h,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              LuckyImageWidget(name: "coins2",width: 140.w,height: 26.h,),
              LuckyGraTextWidget(
                text: "${p2UserCoins.getData()}",
                size: 14.sp,
                colors: [
                  "#FFF7C2".toColor(),
                  "#FFDD09".toColor(),
                ],
                fontWeight: FontWeight.bold,
              ).marginOnly(left: 28.w ),
            ],
          ),
        ).marginOnly(left: 6.w),
        LuckyImageWidget(name: "icon_money",width: 36.w,height: 36.h,),
      ],
    ),
  );

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.updateUserCoins:
        setState(() {});
        break;
    }
  }
}