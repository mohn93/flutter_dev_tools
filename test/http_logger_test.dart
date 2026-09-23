import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/http_logger_dio_interceptor.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/in_memory_logger.dart';
import 'package:flutter_dev_tools/tools/http_logger/entity/http_data.dart';
import 'package:flutter_test/flutter_test.dart';

class _Adapter implements HttpClientAdapter {
  _Adapter(this.statusCode);

  final int statusCode;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async =>
      ResponseBody.fromString(
        '{"ok":true}',
        statusCode,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType]
        },
      );

  @override
  void close({bool force = false}) {}
}

void main() {
  test('keeps only the newest requests and notifies listeners', () {
    final logger = InMemoryLogger(maxSize: 1);
    var changes = 0;
    logger.addListener(() => changes++);
    for (var id = 1; id <= 2; id++) {
      logger.add(HTTPLoggerData(
        request: HTTPRequestData(
          headers: {},
          uri: Uri.parse('https://example.com/$id'),
          method: 'GET',
          data: {},
          requestId: id,
        ),
      ));
    }
    expect(logger.data.map((entry) => entry.requestId), [2]);
    expect(changes, 2);
    logger.dispose();
  });

  test('records a successful Dio request and response', () async {
    final logger = InMemoryLogger();
    var changes = 0;
    logger.addListener(() => changes++);
    final dio = Dio()..httpClientAdapter = _Adapter(200);
    dio.interceptors.add(HTTPDioLoggerInterceptor(logger: logger));

    final response = await dio.get('https://example.com/success');

    expect(response.statusCode, 200);
    expect(logger.data, hasLength(1));
    expect(logger.data.single.request.uri.path, '/success');
    expect(logger.data.single.response?.statusCode, 200);
    expect(logger.data.single.response?.data, {'ok': true});
    expect(changes, 2);
    logger.dispose();
  });

  test('records an HTTP error without swallowing it', () async {
    final logger = InMemoryLogger();
    final dio = Dio()..httpClientAdapter = _Adapter(500);
    dio.interceptors.add(HTTPDioLoggerInterceptor(logger: logger));

    await expectLater(
      dio.get('https://example.com/failure'),
      throwsA(isA<DioException>()),
    );

    expect(logger.data, hasLength(1));
    expect(logger.data.single.response?.statusCode, 500);
    logger.dispose();
  });

  test('records a string request body', () async {
    final logger = InMemoryLogger();
    final dio = Dio()..httpClientAdapter = _Adapter(200);
    dio.interceptors.add(HTTPDioLoggerInterceptor(logger: logger));

    await dio.post('https://example.com/submit', data: 'plain text');

    expect(logger.data.single.request.data, 'plain text');
    expect(logger.data.single.request.prettyData, 'plain text');
    logger.dispose();
  });
}
