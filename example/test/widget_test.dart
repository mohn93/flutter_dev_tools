// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_screen.dart';
import 'package:flutter_dev_tools_example/main.dart';

void main() {
  testWidgets('opens HTTP logger from the example', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.tap(find.text('HTTP Logger'));
    await tester.pumpAndSettle();
    expect(find.byType(HTTPLoggerScreen), findsOneWidget);
  });
}
