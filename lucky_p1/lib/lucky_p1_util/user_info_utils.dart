import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
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
}