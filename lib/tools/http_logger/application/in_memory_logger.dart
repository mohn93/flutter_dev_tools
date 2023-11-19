import 'package:flutter_dev_tools/tools/http_logger/entity/http_data.dart';

class InMemoryLogger {
  InMemoryLogger({
    this.maxSize = 100,
  });

  final int maxSize;

  final _data = <HTTPLoggerData>[];

  void add(HTTPLoggerData data) {
    _data.add(data);
    if (_data.length > maxSize) _data.removeAt(0);
  }

  List<HTTPLoggerData> get data => _data;
}
