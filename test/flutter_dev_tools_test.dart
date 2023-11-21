import 'package:flutter_dev_tools/platform_channels/flutter_dev_tools_platform_interface.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dev_tools/flutter_dev_tools.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter/material.dart';
import 'mocks.mocks.dart'; // Import the generated file

void main() {
  group('FlutterDevTools', () {
    late FlutterDevTools tools;
    late MockFlutterDevToolsPlatform mockPlatform;

    setUp(() {
      mockPlatform = MockFlutterDevToolsPlatform();
      FlutterDevToolsPlatform.instance = mockPlatform; // Use the mock instance
      tools = FlutterDevTools();
    });

    test('diagnoseDynamicLinks returns expected result', () async {
      // Mocking the platform's response
      when(mockPlatform.diagnoseDynamicLinks())
          .thenAnswer((_) async => {'link1': true, 'link2': false});

      expect(
          await tools.diagnoseDynamicLinks(), {'link1': true, 'link2': false});
    });

    testWidgets('openHttpLogger navigates to HTTPLoggerScreen',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Builder(
        builder: (context) {
          return ElevatedButton(
            onPressed: () => tools.openHttpLogger(context),
            child: Text('Open Logger'),
          );
        },
      ))));

      // Tap the button to open the logger.
      await tester.tap(find.byType(ElevatedButton));
      await tester
          .pumpAndSettle(); // Wait for the navigation animation to complete.

      // Verify that HTTPLoggerScreen is now present in the widget tree.
      expect(find.byType(HTTPLoggerScreen), findsOneWidget);
    });
  });
}
