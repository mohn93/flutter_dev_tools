import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_tools/tools/http_logger/entity/http_data.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/in_memory_logger.dart';

class HTTPDioLoggerInterceptor extends Interceptor {
  HTTPDioLoggerInterceptor({
    required this.logger,
  });

  final InMemoryLogger logger;

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler,) {
    try {
      final data = HTTPLoggerData(
        request: HTTPRequestData(
          headers: options.headers,
          requestId: options.hashCode,
          uri: options.uri,
          method: options.method,
          data: options.data,
        ),
      );
      logger.add(data);
    } catch (e) {
      debugPrint('Error: $e');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response,
      ResponseInterceptorHandler handler,) {
    try {
      final data = logger.data.firstWhere(
              (element) =>
          element.requestId == response.requestOptions.hashCode);
      data.response = HTTPResponseData(
        headers: response.headers.map,
        statusCode: response.statusCode ?? 0,
        data: response.data,
        statusMessage: response.statusMessage,
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err,
      ErrorInterceptorHandler handler,) {
    try {
      final data = logger.data.firstWhere(
              (element) => element.requestId == err.requestOptions.hashCode);
      data.response = HTTPResponseData(
        headers: err.response?.headers.map ?? {},
        statusCode: err.response?.statusCode ?? 0,
        data: err.response?.data ?? {},
        error: err.error.toString(),
        statusMessage: err.response?.statusMessage,
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
      handler.next(err);
    }
  }
