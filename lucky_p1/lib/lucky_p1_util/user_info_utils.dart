import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_p1/lucky_p1_routers/lucky_p1_routers.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/storage.dart';

class UserInfoUtils{
  static final UserInfoUtils _instance = UserInfoUtils();
  static UserInfoUtils get instance => _instance;

  updateUserCoins(int addCoins){
    if(addCoins==0){
      return;
    }
    p1UserCoins.saveData(p1UserCoins.getData()+addCoins);
    LuckyEvent(luckyCode: P1LuckyEventCode.updateUserCoins);
  }

  bool updateUserPlayNum(){
    p1UserPlayNum.saveData(p1UserPlayNum.getData()+1);
    LuckyEvent(luckyCode: P1LuckyEventCode.updateUserPlayNum);
    return p1UserPlayNum.getData()%5==0;
  }

  openPlayPageByType(String playType){
    String routersName="";
    if(playType==PlayType.card1.name){
      routersName=LuckyP1RoutersName.play1;
    }
    if(playType==PlayType.card2.name){
      routersName=LuckyP1RoutersName.play2;
    }
    if(playType==PlayType.card3.name){
      routersName=LuckyP1RoutersName.play3;
    }
    if(playType==PlayType.card4.name){
      routersName=LuckyP1RoutersName.play4;
    }
    if(playType==PlayType.card5.name){
      routersName=LuckyP1RoutersName.play5;
    }
    if(playType==PlayType.card7.name){
      routersName=LuckyP1RoutersName.play7;
    }
    if(playType==PlayType.card8.name){
      routersName=LuckyP1RoutersName.play8;
    }
    if(playType==PlayType.card9.name){
      routersName=LuckyP1RoutersName.play9;
    }
    if(routersName.isEmpty){
      return;
    }
    LuckyRouters.instance.openNextPage(routersName: routersName);
  }
}