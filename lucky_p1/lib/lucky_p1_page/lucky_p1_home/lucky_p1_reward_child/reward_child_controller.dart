import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_p1/lucky_p1_bean/play_info_bean.dart';
import 'package:lucky_p1/lucky_p1_dialog/normal_win/normal_win_dialog.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/user_info_utils.dart';

class RewardChildController extends LuckyBaseController{
  List<PlayInfoBean> list=[];

  @override
  void onReady() {
    super.onReady();
    _initList();
  }

  clickVideo(int reward){
    LuckyAdUtils.instance.showP1Ad(
      closeAd: (){
        _showGetCoinsDialog(reward);
      },
    );
  }

  _showGetCoinsDialog(int reward){
    LuckyRouters.instance.showDialog(
      child: NormalWinDialog(
        allReward: reward,
        dismiss: (){
          UserInfoUtils.instance.updateUserCoins(reward);
        },
      ),
    );
  }

  clickPlay(PlayInfoBean bean){
    if(bean.unlock!=1){
      LuckyAdUtils.instance.showP1Ad(
        closeAd: ()async{
          var indexWhere = PlayType.values.indexWhere((element) => element.name==bean.type);
          if(indexWhere>=0){
            var watchVideoNum = await PlayInfoUtils.instance.unlockPlayType(PlayType.values[indexWhere],UnlockType.video);
            bean.watchVideoNum=watchVideoNum;
            update(["list"]);
          }
        },
      );
    }else{
      UserInfoUtils.instance.openPlayPageByType(bean.type??"");
    }
  }

  _initList()async{
    list.clear();
    var result = await PlayInfoUtils.instance.queryPlayList();
    list.addAll(result);
    update(["list"]);
  }

  String getIcon(PlayInfoBean bean){
    if(bean.type==PlayType.card1.name){
      return "card11";
    }else if(bean.type==PlayType.card2.name){
      return "card12";
    }else if(bean.type==PlayType.card3.name){
      return "card13";
    }else if(bean.type==PlayType.card4.name){
      return "card14";
    }else if(bean.type==PlayType.card5.name){
      return "card15";
    }else if(bean.type==PlayType.card6.name){
      return "card16";
    }else if(bean.type==PlayType.card7.name){
      return "card17";
    }else if(bean.type==PlayType.card8.name){
      return "card18";
    }else if(bean.type==PlayType.card9.name){
      return "card19";
    }
    return "card19";
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