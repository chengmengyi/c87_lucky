import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_base/lucky_base_page2.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play2/play2_controller.dart';
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

class Play2Page extends LuckyBasePage2<Play2Controller>{
  @override
  String bgName() => "play21";

  @override
  Play2Controller initController() => Play2Controller();

  @override
  Widget child() =>Stack(
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
            image: Image.asset('lucky_images/play27.webp',fit: BoxFit.fill,),
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
                LuckyImageWidget(name: "play28",width: double.infinity,height: double.infinity,),
                GetBuilder<Play2Controller>(
                  id: "your_widget",
                  builder: (_)=>Container(
                    width: double.infinity,
                    height: 219.h,
                    margin: EdgeInsets.only(left: 37.w,right: 37.w,bottom: 35.h),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            _rewardItemWidget(luckyController.playUtils.yourList.sublist(0,3)),
                            _rewardItemWidget(luckyController.playUtils.yourList.sublist(3,6)),
                            _rewardItemWidget(luckyController.playUtils.yourList.sublist(6,9)),
                          ],
                        ),
                        Expanded(
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
                                  height: 73.h,
                                  alignment: Alignment.center,
                                  child: Visibility(
                                    visible: yourBean.showKey,
                                    child: KeyWidegt(width: 55.w, height: 55.w, globalKey: luckyController.playUtils.keyGlobalKey),
                                  ),
                                );
                              }
                              var w = Container(
                                width: double.infinity,
                                height: 73.h,
                                alignment: Alignment.center,
                                child: LuckyImageWidget(name: yourBean.content,width: 70.w,height: 70.h,),
                              );
                              return yourBean.win&&!hasKey?
                              ScaleTransition(
                                scale: luckyController.playUtils.scaleController,
                                child: w,
                              ):w;
                            },
                          ),
                        )
                      ],
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
                SizedBox(width: 6.w,),
                MaxNumWidget(playType: luckyController.playUtils.playType, fontSize: 30.sp),
              ],
            ).marginOnly(top: 6.h),
          ),
        ],
      ),
    ),
  );

  _rewardItemWidget(List<YourBean> list)=>Container(
    width: 76.w,
    height: 73.h,
    alignment: Alignment.center,
    child: LuckyTextWidget(
      text: luckyController.getLeftReward(list),
      size: 18.sp,
      color: "#FFFFFF",
      shadowsColor: "#000120",
      fontWeight: FontWeight.bold,
    ),
  );
}