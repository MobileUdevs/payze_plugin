
import 'payze_plugin_platform_interface.dart';

class PayzePlugin {
  Future<String?> getPlatformVersion() {
    return PayzePluginPlatform.instance.getPlatformVersion();
  }
}
