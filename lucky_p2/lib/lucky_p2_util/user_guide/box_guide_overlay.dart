import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_utils.dart';
import 'package:lucky_p2/lucky_p2_widget/finger_widget.dart';

class BoxGuideOverlay extends StatelessWidget{
  Offset offset;
  Function() dismissCall;
  BoxGuideOverlay({
    required this.offset,
    required this.dismissCall,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: ClickWidget(
      onTap: (){
        UserGuideUtils.instance.hideOverlay();
        dismissCall.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: offset.dy,
              left: offset.dx,
              child: SizedBox(
                width: 60.w,
                height: 51.h,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    LuckyImageWidget(name: "box",width: 60.w,height: 51.h,),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 60.w,
                          height: 16.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 3.w,right: 3.w),
                          decoration: BoxDecoration(
                            color: "#001A03".toColor(),
                            borderRadius: BorderRadius.circular(33.w),
                          ),
                          child: Container(
                            width: 54.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33.w),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: ["#03FF20".toColor(),"#008702".toColor(),]
                                )
                            ),
                          ),
                        ),
                        LuckyTextWidget(text: "5/5", size: 8.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,shadowsColor: "#000E00",)
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: offset.dy+70.h,
              right: 23.w,
              child: Container(
                width: 205.w,
                height: 55.h,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5.w,
                    color: "#B67AFF".toColor(),
                  )
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Open a treasure chest every ",
                        style: TextStyle(
                          color: "#770000".toColor(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      TextSpan(
                          text: "5",
                          style: TextStyle(
                            color: "#359000".toColor(),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      TextSpan(
                          text: " scratches",
                          style: TextStyle(
                            color: "#770000".toColor(),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ]
                  ),
                ),
              )
            )
          ],
        ),
      ),
    ),
  );
}