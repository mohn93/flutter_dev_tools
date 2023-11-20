library flutter_dev_tools;

import 'package:flutter/material.dart';
import 'package:flutter_dev_tools/platform_channels/flutter_dev_tools_platform_interface.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_screen.dart';

class FlutterDevTools {
  Future<Map<String, bool>?> diagnoseDynamicLinks() {
    return FlutterDevToolsPlatform.instance.diagnoseDynamicLinks();
  }

  void openHttpLogger(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HTTPLoggerScreen()));
  }
}
