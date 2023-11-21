import 'package:flutter_dev_tools/platform_channels/flutter_dev_tools_method_channel.dart';
import 'package:flutter_dev_tools/platform_channels/flutter_dev_tools_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dev_tools/flutter_dev_tools.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDevToolsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDevToolsPlatform {
  @override
  Future<Map<String, bool>?> diagnoseDynamicLinks() =>
      Future.value({'42': true});
}

void main() {
  final FlutterDevToolsPlatform initialPlatform =
      FlutterDevToolsPlatform.instance;

  test('$MethodChannelFlutterDevTools is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDevTools>());
  });

  test('diagnoseDynamicLinks', () async {
    MockFlutterDevToolsPlatform fakePlatform = MockFlutterDevToolsPlatform();
    FlutterDevToolsPlatform.instance = fakePlatform;

    expect(await FlutterDevTools().diagnoseDynamicLinks(), '42');
  });
}
