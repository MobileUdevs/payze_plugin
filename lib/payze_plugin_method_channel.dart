import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'payze_plugin_platform_interface.dart';

/// An implementation of [PayzePluginPlatform] that uses method channels.
class MethodChannelPayzePlugin extends PayzePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('payze_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
