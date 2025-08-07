import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lucky_base_method_channel.dart';

abstract class LuckyBasePlatform extends PlatformInterface {
  /// Constructs a LuckyBasePlatform.
  LuckyBasePlatform() : super(token: _token);

  static final Object _token = Object();

  static LuckyBasePlatform _instance = MethodChannelLuckyBase();

  /// The default instance of [LuckyBasePlatform] to use.
  ///
  /// Defaults to [MethodChannelLuckyBase].
  static LuckyBasePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LuckyBasePlatform] when
  /// they register themselves.
  static set instance(LuckyBasePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> func1() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> func2() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> func3() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> func4() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> openAndroid() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
