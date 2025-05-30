import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/big_win/big_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/no_win/no_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/normal_win/normal_win_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/up_level/up_level_dialog.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';

class PlayUtils{
  late PlayType playType;
  final key = GlobalKey<ScratcherState>();
  late AnimationController scaleController;
  bool _stopAuto=false,canClick=true;
  double _width=0.0,_height=0.0;
  GlobalKey scratchGlobalKey=GlobalKey();

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
})async{
    _stopAuto=true;
    key.currentState?.reveal();
    var hasWin = _checkHasWin();
    if(hasWin){
      scaleController..reset()..forward();
    }
    var allReward=0;
    switch(playType){
      case PlayType.card7:
        var indexWhere = yourList.indexWhere((element) => element.win);
        if(indexWhere>=0){
          var yourBean = yourList[indexWhere];
          allReward=yourBean.reward*yourBean.play7Num;
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
        allReward = yourList.where((element) => element.win).fold(0, (previousValue, element) => previousValue+element.reward);
        break;
    }
    LuckyEvent(luckyCode: P1LuckyEventCode.updatePlayBottomReward,intValue: allReward);

    await Future.delayed(const Duration(milliseconds: 1000));
    // LuckyEvent(luckyCode: P1LuckyEventCode.flyOut);
    // await Future.delayed(const Duration(milliseconds: 300));
    UserInfoUtils.instance.updateUserCoins(allReward);
    var showLevelDialog = UserInfoUtils.instance.updateUserPlayNum();
    if(showLevelDialog){
      LuckyRouters.instance.showDialog(
        child: UpLevelDialog(
          playType: playType,
          dismiss: (){
            _resetPlay(allReward,resetCallback);
          },
        )
      );
      return;
    }
    if(!hasWin){
      LuckyRouters.instance.showDialog(
        child: NoWinDialog(
          dismiss: (){
            _resetPlay(allReward,resetCallback);
          },
        ),
      );
      return;
    }
    if(allReward>=3000){
      LuckyRouters.instance.showDialog(
        child: BigWinDialog(
          allReward: allReward,
          dismiss: (){
            _resetPlay(allReward,resetCallback);
          },
        ),
      );
    }else{
      LuckyRouters.instance.showDialog(
        child: NormalWinDialog(
          allReward: allReward,
          dismiss: (){
            _resetPlay(allReward,resetCallback);
          },
        ),
      );
    }
  }

  _resetPlay(int allReward, Function() resetCallback)async{
    _stopAuto=false;
    key.currentState?.reset();
    canClick=true;
    UserInfoUtils.instance.updateUserCoins(allReward);
    var showTime = await PlayInfoUtils.instance.updatePlayInfo(playType);
    if(showTime){
      LuckyRouters.instance.back();
      // _toNextUnlockPlay();
    }else{
      LuckyEvent(luckyCode: P1LuckyEventCode.flyOut);
      await Future.delayed(const Duration(milliseconds: 200));
      LuckyEvent(luckyCode: P1LuckyEventCode.updatePlayBottomReward,intValue: 0);
      resetCallback.call();
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

  onClose(){
    scaleController.dispose();
  }
}