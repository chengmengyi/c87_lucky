import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class AccountController extends LuckyBaseController{
  var chooseIndex=0;
  TextEditingController editingController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    TTTTUtils.instance.pointEvent(customId: CustomId.cash_confirm_pop);
  }

  clickPayType(index){
    if(chooseIndex==index){
      return;
    }
    chooseIndex=index;
    update(["list"]);
  }

  clickSubmit(Function(int payTypeIndex,String account) callback)async{
    TTTTUtils.instance.pointEvent(customId: CustomId.cash_confirm_pop_c);
    var content = editingController.text.trim();
    if(content.isEmpty){
      return;
    }
    if(!_isNumeric(content)&&!_isEmail(content)){
      showToast("Please enter the correct withdrawal account number");
      return;
    }
    LuckyRouters.instance.back();
    callback.call(chooseIndex,content);
  }

  bool _isNumeric(String input) {
    final numericRegex = RegExp(r'^\d+$');
    return numericRegex.hasMatch(input);
  }

  bool _isEmail(String input) {
    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );
    return emailRegex.hasMatch(input);
  }

  hideKeyboard(){
    var node = FocusScope.of(context);
    if(!node.hasPrimaryFocus&&node.focusedChild!=null){
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  clickClose(){
    LuckyAdUtils.instance.showP2Ad(
      adType: AdType.interstitial,
      adPosId: AdPosId.skerk_close_int,
      showAd: ValueUtils.instance.showAd(AdType.interstitial),
      closeAd: (){
        LuckyRouters.instance.back();
      },
    );
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }
}