import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_tile.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/in_memory_logger.dart';

final httpLoggerProvider = ChangeNotifierProvider((ref) => InMemoryLogger());

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
    final filtered = ref.watch(httpLoggerProvider).data;

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        ...filtered.map(
          (item) => HttpLoggerListTile(data: item),
        ),
      ],
    );
  }
}
