import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lucky_base_platform_interface.dart';

/// An implementation of [LuckyBasePlatform] that uses method channels.
class MethodChannelLuckyBase extends LuckyBasePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lucky_base');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
