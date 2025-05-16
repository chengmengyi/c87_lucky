import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play4/play4_controller.dart';
import 'package:lucky_p1/lucky_p1_widget/bottom_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/play_top_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/up_level_widget.dart';

class Play4Page extends LuckyBasePage<Play4Controller>{
  @override
  String bgName() => "play41";

  @override
  Play4Controller initController() => Play4Controller();

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
    height: 389.h,
    key: luckyController.playUtils.scratchGlobalKey,
    child: Scratcher(
      key: luckyController.playUtils.key,
      enabled: true,
      brushSize: 40,
      threshold: 40,
      color: Colors.transparent,
      image: Image.asset('lucky_images/play42.webp',fit: BoxFit.fill,),
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
          LuckyImageWidget(name: "play43",width: double.infinity,height: double.infinity,),
          GetBuilder<Play4Controller>(
            id: "your_widget",
            builder: (_)=>Column(
              mainAxisSize: MainAxisSize.min,
              children: [

              ],
            ),
          )
        ],
      ),
    ),
  );
}