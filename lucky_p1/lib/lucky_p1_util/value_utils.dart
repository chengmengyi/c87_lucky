import 'dart:convert';
import 'dart:math';

import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p1/lucky_p1_bean/value_bean.dart';
import 'package:lucky_p1/lucky_p1_util/local_config.dart';

class ValueUtils{
  static final ValueUtils _instance = ValueUtils();
  static ValueUtils get instance => _instance;

  ValueBean? _valueBean;

  initValue(){
    try{
      _valueBean=ValueBean.fromJson(jsonDecode(valueStr.base64()));
    }catch(e){}
  }

  bool getPlay2Point()=>Random().nextInt(100)<(_valueBean?.cardNumber?.point??60);

  int getPlay2Reward()=>_randomReward(_valueBean?.cardNumber?.prize??[5000,8000]);

  int _randomReward(List<int> list){
    if(list.length!=2){
      return 0;
    }
    var min = list.first;
    var max = list.last;
    return min + Random().nextInt(max - min + 1);
  }
}