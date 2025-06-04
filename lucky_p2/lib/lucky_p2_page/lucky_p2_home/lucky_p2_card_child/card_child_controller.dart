import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/play_info_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/up_level/up_level_dialog.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';

class CardChildController extends LuckyBaseController{
  List<PlayInfoBean> list=[];
  GlobalKey firstPlayGlobalKey=GlobalKey();
  Timer? _timer;
  var totalSecondsNum=80;

  @override
  void onReady() {
    super.onReady();
    _initList(firstInit: true);
  }

  clickItem(index){
    var playInfoBean = list[index];
    if(playInfoBean.showFinger==true){
      playInfoBean.showFinger=false;
      update(["list"]);
    }
    if((playInfoBean.hasNum??0)<=0){
      showToast("The Next Card 80 Seconds");
      return;
    }
    UserInfoUtils.instance.openPlayPageByType(playInfoBean.type??"");
  }

  _initList({bool firstInit=false,bool noPlayNum=false})async{
    list.clear();
    _timer?.cancel();
    _timer=null;
    var result = await PlayInfoUtils.instance.queryPlayList();
    list.addAll(result);
    if(noPlayNum){
      var indexWhere = list.indexWhere((value)=>(value.hasNum??0)>0);
      if(indexWhere>=0){
        list[indexWhere].showFinger=true;
      }
    }
    update(["list"]);

    var indexWhere = list.indexWhere((element) => (element.hasNum??0)<10);
    if(indexWhere>=0&&null==_timer){
      _timer?.cancel();
      _timer=Timer.periodic(const Duration(milliseconds: 1000), (timer) async{
        bool updateUI=false;
        for (var element in list) {
          if((element.hasNum??0)<10){
            element.secondsNum=(element.secondsNum??0)+1;
            await PlayInfoUtils.instance.savePlayInfo(element);
            if((element.secondsNum??0)>=totalSecondsNum){
              await PlayInfoUtils.instance.addPlayNum(element.type??"");
              element.secondsNum=0;
              element.hasNum=(element.hasNum??0)+1;
              updateUI=true;
            }
          }
        }
        if(updateUI){
          update(["list"]);
        }
      });
    }

    if(firstInit){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        UserGuideUtils.instance.checkShowGuide(context: context,firstGuideGlobalKey: firstPlayGlobalKey);
      });
    }
  }

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.updateHomeList:
        _initList(noPlayNum: luckyEvent.boolValue??false);
        break;
      case P2LuckyEventCode.showLastPlayFingerGuide:
        _showLastPlayFinger();
        break;
    }
  }

  _showLastPlayFinger(){
    var indexWhere = list.indexWhere((value)=>value.type==p2LastPlayType.getData());
    if(indexWhere>=0){
      list[indexWhere].showFinger=true;
      update(["list"]);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  test()async{
    if(!kDebugMode){
      return;
    }
    LuckyRouters.instance.showDialog(child: UpLevelDialog(addNum: 20.3, dismiss: (){}));
  }
}