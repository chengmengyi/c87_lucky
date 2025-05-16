import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p1/lucky_p1_bean/your_bean.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play2/play2_controller.dart';
import 'package:lucky_p1/lucky_p1_widget/bottom_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/play_top_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/up_level_widget.dart';

class Play2Page extends LuckyBasePage<Play2Controller>{
  @override
  String bgName() => "play21";

  @override
  Play2Controller initController() => Play2Controller();

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

  _playWidget()=>SizedBox(
    width: double.infinity,
    height: 381.h,
    key: luckyController.playUtils.scratchGlobalKey,
    child: Scratcher(
      key: luckyController.playUtils.key,
      enabled: true,
      brushSize: 40,
      threshold: 40,
      color: Colors.transparent,
      image: Image.asset('lucky_images/play22.webp',fit: BoxFit.fill,),
      onThreshold: (){
        luckyController.onThreshold();
      },
      onScratchUpdate: (details){
        // smController.updateIconOffset(details);
      },
      onScratchStart: (){
        // VoiceUtils.instance.playVoiceMp3();
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          LuckyImageWidget(name: "play23",width: double.infinity,height: double.infinity,),
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
                    child: StaggeredGridView.countBuilder(
                      padding: const EdgeInsets.all(0),
                      itemCount: luckyController.playUtils.yourList.length,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        var yourBean = luckyController.playUtils.yourList[index];
                        var w = Container(
                          width: double.infinity,
                          height: 73.h,
                          alignment: Alignment.center,
                          child: LuckyImageWidget(name: yourBean.content,width: 70.w,height: 70.h,),
                        );
                        return yourBean.win?
                        ScaleTransition(
                          scale: luckyController.playUtils.scaleController,
                          child: w,
                        ):w;
                      },
                      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );

  _rewardItemWidget(List<YourBean> list)=>Container(
    width: 76.w,
    height: 73.h,
    alignment: Alignment.center,
    child: LuckyTextWidget(
      text: "${list.fold(0, (previousValue, element) => previousValue+element.reward)}",
      size: 18.sp,
      color: "#FFFFFF",
      shadowsColor: "#000120",
      fontWeight: FontWeight.bold,
    ),
  );
}