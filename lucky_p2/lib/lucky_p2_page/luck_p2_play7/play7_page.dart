import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play7/play7_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/bottom_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/box_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/bubble_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/play_animator_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/play_top_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/up_level_widget.dart';

class Play7Page extends LuckyBasePage<Play7Controller>{
  @override
  String bgName() => "play71";

  @override
  Play7Controller initController() => Play7Controller();

  @override
  Widget child() => Stack(
    children: [
      Column(
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
      BubbleWidget(),
      BoxWidget(),
    ],
  );

  _playWidget()=>PlayAnimatorWidget(
    child: SizedBox(
      width: double.infinity,
      height: 381.h,
      key: luckyController.playUtils.scratchGlobalKey,
      child: Scratcher(
        key: luckyController.playUtils.key,
        enabled: true,
        brushSize: 40,
        threshold: 40,
        color: Colors.transparent,
        image: Image.asset('lucky_images/play72.webp',fit: BoxFit.fill,),
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
            LuckyImageWidget(name: "play73",width: double.infinity,height: double.infinity,),
            GetBuilder<Play7Controller>(
              id: "your_widget",
              builder: (_)=>Container(
                width: double.infinity,
                height: 196.h,
                margin: EdgeInsets.only(left: 41.w,right: 41.w,bottom: 17.h),
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
                      height: 65.h,
                      alignment: Alignment.center,
                      child: LuckyImageWidget(name: yourBean.content,width: 50.w,height: 47.h,),
                    );
                    return yourBean.win?
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
    ),
  );
}