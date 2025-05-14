import 'package:flutter/foundation.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_p1/lucky_p1_bean/home_bean.dart';
import 'package:lucky_p1/lucky_p1_bean/play_info_bean.dart';
import 'package:lucky_p1/lucky_p1_dialog/up_level/up_level_dialog.dart';
import 'package:lucky_p1/lucky_p1_routers/lucky_p1_routers.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/value_utils.dart';

class CardChildController extends LuckyBaseController{
  List<PlayInfoBean> list=[];

  @override
  void onReady() {
    super.onReady();
    _initList();
  }

  clickItem(index){
    var playInfoBean = list[index];
    if(playInfoBean.unlock!=1){
      return;
    }
    LuckyRouters.instance.openNextPage(routersName: LuckyP1RoutersName.play1);
  }

  _initList()async{
    list.clear();
    var result = await PlayInfoUtils.instance.queryPlayList();
    list.addAll(result);
    update(["list"]);
  }

  test()async{
    if(!kDebugMode){
      return;
    }
    var result = await PlayInfoUtils.instance.queryPlayList();
    print(result);
  }

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P1LuckyEventCode.updateHomeList:
        _initList();
        break;
    }
  }
}