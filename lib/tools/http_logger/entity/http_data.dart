class HTTPResponseData {
  HTTPResponseData({
    required this.headers,
    required this.statusCode,
    required this.data,
    this.error,
    this.statusMessage,
  });

  final Map<String, dynamic> headers;
  final int statusCode;
  final Map<String, dynamic> data;
  final String? statusMessage;
  final String? error;
  final DateTime createdAt = DateTime.now();

  HTTPResponseData copyWith({
    Map<String, dynamic>? headers,
    int? statusCode,
    Map<String, dynamic>? data,
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
class HTTPLoggerData {
  HTTPLoggerData({
    required this.request,
    this.response,
  }) : requestId = request.requestId;

  final HTTPRequestData request;
  HTTPResponseData? response;
  final int requestId;
}
