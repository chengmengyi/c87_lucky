
import 'lucky_dash_pro_h_platform_interface.dart';

class LuckyDashPro_h {
  static final LuckyDashPro_h _dashPro_h=LuckyDashPro_h();
  static LuckyDashPro_h get instance => _dashPro_h;

  openAndroid(){
    LuckyDashPro_hPlatform.instance.openAndroid();
  }
}
