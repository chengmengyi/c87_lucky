import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lucky_dash_pro_h_platform_interface.dart';

/// An implementation of [LuckyDashPro_hPlatform] that uses method channels.
class MethodChannelLuckyDashPro_h extends LuckyDashPro_hPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lucky_dash_pro_h');

  @override
  Future<void> openAndroid() async{
    await methodChannel.invokeMethod<String>('initttttt');
  }
}
