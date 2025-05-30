import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play3/play3_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/bottom_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/play_animator_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/play_top_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/up_level_widget.dart';

class Play3Page extends LuckyBasePage<Play3Controller>{
  @override
  String bgName() => "play31";

  @override
  Play3Controller initController() => Play3Controller();

  @override
  Widget child() =>Column(
    children: [
      PlayTopWidget(),
      SizedBox(height: 16.h,),
      UpLevelWidget(),
      const Spacer(),
      _playWidget(),
      BottomWidget(
        revealAllCall: (){
          luckyController.clickRevealAll();
        },
      ),
    ],
  );

  _playWidget()=>PlayAnimatorWidget(
    child: SizedBox(
      width: double.infinity,
      height: 389.h,
      key: luckyController.playUtils.scratchGlobalKey,
      child: Scratcher(
        key: luckyController.playUtils.key,
        enabled: true,
        brushSize: 40,
        threshold: 40,
        color: Colors.transparent,
        image: Image.asset('lucky_images/play32.webp',fit: BoxFit.fill,),
        onThreshold: (){
          luckyController.onThreshold();
        },
        onScratchUpdate: (details){
          // smController.updateIconOffset(details);
        },
        onScratchStart: (){
          VoicePlayUtils.instance.playGua();
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            LuckyImageWidget(name: "play33",width: double.infinity,height: double.infinity,),
            GetBuilder<Play3Controller>(
              id: "your_widget",
              builder: (_)=>Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LuckyTextWidget(text: "${luckyController.winList[0]}", size: 30.sp, color: "#510400",fontFamily: "one",),
                      SizedBox(width: 30.w,),
                      LuckyTextWidget(text: "${luckyController.winList[1]}", size: 30.sp, color: "#510400",fontFamily: "one",),
                      SizedBox(width: 30.w,),
                      LuckyTextWidget(text: "${luckyController.winList[2]}", size: 30.sp, color: "#510400",fontFamily: "one",),
                    ],
                  ).marginOnly(bottom: 40.h),
                  Container(
                    width: double.infinity,
                    height: 165.h,
                    margin: EdgeInsets.only(left: 46.w,right: 46.w,bottom: 38.h),
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.all(0),
                      itemCount: luckyController.playUtils.yourList.length,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        var yourBean = luckyController.playUtils.yourList[index];
                        var w = Container(
                          width: double.infinity,
                          height: 55.h,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: LuckyTextWidget(text: yourBean.content, size: 30.sp, color: "#510400",fontFamily: "one",),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: LuckyTextWidget(text: "${yourBean.reward}", size: 13.sp, color: "#E35F00",fontWeight: FontWeight.bold,),
                              ),
                            ],
                          ),
                        );
                        return yourBean.win?
                        ScaleTransition(
                          scale: luckyController.playUtils.scaleController,
                          child: w,
                        ):w;
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}