import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'payze_plugin_platform_interface.dart';

/// An implementation of [PayzePluginPlatform] that uses method channels.
class MethodChannelPayzePlugin extends PayzePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('payze_plugin');

  @override
  Future<bool?> payzeOpen(Map<String, String> json) async {
    final version = await methodChannel.invokeMethod<bool>('payze_open', json);
    return version;
  }
}
