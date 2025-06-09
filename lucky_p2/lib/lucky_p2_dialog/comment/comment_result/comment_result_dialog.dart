import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/comment/comment_result/comment_result_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class CommentResultDialog extends LuckyBaseDialog<CommentResultController>{
  @override
  CommentResultController initController() => CommentResultController();

  @override
  Widget child() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: 284.h,
        margin: EdgeInsets.only(left: 36.w,right: 36.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            LuckyImageWidget(name: "comment5",width: double.infinity,height: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LuckyImageWidget(name: "comment6",width: 72.w,height: 72.w,),
                SizedBox(height: 12.h,),
                LuckyTextWidget(text: "thanks for your feedback", size: 14.sp, color: "#FFFFFF"),
              ],
            ).marginOnly(left: 42.w,right: 42.w),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClickWidget(
                child: BtnWidget(
                  leftStr: "OK",
                  rightStr: "",
                  showVideo: false,
                  onTap: (){
                    luckyController.clickClose();
                  },
                ),
              ).marginOnly(bottom: 20.h),
            )
          ],
        ),
      ),
      Positioned(
        top: 14.h,
        right: 32.w,
        child: ClickWidget(
          onTap: (){
            luckyController.clickClose();
          },
          child: LuckyImageWidget(name: "icon_close",width: 38.w,height: 38.h,),
        ),
      ),
    ],
  );
}