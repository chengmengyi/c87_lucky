import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_p1/lucky_p1_bean/your_bean.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play6/play6_controller.dart';
import 'package:lucky_p1/lucky_p1_widget/bottom_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/play_animator_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/play_top_widget.dart';
import 'package:lucky_p1/lucky_p1_widget/up_level_widget.dart';

class Play6Page extends LuckyBasePage<Play6Controller>{
  @override
  String bgName() => "play61";

  @override
  Play6Controller initController() => Play6Controller();

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
      height: 381.h,
      key: luckyController.playUtils.scratchGlobalKey,
      child: Scratcher(
        key: luckyController.playUtils.key,
        enabled: true,
        brushSize: 40,
        threshold: 40,
        color: Colors.transparent,
        image: Image.asset('lucky_images/play62.webp',fit: BoxFit.fill,),
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
            LuckyImageWidget(name: "play63",width: double.infinity,height: double.infinity,),
            GetBuilder<Play6Controller>(
              id: "your_widget",
              builder: (_)=>Container(
                width: double.infinity,
                height: 208.h,
                margin: EdgeInsets.only(left: 49.w,right: 49.w,bottom: 62.h),
                child: luckyController.playUtils.yourList.isEmpty?
                Container():
                Row(
                  children: [
                    _columnWidget(0),
                    SizedBox(width: 6.w,),
                    _columnWidget(3),
                    SizedBox(width: 12.w,),
                    Expanded(
                      child: StaggeredGridView.countBuilder(
                        padding: const EdgeInsets.all(0),
                        itemCount: 9,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          var yourBean = luckyController.playUtils.yourList[index+6];
                          return _itemWidget(yourBean);
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
    ),
  );

  _columnWidget(int startIndex){
    var yourList = luckyController.playUtils.yourList;
    return SizedBox(
      width: 53.w,
      height: 208.h,
      child: Column(
        children: [
          _itemWidget(yourList[startIndex]),
          _itemWidget(yourList[startIndex+1]),
          _itemWidget(yourList[startIndex+2]),
        ],
      ),
    );
  }

  _itemWidget(YourBean yourBean){
    var w = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        LuckyImageWidget(name: yourBean.is9?"play611":yourBean.content,width: 46.w,height: 46.h,),
        Visibility(
          visible: yourBean.win,
          child: LuckyGraTextWidget(
            text: "${yourBean.reward}",
            size: 13.sp,
            colors: ["#FFFFFF".toColor(),"#FAFF21".toColor(),"#FF8B02".toColor()],
            fontWeight: FontWeight.bold,
            shadowsColor: "#350400",
          ),
        ),
      ],
    );
    return Container(
      width: 53.w,
      height: 69.h,
      alignment: Alignment.center,
      child: yourBean.win?
      ScaleTransition(
        scale: luckyController.playUtils.scaleController,
        child: w,
      ):w,
    );
  }
}