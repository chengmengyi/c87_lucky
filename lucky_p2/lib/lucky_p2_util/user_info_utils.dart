import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_routers/lucky_p2_routers.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_utils.dart';

class UserInfoUtils{
  static final UserInfoUtils _instance = UserInfoUtils();
  static UserInfoUtils get instance => _instance;

  updateUserCoins(double addCoins){
    if(addCoins==0.0){
      return;
    }
    p2UserCoins.saveData(addTwoNums(p2UserCoins.getData(),addCoins));
    LuckyEvent(luckyCode: P2LuckyEventCode.updateUserCoins);
  }

  bool updateUserPlayNum(){
    p2UserPlayNum.saveData(p2UserPlayNum.getData()+1);
    LuckyEvent(luckyCode: P2LuckyEventCode.updateUserPlayNum);
    if(p2UserPlayNum.getData()==3){
      UserGuideUtils.instance.completedNewUserGuide();
    }
    if(p2BoxPro.getData()<5){
      p2BoxPro.saveData(p2BoxPro.getData()+1);
    }
    return p2UserPlayNum.getData()%5==0;
  }

  updateKeyNum(int addNum){
    p2KeyNum.saveData(p2KeyNum.getData()+addNum);
    LuckyEvent(luckyCode: P2LuckyEventCode.updateKeyNum);
  }

  openPlayPageByType(String playType){
    String routersName="";
    if(playType==PlayType.card1.name){
      routersName=LuckyP2RoutersName.play1;
    }
    if(playType==PlayType.card2.name){
      routersName=LuckyP2RoutersName.play2;
    }
    if(playType==PlayType.card3.name){
      routersName=LuckyP2RoutersName.play3;
    }
    if(playType==PlayType.card4.name){
      routersName=LuckyP2RoutersName.play4;
    }
    if(playType==PlayType.card5.name){
      routersName=LuckyP2RoutersName.play5;
    }
    if(playType==PlayType.card6.name){
      routersName=LuckyP2RoutersName.play6;
    }
    if(playType==PlayType.card7.name){
      routersName=LuckyP2RoutersName.play7;
    }
    if(playType==PlayType.card8.name){
      routersName=LuckyP2RoutersName.play8;
    }
    if(playType==PlayType.card9.name){
      routersName=LuckyP2RoutersName.play9;
    }
    if(routersName.isEmpty){
      return;
    }
    p2LastPlayType.saveData(playType);
    LuckyRouters.instance.openNextPage(routersName: routersName);
  }
}