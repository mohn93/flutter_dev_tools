import 'package:flutter_dev_tools/platform_channels/flutter_dev_tools_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FlutterDevToolsPlatform extends PlatformInterface {
  /// Constructs a FlutterDevToolsPlatform.
  FlutterDevToolsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDevToolsPlatform _instance = MethodChannelFlutterDevTools();

  /// The default instance of [FlutterDevToolsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDevTools].
  static FlutterDevToolsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDevToolsPlatform] when
  /// they register themselves.
  static set instance(FlutterDevToolsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String, bool>?> diagnoseDynamicLinks() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
