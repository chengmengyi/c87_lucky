import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_p2/lucky_p2_dialog/account/account_controller.dart';
import 'package:lucky_p2/lucky_p2_widget/btn_widget.dart';

class AccountDialog extends LuckyBaseDialog<AccountController>{
  int chooseIndex;
  Function(int payTypeIndex,String account) callback;
  AccountDialog({
    required this.chooseIndex,
    required this.callback,
  });

  @override
  AccountController initController() => AccountController();

  @override
  initView() {
    luckyController.chooseIndex=chooseIndex;
  }

  @override
  Widget child() => ClickWidget(
    onTap: (){

      luckyController.hideKeyboard();
    },
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: 320.h,
          margin: EdgeInsets.only(left: 36.w,right: 36.w),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              LuckyImageWidget(name: "account1",width: double.infinity,height: double.infinity,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 53.h,),
                  GetBuilder<AccountController>(
                    id: "list",
                    builder: (_)=>MasonryGridView.count(
                      padding: const EdgeInsets.all(0),
                      itemCount: 7,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 8.w,
                      crossAxisSpacing: 8.w,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index) => ClickWidget(
                        onTap: (){
                          luckyController.clickPayType(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: "#EAEAFF".toColor(),
                              borderRadius: BorderRadius.circular(5.w),
                              border: Border.all(
                                width: 1.w,
                                color: luckyController.chooseIndex==index?"#150070".toColor():"#EAEAFF".toColor(),
                              )
                          ),
                          child: LuckyImageWidget(name: "pay_type${index+1}",width: double.infinity,height: 30.h,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  Container(
                    width: double.infinity,
                    height: 50.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 12.w,right: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: "#FFFFFF".toColor(),
                    ),
                    child: TextField(
                      enabled: true,
                      maxLength: 30,
                      textAlign: TextAlign.center,
                      controller: luckyController.editingController,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: "#000000".toColor(),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        isCollapsed: true,
                        hintText: ' Please input your account ID',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: "#B1B1B1".toColor(),
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (v){
                        luckyController.clickSubmit(callback);
                      },
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  BtnWidget(
                    leftStr: "Submit",
                    rightStr: "",
                    showVideo: false,
                    onTap: (){
                      luckyController.clickSubmit(callback);
                    },
                  )
                ],
              ).marginOnly(left: 18.w,right: 18.w)
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
    ),
  );
}