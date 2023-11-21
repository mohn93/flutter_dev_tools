import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_tools/tools/http_logger/entity/http_data.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/in_memory_logger.dart';

/// A Dio interceptor that logs HTTP requests and responses using an [InMemoryLogger].
///
/// This interceptor captures HTTP request and response data, as well as errors,
/// and logs them for later review. It's designed to integrate with Dio, a powerful HTTP
/// client for Dart, to enable detailed tracking of network activity within an application.
class HTTPDioLoggerInterceptor extends Interceptor {
  /// Creates an instance of `HTTPDioLoggerInterceptor`.
  ///
  /// - [logger]: The [InMemoryLogger] instance used to log HTTP transaction data.
  HTTPDioLoggerInterceptor({
    required this.logger,
  });

  final InMemoryLogger logger;

  /// Intercepts and logs outgoing HTTP requests.
  ///
  /// This method is called when a request is made using Dio. It creates and logs an
  /// instance of `HTTPLoggerData` containing request details.
  ///
  /// - [options]: The request options, containing details like headers, URI, and method.
  /// - [handler]: The handler to continue the request processing.
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    try {
      final data = HTTPLoggerData(
        request: HTTPRequestData(
          headers: options.headers,
          requestId: options.hashCode,
          uri: options.uri,
          method: options.method,
          data: options.data ?? {},
        ),
      );
      logger.add(data);
    } catch (e, stackTrace) {
      debugPrint('Error: $e, StackTrace: $stackTrace');
    }
    handler.next(options);
  }

  /// Intercepts and logs incoming HTTP responses.
  ///
  /// This method is called when a response is received. It updates the corresponding
  /// `HTTPLoggerData` instance with response details.
  ///
  /// - [response]: The received response.
  /// - [handler]: The handler to continue the response processing.
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    try {
      final data = logger.data.firstWhere(
          (element) => element.requestId == response.requestOptions.hashCode);
      data.response = HTTPResponseData(
        headers: response.headers.map,
        statusCode: response.statusCode ?? 0,
        data: response.data ?? {},
        statusMessage: response.statusMessage,
      );
    } catch (e, stackTrace) {
      debugPrint('Error: $e, StackTrace: $stackTrace');
    }
    handler.next(response);
  }

  /// Intercepts and logs HTTP errors.
  ///
  /// This method is called when an error occurs during an HTTP request or response.
  /// It updates the corresponding `HTTPLoggerData` instance with error details.
  ///
  /// - [err]: The encountered DioException.
  /// - [handler]: The handler to continue the error processing.
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
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
    } catch (e, stackTrace) {
      debugPrint('Error: $e, StackTrace: $stackTrace');
    }
    handler.next(err);
  }
}
