import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/comment/comment_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/finger_widget.dart';

class CommentDialog extends LuckyBaseDialog<CommentController>{

  @override
  CommentController initController() => CommentController();

  @override
  Widget child() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: 347.h,
        margin: EdgeInsets.only(left: 36.w,right: 36.w),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            LuckyImageWidget(name: "comment1",width: double.infinity,height: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 80.h,),
                LuckyImageWidget(name: "comment2",width: 72.w,height: 72.w,),
                SizedBox(height: 12.h,),
                GetBuilder<CommentController>(
                  id: "list",
                  builder: (_)=>MasonryGridView.count(
                    padding: const EdgeInsets.all(0),
                    itemCount: 5,
                    shrinkWrap: true,
                    crossAxisCount: 5,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 8.w,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return ClickWidget(
                        onTap: (){
                          luckyController.clickStars(index);
                        },
                        child: LuckyImageWidget(name: luckyController.chooseIndex>=index?"comment3":"comment4"),
                      );
                    },
                  ),
                ),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LuckyTextWidget(text: "Complete reviews earn \$5", size: 14.sp, color: "#FFFFFF"),
                    LuckyImageWidget(name: "icon_money",width: 30.w,height: 30.h,),
                  ],
                )
              ],
            ).marginOnly(left: 42.w,right: 42.w),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClickWidget(
                child: BtnWidget(
                  leftStr: "Give 5 Stars",
                  rightStr: "",
                  showVideo: false,
                  onTap: (){},
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
      Positioned(
        top: 170.h,
        right: 40.w,
        child: GetBuilder<CommentController>(
          id: "finger",
          builder: (_)=>Visibility(
            visible: luckyController.chooseIndex==-1,
            child: ClickWidget(
              onTap: (){
                luckyController.clickStars(4);
              },
              child: FingerWidget(),
            ),
          ),
        ),
      )
    ],
  );
}