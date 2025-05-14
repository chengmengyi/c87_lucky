
import 'lucky_base_platform_interface.dart';

class LuckyBase {
  Future<String?> getPlatformVersion() {
    return LuckyBasePlatform.instance.getPlatformVersion();
  }
}
