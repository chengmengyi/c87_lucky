
import 'lucky_p2_platform_interface.dart';

class LuckyP2 {
  Future<String?> getPlatformVersion() {
    return LuckyP2Platform.instance.getPlatformVersion();
  }
}
