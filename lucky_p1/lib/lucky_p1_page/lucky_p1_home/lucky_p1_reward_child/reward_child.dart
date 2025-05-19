import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_child.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_gra_text_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p1/lucky_p1_bean/play_info_bean.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/lucky_p1_reward_child/reward_child_controller.dart';

class RewardChild extends LuckyBaseChild<RewardChildController>{

  @override
  RewardChildController initController() => RewardChildController();

  @override
  Widget child() => SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _videoWidget(),
        _playListWidget(),
      ],
    ),
  );
  
  _videoWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 20.h,),
      LuckyImageWidget(name: "reward1",height: 14.h,),
      SizedBox(height: 6.h,),
      _videoItemWidget(5000),
      _videoItemWidget(8000),
    ],
  );

  _videoItemWidget(int reward)=>SizedBox(
    width: double.infinity,
    height: 102.h,
    child: Stack(
      children: [
        LuckyImageWidget(name: "reward2",width: double.infinity,height: 102.h,),
        Align(
          alignment: Alignment.center,
          child: LuckyGraTextWidget(
            text: "$reward",
            size: 26.sp,
            colors: ["#FFEFCB".toColor(),"#FAFF21".toColor(),"#FF8B02".toColor()],
            shadowsColor: "#170600",
            fontWeight: FontWeight.bold,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ClickWidget(
            onTap: (){
              luckyController.clickVideo(reward);
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                LuckyImageWidget(name: "reward3",width: 100.w,height: 38.h,),
                LuckyImageWidget(name: "unlock4",width: 20.w,height: 20.h,),
              ],
            ),
          ).marginOnly(right: 22.w),
        )
      ],
    ),
  );

  _playListWidget()=>GetBuilder<RewardChildController>(
    id: "list",
    builder: (_)=>ListView.builder(
      shrinkWrap: true,
      itemCount: luckyController.list.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context,index)=> _playItemWidget(luckyController.list[index]),
    ),
  );

  _playItemWidget(PlayInfoBean bean)=>Container(
    width: double.infinity,
    height: 94.h,
    margin: EdgeInsets.only(top: 12.h,left: 12.w,right: 12.w),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        LuckyImageWidget(name: "reward4",width: double.infinity,height: 94.h,),
        Row(
          children: [
            SizedBox(width: 12.w,),
            SizedBox(
              width: 117.w,
              height: 72.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LuckyImageWidget(name: luckyController.getIcon(bean),width: 117.w,height: 72.h,fit: BoxFit.cover,),
                  Visibility(
                    visible: bean.unlock!=1,
                    child: Container(
                      width: 106.w,
                      height: 66.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.w),
                          color: "#000000".toColor().withOpacity(0.5)
                      ),
                      child: LuckyImageWidget(name: "home3",width: 33.w,height: 41.h,),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context,bc){
                  var maxWidth = bc.maxWidth;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LuckyImageWidget(name: "reward5",height: 12.h,),
                      SizedBox(height: 4.h,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LuckyImageWidget(name: "unlock4",width: 17.w,height: 19.h,),
                          SizedBox(width: 4.w,),
                          LuckyTextWidget(
                            text: bean.unlock==1?"3/3":"${bean.watchVideoNum??0}/3",
                            size: 14.sp,
                            color: "#FFFFFF",
                            shadowsColor: "#000485",
                            fontWeight: FontWeight.bold,
                          ),

                        ],
                      ),
                      Container(
                        width: maxWidth,
                        height: 11.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 2.w,right: 2.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          color: "#020202".toColor().withOpacity(0.3),
                        ),
                        child: Container(
                          width: bean.unlock==1?maxWidth:maxWidth*getPro(bean.watchVideoNum??0, 3),
                          height: 7.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            color: "#E1FF00".toColor(),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            ClickWidget(
              onTap: (){
                luckyController.clickPlay(bean);
              },
              child: Stack(
                children: [
                  LuckyImageWidget(name: "reward6",width: 99.w,height: 38.h,).marginOnly(top: 9.h),
                  LuckyImageWidget(name: "unlock4",width: 19.w,height: 21.h,),
                ],
              ),
            ),
            SizedBox(width: 12.w,),
          ],
        )
      ],
    ),
  );
}