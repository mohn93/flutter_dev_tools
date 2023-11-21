import 'package:flutter/services.dart';
import 'package:flutter_dev_tools/platform_channels/flutter_dev_tools_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterDevTools platform = MethodChannelFlutterDevTools();
  const MethodChannel channel = MethodChannel('flutter_dev_tools');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('diagnoseDynamicLinks', () async {
    expect(await platform.diagnoseDynamicLinks(), '42');
  });
}
