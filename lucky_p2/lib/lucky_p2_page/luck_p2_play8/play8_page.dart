import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_base/lucky_base_page2.dart';
import 'package:lucky_base/lucky_utils/language/local_text.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play8/play8_controller.dart';
import 'package:lucky_p2/lucky_p2_util/utils.dart';
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

class Play8Page extends LuckyBasePage2<Play8Controller>{
  @override
  String bgName() => "play81";

  @override
  Play8Controller initController() => Play8Controller();

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
            image: Image.asset('lucky_images/play86.webp',fit: BoxFit.fill,),
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
                LuckyImageWidget(name: "play87",width: double.infinity,height: double.infinity,),
                GetBuilder<Play8Controller>(
                  id: "your_widget",
                  builder: (_)=>Container(
                    width: double.infinity,
                    height: 223.h,
                    margin: EdgeInsets.only(left: 38.w,right: 38.w,bottom: 80.h),
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
                        if(yourBean.isKey){
                          return Container(
                            width: double.infinity,
                            height: 74.h,
                            alignment: Alignment.center,
                            child: Visibility(
                              visible: yourBean.showKey,
                              child: KeyWidegt(width: 55.w, height: 55.w, globalKey: luckyController.playUtils.keyGlobalKey),
                            ),
                          );
                        }
                        var w = Container(
                          width: double.infinity,
                          height: 74.h,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LuckyImageWidget(name: yourBean.content,width: 56.w,height: 44.h,),
                              LuckyTextWidget(text: "${getMoneySymbol()}${getMoneyByCountry(yourBean.reward)}", size: 15.sp, color: "#450A00",fontWeight: FontWeight.bold,)
                            ],
                          ),
                        );
                        return yourBean.win?
                        ScaleTransition(
                          scale: luckyController.playUtils.scaleController,
                          child: w,
                        ):Container(
                          width: double.infinity,
                          height: 74.h,
                          alignment: Alignment.center,
                          child: LuckyTextWidget(text: yourBean.content, size: 40.sp, color: "#691000",fontFamily: "one",),
                        );
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
                LuckyTextWidget(text: LocalText.winUpTo.tr, size: 11.sp, color: "#FFFFFF",shadowsColor: "#000000",fontWeight: FontWeight.bold,),
                SizedBox(width: 2.w,),
                MaxNumWidget(playType: luckyController.playUtils.playType, fontSize: 30.sp),
              ],
            ).marginOnly(top: 12.h),
          ),
        ],
      ),
    ),
  );
}