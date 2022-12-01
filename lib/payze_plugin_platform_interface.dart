import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'payze_plugin_method_channel.dart';

abstract class PayzePluginPlatform extends PlatformInterface {
  /// Constructs a PayzePluginPlatform.
  PayzePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static PayzePluginPlatform _instance = MethodChannelPayzePlugin();

  /// The default instance of [PayzePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelPayzePlugin].
  static PayzePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PayzePluginPlatform] when
  /// they register themselves.
  static set instance(PayzePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
