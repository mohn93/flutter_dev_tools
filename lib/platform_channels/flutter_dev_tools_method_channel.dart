import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_tools/platform_channels/flutter_dev_tools_platform_interface.dart';

/// An implementation of [FlutterDevToolsPlatform] that uses method channels.
class MethodChannelFlutterDevTools extends FlutterDevToolsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_dev_tools');

  @override
  Future<Map<String, bool>?> diagnoseDynamicLinks() async {
    try {
      final result = await methodChannel
          .invokeMethod<Map<Object?, Object?>>('diagnoseDynamicLinks');
      return result?.map(
        (key, value) => MapEntry(
          key as String,
          value as bool,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
