import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play8/play8_controller.dart';
import 'package:lucky_p1/lucky_p1_widget/bottom_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/play_top_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/up_level_widget.dart';

class Play8Page extends LuckyBasePage<Play8Controller>{
  @override
  String bgName() => "play81";

  @override
  Play8Controller initController() => Play8Controller();

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
      image: Image.asset('lucky_images/play82.webp',fit: BoxFit.fill,),
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
          LuckyImageWidget(name: "play83",width: double.infinity,height: double.infinity,),
          GetBuilder<Play8Controller>(
            id: "your_widget",
            builder: (_)=>Container(
              width: double.infinity,
              height: 196.h,
              margin: EdgeInsets.only(left: 41.w,right: 41.w,bottom: 17.h),
              // child: StaggeredGridView.countBuilder(
              //   padding: const EdgeInsets.all(0),
              //   itemCount: luckyController.playUtils.yourList.length,
              //   shrinkWrap: true,
              //   crossAxisCount: 4,
              //   mainAxisSpacing: 0,
              //   crossAxisSpacing: 0,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context,index){
              //     var yourBean = luckyController.playUtils.yourList[index];
              //     var w = Container(
              //       width: double.infinity,
              //       height: 65.h,
              //       alignment: Alignment.center,
              //       child: LuckyImageWidget(name: yourBean.content,width: 50.w,height: 47.h,),
              //     );
              //     return yourBean.win?
              //     ScaleTransition(
              //       scale: luckyController.playUtils.scaleController,
              //       child: w,
              //     ):w;
              //   },
              //   staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
              // ),
            ),
          )
        ],
      ),
    ),
  );
}