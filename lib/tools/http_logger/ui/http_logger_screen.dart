import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_tile.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/in_memory_logger.dart';

/// Provides the shared [InMemoryLogger] instance.
///
/// This is a plain [Provider], so watching it does not rebuild dependents when
/// entries are logged. [HTTPLoggerBody] listens to the logger directly.
final httpLoggerProvider = Provider((ref) {
  final logger = InMemoryLogger();
  ref.onDispose(logger.dispose);
  return logger;
});

class HTTPLoggerScreen extends StatelessWidget {
  const HTTPLoggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Logger'),
      ),
      body: const HTTPLoggerBody(),
    );
  }
}

class HTTPLoggerBody extends ConsumerWidget {
  const HTTPLoggerBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logger = ref.watch(httpLoggerProvider);

    return ListenableBuilder(
      listenable: logger,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ...logger.data.map(
            (item) => HttpLoggerListTile(data: item),
          ),
        ],
      ),
    );
  }
}
