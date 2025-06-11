import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_base/lucky_base_page2.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play9/play9_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/bottom_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/box_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/bubble_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/key_animator_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/key_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/max_num_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/money_lottie_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/play_animator_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/play_top_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/up_level_widget.dart';

class Play9Page extends LuckyBasePage2<Play9Controller>{
  @override
  String bgName() => "play91";

  @override
  Play9Controller initController() => Play9Controller();

  @override
  Widget child() => Stack(
    children: [
      SafeArea(
        top: true,
        bottom: false,
        child: Column(
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
        ),
      ),
      BubbleWidget(),
      BoxWidget(),
      KeyAnimatorWidget(),
      MoneyLottieWidget(),
    ],
  );

  _playWidget()=>PlayAnimatorWidget(
    child: SizedBox(
      width: double.infinity,
      height: 381.h,
      key: luckyController.playUtils.scratchGlobalKey,
      child: Stack(
        children: [
          Scratcher(
            key: luckyController.playUtils.key,
            enabled: true,
            brushSize: 40,
            threshold: 40,
            color: Colors.transparent,
            image: Image.asset('lucky_images/play97.webp',fit: BoxFit.fill,),
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
                LuckyImageWidget(name: "play98",width: double.infinity,height: double.infinity,),
                GetBuilder<Play9Controller>(
                  id: "your_widget",
                  builder: (_)=>Container(
                    width: double.infinity,
                    height: 177.h,
                    margin: EdgeInsets.only(left: 61.w,right: 61.w,bottom: 102.h),
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.all(0),
                      itemCount: luckyController.playUtils.yourList.length,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        var yourBean = luckyController.playUtils.yourList[index];
                        var hasKey = luckyController.playUtils.checkHasKey();
                        if(yourBean.isKey){
                          return Container(
                            width: double.infinity,
                            height: 59.h,
                            alignment: Alignment.center,
                            child: Visibility(
                              visible: yourBean.showKey,
                              child: KeyWidegt(width: 55.w, height: 55.w, globalKey: luckyController.playUtils.keyGlobalKey),
                            ),
                          );
                        }
                        var w = Container(
                          width: double.infinity,
                          height: 59.h,
                          alignment: Alignment.center,
                          child: LuckyImageWidget(name: yourBean.content,width: 52.w,height: 52.h,),
                        );
                        return yourBean.win&&!hasKey?
                        ScaleTransition(
                          scale: luckyController.playUtils.scaleController,
                          child: w,
                        ):w;
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LuckyTextWidget(text: "WIN UP TO", size: 11.sp, color: "#FFFFFF",shadowsColor: "#000000",fontWeight: FontWeight.bold,),
                SizedBox(width: 2.w,),
                MaxNumWidget(playType: luckyController.playUtils.playType, fontSize: 30.sp),
              ],
            ).marginOnly(top: 34.h),
          ),
        ],
      ),
    ),
  );
}