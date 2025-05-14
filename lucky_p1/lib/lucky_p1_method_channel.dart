import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lucky_p1_platform_interface.dart';

/// An implementation of [LuckyP1Platform] that uses method channels.
class MethodChannelLuckyP1 extends LuckyP1Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lucky_p1');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
