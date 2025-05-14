import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p1/lucky_p1_bean/your_bean.dart';
import 'package:lucky_p1/lucky_p1_dialog/big_win/big_win_dialog.dart';
import 'package:lucky_p1/lucky_p1_dialog/normal_win/normal_win_dialog.dart';
import 'package:lucky_p1/lucky_p1_dialog/up_level/up_level_dialog.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/user_info_utils.dart';

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
    _stopAuto=false;
    key.currentState?.reveal();
    var hasWin = _checkHasWin();
    if(hasWin){
      scaleController..reset()..forward();
    }
    await Future.delayed(const Duration(milliseconds: 800));
    var allReward = yourList.where((element) => element.win).fold(0, (previousValue, element) => previousValue+element.reward);
    var showLevelDialog = UserInfoUtils.instance.updateUserPlayNum();
    if(showLevelDialog){
      LuckyRouters.instance.showDialog(
        child: UpLevelDialog(
          allReward: allReward,
          dismiss: (){
            _resetPlay(allReward,resetCallback);
          },
        )
      );
      return;
    }
    if(!hasWin){
      _resetPlay(allReward,resetCallback);
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
    key.currentState?.reset();
    canClick=true;
    _stopAuto=false;
    UserInfoUtils.instance.updateUserCoins(allReward);
    var showTime = await PlayInfoUtils.instance.updatePlayInfo(playType);
    if(showTime){
      LuckyRouters.instance.back();
    }else{
      resetCallback.call();
    }
  }

  bool _checkHasWin()=> yourList.indexWhere((element) => element.win)>=0;

  setYourList(List<YourBean> list){
    yourList.clear();
    yourList.addAll(list);
  }

  onClose(){
    scaleController.dispose();
  }
}