import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_success/cash_success_controller.dart';

class CashSuccessDialog extends LuckyBaseDialog<CashSuccessController>{
  CashTaskBean? cashTaskBean;
  CashSuccessDialog({required this.cashTaskBean});

  @override
  CashSuccessController initController() => CashSuccessController();

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
            LuckyTextWidget(text: "Withdrawal Successful", size: 18.sp, color: "#000000",fontWeight: FontWeight.bold,),
            SizedBox(height: 20.h,),
            LuckyTextWidget(text: "\$${cashTaskBean?.payMoney??0}", size: 40.sp, color: "#000000",fontWeight: FontWeight.bold,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Your withdrawal amount has been issued and will arrive in ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: "#2E2E2E".toColor(),
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    TextSpan(
                        text: "3-5",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: "#0035D2".toColor(),
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    TextSpan(
                        text: " working days. Please check your account",
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
                luckyController.clickKnow(cashTaskBean);
              },
              child: Container(
                width: double.infinity,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: "#5828CA".toColor(),
                  borderRadius: BorderRadius.circular(48.w),
                ),
                child: LuckyTextWidget(text: "I Know", size: 15.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,),
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