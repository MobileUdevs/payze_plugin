import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payze_plugin/payze_plugin_method_channel.dart';

void main() {
  MethodChannelPayzePlugin platform = MethodChannelPayzePlugin();
  const MethodChannel channel = MethodChannel('payze_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.payzeOpen({}), '42');
  });
}
