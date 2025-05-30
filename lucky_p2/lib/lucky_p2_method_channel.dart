import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lucky_p2_platform_interface.dart';

/// An implementation of [LuckyP2Platform] that uses method channels.
class MethodChannelLuckyP2 extends LuckyP2Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lucky_p2');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
