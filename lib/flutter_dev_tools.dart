library flutter_dev_tools;

import 'package:flutter/material.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_screen.dart';

/// A central class for managing various development tools in a Flutter application.
///
/// `FlutterDevTools` provides a set of methods to access different development and debugging tools.
/// It acts as a facade, offering a simplified interface to more complex underlying functionalities.
class FlutterDevTools {
  /// Opens the HTTP Logger screen in the application.
  ///
  /// This method uses the Navigator to push a new route for the HTTP Logger screen,
  /// allowing users to view logged HTTP request and response data.
  ///
  /// - [context]: The BuildContext from which to find the Navigator for routing.
  void openHttpLogger(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HTTPLoggerScreen(),
      ),
    );
  }
}
