import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_tools/platform_channels/flutter_dev_tools_platform_interface.dart';

/// Represents an implementation of [FlutterDevToolsPlatform] that utilizes method channels
/// for communication between Flutter and native platform code.
class MethodChannelFlutterDevTools extends FlutterDevToolsPlatform {
  /// A [MethodChannel] for sending messages to the native platform. It's marked as
  /// visible for testing purposes, allowing for easier testing of channel communication.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_dev_tools');

  /// Asynchronously diagnoses dynamic links in the application.
  ///
  /// This method communicates with the native platform to analyze dynamic links,
  /// returning a map where each key is a dynamic link and its value is a boolean indicating
  /// the status (e.g., successful or failed).
  ///
  /// If there's an error during communication with the platform, the error is printed
  /// to the console and the method returns null.
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
