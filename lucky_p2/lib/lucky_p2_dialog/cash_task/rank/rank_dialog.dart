import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_task/rank/rank_controller.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class RankDialog extends LuckyBaseDialog<RankController>{
  CashTaskBean? cashTaskBean;
  RankDialog({required this.cashTaskBean});

  @override
  RankController initController() => RankController();

  @override
  initView() {
    luckyController.cashTaskBean=cashTaskBean;
  }

  @override
  Widget child() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: 496.h,
        margin: EdgeInsets.only(left: 36.w,right: 36.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            LuckyImageWidget(name: "rank1",width: double.infinity,height: double.infinity,),
            Column(
              children: [
                SizedBox(height: 50.h,),
                LuckyTextWidget(text: "Congratulations, You are in the withdrawal approval queue.", size: 14.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,textAlign: TextAlign.center,),
                SizedBox(height: 6.h,),
                _cashTypeWidget(),
                SizedBox(height: 6.h,),
                _rankStrWidget(),
                SizedBox(height: 6.h,),
                _rankListWidget(),
                SizedBox(height: 6.h,),
                BtnWidget(
                  leftStr: "Skip Wait ",
                  rightStr: "",
                  onTap: (){
                    luckyController.clickWatch();
                  },
                ),
                SizedBox(height: 6.h,),
              ],
            ).marginOnly(left: 16.w,right: 16.w),
          ],
        ),
      ),
      Positioned(
        top: 14.h,
        right: 32.w,
        child: ClickWidget(
          onTap: (){
            LuckyRouters.instance.back();
          },
          child: LuckyImageWidget(name: "icon_close",width: 38.w,height: 38.h,),
        ),
      ),
    ],
  );

  _rankStrWidget()=>GetBuilder<RankController>(
    id: "rank_title",
    builder: (_)=>RichText(
      text: TextSpan(
          children: [
            TextSpan(
                text: "${luckyController.cashTaskBean?.totalPro??0}",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: "#04E500".toColor(),
                  fontWeight: FontWeight.bold,
                )
            ),
            TextSpan(
                text: " In Queue, Your Current rank ",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: "#FFFFFF".toColor(),
                  fontWeight: FontWeight.bold,
                )
            ),
            TextSpan(
                text: "${luckyController.cashTaskBean?.currentPro??0}",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: "#04E500".toColor(),
                  fontWeight: FontWeight.bold,
                )
            ),
          ]
      ),
    ),
  );
  
  _rankListWidget()=>Expanded(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.w),
      child: Container(
        color: "#FBF7EE".toColor(),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 34.h,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: LuckyTextWidget(text: "Rank", size: 12.sp, color: "#000000",fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: LuckyTextWidget(text: "Account", size: 12.sp, color: "#000000",fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: LuckyTextWidget(text: "Amount", size: 12.sp, color: "#000000",fontWeight: FontWeight.bold,),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<RankController>(
                id: "rank_list",
                builder: (_)=>ListView.builder(
                  itemCount: luckyController.rankList.length,
                  itemBuilder: (context,index){
                    var isMe = index+1==luckyController.cashTaskBean?.currentPro;
                    return Container(
                      width: double.infinity,
                      height: 24.h,
                      color: index%2==0?"#F2ECDB".toColor():null,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: LuckyTextWidget(text: "${index+1}", size: 12.sp, color: isMe?"B71C1C":"#000000",fontWeight: FontWeight.bold,),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: LuckyTextWidget(
                                text: luckyController.getAccountStr(luckyController.rankList[index]),
                                size: 12.sp,
                                color: isMe?"B71C1C":"#000000",
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: LuckyTextWidget(text: "\$${ValueUtils.instance.getCashList().random()}", size: 12.sp, color: isMe?"B71C1C":"#000000",fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );

  _cashTypeWidget()=>Container(
    width: 124.w,
    height: 70.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: "#FFFFFF".toColor(),
        border: Border.all(
          width: 1.w,
          color: "#6732C2".toColor(),
        )
    ),
    child: Stack(
      children: [
        LuckyImageWidget(name: "pay_type${(luckyController.cashTaskBean?.payTypeIndex??0)+1}",height: 18.h,fit: BoxFit.fitHeight,),
        Align(
          alignment: Alignment.bottomCenter,
          child: LuckyTextWidget(text: "\$${luckyController.cashTaskBean?.payMoney??0}", size: 24.sp, color: "#00730D",fontWeight: FontWeight.bold,).marginOnly(bottom: 10.h),
        )
      ],
    ),
  );
}