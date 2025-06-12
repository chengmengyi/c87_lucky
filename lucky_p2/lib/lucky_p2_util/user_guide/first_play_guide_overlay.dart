import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_utils.dart';
import 'package:lucky_p2/lucky_p2_widget/finger_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/max_num_widget.dart';

class FirstPlayGuideOverlay extends StatelessWidget{
  Offset offset;
  Size size;
  Function() dismissCall;
  FirstPlayGuideOverlay({
    required this.offset,
    required this.size,
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
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    LuckyImageWidget(name: "new_card1",width: size.width,height: size.height,),
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: 80.w,
                        height: 36.h,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            LuckyImageWidget(name: "home4",width: 80.w,height: 36.h,),
                            LuckyTextWidget(text: "10/10", size: 14.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,).marginOnly(top: 5.h)
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MaxNumWidget(playType: PlayType.card1, fontSize: 18.sp),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: offset.dy+size.height-50.w,
              left: offset.dx+size.width-50.w,
              child: FingerWidget(),
            )
          ],
        ),
      ),
    ),
  );
}