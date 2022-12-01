import 'package:payze_plugin/model/payze.dart';

import 'payze_plugin_platform_interface.dart';
export 'model/payze.dart';

class PayzePlugin {
  PayzePlugin._();

  static final PayzePlugin instance = PayzePlugin._();

  Future<bool?> payzeOpen(Payze payze) async {
    return PayzePluginPlatform.instance.payzeOpen(payze.toJson());
  }
}
