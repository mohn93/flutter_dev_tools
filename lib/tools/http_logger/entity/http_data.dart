import 'package:flutter_dev_tools/tools/http_logger/utils/pretty_map.dart';

/// Represents the data structure for HTTP response data.
///
/// This class holds details of an HTTP response, including headers, status code,
/// response data, and any error messages or status messages.
class HTTPResponseData<DataType> {
  HTTPResponseData({
    required this.headers,
    required this.statusCode,
    required this.data,
    this.error,
    this.statusMessage,
  });

  final Map<String, dynamic> headers;
  final int statusCode;
  final DataType data;
  final String? statusMessage;
  final String? error;
  final DateTime createdAt = DateTime.now();

  /// Provides a human-readable representation of the response data.
  /// If the data is a Map, it's formatted by [prettyMap]; otherwise, it's converted to a string.
  String get prettyData => data is Map<String, dynamic>
      ? prettyMap(data as Map<String, dynamic>)
      : data.toString();

  /// Creates a copy of this HTTPResponseData with the given parameters, allowing for modification
  /// of certain fields while keeping others from the original object.
  HTTPResponseData copyWith({
    Map<String, dynamic>? headers,
    int? statusCode,
    DataType? data,
    String? statusMessage,
    String? error,
  }) {
    return HTTPResponseData(
      headers: headers ?? this.headers,
      statusCode: statusCode ?? this.statusCode,
      data: data ?? this.data,
      statusMessage: statusMessage ?? this.statusMessage,
      error: error ?? this.error,
    );
  }
}

/// Represents the data structure for an HTTP request.
///
/// This class contains details of an HTTP request, including headers, URI, HTTP method,
/// request data, and a unique request ID.
class HTTPRequestData {
  HTTPRequestData({
    required this.headers,
    required this.uri,
    required this.method,
    required this.data,
    required this.requestId,
  });

  final Map<String, dynamic> headers;
  final Uri uri;
  final String method;
  final Map<String, dynamic> data;
  final int requestId;
  final DateTime createdAt = DateTime.now();

  /// Creates a copy of this HTTPRequestData with the given parameters, allowing for modification
  /// of certain fields while keeping others from the original object.
  HTTPRequestData copyWith({
    Map<String, dynamic>? headers,
    Uri? uri,
    String? method,
    Map<String, dynamic>? data,
    int? requestId,
  }) {
    return HTTPRequestData(
      headers: headers ?? this.headers,
      uri: uri ?? this.uri,
      method: method ?? this.method,
      data: data ?? this.data,
      requestId: requestId ?? this.requestId,
    );
  }
}

/// Represents the overall data structure for the HTTP logger.
///
/// This class encapsulates both the request and response data for an HTTP transaction,
/// tying them together with a unique request ID for easy tracking and correlation.
class HTTPLoggerData {
  HTTPLoggerData({
    required this.request,
    this.response,
  }) : requestId = request.requestId;

  final HTTPRequestData request;
  HTTPResponseData? response;
  final int requestId;
}
