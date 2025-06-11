import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/big_win/big_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/first_get_coins/first_get_coins_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/no_win/no_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/normal_win/normal_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/up_level/up_level_dialog.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

import 'user_guide/user_guide_steps.dart';

class PlayUtils{
  late PlayType playType;
  final key = GlobalKey<ScratcherState>();
  late AnimationController scaleController;
  bool _stopAuto=false,canClick=true;
  double _width=0.0,_height=0.0;
  GlobalKey scratchGlobalKey=GlobalKey();
  GlobalKey keyGlobalKey=GlobalKey();

  List<YourBean> yourList=[];

  PlayUtils(this.playType);

  initPlay(TickerProvider vsync){
    _initAnimator(vsync);
    _initAutoScratch();
  }

  _initAutoScratch(){
    var renderBox = scratchGlobalKey.currentContext!.findRenderObject() as RenderBox;
    _width = renderBox.size.width;
    _height = renderBox.size.height;
  }

  startAutoScratch({required Function(Offset offset) offsetCallback})async{
    if(!canClick){
      return;
    }
    canClick=false;
    var hang=1,dx=0,startHeight=90.h;
    key.currentState?.callStart();
    while(hang*15<_height&&!_stopAuto){
      if(hang%2!=0){
        if(dx<_width){
          dx+=10;
          var dy=(hang==1?15:(hang-1)*15+30)+startHeight;
          key.currentState?.addPoint(Offset(dx.toDouble(), dy));
          offsetCallback.call(Offset(dx.toDouble(), dy));
        }else{
          hang++;
        }
      }else{
        if(dx>0){
          dx-=10;
          var dy=(hang-1)*15+30+startHeight;
          key.currentState?.addPoint(Offset(dx.toDouble(), dy));
          offsetCallback.call(Offset(dx.toDouble(), dy));
        }else{
          hang++;
        }
      }
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }

  _initAnimator(TickerProvider vsync){
    scaleController=AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
      lowerBound: 1,
      upperBound: 1.2,
    )
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          scaleController.reverse();
        }else if(status==AnimationStatus.dismissed){
          scaleController.forward();
        }
      });
  }

  onThreshold({
    required Function() resetCallback,
    Function()? refreshKey,
})async{
    _stopAuto=true;
    key.currentState?.reveal();
    var hasWin = _checkHasWin();
    if(hasWin){
      scaleController..reset()..forward();
    }
    var keyIndex = yourList.indexWhere((value)=>value.isKey);
    if(keyIndex>=0){
      TTTTUtils.instance.pointEvent(customId: CustomId.key_out,params: {"source_from":playType.name});
      yourList[keyIndex].showKey=false;
      refreshKey?.call();
      var renderBox = keyGlobalKey.currentContext!.findRenderObject() as RenderBox;
      var offset = renderBox.localToGlobal(Offset.zero);
      LuckyEvent(luckyCode: P2LuckyEventCode.startKeyAnimator,dynamicValue: offset);
      await Future.delayed(const Duration(milliseconds: 1300));
      if(p2FirstGetKey.getData()){
        LuckyEvent(luckyCode: P2LuckyEventCode.firstGetKey);
        p2FirstGetKey.saveData(false);
      }
      UserInfoUtils.instance.updateKeyNum(1);
      _resetPlay(0.0,resetCallback);
      return;
    }

    var allReward=0.0;
    switch(playType){
      case PlayType.card7:
        var indexWhere = yourList.indexWhere((element) => element.win);
        if(indexWhere>=0){
          var yourBean = yourList[indexWhere];
          allReward=mulTwoNums(yourBean.reward, yourBean.play7Num);
        }
        break;
      case PlayType.card4:
      case PlayType.card6:
        for (var value in yourList) {
          if(value.is9){
            allReward+=value.reward*9;
          }else if(value.win){
            allReward+=value.reward;
          }
        }
        break;
      default:
        allReward = yourList.where((element) => element.win).fold(0, (previousValue, element) => addTwoNums(previousValue, element.reward));
        break;
    }
    LuckyEvent(luckyCode: P2LuckyEventCode.updatePlayBottomReward,doubleValue: allReward);
    await Future.delayed(const Duration(milliseconds: 1000));
    if(p2FirstGetCoins.getData()){
      LuckyRouters.instance.showDialog(
        child: FirstGetCoinsDialog(
          allReward: ValueUtils.instance.getNewPrize().toDouble(),
          dismiss: (addNum){
            _resetPlay(addNum,resetCallback);
          },
        ),
      );
      return;
    }
    var showLevelDialog = UserInfoUtils.instance.updateUserPlayNum();
    if(showLevelDialog){
      LuckyRouters.instance.showDialog(
        child: UpLevelDialog(
          addNum: ValueUtils.instance.getBigNum(playType).toDouble(),
          dismiss: (){
            _resetPlay(allReward.toDouble(),resetCallback);
          },
        )
      );
      return;
    }
    if(!hasWin){
      LuckyRouters.instance.showDialog(
        child: NoWinDialog(
          dismiss: (){
            _resetPlay(0.0,resetCallback);
          },
        ),
      );
      return;
    }
    if(allReward>=ValueUtils.instance.getBigNum(playType)){
      LuckyRouters.instance.showDialog(
        child: BigWinDialog(
          allReward: allReward.toDouble(),
          playType: playType,
          dismiss: (addNum){
            _resetPlay(addNum,resetCallback);
          },
        ),
      );
    }else{
      LuckyRouters.instance.showDialog(
        child: NormalWinDialog(
          allReward: allReward.toDouble(),
          playType: playType,
          dismiss: (addNum){
            _resetPlay(addNum,resetCallback);
          },
        ),
      );
    }
  }

  _resetPlay(double allReward, Function() resetCallback)async{
    _stopAuto=false;
    key.currentState?.reset();
    canClick=true;
    await CashUtils.instance.updateCaskTask(UpdateType.card);
    UserInfoUtils.instance.updateUserCoins(allReward.toDouble());
    var hasPlayNum = await PlayInfoUtils.instance.checkHasPlayNum(playType);
    if(!hasPlayNum){
      LuckyRouters.instance.back();
    }else{
      LuckyEvent(luckyCode: P2LuckyEventCode.flyOut);
      await Future.delayed(const Duration(milliseconds: 200));
      LuckyEvent(luckyCode: P2LuckyEventCode.updatePlayBottomReward,intValue: 0);
      resetCallback.call();
      if(allReward>0&&p2UserGuideStep.getData()==UserGuideSteps.showCashGuide){
        LuckyRouters.instance.back();
        LuckyEvent(luckyCode: P2LuckyEventCode.showCashGuide);
      }
      if(UserGuideUtils.instance.checkShowRevealAllGuide()){
        LuckyEvent(luckyCode: P2LuckyEventCode.showRevealAllGuide);
      }
      LuckyEvent(luckyCode: P2LuckyEventCode.updateBoxProgress);
    }
  }

  // _toNextUnlockPlay()async{
  //   var nextPlayType = PlayInfoUtils.instance.getNextPlayType(playType);
  //   if(null==nextPlayType){
  //     LuckyRouters.instance.back();
  //     return;
  //   }
  //   await PlayInfoUtils.instance.unlockPlayType(nextPlayType);
  //   var list = await PlayInfoUtils.instance.queryPlayList();
  //   var indexWhere = list.indexWhere((element) => element.type==playType.name);
  //   if(indexWhere>=0){
  //     for(int i = indexWhere+1;i<list.length;i++){
  //       if(list[i].unlock==1){
  //         UserInfoUtils.instance.openPlayPageByType(list[i].type??"");
  //         break;
  //       }
  //     }
  //   }else{
  //     LuckyRouters.instance.back();
  //   }
  // }

  bool _checkHasWin()=> yourList.indexWhere((element) => element.win)>=0;

  setYourList(List<YourBean> list){
    yourList.clear();
    yourList.addAll(list);
  }

  bool checkHasKey()=>yourList.indexWhere((element) => element.isKey)>=0;

  onClose(){
    scaleController.dispose();
  }
}