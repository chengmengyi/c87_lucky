import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lucky_p2_method_channel.dart';

abstract class LuckyP2Platform extends PlatformInterface {
  /// Constructs a LuckyP2Platform.
  LuckyP2Platform() : super(token: _token);

  static final Object _token = Object();

  static LuckyP2Platform _instance = MethodChannelLuckyP2();

  /// The default instance of [LuckyP2Platform] to use.
  ///
  /// Defaults to [MethodChannelLuckyP2].
  static LuckyP2Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LuckyP2Platform] when
  /// they register themselves.
  static set instance(LuckyP2Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
