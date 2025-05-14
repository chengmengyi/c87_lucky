import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lucky_p1_method_channel.dart';

abstract class LuckyP1Platform extends PlatformInterface {
  /// Constructs a LuckyP1Platform.
  LuckyP1Platform() : super(token: _token);

  static final Object _token = Object();

  static LuckyP1Platform _instance = MethodChannelLuckyP1();

  /// The default instance of [LuckyP1Platform] to use.
  ///
  /// Defaults to [MethodChannelLuckyP1].
  static LuckyP1Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LuckyP1Platform] when
  /// they register themselves.
  static set instance(LuckyP1Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
