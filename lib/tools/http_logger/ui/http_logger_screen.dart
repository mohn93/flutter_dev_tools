import 'package:flutter/material.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_tile.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/in_memory_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// inMemoryLoggerProvider
final inMemoryLoggerProvider = Provider((ref) => InMemoryLogger());

class FilterQuery {
  Set<String> allowedMethods = {};
  String searchQuery = '';

  FilterQuery({
    required this.allowedMethods,
    required this.searchQuery,
  });
}

class HTTPLoggerScreen extends HookConsumerWidget {
  const HTTPLoggerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtered = ref.watch(inMemoryLoggerProvider).data;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Logger'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ...filtered
              .map(
                (item) => HttpLoggerListTile(data: item),
              )
              .toList(),
        ],
      ),
    );
  }
}
