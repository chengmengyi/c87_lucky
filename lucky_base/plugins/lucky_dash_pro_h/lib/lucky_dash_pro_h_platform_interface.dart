import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lucky_dash_pro_h_method_channel.dart';

abstract class LuckyDashPro_hPlatform extends PlatformInterface {
  /// Constructs a LuckyDashPro_hPlatform.
  LuckyDashPro_hPlatform() : super(token: _token);

  static final Object _token = Object();

  static LuckyDashPro_hPlatform _instance = MethodChannelLuckyDashPro_h();

  /// The default instance of [LuckyDashPro_hPlatform] to use.
  ///
  /// Defaults to [MethodChannelLuckyDashPro_h].
  static LuckyDashPro_hPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LuckyDashPro_hPlatform] when
  /// they register themselves.
  static set instance(LuckyDashPro_hPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> openAndroid() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
