import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lucky_base_platform_interface.dart';

/// An implementation of [LuckyBasePlatform] that uses method channels.
class MethodChannelLuckyBase extends LuckyBasePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lucky_base');

  @override
  Future<void> func1() async {
    await methodChannel.invokeMethod<String>('func1');
  }
  @override
  Future<void> func2() async {
    await methodChannel.invokeMethod<String>('func2');
  }
  @override
  Future<void> func3() async {
    await methodChannel.invokeMethod<String>('func3');
  }
  @override
  Future<void> func4() async {
    await methodChannel.invokeMethod<String>('func4');
  }

  @override
  Future<void> openAndroid() async{
    await methodChannel.invokeMethod<String>('initttttt');
  }
}
