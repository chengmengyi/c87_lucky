import 'dart:convert';
import 'dart:math';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/value_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/win_reward_bean.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';

class ValueUtils{
  static final ValueUtils _instance = ValueUtils();
  static ValueUtils get instance => _instance;

  ValueBean? _valueBean;

  initValue(){
    try{
      _valueBean=ValueBean.fromJson(jsonDecode(localValueStrB.base64()));
    }catch(e){
      print(e);
    }
  }

  double getBubbleAddNum()=> 20.3;

  double getBoxAddNum(){
    var playNum = p2UserPlayNum.getData();
    var list = _valueBean?.boxPrize??[];
    if(list.isEmpty){
      return 0.0;
    }
    var last = list.last;
    if(playNum>=(last.endNumber??1000)){
      return _getRandomDoubleInRange(last.prize??[]);
    }
    for (var value in list) {
      if(playNum>=(value.firstNumber??0)&&playNum<(value.endNumber??0)){
        return _getRandomDoubleInRange(value.prize??[]);
      }
    }
    return 0.0;
  }

  double getSignAddNum()=>_getRandomDoubleInRange(_valueBean?.checkReward??[]);

  int getWheelAddNum(){
    var point = _valueBean?.wheelPoint;
    var tiger20 = point?.point20??60;
    var tiger50 = point?.point50??30;
    var tiger80 = point?.point80??5;
    var tiger100 = point?.point100??5;
    var index = Random().nextInt(100);
    if(index<tiger20){
      return 20;
    }else if(index>=tiger20&&index<(tiger20+tiger50)){
      return 50;
    }else if(index>=(tiger20+tiger50)&&index<(tiger20+tiger50+tiger80)){
      return 80;
    }else if(index>=(tiger20+tiger50+tiger80)&&index<(tiger20+tiger50+tiger80+tiger100)){
      return 100;
    }else{
      return 20;
    }
  }

  List<int> getCashList()=>_valueBean?.cardRange??[1000,1200,1500,2000];

  WtdTask? getFirstWtdTask(){
    try{
      return _valueBean?.wtdTask?.first;
    }catch(e){
      return null;
    }
  }

  WtdTask? getWtdTaskByIndex(CashTaskBean? bean){
    try{
      return _valueBean?.wtdTask?[bean?.task3Index??0];
    }catch(e){
      return null;
    }
  }

  WtdTask? getNextWtdTask(CashTaskBean? bean){
    try{
      return _valueBean?.wtdTask?[(bean?.task3Index??0)+1];
    }catch(e){
      return null;
    }
  }

  bool checkIsFinalTask(CashTaskBean? bean) => bean?.task3Index==(_valueBean?.wtdTask?.length??0)-1;

  int getRankAll()=>_valueBean?.queueNumberAll?.intAll??388;

  int getRankCurrent()=>_valueBean?.queueNumberCurrent?.intCurrent??99;

  int getAllReduce(){
    var list = _valueBean?.queueNumberAll?.intAllDelete??[1,3];
    if(list.isEmpty){
      return 1;
    }
    if(list.length<2){
      return list.first;
    }
    final random = Random();
    return list.first + random.nextInt(list.last - list.first + 1);
  }

  int getCurrentReduce(){
    var list = _valueBean?.queueNumberCurrent?.intCurrentDelete??[5,8];
    if(list.isEmpty){
      return 1;
    }
    if(list.length<2){
      return list.first;
    }
    final random = Random();
    return list.first + random.nextInt(list.last - list.first + 1);
  }

  WinRewardBean getWinnerBean(PlayType playType){
    var bigWin=200,rewardNormal=100;
    List<RewardNumber> rewardNumberList=[];
    List<RewardMoney> rewardMoneyList=[];
    switch(playType){
      //玩法2
      case PlayType.card1:
      case PlayType.card3:
        var play = _valueBean?.cardNumberPlay2;
        bigWin=play?.bigwinNumber??200;
        rewardNormal=play?.rewardNormal??100;
        rewardNumberList.addAll(play?.rewardNumber??[]);
        rewardMoneyList.addAll(play?.rewardMoney??[]);
        break;
        //玩法1
      case PlayType.card2:
      case PlayType.card5:
        var play = _valueBean?.cardFruitPlay1;
        bigWin=play?.bigwinNumber??200;
        rewardNormal=play?.rewardNormal??100;
        rewardNumberList.addAll(play?.rewardNumber??[]);
        rewardMoneyList.addAll(play?.rewardMoney??[]);
        break;
        //玩法3
      case PlayType.card7:
        var play = _valueBean?.cardTigerPlay3;
        bigWin=play?.bigwinNumber??200;
        rewardNormal=play?.rewardNormal??100;
        rewardNumberList.addAll(play?.rewardNumber??[]);
        rewardMoneyList.addAll(play?.rewardMoney??[]);
        break;
        //玩法4
      case PlayType.card8:
        var play = _valueBean?.card77hotPlay4;
        bigWin=play?.bigwinNumber??200;
        rewardNormal=play?.rewardNormal??100;
        rewardNumberList.addAll(play?.rewardNumber??[]);
        rewardMoneyList.addAll(play?.rewardMoney??[]);
        break;
        //玩法5
      case PlayType.card9:
        var play = _valueBean?.cardDiamondPlay5;
        bigWin=play?.bigwinNumber??200;
        rewardNormal=play?.rewardNormal??100;
        rewardNumberList.addAll(play?.rewardNumber??[]);
        rewardMoneyList.addAll(play?.rewardMoney??[]);
        break;
        //玩法6
      case PlayType.card4:
      case PlayType.card6:
        var play = _valueBean?.card9betPlay6;
        bigWin=play?.bigwinNumber??200;
        rewardNormal=play?.rewardNormal??100;
        rewardNumberList.addAll(play?.rewardNumber??[]);
        rewardMoneyList.addAll(play?.rewardMoney??[]);
        break;
    }
    if(rewardNumberList.isEmpty||rewardMoneyList.isEmpty){
      return WinRewardBean(winNum: 0, bigWin: bigWin, coinsNum: 0.0, winType: WinType.coins,rewardNormal: rewardNormal);
    }
    var randomRewardMoney = _randomRewardMoney(rewardMoneyList);
    // rewardNormal=randomRewardMoney?.rewardNormal??100;
    var randomRewardNumber = _randomRewardNumber(rewardNumberList);
    var winType = randomRewardMoney?.type==0?WinType.coins:WinType.diamond;
    if(randomRewardNumber?.number==0){
      return WinRewardBean(winNum: 0, bigWin: bigWin, coinsNum: 0, winType: winType,rewardNormal: rewardNormal);
    }
    var winProbability = _getWinProbability(randomRewardMoney, rewardMoneyList);
    var coinsNum=((rewardNormal*winProbability*(randomRewardNumber?.number??0)).toStringAsFixed(2)).toDou();
    return WinRewardBean(winNum: randomRewardNumber?.number??0, bigWin: bigWin, coinsNum: coinsNum, winType: winType,rewardNormal: rewardNormal);
  }

  RewardMoney? _randomRewardMoney(List<RewardMoney> list){
    if(list.isEmpty){
      return null;
    }
    var allScale = list.map((item) => item.scale).reduce((a, b) => (a??0) + (b??0))??0;
    int randomValue = Random().nextInt(allScale);
    int cumulativeProbability = 0;
    for (int i = 0; i < list.length; i++) {
      cumulativeProbability += list[i].scale??0;
      if (randomValue < cumulativeProbability) {
        return list[i];
      }
    }
    return list.first;
  }

  RewardNumber? _randomRewardNumber(List<RewardNumber> list){
    if(list.isEmpty){
      return null;
    }
    var allScale = list.map((item) => item.scale).reduce((a, b) => (a??0) + (b??0))??0;
    int randomValue = Random().nextInt(allScale);
    int cumulativeProbability = 0;
    for (int i = 0; i < list.length; i++) {
      cumulativeProbability += list[i].scale??0;
      if (randomValue < cumulativeProbability) {
        return list[i];
      }
    }
    return list.first;
  }

  double _getWinProbability(RewardMoney? rewardNumber,List<RewardMoney> list){
    var allScale = list.map((item) => item.scale).reduce((a, b) => (a??0) + (b??0))??0;
    if(allScale<=0){
      return 0.0;
    }
    return (rewardNumber?.scale??0)/allScale;
  }

  bool getPlay1Point()=>true;
  bool getPlay2Point()=>true;
  bool getPlay4Point9()=>true;
  bool getPlay4PointOther()=>true;
  bool getPlay8Point7()=>true;
  bool getPlay8Point77()=>true;
  bool getPlay9Point()=>true;

  int getPlay1Reward()=>100;
  int getPlay2Reward()=>100;
  int getPlay4Reward()=>100;
  int getPlay7Reward()=>100;
  int getPlay8Reward()=>100;
  int getPlay9Reward()=>100;

  int getPlay7Num(){
    return 100;
    // var cardTiger = _valueBean?.cardTiger;
    // var tiger0 = cardTiger?.tiger0??40;
    // var tiger3 = cardTiger?.tiger3??30;
    // var tiger4 = cardTiger?.tiger4??10;
    // var tiger5 = cardTiger?.tiger5??10;
    // var tiger6 = cardTiger?.tiger6??8;
    // var tiger7 = cardTiger?.tiger7??2;
    // var index = Random().nextInt(100);
    // if(index<tiger0){
    //   return 0;
    // }else if(index>=tiger0&&index<(tiger0+tiger3)){
    //   return 3;
    // }else if(index>=(tiger0+tiger3)&&index<(tiger0+tiger3+tiger4)){
    //   return 4;
    // }else if(index>=(tiger0+tiger3+tiger4)&&index<(tiger0+tiger3+tiger4+tiger5)){
    //   return 5;
    // }else if(index>=(tiger0+tiger3+tiger4+tiger5)&&index<(tiger0+tiger3+tiger4+tiger5+tiger6)){
    //   return 6;
    // }else if(index>=(tiger0+tiger3+tiger4+tiger5+tiger6)&&index<(tiger0+tiger3+tiger4+tiger5+tiger6+tiger7)){
    //   return 7;
    // }else{
    //   return 0;
    // }
  }

  double _getRandomDoubleInRange(List<int> list) {
    if(list.length<2){
      return 0.0;
    }
    var min = list.first;
    var max = list.last;
    final random = Random();
    double value = min + random.nextDouble() * (max - min);
    return value.toStringAsFixed(2).toDou();
  }

}