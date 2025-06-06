import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/no_money/no_money_controller.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';

class NoMoneyDialog extends LuckyBaseDialog<NoMoneyController>{
  int chooseMoney;
  NoMoneyDialog({required this.chooseMoney});

  @override
  NoMoneyController initController() => NoMoneyController();

  @override
  Widget child() => Stack(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(left: 38.w,right: 38.w),
        decoration: BoxDecoration(
          color: "#FFFFFF".toColor(),
          borderRadius: BorderRadius.circular(18.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LuckyTextWidget(text: "Cash Out", size: 18.sp, color: "#000000",fontWeight: FontWeight.bold,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Your current balance is ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: "#2E2E2E".toColor(),
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    TextSpan(
                        text: "\$${p2UserCoins.getData()}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: "#009D1A".toColor(),
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    TextSpan(
                        text: ", Collect ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: "#2E2E2E".toColor(),
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    TextSpan(
                        text: "\$$chooseMoney",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: "#009D1A".toColor(),
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    TextSpan(
                        text: " and you can withdraw cash！Go and Get more Cash！",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: "#2E2E2E".toColor(),
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ]
              ),
            ),
            SizedBox(height: 16.h,),
            ClickWidget(
              onTap: (){
                luckyController.clickMore();
              },
              child: Container(
                width: double.infinity,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: "#5828CA".toColor(),
                  borderRadius: BorderRadius.circular(48.w),
                ),
                child: LuckyTextWidget(text: "Get More Cash", size: 15.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,),
              ),
            )
          ],
        ),
      ),
      Positioned(
        top: 8.h,
        right: 45.w,
        child: ClickWidget(
          onTap: (){
            luckyController.clickClose();
          },
          child: LuckyImageWidget(name: "icon_close3",width: 24.w,height: 24.w,),
        ),
      )
    ],
  );
}