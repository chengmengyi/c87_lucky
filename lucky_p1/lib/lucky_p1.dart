
import 'lucky_p1_platform_interface.dart';

class LuckyP1 {
  Future<String?> getPlatformVersion() {
    return LuckyP1Platform.instance.getPlatformVersion();
  }
}
