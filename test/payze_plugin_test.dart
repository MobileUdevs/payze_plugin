import 'package:flutter_test/flutter_test.dart';
import 'package:payze_plugin/payze_plugin.dart';
import 'package:payze_plugin/payze_plugin_platform_interface.dart';
import 'package:payze_plugin/payze_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPayzePluginPlatform
    with MockPlatformInterfaceMixin
    implements PayzePluginPlatform {
  @override
  Future<bool?> payzeOpen(Map<String, String> json) {
    throw UnimplementedError();
  }
}

void main() {
  final PayzePluginPlatform initialPlatform = PayzePluginPlatform.instance;

  test('$MethodChannelPayzePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPayzePlugin>());
  });

  test('getPlatformVersion', () async {
    PayzePlugin payzePlugin = PayzePlugin();
    MockPayzePluginPlatform fakePlatform = MockPayzePluginPlatform();
    PayzePluginPlatform.instance = fakePlatform;

    expect(
      await payzePlugin.payzeOpen(
        Payze(
          number: '',
          cardHolder: '',
          expirationDate: '',
          securityNumber: '',
          transactionId: '',
        ),
      ),
      true,
    );
  });
}
