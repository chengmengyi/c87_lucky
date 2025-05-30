import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_bean/play_info_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/unlock_level/unlock_level_controller.dart';

class UnlockLevelDialog extends LuckyBaseDialog<UnlockLevelController>{
  PlayInfoBean playInfoBean;
  UnlockLevelDialog({required this.playInfoBean});

  @override
  UnlockLevelController initController() => UnlockLevelController();

  @override
  Widget child() => Stack(
    alignment: Alignment.topCenter,
    children: [
      LuckyImageWidget(name: "unlock1",width: 300.w,height: 300.h,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LuckyImageWidget(name: "unlock2",height: 33.h,),
          SizedBox(height: 20.h,),
          Stack(
            alignment: Alignment.topRight,
            children: [
              LuckyImageWidget(name: playInfoBean.type??"",width: 250.w,),
              LuckyImageWidget(name: "home3",width: 33.w,height: 41.h,),
            ],
          ),
          SizedBox(height: 20.h,),
          _videoBtnWidget(),
          SizedBox(height: 10.h,),
          _coinsBtnWidget(),
          SizedBox(height: 10.h,),
          ClickWidget(
            onTap: (){
              LuckyRouters.instance.back();
            },
            child: LuckyImageWidget(name: "icon_close",width: 38.w,height: 38.h,),
          )
        ],
      )
    ],
  );

  _videoBtnWidget()=>ClickWidget(
    onTap: (){
      luckyController.clickVideo(playInfoBean);
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        LuckyImageWidget(name: "unlock3",width: 185.w,height: 50.h,),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            LuckyImageWidget(name: "unlock4",width: 24.w,height: 27.h,),
            Container(
              margin: EdgeInsets.only(top: 22.h),
              padding: EdgeInsets.only(left: 4.w,right: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(31.w),
                border: Border.all(
                  width: 1.w,
                  color: "#84165C".toColor(),
                ),
                gradient: LinearGradient(
                  colors: ["#FF3333".toColor(),"#FB0CFF".toColor()]
                ),
              ),
              child: GetBuilder<UnlockLevelController>(
                id: "num",
                builder: (_)=>LuckyTextWidget(text: "${playInfoBean.watchVideoNum??0}/3", size: 10.sp, color: "#FFFFFF",shadowsColor: "#000000",fontWeight: FontWeight.bold,),
              ),
            )
          ],
        )
      ],
    ),
  );

  _coinsBtnWidget()=>ClickWidget(
    onTap: (){
      luckyController.clickCoins(playInfoBean);
    },
    child: Stack(
      alignment: Alignment.centerRight,
      children: [
        LuckyImageWidget(name: "unlock5",width: 185.w,height: 50.h,),
        LuckyTextWidget(
          text: "5000",
          size: 18.sp,
          color: "#F3FF06",
          fontWeight: FontWeight.bold,
          shadowsColor: "#7E2800",
        ).marginOnly(right: 20.w)
      ],
    ),
  );
}