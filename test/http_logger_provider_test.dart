import 'package:flutter/material.dart';
import 'package:flutter_dev_tools/tools/http_logger/entity/http_data.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

HTTPLoggerData _entry(int id) => HTTPLoggerData(
      request: HTTPRequestData(
        headers: {},
        uri: Uri.parse('https://example.com/request-$id'),
        method: 'GET',
        data: {},
        requestId: id,
      ),
    );

void main() {
  test('dependents of httpLoggerProvider do not recompute on new entries', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    var builds = 0;
    final dependentProvider = Provider((ref) {
      ref.watch(httpLoggerProvider);
      builds++;
      return Object();
    });

    final first = container.read(dependentProvider);
    container.read(httpLoggerProvider).add(_entry(1));

    expect(container.read(dependentProvider), same(first));
    expect(builds, 1);
  });

  testWidgets('HTTPLoggerScreen shows entries added after it opened',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: HTTPLoggerScreen()),
    ));
    expect(find.textContaining('request-1'), findsNothing);

    container.read(httpLoggerProvider).add(_entry(1));
    await tester.pump();

    expect(find.textContaining('request-1'), findsOneWidget);
  });
}
