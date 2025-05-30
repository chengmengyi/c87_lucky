import 'package:flutter/foundation.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/home_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/play_info_bean.dart';
import 'package:lucky_p2/lucky_p2_dialog/unlock_level/unlock_level_dialog.dart';
import 'package:lucky_p2/lucky_p2_dialog/up_level/up_level_dialog.dart';
import 'package:lucky_p2/lucky_p2_routers/lucky_p2_routers.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/user_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

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
      LuckyRouters.instance.showDialog(
        child: UnlockLevelDialog(
          playInfoBean: playInfoBean,
        ),
      );
      return;
    }
    if((playInfoBean.time??0)>DateTime.now().millisecondsSinceEpoch){
      showToast("No scratch card, please go to the next level！");
      return;
    }
    UserInfoUtils.instance.openPlayPageByType(playInfoBean.type??"");
  }

  _initList()async{
    list.clear();
    var result = await PlayInfoUtils.instance.queryPlayList();
    list.addAll(result);
    update(["list"]);
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