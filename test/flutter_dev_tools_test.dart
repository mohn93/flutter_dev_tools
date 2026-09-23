import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dev_tools/flutter_dev_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/in_memory_logger.dart';
import 'package:flutter_dev_tools/tools/http_logger/entity/http_data.dart';

void main() {
  group('FlutterDevTools', () {
    testWidgets('openHttpLogger navigates to HTTPLoggerScreen',
        (WidgetTester tester) async {
      final tools = FlutterDevTools();
      await tester.pumpWidget(
          ProviderScope(child: MaterialApp(home: Scaffold(body: Builder(
        builder: (context) {
          return ElevatedButton(
            onPressed: () => tools.openHttpLogger(context),
            child: const Text('Open Logger'),
          );
        },
      )))));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(HTTPLoggerScreen), findsOneWidget);
    });

    testWidgets('logger screen updates when a request completes',
        (tester) async {
      final logger = InMemoryLogger();
      await tester.pumpWidget(ProviderScope(
        overrides: [httpLoggerProvider.overrideWith((ref) => logger)],
        child: const MaterialApp(home: HTTPLoggerScreen()),
      ));

      logger.add(HTTPLoggerData(
        request: HTTPRequestData(
          headers: {},
          uri: Uri.parse('https://example.com/request'),
          method: 'POST',
          data: 'plain text',
          requestId: 1,
        ),
      ));
      await tester.pump();
      expect(find.text('https://example.com/request'), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);

      logger.setResponse(
          1,
          HTTPResponseData(
            headers: {},
            statusCode: 201,
            data: {'ok': true},
          ));
      await tester.pump();
      expect(find.text('201'), findsOneWidget);
      expect(find.text('Pending'), findsNothing);
    });
  });
}
