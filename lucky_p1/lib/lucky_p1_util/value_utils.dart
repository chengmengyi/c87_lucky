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

  bool getPlay1Point()=>Random().nextInt(100)<(_valueBean?.cardNumber?.point??60);
  bool getPlay2Point()=>Random().nextInt(100)<(_valueBean?.cardFruit?.point??60);

  int getPlay1Reward()=>_randomReward(_valueBean?.cardNumber?.prize??[5000,8000]);
  int getPlay2Reward()=>_randomReward(_valueBean?.cardFruit?.prize??[2000,5000]);
  int getPlay7Reward()=>_randomReward(_valueBean?.cardTiger?.prize??[2000,3000]);

  int getPlay7Num(){
    var cardTiger = _valueBean?.cardTiger;
    var tiger0 = cardTiger?.tiger0??40;
    var tiger3 = cardTiger?.tiger3??30;
    var tiger4 = cardTiger?.tiger4??10;
    var tiger5 = cardTiger?.tiger5??10;
    var tiger6 = cardTiger?.tiger6??8;
    var tiger7 = cardTiger?.tiger7??2;
    var index = Random().nextInt(100);
    if(index<tiger0){
      return 0;
    }else if(index>=tiger0&&index<(tiger0+tiger3)){
      return 3;
    }else if(index>=(tiger0+tiger3)&&index<(tiger0+tiger3+tiger4)){
      return 4;
    }else if(index>=(tiger0+tiger3+tiger4)&&index<(tiger0+tiger3+tiger4+tiger5)){
      return 5;
    }else if(index>=(tiger0+tiger3+tiger4+tiger5)&&index<(tiger0+tiger3+tiger4+tiger5+tiger6)){
      return 6;
    }else if(index>=(tiger0+tiger3+tiger4+tiger5+tiger6)&&index<(tiger0+tiger3+tiger4+tiger5+tiger6+tiger7)){
      return 7;
    }else{
      return 0;
    }
  }

  int _randomReward(List<int> list){
    if(list.length!=2){
      return 0;
    }
    var min = list.first;
    var max = list.last;
    return min + Random().nextInt(max - min + 1);
  }
}