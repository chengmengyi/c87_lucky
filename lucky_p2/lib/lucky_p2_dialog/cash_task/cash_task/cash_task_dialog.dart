import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/language/local_text.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/cash_task/cash_task/cash_task_controller.dart';
import 'package:lucky_p2/lucky_p2_util/utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class CashTaskDialog extends LuckyBaseDialog<CashTaskController>{
  CashTaskBean? cashTaskBean;
  bool firstStep;
  CashTaskDialog({
    required this.cashTaskBean,
    required this.firstStep,
  });

  @override
  CashTaskController initController() => CashTaskController();

  @override
  initView() {
    if(firstStep){
      TTTTUtils.instance.pointEvent(customId: CustomId.cash_task_pop);
    }else{
      var wtdTask = ValueUtils.instance.getWtdTaskByIndex(cashTaskBean);
      TTTTUtils.instance.pointEvent(customId: CustomId.one_last_step_pop,params: {"task_from":wtdTask?.type});
    }
  }

  @override
  Widget child() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: 354.h,
        margin: EdgeInsets.only(left: 36.w,right: 36.w),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            LuckyImageWidget(name: "cash_task1",width: double.infinity,height: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 50.h,),
                _cashTypeWidget(),
                SizedBox(height: 10.h,),
                LuckyTextWidget(text: LocalText.completeTheTask.tr, size: 14.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,textAlign: TextAlign.center,),
                LuckyTextWidget(text: LocalText.immediately.tr, size: 14.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,textAlign: TextAlign.center,),
                SizedBox(height: 10.h,),
                _progressWidget(),
                SizedBox(height: 10.h,),
                BtnWidget(
                  leftStr: LocalText.cashOut.tr,
                  rightStr: "",
                  showVideo: false,
                  onTap: (){
                    luckyController.clickCash(firstStep,cashTaskBean);
                  },
                ),
              ],
            ).marginOnly(left: 20.w,right: 20.w),
          ],
        ),
      ),
      Positioned(
        top: 14.h,
        right: 32.w,
        child: ClickWidget(
          onTap: (){
            luckyController.clickClose();
          },
          child: LuckyImageWidget(name: "icon_close",width: 38.w,height: 38.h,),
        ),
      ),
    ],
  );

  _progressWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(15.w),
    decoration: BoxDecoration(
      color: "#6700C4".toColor(),
      borderRadius: BorderRadius.circular(10.w)
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LuckyTextWidget(text: luckyController.getTaskLeftStr(cashTaskBean), size: 14.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,),
            LuckyTextWidget(text: "${cashTaskBean?.totalPro??0}", size: 14.sp, color: "#1BFE02 ",fontWeight: FontWeight.bold,),
            LuckyTextWidget(text: luckyController.getTaskRightStr(cashTaskBean), size: 14.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,),
          ],
        ),
        SizedBox(height: 10.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            LayoutBuilder(
              builder: (context,bc){
                var maxWidth = bc.maxWidth;
                return Container(
                  width: double.infinity,
                  height: 10.h,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: "#4A008D".toColor(),
                    borderRadius: BorderRadius.circular(17.w),
                  ),
                  child: Container(
                    width: maxWidth*getPro(cashTaskBean?.currentPro??0, cashTaskBean?.totalPro??0),
                    height: 10.h,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: "#6EE922".toColor(),
                      borderRadius: BorderRadius.circular(17.w),
                    ),
                  ),
                );
              },
            ),
            LuckyTextWidget(text: "${cashTaskBean?.currentPro??0}/${cashTaskBean?.totalPro??0}", size: 10.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,shadowsColor: "#000000",),
          ],
        )
      ],
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
        LuckyImageWidget(name: "pay_type${(cashTaskBean?.payTypeIndex??0)+1}",height: 18.h,fit: BoxFit.fitHeight,),
        Align(
          alignment: Alignment.bottomCenter,
          child: LuckyTextWidget(text: "${getMoneySymbol()}${getMoneyByCountry(cashTaskBean?.payMoney??0)}", size: 24.sp, color: "#00730D",fontWeight: FontWeight.bold,).marginOnly(bottom: 10.h),
        )
      ],
    ),
  );
}