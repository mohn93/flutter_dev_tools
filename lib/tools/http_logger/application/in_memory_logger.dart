import 'package:flutter_dev_tools/tools/http_logger/entity/http_data.dart';

/// A logger that stores HTTP request and response data in memory.
///
/// This logger is designed to keep a record of HTTP transactions in memory for easy access
/// and debugging. It maintains a list of `HTTPLoggerData` instances, each representing a
/// single HTTP request-response pair. The logger has a maximum size to limit memory usage,
/// after which older records are discarded as new ones are added.
class InMemoryLogger {

  /// Constructs an instance of `InMemoryLogger`.
  ///
  /// - [maxSize]: The maximum number of `HTTPLoggerData` entries to store.
  ///              Once this limit is reached, the oldest entries are removed to make
  ///              room for new ones. Defaults to 100.
  InMemoryLogger({
    this.maxSize = 100,
  });

  final int maxSize;

  final _data = <HTTPLoggerData>[];

  /// Adds a new `HTTPLoggerData` instance to the logger.
  ///
  /// When adding a new data entry, this method ensures that the total number of stored
  /// entries does not exceed the `maxSize`. If it does, the oldest entry is removed.
  ///
  /// - [data]: The `HTTPLoggerData` instance to be added to the logger.
  void add(HTTPLoggerData data) {
    _data.add(data);
    if (_data.length > maxSize) _data.removeAt(0);
  }

  /// A list of all `HTTPLoggerData` entries currently stored in the logger.
  ///
  /// This getter provides access to the logged data, allowing external components
  /// to retrieve and display HTTP transaction information.
  List<HTTPLoggerData> get data => _data;
}
